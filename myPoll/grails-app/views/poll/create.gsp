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
		<div class="row dim greyText shadow">
			<section class="col">
				<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			</section>
        </div>
			
        <g:if test="${flash.message}">
        <div class="row">
            <section class="col">
                <div class="message" role="status">${flash.message}</div>
            </section>
        </div>
        </g:if>

        <g:hasErrors bean="${pollInstance}">
            <div class="row">
                <div class="col">
                    <ul>
                        <g:eachError bean="${pollInstance}" var="error">
                            <li class="hint"><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </div>
            </div>
        </g:hasErrors>

        <div class="row white shadow">
            <section class="l-six m-twelve s-twelve cols">
                <div class="row">
                    <div class="l-ten m-ten s-ten cols">
                        <g:form url="[resource: pollInstance, action:'save']" name="pollCreateForm">
                            <h2 class="property-header">Give your Poll a name!</h2>
                            <input id="name" type="text" required="required" name="name" value="${ pollInstance.name }"/>
                            <h2 class="property-header">Briefly describe your poll!</h2>
                            <textarea id="description" required="required" name="description">${ pollInstance.description }</textarea>
                            <h2 class="property-header">Select some sections for your poll!</h2>
                            <ul>
                                <li><label for="clustering"><input id="clustering" type="checkbox" name="clustering"/>Clustering</label></li>
                                <li><label for="comparing"><input id="comparing" type="checkbox" name="comparing"/>Comparing</label></li>
                                <li><label for="feedback"><input id="feedback" type="checkbox" name="feedback"/>Feedback</label></li>
                            </ul>
                            <h2 class="property-header">Name the Web-Sites you want to compare!</h2>
                            <p>page A<input id="testObjectUrlA" type="url" name="testObjectUrlA" value="${ pollInstance.testObjectUrlA }" placeholder="www.site-a.com"/></p>
                            <p>page B<input id="testObjectUrlB" type="url" name="testObjectUrlB" value="${ pollInstance.testObjectUrlB }" placeholder="www.site-b.com"/></p>
                        </g:form>
                    </div>
                    <div class="actions l-two m-two s-two cols">
                        <input class="icon-submit" type="submit" form="pollCreateForm" value="&#xf0c7;" />
                    </div>
                </div>
            </section>
        </div>
	</body>
</html>
