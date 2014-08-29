package mypoll

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

class SaveSubjectSelectionsCommand {
    Map<String, String> selections
}

@Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
@Transactional(readOnly = true)
class OpinionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Opinion.list(params), model:[opinionInstanceCount: Opinion.count()]
    }

    def welcome(Opinion opinionInstance) {
        model: [opinionInstance: opinionInstance]
    }

    /*
	 * renders the initial page a subject will see.
	 */
    def indexSubject(Opinion opinionInstance) {
        Poll pollInstance = opinionInstance.poll
        def answeredItemsPerSection = getAnsweredItemsPerSection(opinionInstance)
        Boolean submittable = allItemsAnswered(opinionInstance)
        model: [pollInstance: pollInstance, opinionInstance: opinionInstance, answeredItemsPerSection: answeredItemsPerSection, submittable: submittable]
    }

    /*
	 * creates a new Opinion and links it to the poll, then redirects to the index page for subjects
	 */
    @Transactional
    def addOpinion(Poll pollInstance) {
        if (!pollInstance.isActive) return

        String testObjectUrl = ( pollInstance.opinions.size() % 2 == 0 ? pollInstance.testObjectUrlA : pollInstance.testObjectUrlB )
        Opinion opinionInstance = new Opinion(
			testObjectUrl: testObjectUrl, 
			poll: pollInstance, 
			submittable: false, 
			submitted: false)
        opinionInstance.save flush:true

        redirect action: 'welcome', id: opinionInstance.id
    }

    @Transactional
    def answerSectionItems(Opinion opinionInstance) {

        if (opinionInstance.submitted) return

        Poll pollInstance = opinionInstance.poll
        PollSection pollSectionInstance = pollInstance.sections.find{ pollSectionInstance -> 
				allSectionItemsAnswered(opinionInstance.selections as Map<String, Choice>, pollSectionInstance as PollSection) == false } as PollSection
		
		if (pollSectionInstance == null) {
			opinionInstance.submittable = true
			opinionInstance.save flush:true
			redirect action: 'submitOpinion', id: opinionInstance.id
			return
		}

        boolean needsTestObject = pollSectionInstance.needsTestObject
		boolean displayWideEnoughForIFrame = displayWideEnoughForIFrame(params.displayWidth as int)
        boolean displayTestObjectInIFrame = needsTestObject && displayWideEnoughForIFrame

        model: [pollInstance: pollInstance, pollSectionInstance: pollSectionInstance, opinionInstance: opinionInstance, needsTestObject: needsTestObject, displayTestObjectInIFrame: displayTestObjectInIFrame]
    }

    @Transactional
    def saveSubjectSelections(SaveSubjectSelectionsCommand cmd) {
		Opinion opinionInstance = Opinion.get(params.id as long)
		
        if (opinionInstance.submitted) opinionInstance.errors.reject('opinion.submitted.editFailure',
                "Your opinion has already been submitted. Changing your answers is no longer possible")

        if (opinionInstance.hasErrors()) {
            respond opinionInstance.errors, view: 'error'
            return
        }
		
		cmd.selections.each { subjectSelection ->
			opinionInstance.selections.put(subjectSelection.getKey(), subjectSelection.getValue() )
		}

        opinionInstance.save flush:true

        redirect action: 'answerSectionItems', id: opinionInstance.id, params: [displayWidth: params.displayWidth]
    }

    @Transactional
    def submitOpinion(Opinion opinionInstance) {
        def pollInstance = opinionInstance.poll

        if (!opinionInstance.submittable) {
            opinionInstance.errors.reject('opinion.items.unanswered', "You have not answered all items. Please answer the remaining items and submit your opinion again")
        }

        if (opinionInstance.hasErrors()) {
            def answeredItemsPerSection = getAnsweredItemsPerSection(opinionInstance)
            respond opinionInstance.errors, view: 'indexSubject', model: [pollInstance: pollInstance, opinionInstance: opinionInstance, answeredItemsPerSection: answeredItemsPerSection]
            return
        }

        opinionInstance.submitted = true
		opinionInstance.submittable = false
        opinionInstance.save flush:true

        redirect action: 'thanks'
    }

    def thanks() {

    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'opinion.label', default: 'Opinion'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    private static Map<PollSection,Integer> getAnsweredItemsPerSection (Opinion opinionInstance) {
        Poll pollInstance = opinionInstance.poll
        Map<PollSection, Integer> answeredItemsPerSection = new HashMap<PollSection, Integer>()
        for (pollSectionInstance in pollInstance.sections) {
            Integer count = 0
            for (itemInstance in pollSectionInstance.items) {
                if (opinionInstance.selections.containsKey(itemInstance.id as String))  count += 1
            }
            answeredItemsPerSection.put(pollSectionInstance as PollSection, count)
        }
        return answeredItemsPerSection
    }

    private static boolean allItemsAnswered(Opinion opinionInstance) {
        def itemIds = opinionInstance.poll.getPollItems().collect { it.id as String }
		return opinionInstance.selections.keySet().containsAll(itemIds)
    }
	
	private static boolean allSectionItemsAnswered(Map<String, Choice> selections, PollSection pollSectionInstance) {
		def itemIds = pollSectionInstance.items.collect { it.id as String }
		return selections.keySet().containsAll(itemIds)

	}
	
	private static boolean displayWideEnoughForIFrame(int displayWidth) {
		return displayWidth > 1024
	}
}
