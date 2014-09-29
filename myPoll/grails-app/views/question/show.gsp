
<%@ page import="mypoll.QuestionType; mypoll.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
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
		<div class="row dim greyText shadow">
            <section class="col">
                <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            </section>
        </div>

        <g:if test="${flash.message}">
        <div class="row">
            <section class="col">
                <div class="message" role="status">${flash.message}</div>
            </section>
        </div>
        </g:if>

        <div class="row white shadow">
            <div class="l-six m-twelve s-twelve cols boxInside">
                <div class="row">
                    <g:form url="[resource: questionInstance, action: 'update']" method="PUT" name="editQuestionTextForm">
                        <div class="property l-ten m-ten s-ten cols">
                            <g:if test="${ toBeEdited == 'text' }">
                                <h2 class="property-header"><g:message code="question.edit.text" default="Edit text"/></h2>
                                    <textArea name="text">${ questionInstance?.text }</textArea>
                            </g:if>
                            <g:else>
                                <h2 class="property-header"><g:message code="question.text.label" default="Text" /></h2>
                                <p class="property-value box nomargin top">${questionInstance?.text}</p>
                            </g:else>
                        </div>
                        <div class="l-two m-two s-two cols actions">
                            <g:if test="${ toBeEdited == 'text' }">
                                <input class="icon-submit" type="submit" value="&#xf0c7;" form="editQuestionTextForm"/>
                                <input type="hidden" name="property" value="text" />
                            </g:if>
                            <g:else>
                                <g:link class="icon-link" controller="question" action="edit" params ="[id: questionInstance.id, toBeEdited: 'text']">
                                    <i class="fa fa-pencil"></i>
                                </g:link>
                            </g:else>
                        </div>
                    </g:form>
                </div>
            </div>



            <div class="l-six m-twelve s-twelve cols boxInside">
                <div class="row">
                    <g:form url="[resource: questionInstance, action: 'update']" method="PUT" name="editQuestionScaleForm">
                        <div class="property l-ten m-ten s-ten cols">
                            <g:if test="${ toBeEdited == 'scale'}">
                                <h2 class="property-header"><g:message code="question.edit.scale" default="Scale" /></h2>

                                    <g:render template="selectScale" model="[idOfSelectedScale: questionInstance?.scale?.id, mode: 'editQuestion', questionType: questionInstance?.type]" />

                            </g:if>
                            <g:else>
                                <h2 class="property-header"><g:message code="scale.label" default="Scale" /></h2>
                                <p class="property-value box nomargin top">${ questionInstance.type == QuestionType.OPEN ? message(code: 'question.open', default: 'Open Question') : questionInstance?.scale?.name}</p>
                            </g:else>
                        </div>
                        <div class="l-two m-two s-two cols actions">
                            <g:if test="${ toBeEdited == 'scale'}">
                                <input class="icon-submit" type="submit" value="&#xf0c7;" form="editQuestionScaleForm" />
                                <input type="hidden" name="property" value="scale" />
                            </g:if>
                            <g:else>
                                <g:link class="icon-link" controller="question" action="edit" params="[id: questionInstance.id, toBeEdited: 'scale']">
                                    <i class="fa fa-pencil"></i>
                                </g:link>
                            </g:else>
                        </div>
                    </g:form>
                </div>
            </div>
		</div>
	</body>
</html>
