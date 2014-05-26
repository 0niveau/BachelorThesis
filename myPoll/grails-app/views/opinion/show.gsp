
<%@ page import="mypoll.Opinion" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'opinion.label', default: 'Opinion')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-opinion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-opinion" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list opinion">
			
				<g:if test="${opinionInstance?.poll}">
				<li class="fieldcontain">
					<span id="poll-label" class="property-label"><g:message code="opinion.poll.label" default="Poll" /></span>
					
						<span class="property-value" aria-labelledby="poll-label"><g:link controller="poll" action="show" id="${opinionInstance?.poll?.id}">${opinionInstance?.poll?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${opinionInstance?.selections}">
				<li class="fieldcontain">
					<span id="selections-label" class="property-label"><g:message code="opinion.selections.label" default="Selections" /></span>
					
						<g:each in="${opinionInstance.selections}" var="s">
						<span class="property-value" aria-labelledby="selections-label"><g:link controller="selection" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${opinionInstance?.testObjectUrl}">
				<li class="fieldcontain">
					<span id="testObjectURL-label" class="property-label"><g:message code="opinion.testObjectURL.label" default="Test Object URL" /></span>
					
						<span class="property-value" aria-labelledby="testObjectURL-label"><g:fieldValue bean="${opinionInstance}" field="testObjectUrl"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:opinionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${opinionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
