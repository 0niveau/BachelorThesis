<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<nav class="row">
			<ul class="navigation">
				<li class="navigation__links"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li class="navigation__links"><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</nav>
		<div id="create-question" class="row dim greyText shadow">
            <div class="col" >
                <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            </div>
        </div>

        <g:if test="${flash.message}">
         <div class="row">
             <section class="col">
                 <div class="message">${flash.message}</div>
             </section>
         </div>
        </g:if>

        <g:hasErrors bean="${questionInstance}">
        <div class="row">
            <section class="col">
                <ul class="errors" role="alert">
                    <g:eachError bean="${questionInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
            </section>
        </div>
        </g:hasErrors>

        <div class="row white shadow">
            <div class="l-six m-twelve s-twelve cols">
				<div class="row">
                    <div class="l-ten m-ten s-ten cols">
                        <g:form url="[resource:questionInstance, action:'save']" name="questionCreateForm" >
                            <h2 class="property-header"><g:message code="question.text.label" default="Text" /></h2>
                            <textarea class="${hasErrors(bean: questionInstance, field: 'text', 'error')}" name="text">${questionInstance?.text}</textarea>

                            <h2 class="property-header"><g:message code="scale.label" default="Scale" /></h2>
                            <p class="hint">
                            	<g:message code="hint.question.create.missingScale" 
                            	default="If you can't find any scale that fits for your purpose, you can easily create your own. Just follow this link" />
                            </p>
                            <g:link controller="scale" action="create" params="[useInQuestion: true]"><i class="fa fa-hand-o-right padding-right"></i><g:message code="scale.new" default="new Scale" /></g:link>
                            <div class="row">
                                <div class="l-six m-six s-twelve cols">
                                    <h3><g:message code="scale.available" default="Available Scales" /></h3>
                                    <ul class="selectableList">
                                        <g:each in="${ mypoll.Scale.list() }" status="i" var="scale">
                                            <li class="selectable" data-selectionRef="choices${scale.id}">
                                                <label class="radioInputLabel">
                                                    <input type="radio" name="scale" value="${scale.id}" id="${scale.id}" ${ scale.id == idOfSelectedScale ? "checked='checked'" : '' }/>
                                                    ${ scale.name }
                                                </label>
                                            </li>
                                        </g:each>
                                    </ul>
                                </div>
                                <g:each in="${ mypoll.Scale.list() }" status="i" var="scale">
                                    <div id="choices${scale.id}" class="propertyDetails l-six m-six s-twelve cols highlight">
                                        <h3><g:message code="scale.choices.label" default="Choices" /></h3>
                                        <ol>
                                            <g:each in="${ scale.choices }" var="choice" >
                                                <li>${choice.value}</li>
                                            </g:each>
                                        </ol>
                                    </div>
                                </g:each>
                            </div>
                            <g:if test="${ pollSectionId }">
                            	<input type="hidden" name="pollSectionId" value="${ pollSectionId }" />
                            </g:if>
                        </g:form>
                    </div>
                    <div class="actions l-two m-two s-two cols">
                        <input class="icon-submit" type="submit" form="questionCreateForm" value="&#xf0c7;" />
                    </div>
                </div>
            </div>
		</div>
	</body>
</html>
