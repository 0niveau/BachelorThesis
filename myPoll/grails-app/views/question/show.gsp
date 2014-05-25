
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
		<div id="show-question" class="main row">
            <section class="col">
                <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            </section>

			<g:if test="${flash.message}">
            <section class="col">
			    <div class="message" role="status">${flash.message}</div>
            </section>
            </g:if>

            <section class="properties l-six m-six s-twelve cols">
                <g:if test="${questionInstance?.text}">
                <div class="property">
                    <h2 class="property-header"><g:message code="question.text.label" default="Text" /></h2>
                    <p class="property-value selectable" data-propertyRef="text">${questionInstance?.text}</p>
                </div>
                </g:if>

                <g:if test="${questionInstance?.scale}">
                <div class="property">
                    <h2 class="property-header"><g:message code="question.scale.label" default="Scale" /></h2>
                    <p class="property-value selectable" data-propertyRef="scale">${questionInstance?.scale?.name}</p>
                </div>
                </g:if>
            </section>

            <section class="propertyDetailsSection l-six m-six s-twelve cols">
                <div id="text" class="propertyDetails">
                    <h2 class="property-header"><g:message code="question.text.label" default="Text" /></h2>
                    <g:form url="[resource: questionInstance, action: 'update']" method="PUT">
                        <textarea name="text">${ questionInstance?.text }</textarea>
                        <g:submitButton name="save" value="${ message(code: 'question.property.update', default: 'Save')}"></g:submitButton>
                    </g:form>
                </div>

                <div id="scale" class="propertyDetails">
                    <h2 class="property-header"><g:message code="question.scale.label" default="Scale" /></h2>
                    <g:form url="[resource: questionInstance, action: 'update']" method="PUT">
                        <g:render template="selectScale" model="[idOfSelectedScale: questionInstance?.scale?.id]"></g:render>
                        <g:submitButton name="save" value="${ message(code: 'question.property.update', default: 'Save')}"></g:submitButton>
                    </g:form>
                </div>
            </section>

            <section class="col">
                <g:form url="[resource:questionInstance, action:'delete']" method="DELETE">
                    <fieldset class="buttons">
                        <g:link class="edit" action="edit" resource="${questionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                        <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </fieldset>
                </g:form>
            </section>
		</div>
	</body>
</html>
