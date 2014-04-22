<%@ page import="mypoll.Option" %>



<div class="fieldcontain ${hasErrors(bean: optionInstance, field: 'index', 'error')} required">
	<label for="index">
		<g:message code="option.index.label" default="Index" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="index" type="number" value="${optionInstance.index}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: optionInstance, field: 'value', 'error')} ">
	<label for="value">
		<g:message code="option.value.label" default="Value" />
		
	</label>
	<g:textField name="value" value="${optionInstance?.value}"/>

</div>

