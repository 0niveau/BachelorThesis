package mypoll

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)

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
		def poll = new Poll(
			name: name,
			description: description,
			isActive: false,
			testObjectUrlA: testObjectUrlA,
			testObjectUrlB: testObjectUrlB			
		) 
	}
}

class PollController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Poll.list(params), model:[pollInstanceCount: Poll.count()]
    }

    def show(Poll pollInstance) {
        respond pollInstance
    }

    def create() {
        respond new Poll(params)
    }

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
	def saveTwo(Poll pollInstance) {
		if (pollInstance == null) {
			notFound()
			return
		}

		if (pollInstance.hasErrors()) {
			respond pollInstance.errors, view:'create'
			return
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

    def edit(Poll pollInstance) {
        respond pollInstance
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
