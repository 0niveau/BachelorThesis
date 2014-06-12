
<%@ page import="mypoll.Question" %>
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
                <div class="row flat">
                    <div class="property l-ten m-ten s-ten cols">
                        <g:if test="${ toBeEdited == 'text' }">
                            <h2>Edit question Text</h2>
                            <g:form url="[resource: questionInstance, action: 'update']" method="PUT">
                                <textArea name="text">${ questionInstance?.text }</textArea>
                                <g:submitButton name="update" value="Save"></g:submitButton>
                            </g:form>
                        </g:if>
                        <g:else>
                            <h2 class="property-header"><g:message code="question.text.label" default="Text" /></h2>
                            <p class="property-value box nomargin top" data-selectionRef="text">${questionInstance?.text}</p>
                        </g:else>
                    </div>
                    <div class="l-two m-two s-two cols flat actions">
                        <g:link controller="question" action="edit" params ="[id: questionInstance.id, toBeEdited: 'text']">Edit Text</g:link>
                    </div>
                </div>
            </div>



            <div class="l-six m-twelve s-twelve cols boxInside">
                <div class="row flat">
                    <div class="property l-ten m-ten s-ten cols">
                        <g:if test="${ toBeEdited == 'scale'}">
                            <h2 class="property-header"><g:message code="question.scale.label" default="Scale" /></h2>
                            <g:form url="[resource: questionInstance, action: 'update']" method="PUT">
                                <g:render template="selectScale" model="[idOfSelectedScale: questionInstance?.scale?.id, mode: 'editQuestion']"></g:render>
                                <g:submitButton name="save" value="${ message(code: 'question.property.update', default: 'Save')}"></g:submitButton>
                            </g:form>
                        </g:if>
                        <g:else>
                            <h2 class="property-header"><g:message code="question.scale.label" default="Scale" /></h2>
                            <p class="property-value box nomargin top" data-selectionRef="scale">${questionInstance?.scale?.name}</p>
                        </g:else>
                    </div>
                    <div class="l-two m-two s-two cols flat actions">
                        <g:link controller="question" action="edit" params="[id: questionInstance.id, toBeEdited: 'scale']">Edit Scale</g:link>
                    </div>
                </div>
            </div>
		</div>

        <section class="row dim">
            <div class="col">
                <g:form url="[resource:questionInstance, action:'delete']" method="DELETE">
                    <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </g:form>
            </div>
        </section>
	</body>
</html>
