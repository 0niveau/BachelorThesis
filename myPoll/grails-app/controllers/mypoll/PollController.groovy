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
		testObjectUrlA nullable: false, blank: false
		testObjectUrlB nullable: false, blank: false
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

    static allowedMethods = [save: "POST", update: "PUT",toggleActivation: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Poll.list(params), model:[pollInstanceCount: Poll.count()]
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
    def save(Poll pollInstance) {
        if (pollInstance == null) {
            notFound()
            return
        }

        if (pollInstance.hasErrors()) {
            respond pollInstance.errors, view:'create'
            return
        }

		pollInstance.save flush:true

		if (params.clustering) {
			def clustering = new PollSection(name: 'Clustering', needsTestObject: false, poll: pollInstance)
			clustering.save flush:true
		}
		if (params.comparing) {
			def comparing = new PollSection(name: 'Comparing', needsTestObject: true, poll: pollInstance)
			comparing.save flush:true	
		}
		if (params.feedback) {
			def feedback = new PollSection(name: 'Feedback', needsTestObject: false, poll: pollInstance)
			feedback.save flush:true		
		}

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pollInstance.label', default: 'Poll'), pollInstance.id])
                redirect pollInstance
            }
            '*' { respond pollInstance, [status: CREATED] }
        }
    }

    def edit(Poll pollInstance) {
        def toBeEdited = params.toBeEdited

        render view: 'show', model:[pollInstance: pollInstance, toBeEdited: toBeEdited]
    }

    @Transactional
    def update(Poll pollInstance) {

        if (pollInstance.isActive) pollInstance.errors.reject('poll.isActive.editFailure', "You can't edit an acitve poll")

        if (pollInstance == null) {
            notFound()
            return
        }

        if (pollInstance.hasErrors()) {
            respond pollInstance.errors, view:'show'
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

    @Transactional
    def toggleActivation(Poll pollInstance) {
        if (pollInstance == null) {
            notFound()
            return
        }

        if (pollInstance.hasErrors()) {
            respond pollInstance.errors, view:'edit'
            return
        }

        if (pollInstance.isActive) {
            def oldOpinions = pollInstance.opinions
            pollInstance.opinions = []

            for (opinionInstance in oldOpinions) {
                opinionInstance.delete flush: true
            }
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
