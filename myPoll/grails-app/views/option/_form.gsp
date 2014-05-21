<%@ page import="mypoll.Option" %>


<div class="fieldcontain ${hasErrors(bean: optionInstance, field: 'value', 'error')} ">
	<label for="value">
		<g:message code="option.value.label" default="Value" />
		
	</label>
	<g:textField name="value" value="${optionInstance?.value}"/>

</div>

