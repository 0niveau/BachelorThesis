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
		<div id="create-poll" class="main row">
			<section class="col">
				<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			</section>
			
			<g:if test="${flash.message}">
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
			</g:if>
			
			<section class="l-six m-six s-twelve cols">
				<g:form url="[resource:pollInstance, action:'save']" >
					<fieldset class="form">
						<h2>Give your Poll a name!</h2>
						<input id="name" type="text" required="required" name="name" value="${ pollInstance.name }"/>					
						<h2>Briefly describe your poll!</h2>
						<textarea id="description" required="required" name="description">${ pollInstance.description }</textarea>									
						<h2>Choose the sections you want to integrate in your poll!</h2>
						<label for="clustering"><input id="clustering" type="checkbox" name="clustering"/>Clustering</label>					
						<label for="comparing"><input id="comparing" type="checkbox" name="comparing"/>Comparing</label>					
						<label for="feedback"><input id="feedback" type="checkbox" name="feedback"/>Feedback</label>
						<h2>Name the Web-Sites you want to compare!</h2>
						<input id="testObjectUrlA" type="url" name="testObjectUrlA" value="${ pollInstance.testObjectUrlA }" placeholder="www.site-a.com"/>
						<span>vs</span>
						<input id="testObjectUrlB" type="url" name="testObjectUrlB" value="${ pollInstance.testObjectUrlB }" placeholder="www.site-b.com"/>
					</fieldset>
					<fieldset class="buttons">
						<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</fieldset>
				</g:form>
			</section>
			
		</div>
	</body>
</html>
