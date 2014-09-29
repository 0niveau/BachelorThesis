package mypoll

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

class QuestionCreateCommand {
    String text
    String scale

    def createQuestion() {

        def questionInstance
        if (scale == "none") {
            questionInstance = new Question( text: text, scale: null, type: QuestionType.OPEN )
        } else {
            def scaleInstance = Scale.get(scale as Long)
            questionInstance = new Question( text: text, scale: scaleInstance, type: QuestionType.CLOSED )
        }

        return questionInstance
    }
}

class QuestionUpdateCommand {
    String id
    String property
    String text
    String scale

    def updateQuestion() {
        Question questionInstance = Question.get(id as Long)

        if (property == "text") {
            questionInstance.text = text
        }

        if (property == "scale") {

            if (scale == "none") {
                questionInstance.scale = null
                questionInstance.type = QuestionType.OPEN
            } else {
                def scaleInstance = Scale.get(scale as Long)
                questionInstance.scale = scaleInstance
                questionInstance.type = QuestionType.CLOSED
            }
        }
        return questionInstance
    }
}

@Secured(['IS_AUTHENTICATED_REMEMBERED'])
@Transactional(readOnly = true)
class QuestionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Question.list(params), model:[questionInstanceCount: Question.count(), sort: params.sort, order: params.order]
    }

    def show(Question questionInstance) {
        respond questionInstance
    }

    def create() {
		def pollSectionId = ""
		if(params.pollSectionId) {
			pollSectionId = params.pollSectionId as long
		}
        respond new Question(params), model:[pollSectionId: pollSectionId]
    }

    @Transactional
    def save(QuestionCreateCommand cmd) {
        if (cmd == null) {
            notFound()
            return
        }

        Question questionInstance = cmd.createQuestion()

        if (!questionInstance.validate()) {
            respond questionInstance.errors, view:'create'
            return
        }

        if (questionInstance.type == QuestionType.OPEN) {
            questionInstance.save flush:true
        } else if (questionInstance.type == QuestionType.CLOSED) {
            questionInstance.scale.addToQuestions(questionInstance).save flush:true
        }
		
		if(params.pollSectionId) {
			redirect controller: 'pollSection', action: 'addableItems', id: params.pollSectionId as long
			return
		}

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.text])
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
    def update(QuestionUpdateCommand cmd) {
        if (cmd == null) {
            notFound()
            return
        }

        Question questionInstance = cmd.updateQuestion()

        if (!questionInstance.validate()) {
            respond questionInstance.errors, view:'show'
            return
        }

        if (questionInstance.type == QuestionType.OPEN) {
            questionInstance.save flush:true
        } else if (questionInstance.type == QuestionType.CLOSED) {
            questionInstance.scale.addToQuestions(questionInstance).save flush:true
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.text])
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
		
		def scaleInstance = questionInstance.scale
		scaleInstance.questions.remove(questionInstance)
		scaleInstance.save flush:true
        questionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'question.label', default: 'Question'), questionInstance.text])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'question.label', default: 'Question'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
