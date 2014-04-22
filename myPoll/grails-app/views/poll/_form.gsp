<%@ page import="mypoll.Poll" %>



<div class="fieldcontain ${hasErrors(bean: pollInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="poll.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${pollInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="poll.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${pollInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollInstance, field: 'isActive', 'error')} ">
	<label for="isActive">
		<g:message code="poll.isActive.label" default="Is Active" />
		
	</label>
	<g:checkBox name="isActive" value="${pollInstance?.isActive}" />

</div>

<div class="fieldcontain ${hasErrors(bean: pollInstance, field: 'sections', 'error')} ">
	<label for="sections">
		<g:message code="poll.sections.label" default="Sections" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${pollInstance?.sections?}" var="s">
    <li><g:link controller="pollSection" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="pollSection" action="create" params="['poll.id': pollInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'pollSection.label', default: 'PollSection')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: pollInstance, field: 'testObjectUrlA', 'error')} ">
	<label for="testObjectUrlA">
		<g:message code="poll.testObjectUrlA.label" default="Test Object Url A" />
		
	</label>
	<g:textField name="testObjectUrlA" value="${pollInstance?.testObjectUrlA}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: pollInstance, field: 'testObjectUrlB', 'error')} ">
	<label for="testObjectUrlB">
		<g:message code="poll.testObjectUrlB.label" default="Test Object Url B" />
		
	</label>
	<g:textField name="testObjectUrlB" value="${pollInstance?.testObjectUrlB}"/>

</div>

