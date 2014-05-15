
<%@ page import="mypoll.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<nav class="row">
			<ul class="navigation">
				<li class="navigation__links"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li class="navigation__links"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</nav>
		<div id="list-question" class="main row">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="question.scale.label" default="Scale" /></th>
					
						<g:sortableColumn property="text" title="${message(code: 'question.text.label', default: 'Text')}" />				
						
						<th></th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${questionInstanceList}" status="i" var="questionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${questionInstance.id}">${fieldValue(bean: questionInstance, field: "scale")}</g:link></td>
					
						<td>${fieldValue(bean: questionInstance, field: "text")}</td>
						
						<g:if test="${ selectable }">
						<td><label>auswählen<input name="questionIds[${ i }]" form="addItemsToSectionForm" type="checkbox" value="${ questionInstance.id }"></label></td>
						</g:if>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${questionInstanceCount ?: 0}" />
			</div>
			
			<g:if test="${ selectable }">
			<g:form id="${ sectionId }" name="addItemsToSectionForm" controller="pollSection" action="addItems">
				<button type="submit">Auswahl hinzufügen</button>
			</g:form>
			</g:if>
		</div>
	</body>
</html>
