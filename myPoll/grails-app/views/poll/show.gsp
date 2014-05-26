<%-- 	
	required: pollInstance, 
	optional: selectableQuestions, targetId, mode 			
--%>
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
		<div id="show-poll" class="main row">

			<section class="col">
				<h1>${ pollInstance?.name }</h1>
				<g:if test="${ pollInstance?.isActive }"><g:message code="poll.status.isActive" default="(active)" /></g:if>
			</section>	
			
			<g:if test="${flash.message}">
			<section class="col">
				<div class="message cols" role="status">${flash.message}</div>
			</section>			
			</g:if>		

			<section class="properties l-six m-six s-twelve cols">
				<g:if test="${ pollInstance?.description }" >
				<div class="property">
					<h2 class="property-header"><g:message code="poll.description.label" default="Description" /></h2>					
					<p class="property-value selectable" data-selectionRef="description">${ pollInstance?.description }</p>
				</div>
				</g:if>
				
				<g:if test="${ pollInstance?.sections }" >
				<div class="property">
					<h2 class="property-header"><g:message code="poll.sections.label" default="Sections" /></h2>							
					<ul id="pollSectionList">
						<g:each in="${ pollInstance?.sections }" status="i" var="s" >
						<li class="property-value selectable pollSection ${ s.id == targetId ? 'selected' : '' }" data-selectionRef="section${ s?.id }" data-sectionId="${ s.id }">${s?.name}</li>
						</g:each>
					</ul>			
				</div>
				</g:if>
				
				<g:if test="${ pollInstance?.testObjectUrlA && pollInstance?.testObjectUrlB }" >
				<div class="property">
					<h2 class="property-header"><g:message code="poll.testObjectUrls.label" default="Test objects"/></h2>					
					<p class="property-value selectable" data-selectionRef="testObjects">${ pollInstance?.testObjectUrlA } vs ${ pollInstance?.testObjectUrlB }</p>
				</div>
				</g:if>
			</section>					

			<section class="l-six m-six s-twelve cols propertyDetailsSection">
				<div id="description" class="propertyDetails">
					<h2 class="property-header"><g:message code="poll.description.label" default="Description" /></h2>
					<g:form url="[resource: pollInstance, action: 'update']" method="PUT">
						<textarea name="description">${ pollInstance?.description }</textarea>
						<g:submitButton name="save" value="${ message(code: 'poll.property.update', default: 'Save') }" />
					</g:form>
				</div>
				
				<g:each in="${ pollInstance?.sections }" var="s" >
				<g:render
					template="/pollSection/pollSection"
					model="['pollSection': s, 'targetId': targetId, 'selectableQuestions': selectableQuestions, 'mode': mode]"/>
				</g:each>
				
				<div id="testObjects" class="propertyDetails">
					<h2 class="property-header"><g:message code="poll.testObjectUrls.label" default="Test objects"/></h2>
					<g:form url="[resource: pollInstance, action: 'update']" method="PUT">
						<label>TestObjectA<input type="text" name="testObjectUrlA" value="${ pollInstance.testObjectUrlA }" placeholder="www.site-a.com" /></label>
						<label>TestObjectB<input type="text" name="testObjectUrlB" value="${ pollInstance.testObjectUrlB }" placeholder="www.site-b.com" /></label>
						<g:submitButton name="save" value="${ message(code: 'poll.property.update', default: 'Save') }" />
					</g:form>
				</div>
			</section>
			
			<section class="col">
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
						<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
						<a href="#" id="clearDetails">clearRightSection</a>
					</fieldset>
				</g:form>
			</section>
		</div>
	</body>
</html>
