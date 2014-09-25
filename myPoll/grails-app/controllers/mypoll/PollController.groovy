package mypoll

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['IS_AUTHENTICATED_REMEMBERED'])
@Transactional(readOnly = true)
class PollController {

    static allowedMethods = [save: "POST", update: "PUT",toggleActivation: "PUT", delete: "DELETE"]

    // injecting exportService from export plugin
    def exportService
    def grailsApplication

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Poll.list(params), model:[pollInstanceCount: Poll.count(), sort: params.sort, order: params.order]
    }

    def show(Poll pollInstance) {
        def targetId = params.targetId as Long
        def mode = params.mode
        render view: 'show', model: [pollInstance: pollInstance, targetId: targetId, mode: mode]
    }

    def create() {
        respond new Poll(params)
    }

	/*
	 * creates the new poll and its sections
	 * @cmd contains the values needed for the creation of the new poll	
	 */
    @Transactional
    def save(Poll pollInstance) {
        if (pollInstance == null) {
            notFound()
            return
        }

        if (pollInstance.hasErrors()) {
            respond pollInstance.errors, view:'create'
            return
        }

		pollInstance.save flush:true

		if (params.clustering) {
			def clustering = new PollSection(name: message(code: 'poll.sections.clustering.label', default: 'Clustering'), needsTestObject: false, poll: pollInstance)
			clustering.save flush:true
		}
		if (params.comparing) {
			def comparing = new PollSection(name: message(code: 'poll.sections.comparing.label', default: 'Comparing'), needsTestObject: true, poll: pollInstance)
			comparing.save flush:true	
		}
		if (params.feedback) {
			def feedback = new PollSection(name: message(code: 'poll.sections.feedback.label', default: 'Feedback'), needsTestObject: false, poll: pollInstance)
			feedback.save flush:true		
		}

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'poll.label', default: 'Poll'), pollInstance.name])
                redirect pollInstance
            }
            '*' { respond pollInstance, [status: CREATED] }
        }
    }

    def edit(Poll pollInstance) {
        def toBeEdited = params.toBeEdited

        render view: 'show', model:[pollInstance: pollInstance, toBeEdited: toBeEdited]
    }

    @Transactional
    def update(Poll pollInstance) {

        if (pollInstance.isActive) pollInstance.errors.reject('poll.isActive.editFailure', "You can't edit an active poll")

        if (pollInstance == null) {
            notFound()
            return
        }

        if (pollInstance.hasErrors()) {
            respond pollInstance.errors, view:'show'
            return
        }

        pollInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'poll.label', default: 'Poll'), pollInstance.name])
                redirect pollInstance
            }
            '*'{ respond pollInstance, [status: OK] }
        }
    }

    /*
     * (De-) Activates the pollInstance so that Opinions can be submitted.
     * Deletes existing Opinions each time it is activated.
     */
    @Transactional
    def toggleActivation(Poll pollInstance) {
        if (pollInstance == null) {
            notFound()
            return
        }

        if (pollInstance.hasErrors()) {
            respond pollInstance.errors, view:'edit'
            return
        }

        // Deleting old Opinions
        if (pollInstance.isActive) {
            pollInstance.resetOpinions()
        }

        pollInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'poll.label', default: 'Poll'), pollInstance.name])
                redirect pollInstance
            }
            '*'{ respond pollInstance, [status: OK] }
        }
    }

    /*
     * groups the submitted Opinions by testObjectUrl and passes both lists to the corresponding view
     */
    def opinionList(Poll pollInstance) {

        def aggregatedResults = aggregatePollResults(pollInstance)

        render view: '/opinion/opinionList', model: [pollInstance: pollInstance, aggregatedResults: aggregatedResults]
    }

    private static List<ItemAggregation> aggregatePollResults(Poll pollInstance) {
        List<Item> pollItems = pollInstance.getPollItems()
        List<Opinion> opinions = pollInstance.opinions.findAll { opinion -> opinion.submitted } as List<Opinion>

        List<ItemAggregation> itemAggregations = []

        for (pollItem in pollItems) {

            List<String> itemAnswers = opinions.collect { opinion -> opinion.selections.get(pollItem.id as String) }

            ItemAggregation itemAggregation = new ItemAggregation()
            itemAggregation.item = pollItem
            itemAggregation.question = pollItem.question
            itemAggregation.possibleAnswers = pollItem.choices.collect {choice -> choice.value }
            itemAggregation.selectionsPerAnswer = itemAggregation.possibleAnswers.collectEntries { answer -> [(answer): itemAnswers.findAll { itemAnswer -> itemAnswer == answer }.size()] }

            itemAggregations.add(itemAggregation)
        }

        return itemAggregations
    }

    /*
     * takes all submitted opinions that have the chosen testObjectUrl and writes the selected values to a csv file
     */
    def exportOpinions(Poll pollInstance) {
        List items = pollInstance.getPollItems()

        String testObjectUrl = params.testObjectUrl
        String filename = testObjectUrl.replace("http://","")

        // only the submitted opinions will be exported
        List opinions = Opinion.findAll { opinion -> opinion.submitted }

        List<String> fields = []
        Map labels = [:]

        for (itemInstance in items) {
            // Extracting the values from the opinions' selections
            fields.add("selections.${ itemInstance.id as String }.value")

            // labeling each column with the corresponding question-text
            labels.put('selections.' + itemInstance.id.toString() + '.value', itemInstance.question)
        }

        Map parameters = [separator: ',', encoding: "ISO-8859-1", quoteCharacter: "\u0000"]

        response.contentType = "text/csv"
        response.addHeader("Content-disposition", "attachment;filename=${filename}.csv")

        exportService.export('csv', response.outputStream, opinions, fields as List<String>, labels, [:], parameters)
    }

    @Transactional
    def delete(Poll pollInstance) {


        if (pollInstance == null) {
            notFound()
            return
        }

        pollInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'poll.label', default: 'Poll'), pollInstance.name])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'poll.label', default: 'Poll'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
