<%@ page import="mypoll.Question" %>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'text', 'error')} ">
    <h2 class="property-header"><g:message code="question.text.label" default="Text" /></h2>
	<textarea name="text">${questionInstance?.text}</textarea>

</div>

<h2 class="property-header"><g:message code="question.scale.label" default="Scale" /></h2>
<div class="l-six m-six s-twelve cols">
    <h3><g:message code="question.scale.available" default="Available Scales" /></h3>
    <g:each in="${ mypoll.Scale.list() }" status="i" var="scale">
     <div class="selectable" data-selectionRef="options${scale.id}">
         <label class="radioInputLabel">
             <input type="radio" name="scale" value="${scale.id}" id="${scale.id}" ${ scale.id == idOfSelectedScale ? "checked='checked'" : '' }/>
             ${ scale.name }
         </label>
     </div>
    </tr>
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
