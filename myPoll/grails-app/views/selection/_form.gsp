<%@ page import="mypoll.Selection" %>



<div class="fieldcontain ${hasErrors(bean: selectionInstance, field: 'item', 'error')} required">
	<label for="item">
		<g:message code="selection.item.label" default="Item" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="item" name="item.id" from="${mypoll.Item.list()}" optionKey="id" required="" value="${selectionInstance?.item?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: selectionInstance, field: 'value', 'error')} ">
	<label for="value">
		<g:message code="selection.value.label" default="Value" />
		
	</label>
	<g:textField name="value" value="${selectionInstance?.value}"/>

</div>

