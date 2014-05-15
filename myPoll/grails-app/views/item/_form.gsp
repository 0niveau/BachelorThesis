<%@ page import="mypoll.Item" %>



<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'options', 'error')} ">
	<label for="options">
		<g:message code="item.options.label" default="Options" />
		
	</label>
	<g:select name="options" from="${mypoll.Option.list()}" multiple="multiple" optionKey="id" size="5" value="${itemInstance?.options*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'question', 'error')} ">
	<label for="question">
		<g:message code="item.question.label" default="Question" />
		
	</label>
	<g:textField name="question" value="${itemInstance?.question}"/>

</div>