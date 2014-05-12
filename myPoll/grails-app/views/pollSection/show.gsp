
<%@ page import="mypoll.PollSection" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pollSection.label', default: 'PollSection')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<nav class="row">
			<ul class="navigation">
				<li class="navigation__links"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li class="navigation__links"><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li class="navigation__links"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</nav>
		<div id="show-pollSection" class="main row">
			<section class="col">
				<h1>${ pollSectionInstance?.name }</h1>
			</section>
		
			<g:if test="${flash.message}">
			<section class="col">
				<div class="message" role="status">${flash.message}</div>
			</section>			
			</g:if>
			
			<section class="properties l-six m-six s-twelve cols">
				
					<g:if test="${pollSectionInstance?.description}">
					<div class="property">
						<h2 class="property-header"><g:message code="pollSection.description.label" /></h2>
						<p>${ pollSectionInstance?.description }</p>					
					</div>
					</g:if>
					
					<g:if test="${pollSectionInstance?.needsTestObject}">
					<div class="property">
						<h2 class="property-header"><g:message code="pollSection.needsTestObject.label" default="Needs Test Object" /></h2>
						<p><g:formatBoolean boolean="${pollSectionInstance?.needsTestObject}" /></p>
					</div>
					</g:if>
				
					<g:if test="${pollSectionInstance?.items}">
					<div class="property">
						<h2 class="property-header"><g:message code="pollSectionInstance.items.label" default="Items"/></h2>
						<ol class="pollSectionItems">
							<g:each in="${pollSectionInstance.items}" var="i">
							<li><g:link controller="item" action="show" id="${i.id}">${i?.title}</g:link></li>							
							</g:each>
						</ol>
					</div>
					</g:if>					
				
					<g:if test="${pollSectionInstance?.poll}">					
					<div class="property">
						<h2 class="property-header"><g:message code="pollSectionInstance.poll.label" default="Poll"/></h2>
						<p><g:link controller="poll" action="show" id="${pollSectionInstance?.poll?.id}">${pollSectionInstance?.poll?.name}</g:link></p>
					</div>					
					</g:if>
			</section>
			
			<section class="col">
				<g:form url="[resource:pollSectionInstance, action:'delete']" method="DELETE">
					<fieldset class="buttons">
						<g:link class="edit" action="edit" resource="${pollSectionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</section>
			
		</div>
	</body>
</html>
