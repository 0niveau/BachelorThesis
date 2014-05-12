
<%@ page import="mypoll.PollSection" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'pollSection.label', default: 'PollSection')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<nav class="row" role="navigation">
			<ul class="navigation">
				<li class="navigation__links"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li class="navigation__links"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</nav>
		<div id="list-pollSection" class="main row">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'pollSection.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'pollSection.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="needsTestObject" title="${message(code: 'pollSection.needsTestObject.label', default: 'Needs Test Object')}" />
					
						<th><g:message code="pollSection.poll.label" default="Poll" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${pollSectionInstanceList}" status="i" var="pollSectionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${pollSectionInstance.id}">${fieldValue(bean: pollSectionInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: pollSectionInstance, field: "description")}</td>
					
						<td><g:formatBoolean boolean="${pollSectionInstance.needsTestObject}" /></td>
					
						<td>${fieldValue(bean: pollSectionInstance, field: "poll")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${pollSectionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
