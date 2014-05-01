package mypoll



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)

class PollSectionAddItemsCommand{
	List questionIds = []
}

class PollSectionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PollSection.list(params), model:[pollSectionInstanceCount: PollSection.count()]
    }

    def show(PollSection pollSectionInstance) {
        respond pollSectionInstance
    }

    def create() {
        respond new PollSection(params)
    }

    @Transactional
    def save(PollSection pollSectionInstance) {
        if (pollSectionInstance == null) {
            notFound()
            return
        }

        if (pollSectionInstance.hasErrors()) {
            respond pollSectionInstance.errors, view:'create'
            return
        }

        pollSectionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pollSectionInstance.label', default: 'PollSection'), pollSectionInstance.id])
                redirect pollSectionInstance
            }
            '*' { respond pollSectionInstance, [status: CREATED] }
        }
    }

    def edit(PollSection pollSectionInstance) {
        respond pollSectionInstance
    }
	
	/*
	 * Takes a selection of myPoll.Question and for each them adds an item to the the pollSection
	 * @cmd the command objects that contains the ids of the selected questions
	 */
	def addItems(PollSectionAddItemsCommand cmd) {
		def pollSectionInstance = PollSection.get(params.id)
		def questions = []
		def items = []
		
		// retrieve the selected questions
		for (questionId in cmd.questionIds) {
			if( questionId!=null ) {
				questions.add(Question.get(questionId))
			}			
		}		
		
		// for each question, create an item and add it to the pollSection
		for (question in questions) {
			def itemInstance = new Item(title: question.title, question: question.text, pollSection: pollSectionInstance)
			for (option in question.getScale().getOptions()) {
				itemInstance.addToOptions(new Option(index: option.index, value: option.value))
			}
			itemInstance.save flush: true
		}
		redirect action: "show", id: params.id
		
	}

    @Transactional
    def update(PollSection pollSectionInstance) {
        if (pollSectionInstance == null) {
            notFound()
            return
        }

        if (pollSectionInstance.hasErrors()) {
            respond pollSectionInstance.errors, view:'edit'
            return
        }

        pollSectionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PollSection.label', default: 'PollSection'), pollSectionInstance.id])
                redirect pollSectionInstance
            }
            '*'{ respond pollSectionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PollSection pollSectionInstance) {

        if (pollSectionInstance == null) {
            notFound()
            return
        }

        pollSectionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PollSection.label', default: 'PollSection'), pollSectionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pollSectionInstance.label', default: 'PollSection'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
