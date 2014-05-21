<%@ page import="mypoll.Scale" %>



<div class="fieldcontain ${hasErrors(bean: scaleInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="Scale.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${scaleInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: scaleInstance, field: 'options', 'error')} ">
	<h2>Define the options!</h2>
	<ol id="scaleOptionList" class="${ !scaleInstance?.options ? 'hidden' : '' }">		
		<g:each in="${ scaleInstance?.options }" status="i" var="option">
		<li>
			<input name="options[${ i }]" type="text" value="option.value" required="required"/>
		</li>
		</g:each>			
	</ol>
	<a href="#" id="addNewOption">Add an option!</a>
</div>
