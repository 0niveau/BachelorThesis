<%@ page import="mypoll.OrdinalScale" %>



<div class="fieldcontain ${hasErrors(bean: ordinalScaleInstance, field: 'options', 'error')} ">
	<label for="options">
		<g:message code="ordinalScale.options.label" default="Options" />
		
	</label>
	<g:select name="options" from="${mypoll.Option.list()}" multiple="multiple" optionKey="id" size="5" value="${ordinalScaleInstance?.options*.id}" class="many-to-many"/>

</div>

