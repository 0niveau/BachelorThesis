<%@ page import="mypoll.NominalScale" %>



<div class="fieldcontain ${hasErrors(bean: nominalScaleInstance, field: 'options', 'error')} ">
	<label for="options">
		<g:message code="nominalScale.options.label" default="Options" />
		
	</label>
	<g:select name="options" from="${mypoll.Option.list()}" multiple="multiple" optionKey="id" size="5" value="${nominalScaleInstance?.options*.id}" class="many-to-many"/>

</div>

