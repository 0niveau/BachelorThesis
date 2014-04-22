package mypoll



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class SelectionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Selection.list(params), model:[selectionInstanceCount: Selection.count()]
    }

    def show(Selection selectionInstance) {
        respond selectionInstance
    }

    def create() {
        respond new Selection(params)
    }

    @Transactional
    def save(Selection selectionInstance) {
        if (selectionInstance == null) {
            notFound()
            return
        }

        if (selectionInstance.hasErrors()) {
            respond selectionInstance.errors, view:'create'
            return
        }

        selectionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'selectionInstance.label', default: 'Selection'), selectionInstance.id])
                redirect selectionInstance
            }
            '*' { respond selectionInstance, [status: CREATED] }
        }
    }

    def edit(Selection selectionInstance) {
        respond selectionInstance
    }

    @Transactional
    def update(Selection selectionInstance) {
        if (selectionInstance == null) {
            notFound()
            return
        }

        if (selectionInstance.hasErrors()) {
            respond selectionInstance.errors, view:'edit'
            return
        }

        selectionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Selection.label', default: 'Selection'), selectionInstance.id])
                redirect selectionInstance
            }
            '*'{ respond selectionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Selection selectionInstance) {

        if (selectionInstance == null) {
            notFound()
            return
        }

        selectionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Selection.label', default: 'Selection'), selectionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'selectionInstance.label', default: 'Selection'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
