package mypoll

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional


class ScaleCreateCommand {
	String name
	List options = []
	
	Scale createScale () {
		Scale scaleInstance = new Scale(
			name: name,
			options: []
		)
		return scaleInstance
	}
}

class ScaleUpdateCommand {
    String name
    List options = []
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
		boolean useInQuestion
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

		cmd.options.each { value ->
			Option optionInstance = new Option(value: value)
			if (optionInstance.validate()) {
                scaleInstance.options.add(optionInstance)
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
				flash.message = message(code: 'default.created.message', args: [message(code: 'ScaleInstance.label', default: 'Scale'), scaleInstance.id])
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

        List<Option> newOptions = []

        cmd.options.each { value ->
            Option optionInstance = new Option(value: value)
            if (optionInstance.validate()) {
                newOptions.add(optionInstance)
            }
        }

        scaleInstance.name = cmd.name
        scaleInstance.options = newOptions

		if (scaleInstance.validate()) {
            scaleInstance.save flush:true

            flash.message = message(code: 'default.updated.message', args: [message(code: 'Scale.label', default: 'Scale'), scaleInstance.id])

            redirect scaleInstance

        } else {
            respond scaleInstance.errors, view: 'edit'
            return
        }
	}
	
	protected void notFound() {
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'ScaleInstance.label', default: 'Scale'), params.id])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}
}
