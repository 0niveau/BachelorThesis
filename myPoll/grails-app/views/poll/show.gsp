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

        <section class="row dim greyText">
            <div class="col">
                <h1>${ pollInstance?.name }</h1>
                <g:if test="${ pollInstance?.isActive }"><g:message code="poll.status.isActive" default="(active)" /></g:if>
            </div>
        </section>

        <g:if test="${flash.message}">
        <section class="row">
            <div class="message col" role="status">${flash.message}</div>
        </section>
        </g:if>

        <div class="row">
			<section class="properties l-six m-six s-twelve cols">
				<g:if test="${ pollInstance?.description }" >
				<div class="row">
                    <div class="property col">
                        <h2 class="property-header"><g:message code="poll.description.label" default="Description" /></h2>
                        <p class="property-value box nomargin top ${ pollInstance?.isActive ? '' : 'selectable propagateSelection'}" data-selectionRef="description">${ pollInstance?.description }</p>
				    </div>
                </div>
				</g:if>
				
				<g:if test="${ pollInstance?.sections }" >
                <div class="row">
                    <div class="property col ${ targetId != null ? 'containsSelection' : '' }">
                        <h2 class="property-header"><g:message code="poll.sections.label" default="Sections" /></h2>
                        <g:each in="${ pollInstance?.sections }" status="i" var="s" >
                        <div class="property-value selectable propagateSelection box pollSection ${ s.id == targetId ? 'selected' : '' }" data-selectionRef="section${ s?.id }" data-sectionId="${ s.id }">${s?.name}</div>
                        </g:each>
                    </div>
                </div>
				</g:if>
				
				<g:if test="${ pollInstance?.testObjectUrlA && pollInstance?.testObjectUrlB }" >
                <div class="row">
                    <div class="property col">
                        <h2 class="property-header"><g:message code="poll.testObjectUrls.label" default="Test objects"/></h2>
                        <p class="property-value box nomargin top ${ pollInstance?.isActive ? '' : 'selectable propagateSelection'}" data-selectionRef="testObjects">${ pollInstance?.testObjectUrlA } vs ${ pollInstance?.testObjectUrlB }</p>
                    </div>
                </div>
				</g:if>
				
				<g:if test="${ pollInstance?.isActive }" >
                <div class="row">
                    <div class="property col">
                        <h2 class="property-header">Share your poll!</h2>
                        <p class="property-value box nomargin top">This poll is currently active. It is not possible to edit it right now. Share this link to get some opinions for your poll!</p>
                        <p class="box">
                            <span><g:link controller="opinion" action="addOpinion" id="${ pollInstance.id }">Participate</g:link></span>
                        </p>
                    </div>
                </div>
				</g:if>	
				
			</section>					

			<section class="l-six m-six s-twelve cols propertyDetailsSection">
                <g:if test="${ !pollInstance.isActive }">
                <div id="description" class="propertyDetails row">
                    <div class="col">
                        <h2 class="property-header"><g:message code="poll.description.label" default="Description" /></h2>
                        <g:form url="[resource: pollInstance, action: 'update']" method="PUT">
                            <textarea name="description">${ pollInstance?.description }</textarea>
                            <g:submitButton name="save" value="${ message(code: 'poll.property.update', default: 'Save') }" />
                        </g:form>
                    </div>
                </div>
                </g:if>

                <g:each in="${ pollInstance?.sections }" var="s" >
                <g:render
                    template="/pollSection/pollSection"
                    model="['pollSection': s, 'targetId': targetId, 'selectableQuestions': selectableQuestions, 'mode': mode]"/>
                </g:each>

                <g:if test="${ !pollInstance.isActive }">
                <div id="testObjects" class="propertyDetails row">
                    <div class="col">
                        <h2 class="property-header"><g:message code="poll.testObjectUrls.label" default="Test objects"/></h2>
                        <g:form url="[resource: pollInstance, action: 'update']" method="PUT">
                            <label>TestObjectA<input type="text" name="testObjectUrlA" value="${ pollInstance.testObjectUrlA }" placeholder="www.site-a.com" /></label>
                            <label>TestObjectB<input type="text" name="testObjectUrlB" value="${ pollInstance.testObjectUrlB }" placeholder="www.site-b.com" /></label>
                            <g:submitButton name="save" value="${ message(code: 'poll.property.update', default: 'Save') }" />
                        </g:form>
                    </div>
                </div>
                </g:if>
			</section>
        </div>

        <section class="row dim">
            <div class="col">
                <g:form url="[resource: pollInstance, action: 'toggleActivation']" method="PUT">
                        <input type="hidden" value="${ !pollInstance.isActive }" name="isActive" />
                        <g:submitButton name="update" value="${ pollInstance.isActive ? 'Deactivate' : 'Publish!' }"/>
                </g:form>
                <g:form url="[resource:pollInstance, action:'delete']" method="DELETE">
                        <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        <a href="#" id="clearDetails">clearRightSection</a>
                </g:form>
                <g:link controller="opinion" action="opinionList" id="${ pollInstance.id }">Show Opinions</g:link>
            </div>
        </section>

	</body>
</html>
