<%@ page import="mypoll.PollSection" %>



<div class="fieldcontain ${hasErrors(bean: pollSectionInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="pollSection.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${pollSectionInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollSectionInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="pollSection.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${pollSectionInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollSectionInstance, field: 'items', 'error')} ">
	<label for="items">
		<g:message code="pollSection.items.label" default="Items" />
		
	</label>
	<g:select name="items" from="${mypoll.Item.list()}" multiple="multiple" optionKey="id" size="5" value="${pollSectionInstance?.items*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollSectionInstance, field: 'needsTestObject', 'error')} ">
	<label for="needsTestObject">
		<g:message code="pollSection.needsTestObject.label" default="Needs Test Object" />
		
	</label>
	<g:checkBox name="needsTestObject" value="${pollSectionInstance?.needsTestObject}" />

</div>

<div class="fieldcontain ${hasErrors(bean: pollSectionInstance, field: 'poll', 'error')} required">
	<label for="poll">
		<g:message code="pollSection.poll.label" default="Poll" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="poll" name="poll.id" from="${mypoll.Poll.list()}" optionKey="id" required="" value="${pollSectionInstance?.poll?.id}" class="many-to-one"/>

</div>

