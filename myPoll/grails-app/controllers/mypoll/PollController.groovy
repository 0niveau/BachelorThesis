package mypoll

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

class PollCreateCommand {
	String name
	String description
	Boolean clustering
	Boolean comparing
	Boolean feedback
	String testObjectUrlA
	String testObjectUrlB
	
	static constraints = {
		name blank: false
		clustering nullable: true
		comparing nullable: true
		feedback nullable: true
		testObjectUrlA nullable: true
		testObjectUrlB nullable: true
	}
	
	Poll createPoll() {
		def pollInstance = new Poll(
			name: name,
			description: description,
			isActive: false,
			testObjectUrlA: testObjectUrlA,
			testObjectUrlB: testObjectUrlB		
		)
        return pollInstance
	}
}

class saveSubjectSelectionsCommand {
    Map<Item, Option> selections
}

@Transactional(readOnly = true)
class PollController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Poll.list(params), model:[pollInstanceCount: Poll.count()]
    }
	
	/*
	 * This renders the initial page a subject will see.
	 */
	def indexSubject(Opinion opinionInstance) {
		Poll pollInstance = opinionInstance.poll
        Map<PollSection, Integer> answeredItemsPerSection = new HashMap<PollSection, Integer>()
        for (pollSectionInstance in pollInstance.sections) {
            Integer count = 0
            for (itemInstance in pollSectionInstance.items) {
                if (opinionInstance.selections.containsKey(itemInstance.id as String))  count += 1
            }
            answeredItemsPerSection.put(pollSectionInstance, count)
        }
		model: [pollInstance: pollInstance, opinionInstance: opinionInstance, answeredItemsPerSection: answeredItemsPerSection]
	}

    def show(Poll pollInstance) {
        def targetId = params.targetId as Long
        render view: 'show', model: [pollInstance: pollInstance, targetId: targetId]
    }

    def create() {
        respond new Poll(params)
    }

	/*
	 * creates the new poll and its sections
	 * @cmd contains the values needed for the creation of the new poll	
	 */
    @Transactional
    def save(PollCreateCommand cmd) {
        if (cmd == null) {
            notFound()
            return
        }

        if (cmd.hasErrors()) {
            respond cmd.errors, view:'create'
            return
        }
		
		def pollInstance = cmd.createPoll()
		pollInstance.save flush:true
		if (cmd.clustering) {
			def clustering = new PollSection(name: 'Clustering', needsTestObject: false, poll: pollInstance)
			clustering.save flush:true
		}
		if (cmd.comparing) {
			def comparing = new PollSection(name: 'Comparing', needsTestObject: true, poll: pollInstance)
			comparing.save flush:true	
		}
		if (cmd.feedback) {
			def feedback = new PollSection(name: 'Feedback', needsTestObject: false, poll: pollInstance)
			feedback.save flush:true		
		}
		
        pollInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pollInstance.label', default: 'Poll'), pollInstance.id])
                redirect pollInstance
            }
            '*' { respond pollInstance, [status: CREATED] }
        }
    }

    @Transactional
    def update(Poll pollInstance) {
        if (pollInstance == null) {
            notFound()
            return
        }

        if (pollInstance.hasErrors()) {
            respond pollInstance.errors, view:'edit'
            return
        }

        pollInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Poll.label', default: 'Poll'), pollInstance.id])
                redirect pollInstance
            }
            '*'{ respond pollInstance, [status: OK] }
        }
    }
	
	/*
	 * creates a new Opinion and links it to the poll, then redirects to the poll's index page for subjects
	 */
	def addOpinion(Poll pollInstance) {
				
		String testObjectUrl = ( pollInstance.opinions.size() % 2 == 0 ? pollInstance.testObjectUrlA : pollInstance.testObjectUrlB )
		Opinion opinionInstance = new Opinion(testObjectUrl: testObjectUrl, poll: pollInstance)
		opinionInstance.save flush:true 
		
		redirect action: 'indexSubject', id: opinionInstance.id
	}
	
	def answerSectionItems() {
		Poll pollInstance = Poll.get(params.pollId)
		PollSection pollSectionInstance = PollSection.get(params.sectionId)
		Opinion opinionInstance = Opinion.get(params.opinionId)
		
		Boolean needsTestObject = pollSectionInstance.needsTestObject
		
		model: [pollInstance: pollInstance, pollSectionInstance: pollSectionInstance, opinionInstance: opinionInstance, needsTestObject: needsTestObject]
	}

    def saveSubjectSelections(saveSubjectSelectionsCommand cmd) {
        Opinion opinionInstance = Opinion.get(params.id)
        opinionInstance.selections.putAll(cmd.selections)

        opinionInstance.save flush:true

        redirect action: 'indexSubject', id: opinionInstance.id

    }

    @Transactional
    def delete(Poll pollInstance) {

        if (pollInstance == null) {
            notFound()
            return
        }

        pollInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Poll.label', default: 'Poll'), pollInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pollInstance.label', default: 'Poll'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
