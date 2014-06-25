package mypoll

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['IS_AUTHENTICATED_REMEMBERED'])
@Transactional(readOnly = true)
class QuestionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
		def selectable
		def sectionId
		if (params.addToSection) {
			selectable = true
		}
		if (params.id) {
			sectionId=params.id
		}
        params.max = Math.min(max ?: 10, 100)
        respond Question.list(params), model:[questionInstanceCount: Question.count(), selectable: selectable, sectionId: sectionId]
    }

    def show(Question questionInstance) {
        respond questionInstance
    }

    def create() {
		def pollSectionId
		if(params.pollSectionId) {
			pollSectionId = params.pollSectionId as long
		}
        respond new Question(params), model:[pollSectionId: pollSectionId]
    }

    @Transactional
    def save(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }

        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view:'create'
            return
        }

        questionInstance.save flush:true
		
		if(params.pollSectionId) {
			redirect controller: 'pollSection', action: 'addableItems', id: params.pollSectionId as long
			return
		}

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'questionInstance.label', default: 'Question'), questionInstance.id])
                redirect questionInstance
            }
            '*' { respond questionInstance, [status: CREATED] }
        }
    }

    def edit(Question questionInstance) {
        def toBeEdited = params.toBeEdited

        render view: 'show', model: [questionInstance: questionInstance, toBeEdited: toBeEdited]
    }

    @Transactional
    def update(Question questionInstance) {
        if (questionInstance == null) {
            notFound()
            return
        }

        if (questionInstance.hasErrors()) {
            respond questionInstance.errors, view:'edit'
            return
        }

        questionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
                redirect questionInstance
            }
            '*'{ respond questionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Question questionInstance) {

        if (questionInstance == null) {
            notFound()
            return
        }

        questionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Question.label', default: 'Question'), questionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'questionInstance.label', default: 'Question'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
