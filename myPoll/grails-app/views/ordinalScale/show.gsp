
<%@ page import="mypoll.OrdinalScale" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'ordinalScale.label', default: 'OrdinalScale')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-ordinalScale" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-ordinalScale" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list ordinalScale">
			
				<g:if test="${ordinalScaleInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="ordinalScale.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${ordinalScaleInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${ordinalScaleInstance?.options}">
				<li class="fieldcontain">
					<span id="options-label" class="property-label"><g:message code="ordinalScale.options.label" default="Options" /></span>
					
						<g:each in="${ordinalScaleInstance.options.sort { it.index } }" var="o">
						<span class="property-value" aria-labelledby="options-label"><g:link controller="option" action="show" id="${o.id}">${o?.value}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:ordinalScaleInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${ordinalScaleInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
