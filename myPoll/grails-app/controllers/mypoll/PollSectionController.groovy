package mypoll



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)

class PollSectionAddItemsCommand {
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
        Poll pollInstance = pollSectionInstance.poll
        def toBeEdited = params.toBeEdited

        render view: '/poll/show', model: [pollInstance: pollInstance, targetId: pollSectionInstance.id, mode: toBeEdited]

    }
	
	/*
	 * Passes a list of questions to the poll's 'show' view, that could be added to a specific pollSection
	 */
	def addableItems() {
		PollSection pollSectionInstance = PollSection.get(params.id)
		Poll pollInstance = pollSectionInstance.poll
		
		// retrieve question that have been added so far
		def idsOfAddedQuestions = []
		pollSectionInstance.items.each { item -> idsOfAddedQuestions.add(item.idOfOrigin) }
		
		// find all questions, that have not been added yet
		def allQuestions = Question.getAll()		
		def selectableQuestions = allQuestions.findAll { !idsOfAddedQuestions.contains(it.id) }
		
		render view: '/poll/show', model: [pollInstance: pollInstance, targetId: pollSectionInstance.id, selectableQuestions: selectableQuestions, mode: 'sectionAddItems']
	}
	
	/*
	 * Takes a selection of myPoll.Question and for each them adds an item to the the pollSection
	 * @cmd the command objects that contains the ids of the selected questions
	 */
	def addItems(PollSectionAddItemsCommand cmd) {
		def pollSectionInstance = PollSection.get(params.id)
		def pollInstance = pollSectionInstance.poll
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
			def itemInstance = new Item(title: question.title, question: question.text, idOfOrigin: question.id, pollSection: pollSectionInstance)
			for (option in question.getScale().getOptions()) {
				itemInstance.addToOptions(new Option(index: option.index, value: option.value))
			}
			itemInstance.save flush: true
		}
		render view: '/poll/show', model:[pollInstance: pollInstance, targetId: pollSectionInstance.id]
		
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

        flash.message = message(code: 'default.updated.message', args: [message(code: 'PollSection.label', default: 'PollSection'), pollSectionInstance.id])

        render view: '/Poll/show', model: [pollInstance: pollSectionInstance.poll, targetId: pollSectionInstance.id]

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
