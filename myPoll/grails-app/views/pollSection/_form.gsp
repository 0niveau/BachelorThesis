<%@ page import="mypoll.PollSection" %>



<div class="fieldcontain ${hasErrors(bean: pollSectionInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="pollSection.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${pollSectionInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollSectionInstance, field: 'poll', 'error')} required">
	<label for="poll">
		<g:message code="pollSection.poll.label" default="Poll" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="poll" name="poll.id" from="${mypoll.Poll.list()}" optionKey="id" required="" value="${pollSectionInstance?.poll?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollSectionInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="pollSection.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${pollSectionInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollSectionInstance, field: 'index', 'error')} required">
	<label for="index">
		<g:message code="pollSection.index.label" default="Index" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="index" type="number" value="${pollSectionInstance.index}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollSectionInstance, field: 'needsTestObject', 'error')} ">
	<label for="needsTestObject">
		<g:message code="pollSection.needsTestObject.label" default="Needs Test Object" />
		
	</label>
	<g:checkBox name="needsTestObject" value="${pollSectionInstance?.needsTestObject}" />

</div>

