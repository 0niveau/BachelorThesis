package mypoll

import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional


class ScaleCreateCommand {
	String name
	List choices = []
	
	Scale createScale () {
		Scale scaleInstance = new Scale(
			name: name,
			choices: []
		)
		return scaleInstance
	}
}

class ScaleUpdateCommand {
    String name
    List choices = []
}

@Secured(['IS_AUTHENTICATED_REMEMBERED'])
@Transactional(readOnly = true)
class ScaleController {
	
	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		respond Scale.list(params), model:[scaleInstanceCount: Scale.count(), sort: params.sort, order: params.order]
	}
	
	def show(Scale scaleInstance) {
		respond scaleInstance
	}
	
	def create() {
		boolean useInQuestion = false
		if(params.useInQuestion) { 
			useInQuestion = params.useInQuestion as boolean
		}
		respond new Scale(params), model: [useInQuestion: useInQuestion]
	}
	
	@Transactional
	def save(ScaleCreateCommand cmd) {
		if (cmd == null) {
			notFound()
			return
		}
		
		if (cmd.hasErrors()) {
			respond cmd.errors, view: 'create'
			return
		}
		
		Scale scaleInstance = cmd.createScale()		

		cmd.choices.each { value ->
			Choice choiceInstance = new Choice(value: value)
			if (choiceInstance.validate()) {
                scaleInstance.choices.add(choiceInstance)
			}
		}

        if (scaleInstance.validate()) {
            scaleInstance.save flush:true
        } else {
            respond scaleInstance.errors, view: 'create'
            return
        }
		
		if (params.useInQuestion) {
			redirect controller: 'question', action: 'create'
			return	
		}
		
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.created.message', args: [message(code: 'scale.label', default: 'Scale'), scaleInstance.id])
				redirect scaleInstance
			}
			'*' { respond scaleInstance, [status: CREATED] }
		}			
	}

    def edit(Scale scaleInstance) {
        respond scaleInstance

    }
	
	@Transactional
	def update(ScaleUpdateCommand cmd) {
        Scale scaleInstance = Scale.get(params.id)

        if (scaleInstance == null) {
            notFound()
            return
        }

        List<Choice> newChoices = []

        cmd.choices.each { value ->
            Choice choiceInstance = new Choice(value: value)
            if (choiceInstance.validate()) {
                newChoices.add(choiceInstance)
            }
        }

        scaleInstance.name = cmd.name
        scaleInstance.choices = newChoices

		if (scaleInstance.validate()) {
            scaleInstance.save flush:true

            flash.message = message(code: 'default.updated.message', args: [message(code: 'scale.label', default: 'Scale'), scaleInstance.id])

            redirect scaleInstance

        } else {
            respond scaleInstance.errors, view: 'edit'
        }
	}
	
	@Transactional
	def delete(Scale scaleInstance) {

		if (scaleInstance == null) {
			notFound()
			return
		}
		
		if (!scaleInstance.questions.isEmpty()) {
			scaleInstance.errors.reject('scaleInstance.delete.failure.inUse', "You can't delete a scale, that is still used by a question!")
		}
		
		if (scaleInstance.hasErrors()) {
			respond scaleInstance.errors, view: 'index', model: [scaleInstanceList: Scale.list(), defectiveScale: scaleInstance]
			return
		}

		scaleInstance.delete flush:true

		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.deleted.message', args: [message(code: 'scale.label', default: 'Scale'), scaleInstance.id])
				redirect action:"index", method:"GET"
			}
			'*'{ render status: NO_CONTENT }
		}
	}
	
	protected void notFound() {
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'scale.label', default: 'Scale'), params.id])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}
}
