<%@ page import="mypoll.Scale" %>



<div class="fieldcontain ${hasErrors(bean: ScaleInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="Scale.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${ScaleInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: ScaleInstance, field: 'options', 'error')} ">
	<h2>Define the options!</h2>
	<g:each in="${ (0..<numberOfOptions) }" >
		<div>
			<input name="options[${ it }]" type="text" required="required"/>
		</div>
	</g:each>
</div>
