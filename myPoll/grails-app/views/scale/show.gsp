
<%@ page import="mypoll.Scale" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'scale.label', default: 'Scale')}" />
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
		<div id="show-scale" class="main row">
			<section class="col">
				<h1>${ scaleInstance?.name }</h1>
			</section>
						
			<g:if test="${flash.message}">
			<section class="col">
				<h2><g:message code="" default="Name"/></h2>
				<div class="message" role="status">${flash.message}</div>
			</section>			
			</g:if>
					
			<section class="properties l-six m-six s-twelve cols">
				<g:if test="${scaleInstance?.options}">
				<div class="property">
					<h2 class="property-header"><g:message code="scale.options.label" default="Options"/></h2>							
					<ol class="optionList draggableItemList" data-listedElements="options">
						<g:each in="${scaleInstance.options}" var="o" status="s">
						<li class="property-value option draggableItem" draggable="true">
							${ o.value }
							<input type="hidden" name="options[${ s }]" value="${ o.id }" form="reorderOptionsForm"/>
						</li>
						</g:each>
					</ol>
					<g:form name="reorderOptionsForm" controller="scale" action="update" id="${ scaleInstance?.id }" method="PUT">
						<g:submitButton name="save" value="Save Order"/>
					</g:form>
				</div>			
				</g:if>	
			</section>								
			
			<section class="col">
				<g:form url="[resource:scaleInstance, action:'delete']" method="DELETE">
					<fieldset class="buttons">
						<g:link class="edit" action="edit" resource="${scaleInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
						<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					</fieldset>
				</g:form>
			</section>					
		</div>
	</body>
</html>
