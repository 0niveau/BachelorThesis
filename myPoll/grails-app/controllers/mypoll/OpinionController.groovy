package mypoll

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
@Transactional(readOnly = true)
class OpinionController {

    // injecting exportService from export plugin
    def exportService
    def grailsApplication

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Opinion.list(params), model:[opinionInstanceCount: Opinion.count()]
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
    def addOpinion(Poll pollInstance) {
        if (!pollInstance.isActive) return

        String testObjectUrl = ( pollInstance.opinions.size() % 2 == 0 ? pollInstance.testObjectUrlA : pollInstance.testObjectUrlB )
        Opinion opinionInstance = new Opinion(
			testObjectUrl: testObjectUrl, 
			poll: pollInstance, 
			submittable: false, 
			submitted: false)
        opinionInstance.save flush:true

        redirect action: 'indexSubject', id: opinionInstance.id
    }

    /*
     * groups the submitted Opinions by testObjectUrl and passes both lists to the corresponding view
     * TODO factor this out to poll controller
     */
    @Secured(['IS_AUTHENTICATED_REMEMBERED'])
    def opinionList(Poll pollInstance) {		

		def aggregatedResults = aggregatePollResults(pollInstance)
		
        model: [pollInstance: pollInstance, aggregatedResults: aggregatedResults]
    }
	
	private List<ItemAggregation> aggregatePollResults(Poll pollInstance) {
		List<Item> pollItems = pollInstance.getPollItems()
		List<Opinion> opinionsA = pollInstance.opinions.findAll { opinion -> opinion.testObjectUrl == pollInstance.testObjectUrlA && opinion.submitted }
		List<Opinion> opinionsB = pollInstance.opinions.findAll { opinion -> opinion.testObjectUrl == pollInstance.testObjectUrlB && opinion.submitted }
		
		List<ItemAggregation> itemAggregations = []
		
		for (pollItem in pollItems) {
			
			List<Selection> itemAnswersA = opinionsA.collect { opinion -> opinion.selections.get(pollItem.id as String) }
			List<Selection> itemAnswersB = opinionsB.collect { opinion -> opinion.selections.get(pollItem.id as String) }
			
			ItemAggregation itemAggregation = new ItemAggregation()
			itemAggregation.item = pollItem
			itemAggregation.question = pollItem.question
			itemAggregation.possibleAnswers = pollItem.options.collect {option -> option.value }
			itemAggregation.selectionsPerAnswerA = itemAggregation.possibleAnswers.collectEntries { answer -> [(answer): itemAnswersA.findAll { itemAnswer -> itemAnswer.value == answer }.size()] }
			itemAggregation.selectionsPerAnswerB = itemAggregation.possibleAnswers.collectEntries { answer -> [(answer): itemAnswersB.findAll { itemAnswer -> itemAnswer.value == answer }.size()] }
			
			itemAggregations.add(itemAggregation)
		}
			
		return itemAggregations
	}

    /*
     * takes all submitted opinions that have the chosen testObjectUrl and writes the selected values to a csv file
     * TODO factor this out to poll controller
     */
    @Secured(['IS_AUTHENTICATED_REMEMBERED'])
    def exportOpinions() {
        Poll pollInstance = Poll.get(params.pollId)

        List items = pollInstance.getPollItems()

        String testObjectUrl = params.testObjectUrl
        String filename = testObjectUrl.replace("http://","")

        // only the opinions with the desired testObjectUrl will be exported
        List opinions = Opinion.findAll { testObjectUrl == testObjectUrl }

        List<String> fields = []
        Map labels = [:]

        for (itemInstance in items) {
            // Extracting the values from the opinions' selections
            fields.add("selections.${ itemInstance.id as String }.value")

            // labeling each column with the corresponding question-text
            labels.put('selections.' + itemInstance.id.toString() + '.value', itemInstance.question)
        }

        Map parameters = [separator: ',', quoteCharacter: "\u0000"]

        response.contentType = "text/csv"
        response.addHeader("Content-disposition", "attachment;filename=${filename}.csv")

        exportService.export('csv', response.outputStream, opinions, fields as List<String>, labels, [:], parameters)

    }

    def answerSectionItems(Opinion opinionInstance) {

        if (opinionInstance.submitted) return

        Poll pollInstance = opinionInstance.poll
        PollSection pollSectionInstance = pollInstance.sections.find{ pollSectionInstance -> 
				allSectionItemsAnswered(opinionInstance.selections, pollSectionInstance) == false }
		
		if (pollSectionInstance == null) {
			opinionInstance.submittable = true
			opinionInstance.save flush:true
			redirect action: 'indexSubject', id: opinionInstance.id
			return
		}

        boolean needsTestObject = pollSectionInstance.needsTestObject
		boolean displayWideEnoughForIFrame = displayWideEnoughForIFrame(params.displayWidth as int)
        boolean displayTestObjectInIFrame = needsTestObject && displayWideEnoughForIFrame

        model: [pollInstance: pollInstance, pollSectionInstance: pollSectionInstance, opinionInstance: opinionInstance, needsTestObject: needsTestObject, displayTestObjectInIFrame: displayTestObjectInIFrame]
    }

    def saveSubjectSelections(SaveSubjectSelectionsCommand cmd) {
		Opinion opinionInstance = Opinion.get(params.id)
		
        if (opinionInstance.submitted) opinionInstance.errors.reject('opinion.submitted.editFailure',
                "Your opinion has already been submitted. Changing your answers is no longer possible")

        if (opinionInstance.hasErrors()) {
            respond opinionInstance.errors, view: 'error'
            return
        }
		
		cmd.selections.each { subjectSelection ->
			opinionInstance.selections.put(subjectSelection.getKey(), new Selection( opinion: opinionInstance, value: subjectSelection.getValue()) )				
		}

        opinionInstance.save flush:true

        redirect action: 'answerSectionItems', id: opinionInstance.id, params: [displayWidth: params.displayWidth]
    }

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
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'opinionInstance.label', default: 'Opinion'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    private Map<PollSection,Integer> getAnsweredItemsPerSection (Opinion opinionInstance) {
        Poll pollInstance = opinionInstance.poll
        Map<PollSection, Integer> answeredItemsPerSection = new HashMap<PollSection, Integer>()
        for (pollSectionInstance in pollInstance.sections) {
            Integer count = 0
            for (itemInstance in pollSectionInstance.items) {
                if (opinionInstance.selections.containsKey(itemInstance.id as String))  count += 1
            }
            answeredItemsPerSection.put(pollSectionInstance, count)
        }
        return answeredItemsPerSection
    }

    private boolean allItemsAnswered(Opinion opinionInstance) {
        def itemIds = opinionInstance.poll.getPollItems().collect { it.id as String }
		return opinionInstance.selections.keySet().containsAll(itemIds)
    }
	
	private boolean allSectionItemsAnswered(Map<String, Option> selections, PollSection pollSectionInstance) {
		def itemIds = pollSectionInstance.items.collect { it.id as String }
		return selections.keySet().containsAll(itemIds)

	}
	
	private boolean displayWideEnoughForIFrame(int displayWidth) {
		return displayWidth > 768
	}
}
