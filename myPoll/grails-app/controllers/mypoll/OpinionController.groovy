package mypoll



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OpinionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Opinion.list(params), model:[opinionInstanceCount: Opinion.count()]
    }

    def show(Opinion opinionInstance) {
        respond opinionInstance
    }

	@Transactional
    def create() {
		Poll pollInstance = Poll.get(params.id)
		
		Opinion opinionInstance = new Opinion(poll: pollInstance)
		(pollInstance.optinions().length() % 2 == 0) ? testObjectUrl = pollInstance.testObjectUrlA	: pollInstance.testObjectUrlB
		
		opinionInstance.testObjectUrl = testObjectUrl
		
		opinionInstance.save flush:true		
		
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [message(code: 'opinionInstance.label', default: 'Opinion'), opinionInstance.id])
				redirect opinionInstance
			}
			'*' { respond opinionInstance, [status: CREATED] }
		}
    }

    @Transactional
    def save(Opinion opinionInstance) {
        if (opinionInstance == null) {
            notFound()
            return
        }

        if (opinionInstance.hasErrors()) {
            respond opinionInstance.errors, view:'create'
            return
        }

        opinionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'opinionInstance.label', default: 'Opinion'), opinionInstance.id])
                redirect opinionInstance
            }
            '*' { respond opinionInstance, [status: CREATED] }
        }
    }

    def edit(Opinion opinionInstance) {
        respond opinionInstance
    }

    @Transactional
    def update(Opinion opinionInstance) {
        if (opinionInstance == null) {
            notFound()
            return
        }

        if (opinionInstance.hasErrors()) {
            respond opinionInstance.errors, view:'edit'
            return
        }

        opinionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Opinion.label', default: 'Opinion'), opinionInstance.id])
                redirect opinionInstance
            }
            '*'{ respond opinionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Opinion opinionInstance) {

        if (opinionInstance == null) {
            notFound()
            return
        }

        opinionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Opinion.label', default: 'Opinion'), opinionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
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
}
