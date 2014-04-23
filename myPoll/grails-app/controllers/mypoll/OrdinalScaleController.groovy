package mypoll



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)

class OrdinalScaleSaveCommand {
	String name
	List options = []
}

class OrdinalScaleController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond OrdinalScale.list(params), model:[ordinalScaleInstanceCount: OrdinalScale.count()]
    }

    def show(OrdinalScale ordinalScaleInstance) {
        respond ordinalScaleInstance
    }

    def create() {
		int numberOfOptions = params.numberOfOptions as int
		model: [numberOfOptions: numberOfOptions]
    }	

    @Transactional
    def save(OrdinalScaleSaveCommand cmd) {
        if (cmd == null) {
            notFound()
            return
        }

        if (cmd.hasErrors()) {
            respond ordinalScaleInstance.errors, view:'create'
            return
        }

		def ordinalScaleInstance = new OrdinalScale(name: cmd.name)
        ordinalScaleInstance.save flush:true
		
		for (option in cmd.options) {
			def optionInstance = new Option(index: cmd.options.indexOf(option) + 1, value: option)
			optionInstance.save flush:true		
			ordinalScaleInstance.addToOptions(optionInstance)	
		}
		
		ordinalScaleInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'ordinalScaleInstance.label', default: 'OrdinalScale'), ordinalScaleInstance.id])
                redirect ordinalScaleInstance
            }
            '*' { respond ordinalScaleInstance, [status: CREATED] }
        }
    }

	/*
    def edit(OrdinalScale ordinalScaleInstance) {
        respond ordinalScaleInstance
    }
    */

	/*
    @Transactional
    def update(OrdinalScale ordinalScaleInstance) {
        if (ordinalScaleInstance == null) {
            notFound()
            return
        }

        if (ordinalScaleInstance.hasErrors()) {
            respond ordinalScaleInstance.errors, view:'edit'
            return
        }

        ordinalScaleInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'OrdinalScale.label', default: 'OrdinalScale'), ordinalScaleInstance.id])
                redirect ordinalScaleInstance
            }
            '*'{ respond ordinalScaleInstance, [status: OK] }
        }
    }
    */

    @Transactional
    def delete(OrdinalScale ordinalScaleInstance) {

        if (ordinalScaleInstance == null) {
            notFound()
            return
        }

        ordinalScaleInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'OrdinalScale.label', default: 'OrdinalScale'), ordinalScaleInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'ordinalScaleInstance.label', default: 'OrdinalScale'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
