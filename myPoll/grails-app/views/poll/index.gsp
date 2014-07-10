
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
		<section class="row dim greyText shadow">
			<div class="col">
				<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			</div>				
		</section>
		
		<g:if test="${flash.message}">
		<section class="row">
			<div class="col">
				<div class="message" role="status">${flash.message}</div>
			</div>				
		</section>			
		</g:if>
		
		<section class="row shadow">
			<div class="col actions left-text">
				<g:set var="name" value="${ message(code: 'poll.name.label', default: 'name') }"/>
				<g:if test="${ order == 'asc' && sort == 'name' }">
					<g:link class="icon-link" controller="poll" action="index" params="[sort: 'name', max: 10, order: 'desc']">
						<i class="fa fa-arrow-circle-o-down"></i><span class="padding-left">
							<g:message code="instanceList.sortBy.desc"
							args="[name]" 
							default="sort by ${ name } descending"/></span>
					</g:link>												
				</g:if>
				<g:else>
					<g:link class="icon-link" controller="poll" action="index" params="[sort: 'name', max: 10, order: 'asc']">
						<i class="fa fa-arrow-circle-o-up"></i><span class="padding-left">
							<g:message code="instanceList.sortBy.asc"
							args="[name]" 
							default="sort by ${ name } ascending"/></span>
					</g:link>
				</g:else>
			</div>
			<div class="col actions left-text">								
				<g:if test="${ order == 'asc' && sort == 'isActive' }">
					<g:set var="status" value="${ message(code: 'poll.plural.shared.not', default: 'Not shared') }"/>
					<g:link class="icon-link" controller="poll" action="index" params="[sort: 'isActive', max: 10, order: 'desc']">
						<i class="fa fa-arrow-circle-o-down"></i><span class="padding-left">
							<g:message code="instanceList.sortBy.first"
							args="[status]" 
							default="${ status } first"/></span>
					</g:link>					
				</g:if>
				<g:else>
					<g:set var="status" value="${ message(code: 'poll.plural.shared', default: 'Shared') }"/>
					<g:link class="icon-link" controller="poll" action="index" params="[sort: 'isActive', max: 10, order: 'asc']">
						<i class="fa fa-arrow-circle-o-up"></i><span class="padding-left">
							<g:message code="instanceList.sortBy.first"
							args="[status]" 
							default="${ status } first"/></span>
					</g:link>
				</g:else>				
			</div>
		</section>
		
		<section class="row white shadow">
			<div class="col">
				
				<g:each in="${pollInstanceList}" status="i" var="pollInstance">
					<div class="row instanceListItem">
						<div class="l-one m-two s-two cols icon-box lightgrey">
							<g:if test="${ pollInstance?.isActive }">
								<i class="fa fa-lock"></i>
							</g:if>
							<g:else>
								<i class="fa fa-unlock"></i>
							</g:else>
						</div>
						<div class="l-ten m-eight s-eight cols">
							<g:link class="text-link" controller="poll" action="show" id="${ pollInstance?.id }">
								<h2 class="nomargin-top">${ pollInstance?.name }</h2>
							</g:link>
							<p class="nomargin"><span class="italic">${ pollInstance?.testObjectUrlA }</span> vs <span class="italic">${ pollInstance?.testObjectUrlB }</span></p>
							<p class="nomargin hint">${ pollInstance?.opinions?.findAll{ it.submitted == true }.size() } opinions submitted</p>
						</div>						
						<div class="actions l-one m-two s-two cols">							
							<g:form controller="poll" action="delete" id="${ pollInstance?.id }" method="DELETE">
								<input class="icon-submit" type="submit" value="&#xf014;" />
							</g:form>
						</div>						
					</div>
				</g:each>
				
				<div class="pagination">
					<g:paginate total="${pollInstanceCount ?: 0}" />
				</div>			
			
			</div>
		</section>
	</body>
</html>
