<%@ page import="mypoll.Scale" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'scale.label', default: 'Scale')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
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
            <div class="col">
                <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            </div>
        </div>

        <g:if test="${flash.message}">
        <div class="row">
            <div class="col">
                <div class="message" role="status">${flash.message}</div>
            </div>
        </div>
        </g:if>

        <g:hasErrors bean="${scaleInstance}">
        <div class="row">
            <div class="col">
                <ul class="errors">
                    <g:eachError bean="${scaleInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </div>
        </div>
        </g:hasErrors>

        <div class="row white shadow">
            <div class="l-six m-twelve s-twelve cols">
                <g:form url="[resource:scaleInstance, action:'update']" method="PUT" name="scaleEditForm">
                    <g:hiddenField name="version" value="${scaleInstance?.version}" />
                    <g:render template="form" model="[scaleInstance: scaleInstance, form: 'scaleEditForm']"/>
                </g:form>
            </div>
        </div>
	</body>
</html>
