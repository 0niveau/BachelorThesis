package mypoll



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class NominalScaleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond NominalScale.list(params), model:[nominalScaleInstanceCount: NominalScale.count()]
    }

    def show(NominalScale nominalScaleInstance) {
        respond nominalScaleInstance
    }

    def create() {
        respond new NominalScale(params)
    }

    @Transactional
    def save(NominalScale nominalScaleInstance) {
        if (nominalScaleInstance == null) {
            notFound()
            return
        }

        if (nominalScaleInstance.hasErrors()) {
            respond nominalScaleInstance.errors, view:'create'
            return
        }

        nominalScaleInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'nominalScaleInstance.label', default: 'NominalScale'), nominalScaleInstance.id])
                redirect nominalScaleInstance
            }
            '*' { respond nominalScaleInstance, [status: CREATED] }
        }
    }

    def edit(NominalScale nominalScaleInstance) {
        respond nominalScaleInstance
    }

    @Transactional
    def update(NominalScale nominalScaleInstance) {
        if (nominalScaleInstance == null) {
            notFound()
            return
        }

        if (nominalScaleInstance.hasErrors()) {
            respond nominalScaleInstance.errors, view:'edit'
            return
        }

        nominalScaleInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'NominalScale.label', default: 'NominalScale'), nominalScaleInstance.id])
                redirect nominalScaleInstance
            }
            '*'{ respond nominalScaleInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(NominalScale nominalScaleInstance) {

        if (nominalScaleInstance == null) {
            notFound()
            return
        }

        nominalScaleInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'NominalScale.label', default: 'NominalScale'), nominalScaleInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'nominalScaleInstance.label', default: 'NominalScale'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
