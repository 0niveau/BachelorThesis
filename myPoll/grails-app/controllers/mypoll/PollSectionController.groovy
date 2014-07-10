package mypoll

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

class PollSectionAddItemsCommand {
	List questionIds = []
}

@Secured(['IS_AUTHENTICATED_REMEMBERED'])
@Transactional(readOnly = true)
class PollSectionController {

    static allowedMethods = [save: "POST", updateItemOrder: "PUT", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PollSection.list(params), model:[pollSectionInstanceCount: PollSection.count()]
    }

    def show(PollSection pollSectionInstance) {
        redirect controller: 'poll', action: 'show', params: [id: pollSectionInstance.poll.id, targetId: pollSectionInstance.id]
    }

    def showAllItems(PollSection pollSectionInstance) {
        render view: "/poll/show", model: [pollInstance: pollSectionInstance.poll, targetId: pollSectionInstance.id, mode: 'showAllItems']
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
            respond pollSectionInstance.errors, view:'/poll/show', model: [pollInstance: pollSectionInstance.poll, targetId: 'newSection', newPollSectionInstance: pollSectionInstance]
            return
        }

        pollSectionInstance.save flush:true

        flash.message = message(code: 'default.created.message', args: [message(code: 'pollSectionInstance.label', default: 'PollSection'), pollSectionInstance.id])

        redirect controller: 'poll', action: 'show', params: [id: pollSectionInstance.poll.id, targetId: pollSectionInstance.id]

    }

	/*
	 * Renders a poll's 'show' view in a specified state, that allows the user to edit specific properties of the pollSection
	 */
    def edit(PollSection pollSectionInstance) {
        Poll pollInstance = pollSectionInstance.poll
        def toBeEdited = params.toBeEdited

        render view: '/poll/show', model: [pollInstance: pollInstance, targetId: pollSectionInstance.id, toBeEdited: toBeEdited]

    }
	
	/*
	 * Passes a list of questions to the poll's 'show' view, that could be added to a specific pollSection
	 */
	def addableItems() {
		PollSection pollSectionInstance = PollSection.get(params.id)
		Poll pollInstance = pollSectionInstance.poll

        if (pollInstance.isActive) pollInstance.errors.reject('poll.isActive.editFailure', "You can't edit an active poll")

        if (pollInstance.hasErrors()) {
            resond pollInstance.errors, view: 'poll/show'
            return
        }
		
		// retrieve question that have been added so far
		def idsOfAddedQuestions = []
		pollSectionInstance.items.each { item -> idsOfAddedQuestions.add(item.idOfOrigin) }
		
		// find all questions, that have not been added yet
		def allQuestions = Question.getAll()		
		def selectableQuestions = allQuestions.findAll { !idsOfAddedQuestions.contains(it.id) }
		
		render view: '/poll/show', model: [pollInstance: pollInstance, targetId: pollSectionInstance.id, selectableQuestions: selectableQuestions, mode: 'addSectionItems']
	}
	
	/*
	 * Takes a selection of myPoll.Question and for each them adds an item to the the pollSection
	 * @cmd the command objects that contains the ids of the selected questions
	 */
	def addItems(PollSectionAddItemsCommand cmd) {
		def pollSectionInstance = PollSection.get(params.id)
		def pollInstance = pollSectionInstance.poll

        if (pollInstance.isActive) pollInstance.errors.reject('poll.isActive.editFailure', "You can't edit an acitve poll")

        if (pollInstance.hasErrors()) {
            resond pollInstance.errors, view: 'poll/show'
            return
        }

        // retrieve the ids of the questions, that have already been added as items
        def idsOfAddedQuestions = []
        pollSectionInstance.items.each { item -> idsOfAddedQuestions.add(item.idOfOrigin) }

		// retrieve the selected questions
        def questions = []
        for (questionId in cmd.questionIds) {
			if( questionId!=null && !idsOfAddedQuestions.contains(questionId as Long) ) {
				questions.add(Question.get(questionId))
			}			
		}		
		
		// for each question, create an item and add it to the pollSection
		for (question in questions) {
			def itemInstance = new Item(question: question.text, idOfOrigin: question.id, pollSection: pollSectionInstance)
			for (option in question.getScale().getOptions()) {
				itemInstance.addToOptions(option)
			}
			itemInstance.save flush: true
		}
        redirect controller: 'poll', action: 'show', id: pollInstance.id, params: [targetId: pollSectionInstance.id, mode: 'showAllItems']
		
	}

    def reorderItems(PollSection pollSectionInstance) {

        render view: "/poll/show", model: [pollInstance: pollSectionInstance.poll, targetId: pollSectionInstance.id, mode: 'reorderSectionItems']
    }

    @Transactional
    def update(PollSection pollSectionInstance) {
        Poll pollInstance = pollSectionInstance.poll

        if (pollInstance.isActive) pollInstance.errors.reject('poll.isActive.editFailure', "You can't edit an active poll")

        if (pollInstance.hasErrors()) {
            resond pollInstance.errors, view: 'poll/show'
            return
        }

        if (pollSectionInstance == null) {
            notFound()
            return
        }

        if (pollSectionInstance.validate()) {
            pollSectionInstance.save flush:true

            flash.message = message(code: 'default.updated.message', args: [message(code: 'PollSection.label', default: 'PollSection'), pollSectionInstance.id])

            redirect controller: 'poll', action: 'show', id: pollInstance.id, params: [targetId: pollSectionInstance.id, mode: params.mode]
        } else {
            respond pollSectionInstance.errors, view:'/poll/show', model: [pollInstance: pollInstance, pollSectionInstance: pollSectionInstance, targetId: pollSectionInstance.id]
            return
        }
    }

    @Transactional
    def delete(PollSection pollSectionInstance) {
        Poll pollInstance = pollSectionInstance.poll

        if (pollInstance.isActive) pollInstance.errors.reject('poll.isActive.editFailure', "You can't edit an acitve poll")

        if (pollInstance.hasErrors()) {
            resond pollInstance.errors, view: 'poll/show'
            return
        }

        if (pollSectionInstance == null) {
            notFound()
            return
        }
		
		pollInstance.opinions.clear()
		pollInstance.sections.remove(pollSectionInstance)
		pollInstance.save flush:true
        pollSectionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PollSection.label', default: 'PollSection'), pollSectionInstance.id])
                redirect controller:"poll", action:"show", id: pollInstance.id, method:"GET"
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
