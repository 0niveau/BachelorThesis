<%@ page import="mypoll.NominalScale" %>



<div class="fieldcontain ${hasErrors(bean: nominalScaleInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="nominalScale.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${nominalScaleInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: nominalScaleInstance, field: 'options', 'error')} ">
	<h2>Define the options!</h2>
	<g:each in="${ (0..<numberOfOptions) }" >
		<div>
			<input name="options[${ it }]" type="text" required="required"/>
		</div>
	</g:each>
</div>

