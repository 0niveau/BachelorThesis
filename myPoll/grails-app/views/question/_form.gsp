<%@ page import="mypoll.Question" %>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'text', 'error')} ">
	<label for="text">
		<g:message code="question.text.label" default="Text" />
		
	</label>
	<textarea name="text">${questionInstance?.text}</textarea>

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'scale', 'error')} required">
	<label for="scale">
		<g:message code="question.scale.label" default="Scale" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="scale" name="scale.id" from="${mypoll.Scale.list()}" optionKey="id" required="" value="${questionInstance?.scale?.id}" class="many-to-one"/>
</div>