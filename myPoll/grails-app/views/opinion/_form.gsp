<%@ page import="mypoll.Opinion" %>



<div class="fieldcontain ${hasErrors(bean: opinionInstance, field: 'poll', 'error')} required">
	<label for="poll">
		<g:message code="opinion.poll.label" default="Poll" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="poll" name="poll.id" from="${mypoll.Poll.list()}" optionKey="id" required="" value="${opinionInstance?.poll?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: opinionInstance, field: 'selections', 'error')} ">
	<label for="selections">
		<g:message code="opinion.selections.label" default="Selections" />
		
	</label>
	<g:select name="selections" from="${mypoll.Selection.list()}" multiple="multiple" optionKey="id" size="5" value="${opinionInstance?.selections*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: opinionInstance, field: 'testObjectURL', 'error')} ">
	<label for="testObjectURL">
		<g:message code="opinion.testObjectURL.label" default="Test Object URL" />
		
	</label>
	<g:textField name="testObjectURL" value="${opinionInstance?.testObjectURL}"/>

</div>

