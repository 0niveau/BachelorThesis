
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
		<div class="row dim greyText shadow">
			<div class="col">
				<h1>${ scaleInstance?.name }</h1>
			</div>
        </div>
						
        <g:if test="${flash.message}">
            <div class="row">
                <section class="col">
                    <h2><g:message code="" default="Name"/></h2>
                    <div class="message" role="status">${flash.message}</div>
                </section>
            </div>
        </g:if>

        <g:hasErrors bean="${ scaleInstance}">
            <div class="row">
                <div class="col">
                    <g:eachError bean="${scaleInstance}" var="error">
                        <p class="hint"><g:message error="${error}"/></p>
                    </g:eachError>
                </div>
            </div>
        </g:hasErrors>

        <div class="row white shadow">
            <section class="properties l-six m-twelve s-twelve cols">
                <g:if test="${scaleInstance?.choices}">
                <div class="row">
                    <div class="l-ten m-ten s-ten cols">
                        <h2 class="property-header"><g:message code="scale.choices.label" default="choices"/></h2>
                        <ol class="choicesList" data-listedElements="choices">
                            <g:each in="${scaleInstance?.choices}" var="choice" status="s">
                                <li class="property-value choice">
                                    ${ choice.value }
                                </li>
                            </g:each>
                        </ol>
                    </div>
                    <div class="actions l-two m-two s-two cols">
                        <g:link class="icon-link" action="edit" resource="${scaleInstance}"><i class="fa fa-pencil"></i></g:link>
                    </div>
                </div>
                </g:if>
            </section>
        </div>
	</body>
</html>
