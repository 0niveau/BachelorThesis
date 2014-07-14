package mypoll

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['IS_AUTHENTICATED_REMEMBERED'])
@Transactional(readOnly = true)
class ChoiceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Choice.list(params), model:[choiceInstanceCount: Choice.count()]
    }

    def show(Choice choiceInstance) {
        respond choiceInstance
    }

    def create() {
        respond new Choice(params)
    }

    @Transactional
    def save(Choice choiceInstance) {
        if (choiceInstance == null) {
            notFound()
            return
        }

        if (choiceInstance.hasErrors()) {
            respond choiceInstance.errors, view:'create'
            return
        }

        choiceInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'choice.label', default: 'Choice'), choiceInstance.id])
                redirect choiceInstance
            }
            '*' { respond choiceInstance, [status: CREATED] }
        }
    }

    def edit(Choice choiceInstance) {
        respond choiceInstance
    }

    @Transactional
    def update(Choice choiceInstance) {
        if (choiceInstance == null) {
            notFound()
            return
        }

        if (choiceInstance.hasErrors()) {
            respond choiceInstance.errors, view:'edit'
            return
        }

        choiceInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'choice.label', default: 'Choice'), choiceInstance.id])
                redirect choiceInstance
            }
            '*'{ respond choiceInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Choice choiceInstance) {

        if (choiceInstance == null) {
            notFound()
            return
        }

        choiceInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'choice.label', default: 'Choice'), choiceInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'choice.label', default: 'Choice'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
