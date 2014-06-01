<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poll.label', default: 'Poll')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<nav class="row">
			<ul class="navigation">
				<li class="navigation__links"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li class="navigation__links"><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</nav>
		<div class="row dim greyText">
			<section class="col">
				<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			</section>
        </div>
			
        <g:if test="${flash.message}">
        <div class="row">
            <section class="col">
                <div class="message" role="status">${flash.message}</div>
                <g:hasErrors bean="${pollInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${pollInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
                </g:hasErrors>
            </section>
        </div>
        </g:if>

        <div class="row">
            <section class="l-six m-six s-twelve cols">
                <g:form url="[resource:pollInstance, action:'save']" >
                    <div class="row">
                        <div class="col">
                            <h2 class="property-header">Give your Poll a name!</h2>
                            <input id="name" type="text" required="required" name="name" value="${ pollInstance.name }"/>
                            <h2 class="property-header">Briefly describe your poll!</h2>
                            <textarea id="description" required="required" name="description">${ pollInstance.description }</textarea>
                            <h2 class="property-header">Select some sections for your poll!</h2>
                            <label for="clustering"><input id="clustering" type="checkbox" name="clustering"/>Clustering</label>
                            <label for="comparing"><input id="comparing" type="checkbox" name="comparing"/>Comparing</label>
                            <label for="feedback"><input id="feedback" type="checkbox" name="feedback"/>Feedback</label>
                            <h2 class="property-header">Name the Web-Sites you want to compare!</h2>
                            <input id="testObjectUrlA" type="url" name="testObjectUrlA" value="${ pollInstance.testObjectUrlA }" placeholder="www.site-a.com"/>
                            <span>vs</span>
                            <input id="testObjectUrlB" type="url" name="testObjectUrlB" value="${ pollInstance.testObjectUrlB }" placeholder="www.site-b.com"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                        </div>
                    </div>
                </g:form>
            </section>
        </div>
	</body>
</html>
