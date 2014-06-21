<%-- 	
	required: pollInstance, 
	optional: selectableQuestions, targetId, mode 			
--%>
<%@ page import="mypoll.Poll" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poll.label', default: 'Poll')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<nav class="row">
			<ul class="navigation">
				<li class="navigation__links"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li class="navigation__links"><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li class="navigation__links"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</nav>

        <section class="row dim shadow greyText">
            <div class="col">
                <h1>${ pollInstance?.name }</h1>
                <g:if test="${ pollInstance?.isActive }"><g:message code="poll.status.isActive" default="(active)" /></g:if>
            </div>
        </section>

        <g:if test="${flash.message}">
        <section class="row">
            <div class="message col" role="status">${flash.message}</div>
        </section>
        </g:if>

        <g:hasErrors bean="${pollInstance}">
        <section class="row">
            <div class="col">
                <g:eachError bean="${pollInstance}" var="error">
                    <p class="hint"><g:message error="${error}"/></p>
                </g:eachError>
            </div>
        </section>
        </g:hasErrors>

        <div class="row white shadow">
            <g:if test="${ pollInstance?.description }" >
                <div class="l-six m-twelve s-twelve cols boxInside">
                    <div class="property row l-regular border-bottom-blueDotted">
                        <div class="l-ten m-ten s-ten cols">
                            <g:if test="${ toBeEdited == 'pollDescription' }">
                                <h2 class="property-header"><g:message code="poll.description.label" default="Enter a new Description" /></h2>
                                <g:form url="[resource: pollInstance, action: 'update']" method="PUT" name="editPollDescriptionForm">
                                    <textarea name="description">${ pollInstance?.description }</textarea>
                                </g:form>
                            </g:if>
                            <g:else>
                                <h2 class="property-header"><g:message code="poll.description.label" default="Description" /></h2>
                                <p class="property-value box">${ pollInstance?.description }</p>
                            </g:else>
                        </div>
                        <div class="actions l-two m-two s-two cols">
                            <g:if test="${ !pollInstance?.isActive }">
                                <g:if test="${ toBeEdited == 'pollDescription' }">
                                    <input class="icon-submit" type="submit" form="editPollDescriptionForm" value="&#xf0c7;"/>
                                </g:if>
                                <g:else>
                                    <g:link class="icon-link" controller="poll" action="edit" id="${ pollInstance.id }" params="[toBeEdited: 'pollDescription']">
                                        <i class="fa fa-pencil"></i></g:link>
                                </g:else>
                            </g:if>
                            <g:else><a class="icon-link disabled"><i class="fa fa-pencil"></i></a></g:else>
                        </div>
                    </div>
                </div>
            </g:if>


            <div class="l-six m-twelve s-twelve cols boxInside ">
                <div class="property row l-regular border-bottom-blueDotted">
                    <div class="l-ten m-ten s-ten cols">
                        <g:if test="${ toBeEdited == 'testObjects' }">
                            <h2 class="property-header"><g:message code="poll.testObjectUrls.label" default="Test objects"/></h2>
                            <g:form url="[resource: pollInstance, action: 'update']" method="PUT" name="editPollTestObjectsForm">
                                <div class="box">
                                    <label>TestObjectA<input type="url" name="testObjectUrlA" value="${ pollInstance?.testObjectUrlA }" placeholder="www.site-a.com" /></label> <br>
                                    <label>TestObjectB<input type="url" name="testObjectUrlB" value="${ pollInstance?.testObjectUrlB }" placeholder="www.site-b.com" /></label>
                                </div>
                            </g:form>
                        </g:if>
                        <g:else>
                            <h2 class="property-header"><g:message code="poll.testObjectUrls.label" default="Test objects"/></h2>
                            <p class="property-value box">${ pollInstance?.testObjectUrlA } vs ${ pollInstance?.testObjectUrlB }</p>
                        </g:else>
                    </div>
                    <div class="actions l-two m-two s-two cols">
                        <g:if test="${ !pollInstance?.isActive }">
                            <g:if test="${ toBeEdited == 'testObjects' }">
                                <input class="icon-submit" type="submit" form="editPollTestObjectsForm" value="&#xf0c7;" />
                            </g:if>
                            <g:else>
                                <g:link class="icon-link" controller="poll" action="edit" id="${ pollInstance.id }" params="[toBeEdited: 'testObjects']">
                                    <i class="fa fa-pencil"></i></g:link>
                            </g:else>
                        </g:if>
                        <g:else><a class="icon-link disabled"><i class="fa fa-pencil"></i></a></g:else>
                    </div>
                </div>
            </div>

            <div class="col boxInside">
                <div class="property row">
                    <div class="l-six m-twelve s-twelve cols">
                        <h2 class="property-header"><g:message code="poll.sections.label" default="Sections" /></h2>
                        <g:each in="${ pollInstance?.sections }" status="i" var="s" >
                        <div class="property-value selectable box pollSection ${ s.id == targetId ? 'selected' : '' }" data-selectionRef="section${ s?.id }" data-sectionId="${ s.id }">${s?.name}</div>
                        </g:each>
                        <g:if test="${ !pollInstance?.isActive }">
                            <div class="property-valeu selectable box pollSection ${ targetId == 'newSection' ? 'selected' : '' }" data-selectionRef="newSection"><i class="fa fa-plus"></i> Add a new Section</div>
                        </g:if>
                    </div>
                    <div class="l-six m-twelve s-twelve cols">
                        <g:each in="${ pollInstance?.sections }" var="s" >
                            <g:render
                                    template="/pollSection/pollSection"
                                    model="['pollSection': s, 'targetId': targetId, 'selectableQuestions': selectableQuestions, 'toBeEdited': toBeEdited]"/>
                        </g:each>
                        <g:if test="${ !pollInstance?.isActive }">
                            <div id="newSection" class="propertyDetails row l-bigger ${ targetId == 'newSection' ? 'selected' : '' }" >
                                <div class="l-ten m-ten s-ten cols">
                                    <h2 class="property-header">Add a new Section</h2>
                                    <g:hasErrors bean="${ newPollSectionInstance }">
                                        <section class="row">
                                            <div class="col">
                                                <g:eachError bean="${newPollSectionInstance}" var="error">
                                                    <p class="hint"><g:message error="${error}"/></p>
                                                </g:eachError>
                                            </div>
                                        </section>
                                    </g:hasErrors>
                                    <g:form url="[controller: 'pollSection', resource: newPollSectionInstance, action: 'save', pollInstanceId: pollInstance?.id]" name="createPollSectionForm">
                                        <fieldset class="values">
                                            <h3>Enter a name for your pollSection</h3>
                                            <input type="text" name="name" value="${ newPollSectionInstance?.name }">
                                            <h3>Briefly describe your pollSection</h3>
                                            <textarea name="description">${ newPollSectionInstance?.description }</textArea>
                                            <h3>Does your pollSection need a testObject?</h3>
                                            <label><g:checkBox name="needsTestObject" value="${ newPollSectionInstance?.needsTestObject}"></g:checkBox>yes</label>
                                            <input type="hidden" name="poll" value="${ pollInstance?.id }">
                                        </fieldset>
                                    </g:form>
                                </div>
                                <div class="actions l-two m-two s-two cols">
                                    <input class="icon-submit" type="submit" form="createPollSectionForm" value="&#xf0c7;" />
                                </div>
                            </div>
                        </g:if>
                    </div>
                </div>
            </div>

            <div class="l-six m-twelve s-twelve cols boxInside">
                <div class="row l-regular border-bottom-blueDotted">
                    <div class="property l-ten m-ten s-ten cols">
                        <h2 class="property-header">Share your poll!</h2>
                        <g:if test="${ pollInstance?.isActive }" >
                            <p class="property-value box">This poll is currently active. It is not possible to edit it right now. Share this link to get some opinions for your poll!</p>
                            <p class="box">
                                <span><g:link controller="opinion" action="addOpinion" id="${ pollInstance.id }">Participate</g:link></span>
                            </p>
                        </g:if>
                        <g:else>
                            <p class="property-value box">This poll is currently Deactivated. Configure your poll according to your preferences and publish it to receive opinions!</p>
                        </g:else>
                    </div>
                    <div class="actions l-two m-two s-two cols">
                        <g:form url="[resource: pollInstance, action: 'toggleActivation']" method="PUT">
                            <input type="hidden" value="${ !pollInstance.isActive }" name="isActive" />
                            <g:if test="${pollInstance?.isActive}">
                                <input type="submit" class="icon-submit" value="&#xf023;"/>
                            </g:if>
                            <g:else>
                                <input type="submit" class="icon-submit" value="&#xf09c;"/>
                            </g:else>
                        </g:form>
                    </div>
                </div>
            </div>


            <div class="l-six m-twelve s-twelve cols boxInside">
                <div class="row l-regular border-bottom-blueDotted">
                    <div class="property l-ten m-ten s-ten cols">
                        <h2 class="property-header">Opinions</h2>
                        <g:if test="${ pollInstance?.opinions }" >
                            <p class="property-value box">Your poll has already received ${ pollInstance?.opinions?.findAll { it.submitted }.size() } opinions</p>
                        </g:if>
                        <g:else>
                            <p class="property-value box">Nobody has submitted an opinion yet</p>
                        </g:else>
                    </div>
                    <div class="actions l-two m-two s-two cols">
                        <g:link class="icon-link" controller="opinion" action="opinionList" id="${ pollInstance.id }"><i class="fa fa-eye"></i></g:link>
                    </div>
                </div>
            </div>
        </div>
	</body>
</html>
