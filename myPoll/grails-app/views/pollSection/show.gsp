
<%@ page import="mypoll.PollSection" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pollSection.label', default: 'PollSection')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-pollSection" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-pollSection" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list pollSection">
			
				<g:if test="${pollSectionInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="pollSection.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${pollSectionInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollSectionInstance?.poll}">
				<li class="fieldcontain">
					<span id="poll-label" class="property-label"><g:message code="pollSection.poll.label" default="Poll" /></span>
					
						<span class="property-value" aria-labelledby="poll-label"><g:link controller="poll" action="show" id="${pollSectionInstance?.poll?.id}">${pollSectionInstance?.poll?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollSectionInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="pollSection.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${pollSectionInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollSectionInstance?.index}">
				<li class="fieldcontain">
					<span id="index-label" class="property-label"><g:message code="pollSection.index.label" default="Index" /></span>
					
						<span class="property-value" aria-labelledby="index-label"><g:fieldValue bean="${pollSectionInstance}" field="index"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${pollSectionInstance?.needsTestObject}">
				<li class="fieldcontain">
					<span id="needsTestObject-label" class="property-label"><g:message code="pollSection.needsTestObject.label" default="Needs Test Object" /></span>
					
						<span class="property-value" aria-labelledby="needsTestObject-label"><g:formatBoolean boolean="${pollSectionInstance?.needsTestObject}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:pollSectionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${pollSectionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
