package mypoll

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional


class ScaleCreateCommand {
	String name
	List options = []
	
	static constraints = {
		name blank: false
		options minSize: 2
	}
	
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

    static constraints = {
        name blank: false
        options minSize: 2
    }
}

@Secured(['IS_AUTHENTICATED_REMEMBERED'])
@Transactional(readOnly = true)
class ScaleController {
	
	static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		respond Scale.list(params), model:[scaleInstanceCount: Scale.count()]
	}
	
	def show(Scale scaleInstance) {
		respond scaleInstance
	}
	
	def create() {
		respond new Scale(params)
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

		for (option in cmd.options) {
			Option optionInstance = new Option(value: option)
			if (optionInstance.hasErrors()) {
				return
			}
			optionInstance.save flush:true
			scaleInstance.options.add(optionInstance)
		}
		scaleInstance.save flush:true
		
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

        scaleInstance.name = cmd.name
        List<Option> currentOptions = scaleInstance.options
        List<Option> newOptions = createOptionsFromValues(cmd.options)

        scaleInstance.options = newOptions

		if (scaleInstance == null) {
			notFound()
			return
		}
		
		if (scaleInstance.hasErrors()) {
			respond scaleInstance.errors, view: 'edit'
			return
		}

        /*
        for (optionInstance in currentOptions) {
            optionInstance.delete flush:true
        }
        */

		scaleInstance.save flush:true
		
		flash.message = message(code: 'default.updated.message', args: [message(code: 'Scale.label', default: 'Scale'), scaleInstance.id])
		
		redirect scaleInstance
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

    def createOptionsFromValues (List<String> values) {
        List<Option> options = []
        for (value in values) {
            Option optionInstance = new Option(value: value)
            if (optionInstance.hasErrors()) {
                return
            }
            optionInstance.save flush:true
            options.add(optionInstance)
        }
        return options
    }
}
