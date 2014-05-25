<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<nav class="row">
			<ul class="navigation">
				<li class="navigation__links"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li class="navigation__links"><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</nav>
		<div id="create-question" class="main row">
            <section class="col" >
                <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            </section>

            <g:if test="${flash.message}">
            <section class="col">
                <div class="message" role="status">${flash.message}</div>
            </section>
			</g:if>

			<g:hasErrors bean="${questionInstance}">
			<section class="col">
                <ul class="errors" role="alert">
                    <g:eachError bean="${questionInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </section>
			</g:hasErrors>

            <section class="l-six m-six s-twelve cols">
			<g:form url="[resource:questionInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
            </section>
		</div>
	</body>
</html>
