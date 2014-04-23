
<%@ page import="mypoll.Poll" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poll.label', default: 'Poll')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-poll" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-poll" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list poll">
			
				<g:if test="${pollInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="poll.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${pollInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="poll.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${pollInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollInstance?.isActive}">
				<li class="fieldcontain">
					<span id="isActive-label" class="property-label"><g:message code="poll.isActive.label" default="Is Active" /></span>
					
						<span class="property-value" aria-labelledby="isActive-label"><g:formatBoolean boolean="${pollInstance?.isActive}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollInstance?.opinions}">
				<li class="fieldcontain">
					<span id="opinions-label" class="property-label"><g:message code="poll.opinions.label" default="Opinions" /></span>
					
						<g:each in="${pollInstance.opinions}" var="o">
						<span class="property-value" aria-labelledby="opinions-label"><g:link controller="opinion" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${pollInstance?.sections}">
				<li class="fieldcontain">
					<span id="sections-label" class="property-label"><g:message code="poll.sections.label" default="Sections" /></span>
					
						<g:each in="${pollInstance.sections}" var="s">
						<span class="property-value" aria-labelledby="sections-label"><g:link controller="pollSection" action="show" id="${s.id}">${s?.name}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${pollInstance?.testObjectUrlA}">
				<li class="fieldcontain">
					<span id="testObjectUrlA-label" class="property-label"><g:message code="poll.testObjectUrlA.label" default="Test Object Url A" /></span>
					
						<span class="property-value" aria-labelledby="testObjectUrlA-label"><g:fieldValue bean="${pollInstance}" field="testObjectUrlA"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollInstance?.testObjectUrlB}">
				<li class="fieldcontain">
					<span id="testObjectUrlB-label" class="property-label"><g:message code="poll.testObjectUrlB.label" default="Test Object Url B" /></span>
					
						<span class="property-value" aria-labelledby="testObjectUrlB-label"><g:fieldValue bean="${pollInstance}" field="testObjectUrlB"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:pollInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${pollInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
