
<%@ page import="mypoll.Scale" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'scale.label', default: 'Scale')}" />
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
		
		<g:if test="${ defectiveScale }">		
			<div class="row">
				<div class="col">
					<ul class="errors">
						<g:eachError bean="${ defectiveScale }" var="error">
							<li class="hint"><g:message error="${ error }" /></li>
						</g:eachError>
					</ul>							
				</div>
			</div>			
		</g:if>
		
		<g:set var="name" value="${ message(code: 'scale.name.label', default: 'Name') }" />		
		<div class="row shadow actions left-text">
			<div class="col">			
				<g:if test="${ order == 'asc' && sort == 'name' }">
					<g:link class="icon-link" controller="scale" action="index" params="[sort: 'name', max: 10, order: 'desc']">
						<i class="fa fa-arrow-circle-o-down"></i><span class="padding-left">
						<g:message code="instanceList.sortBy.desc" 
						args="[name]"
						default="sort by name descending"/></span>
					</g:link>					
				</g:if>
				<g:else>
					<g:link class="icon-link" controller="scale" action="index" params="[sort: 'name', max: 10, order: 'asc']">
						<i class="fa fa-arrow-circle-o-up"></i><span class="padding-left">
						<g:message code="instanceList.sortBy.asc" 
						args="[name]"
						default="sort by name ascending"/></span>
					</g:link>
				</g:else>
			</div>
		</div>
		
		<div class="row white shadow">
			<div class="col">
				<g:each in="${ scaleInstanceList }" status="i" var="scaleInstance">
					<div class="row instanceListItem">
						<div class="l-eleven m-ten s-ten cols">
							<g:link class="text-link" controller="scale" action="show" id="${ scaleInstance?.id }">
								<h2 class="nomargin">${ scaleInstance?.name }</h2>
							</g:link>
							<ol class="inlineItems nopadding nomargin">
								<g:each in="${ scaleInstance?.options }">
									<li><span class="italic nomargin">${ it?.value }</span></li>
								</g:each>
							</ol>
						</div>
						<div class="actions l-one m-two s-two cols">
							<g:if test="${ scaleInstance.questions.isEmpty() }">
								<g:form controller="scale" action="delete" id="${ scaleInstance?.id }" method="DELETE">
									<input class="icon-submit" type="submit" value="&#xf014;" />
								</g:form>
							</g:if>
							<g:else>
								<a class="icon-link disabled"><i class="fa fa-trash-o"></i></a>
							</g:else>
						</div>
					</div>
				</g:each>
				
			</div>
		</div>		
		<div class="pagination">
			<g:paginate total="${scaleInstanceCount ?: 0}" />
		</div>
	</body>
</html>
