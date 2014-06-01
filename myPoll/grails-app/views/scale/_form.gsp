<%@ page import="mypoll.Scale" %>

<div class="row fieldcontain ${hasErrors(bean: scaleInstance, field: 'name', 'error')} required">
    <div class="col">
        <h2 class="property-header"><g:message code="Scale.name.label" default="Name" /></h2>
        <g:textField name="name" required="" value="${scaleInstance?.name}"/>
    </div>
</div>

<div class="row fieldcontain ${hasErrors(bean: scaleInstance, field: 'options', 'error')} ">
    <div class="col">
        <h2 class="property-header">Define the options!</h2>
        <ol id="scaleOptionList" class="${ !scaleInstance?.options ? 'hidden' : '' }">
            <g:each in="${ scaleInstance?.options }" status="i" var="option">
            <li>
                <input name="options[${ i }]" type="text" value="${option.value}" required="required"/>
            </li>
            </g:each>
        </ol>
        <a href="#" id="addNewOption">Add an option!</a>
    </div>
</div>
