
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
		<div class="row dim greyText shadow">
			<div class="col">
				<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			</div>
		</div>
		
		<g:if test="${flash.message}">
			<div class="row">
				<div class="col">
					<div class="message" role="status">${flash.message}</div>
				</div>
			</div>							
		</g:if>
		
		<g:set var="text" value="${ message(code: 'question.text.label', default:'text') }" />
		<div class="row shadow">
			<div class="col actions left-text">
				<g:if test="${ order == 'asc' && sort == 'text' }">
					<g:link class="icon-link" controller="question" action="index" params="[sort: 'text', max: 10, order: 'desc']">
						<i class="fa fa-arrow-circle-o-down"></i><span class="padding-left">
							<g:message code="instanceList.sortBy.desc"
							args="[text]" 
							default="sort by text descending"/></span>
					</g:link>
				</g:if>
				<g:else>
					<g:link class="icon-link" controller="question" action="index" params="[sort: 'text', max: 10, order: 'asc']">
						<i class="fa fa-arrow-circle-o-up"></i><span class="padding-left">
						<g:message code="instanceList.sortBy.asc"
						args="[text]" 
						default="sort by text ascending"/></span>
					</g:link>
				</g:else>
			</div>
		</div>
		
		<div class="row white shadow">
			<div class="col">
				<g:each in="${ questionInstanceList }" status="i" var="questionInstance">
					<div class="row instanceListItem">
						<div class="l-eleven m-ten s-ten cols">
							<g:link class="text-link" controller="question" action="show" id="${ questionInstance?.id }">
								<h2 class="nomargin">${ questionInstance?.text }</h2>
							</g:link>
							<p class="nomargin italic">
								${ questionInstance?.scale?.name }
							</p>
						</div>
						<div class="actions l-one m-two s-two cols">
							 <g:form url="[resource:questionInstance, action:'delete']" method="DELETE">
			                    <input class="icon-submit" type="submit" value="&#xf014;" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
			                </g:form>
						</div>
					</div>
				</g:each>
			</div>
		</div>			
		<div class="pagination">
			<g:paginate total="${questionInstanceCount ?: 0}" />
		</div>
	</body>
</html>
