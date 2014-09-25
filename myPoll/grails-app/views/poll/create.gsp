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
                    <g:form url="[resource: pollInstance, action:'save']" name="pollCreateForm">
                        <div class="l-ten m-ten s-ten cols">
                            <h2 class="property-header"><g:message code="poll.name.label" default="Name" /></h2>
                            <input id="name" type="text" required="required" name="name" value="${ pollInstance?.name }"/>
                            <h2 class="property-header"><g:message code="poll.create.describe" default="Description"/></h2>
                            <textarea id="description" required="required" name="description">${ pollInstance?.description }</textarea>
                            <h2 class="property-header"><g:message code="poll.create.selectSections" default="Select some sections"/></h2>
                            <ul>
                                <li>
                                	<label for="clustering">
	                                	<input id="clustering" type="checkbox" name="clustering"/>
	                                	<g:message code="poll.sections.clustering.label" default="Demographic Clustering" />
                                	</label>
                                </li>
                                <li>
                                	<label for="comparing">
                                		<input id="comparing" type="checkbox" name="comparing"/>
                                		<g:message code="poll.sections.comparing.label" default="WebSite Evaluation" />
                                	</label>
                                </li>
                                <li>
                                	<label for="feedback">
                                		<input id="feedback" type="checkbox" name="feedback"/>
                                		<g:message code="poll.sections.feedback.label" default="Feedback" />
                                	</label>
                                </li>
                            </ul>
                            <h2 class="property-header"><g:message code="poll.create.testObjects" default="Testobjects" /></h2>
                            <p><g:message code="poll.testObjectUrl" default="page"/> <input id="testObjectUrl" type="url" name="testObjectUrl" value="${ pollInstance.testObjectUrl }" placeholder="http://www.site.com"/></p>
                        </div>
                        <div class="actions l-two m-two s-two cols">
                            <input class="icon-submit" type="submit" form="pollCreateForm" value="&#xf0c7;" />
                        </div>
                    </g:form>
                </div>
            </section>
        </div>
	</body>
</html>
