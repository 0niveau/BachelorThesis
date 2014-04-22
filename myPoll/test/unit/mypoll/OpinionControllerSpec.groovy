package mypoll



import grails.test.mixin.*
import spock.lang.*

@TestFor(OpinionController)
@Mock(Opinion)
class OpinionControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.opinionInstanceList
            model.opinionInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.opinionInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            def opinion = new Opinion()
            opinion.validate()
            controller.save(opinion)

        then:"The create view is rendered again with the correct model"
            model.opinionInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            opinion = new Opinion(params)

            controller.save(opinion)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/opinion/show/1'
            controller.flash.message != null
            Opinion.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def opinion = new Opinion(params)
            controller.show(opinion)

        then:"A model is populated containing the domain instance"
            model.opinionInstance == opinion
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def opinion = new Opinion(params)
            controller.edit(opinion)

        then:"A model is populated containing the domain instance"
            model.opinionInstance == opinion
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/opinion/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def opinion = new Opinion()
            opinion.validate()
            controller.update(opinion)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.opinionInstance == opinion

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            opinion = new Opinion(params).save(flush: true)
            controller.update(opinion)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/opinion/show/$opinion.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/opinion/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def opinion = new Opinion(params).save(flush: true)

        then:"It exists"
            Opinion.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(opinion)

        then:"The instance is deleted"
            Opinion.count() == 0
            response.redirectedUrl == '/opinion/index'
            flash.message != null
    }
}
