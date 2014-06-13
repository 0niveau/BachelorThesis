package mypoll



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OpinionController {

    // injecting exportService from export plugin
    def exportService
    def grailsApplication

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Opinion.list(params), model:[opinionInstanceCount: Opinion.count()]
    }

    /*
	 * renders the initial page a subject will see.
	 */
    def indexSubject(Opinion opinionInstance) {
        Poll pollInstance = opinionInstance.poll
        Map<PollSection, Integer> answeredItemsPerSection = new HashMap<PollSection, Integer>()
        for (pollSectionInstance in pollInstance.sections) {
            Integer count = 0
            for (itemInstance in pollSectionInstance.items) {
                if (opinionInstance.selections.containsKey(itemInstance.id as String))  count += 1
            }
            answeredItemsPerSection.put(pollSectionInstance, count)
        }
        model: [pollInstance: pollInstance, opinionInstance: opinionInstance, answeredItemsPerSection: answeredItemsPerSection]
    }

    /*
	 * creates a new Opinion and links it to the poll, then redirects to the index page for subjects
	 */
    def addOpinion(Poll pollInstance) {
        if (!pollInstance.isActive) return

        String testObjectUrl = ( pollInstance.opinions.size() % 2 == 0 ? pollInstance.testObjectUrlA : pollInstance.testObjectUrlB )
        Opinion opinionInstance = new Opinion(testObjectUrl: testObjectUrl, poll: pollInstance)
        opinionInstance.save flush:true

        redirect action: 'indexSubject', id: opinionInstance.id
    }

    /*
     * groups the submitted Opinions by testObjectUrl and passes both lists to the corresponding view
     */
    def opinionList(Poll pollInstance) {
        List<Opinion> opinionsA = []
        List<Opinion> opinionsB = []
        pollInstance.opinions.each {
            opinion -> opinion.testObjectUrl == pollInstance.testObjectUrlA ? opinionsA.add(opinion) : opinionsB.add(opinion)
        }


        model: [pollInstance: pollInstance, opinionsA: opinionsA, opinionsB: opinionsB]
    }

    /*
     * takes all submitted opinions that have the chosen testObjectUrl and writes the selected values to a csv file
     */
    def exportOpinions() {
        Poll pollInstance = Poll.get(params.pollId)

        List items = pollInstance.sections.collect{ it.items }.flatten()

        String testObjectUrl = params.testObjectUrl
        String filename = testObjectUrl.replace("http://","")

        // only the opinions with the desired testObjectUrl will be exported
        List opinions = Opinion.findAll { testObjectUrl == testObjectUrl }

        List<String> fields = []
        Map labels = [:]

        for (itemInstance in items) {
            // Extracting the values from the opinions' selections
            fields.add("selections.${ itemInstance.id as String }.value")

            // labeling each column with the corresponding question-text
            labels.put('selections.' + itemInstance.id.toString() + '.value', itemInstance.question)
        }

        Map parameters = [separator: ',', quoteCharacter: "\u0000"]

        response.contentType = "text/csv"
        response.addHeader("Content-disposition", "attachment;filename=${filename}.csv")

        exportService.export('csv', response.outputStream, opinions, fields as List<String>, labels, [:], parameters)

    }

    def answerSectionItems() {
        Opinion opinionInstance = Opinion.get(params.opinionId)

        if (opinionInstance.submitted) return

        Poll pollInstance = Poll.get(params.pollId)
        PollSection pollSectionInstance = PollSection.get(params.sectionId)

        Boolean needsTestObject = pollSectionInstance.needsTestObject

        model: [pollInstance: pollInstance, pollSectionInstance: pollSectionInstance, opinionInstance: opinionInstance, needsTestObject: needsTestObject]
    }

    def saveSubjectSelections(saveSubjectSelectionsCommand cmd) {
        Opinion opinionInstance = Opinion.get(params.id)

        if (opinionInstance.submitted) opinionInstance.errors.reject('opinion.submitted.editFailure',
                "Your opinion has already been submitted. Changing your answers is no longer possible")

        if (opinionInstance.hasErrors()) {
            respond opinionInstance.errors, view: 'error'
            return
        }

        opinionInstance.selections.putAll(cmd.selections)

        opinionInstance.save flush:true

        redirect action: 'indexSubject', id: opinionInstance.id
    }

    def submitOpinion(Opinion opinionInstance) {
        opinionInstance.submitted = true
        opinionInstance.save flush:true

        redirect action: 'thanks'
    }

    def thanks() {

    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'opinionInstance.label', default: 'Opinion'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
