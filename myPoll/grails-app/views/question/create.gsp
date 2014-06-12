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
            <section class="col" >
                <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            </section>
        </div>

        <g:if test="${flash.message}">
         <div class="row">
             <section class="col">
                 <div class="message" role="status">${flash.message}</div>
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
            <section class="l-six m-six s-twelve cols">
			<g:form url="[resource:questionInstance, action:'save']" >
				<div class="row">
                    <div class="col ${hasErrors(bean: questionInstance, field: 'text', 'error')} ">
                        <h2 class="property-header"><g:message code="question.text.label" default="Text" /></h2>
                        <textarea name="text">${questionInstance?.text}</textarea>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <h2 class="property-header"><g:message code="question.scale.label" default="Scale" /></h2>
                        <div class="row">
                            <div class="l-six m-six s-twelve cols">
                                <h3><g:message code="question.scale.available" default="Available Scales" /></h3>
                                <g:each in="${ mypoll.Scale.list() }" status="i" var="scale">
                                <div class="selectable" data-selectionRef="options${scale.id}">
                                    <label class="radioInputLabel">
                                        <input type="radio" name="scale" value="${scale.id}" id="${scale.id}" ${ scale.id == idOfSelectedScale ? "checked='checked'" : '' }/>
                                        ${ scale.name }
                                    </label>
                                </div>
                                </g:each>
                            </div>
                            <g:each in="${ mypoll.Scale.list() }" status="i" var="scale">
                            <div id="options${scale.id}" class="propertyDetails l-six m-six s-twelve cols">
                                <h3><g:message code="scale.options.label" default="Options" /></h3>
                                <ol>
                                    <g:each in="${ scale.options }" var="option" >
                                        <li>${option.value}</li>
                                    </g:each>
                                </ol>
                            </div>
                            </g:each>
                        </div>
                    </div>
                </div>

				<div class="row">
					<div class="col">
                        <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					</div>
				</div>
			</g:form>
            </section>
		</div>
	</body>
</html>
