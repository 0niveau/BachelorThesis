
<%@ page import="mypoll.Poll" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poll.label', default: 'Poll')}" />
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
		<div id="show-poll" class="main">
			<section class="row">
				<h1>${ pollInstance?.name }</h1>
				<g:if test="${ pollInstance?.isActive }"><g:message code="poll.status.isActive" default="(active)" /></g:if>
			</section>			
			
			<g:if test="${flash.message}">
			<section class="row">
				<div class="message cols" role="status">${flash.message}</div>
			</section>			
			</g:if>
			
			<section class="properties row">
				<g:if test="${ pollInstance?.description }" >
				<h2 class="property-header"><g:message code="poll.description.label" default="Description" /></h2>
				<div class="property">
					<p>${ pollInstance?.description }</p>
				</div>
				</g:if>
				
				<g:if test="${ pollInstance?.sections }" >
				<h2 class="property-header"><g:message code="poll.sections.label" default="Sections" /></h2>
				<div class="property">					
						<g:each in="${ pollInstance?.sections }" var="s" >
						<h3><g:link controller="pollSection" action="show" id="${s.id}">${s?.name}</g:link></h3>
						<g:if test="${ s?.items }">
						<ul>						
						<g:each in="${ s?.items }" var="i">
							<li>${ i?.title }</li>
						</g:each>
						</ul>
						</g:if>
						<g:link controller="question" action="index" id="${ s.id }" params="[addToSection: 'addToSection']">Item hinzufügen</g:link>
						</g:each>
				</div>
				</g:if>
				
				<g:if test="${ pollInstance?.testObjectUrlA && pollInstance?.testObjectUrlB }" >
				<h2 class="property-header"><g:message code="poll.testObjectUrls.label" default="Test objects"/></h2>
				<div class="property">
					<span>${ pollInstance?.testObjectUrlA } vs ${ pollInstance?.testObjectUrlB }</span>
				</div>
				</g:if>
			</section>
			
			
			<ol class="property-list poll">			
				<g:if test="${pollInstance?.opinions}">
				<li class="fieldcontain">
					<span id="opinions-label" class="property-label"><g:message code="poll.opinions.label" default="Opinions" /></span>		
						<g:each in="${pollInstance.opinions}" var="o">
						<span class="property-value" aria-labelledby="opinions-label"><g:link controller="opinion" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></span>
						</g:each>					
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
