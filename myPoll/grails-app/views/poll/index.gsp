
<%@ page import="mypoll.Poll" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'poll.label', default: 'Poll')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<nav class="row">
			<ul class="navigation">
				<li class="navigation__links"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li class="navigation__links"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</nav>
		<div id="list-poll" class="main">
			<section class="row">
				<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			</section>
			
			<g:if test="${flash.message}">
			<section class="row">
				<div class="message" role="status">${flash.message}</div>
			</section>			
			</g:if>
			
			<section class="row">
				<table>
				<thead>
						<tr>
						
							<g:sortableColumn property="name" title="${message(code: 'poll.name.label', default: 'Name')}" />
						
							<g:sortableColumn property="description" title="${message(code: 'poll.description.label', default: 'Description')}" />
						
							<g:sortableColumn property="isActive" title="${message(code: 'poll.isActive.label', default: 'Is Active')}" />
						
							<g:sortableColumn property="testObjectUrlA" title="${message(code: 'poll.testObjectUrlA.label', default: 'Test Object Url A')}" />
						
							<g:sortableColumn property="testObjectUrlB" title="${message(code: 'poll.testObjectUrlB.label', default: 'Test Object Url B')}" />
						
						</tr>
					</thead>
					<tbody>
					<g:each in="${pollInstanceList}" status="i" var="pollInstance">
						<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						
							<td><g:link action="show" id="${pollInstance.id}">${fieldValue(bean: pollInstance, field: "name")}</g:link></td>
						
							<td>${fieldValue(bean: pollInstance, field: "description")}</td>
						
							<td><g:formatBoolean boolean="${pollInstance.isActive}" /></td>
						
							<td>${fieldValue(bean: pollInstance, field: "testObjectUrlA")}</td>
						
							<td>${fieldValue(bean: pollInstance, field: "testObjectUrlB")}</td>
						
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${pollInstanceCount ?: 0}" />
				</div>			
			</section>
		</div>
	</body>
</html>
