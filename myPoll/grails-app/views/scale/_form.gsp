<%@ page import="mypoll.Scale" %>



<div class="fieldcontain ${hasErrors(bean: scaleInstance, field: 'name', 'error')} required">
	<label for="nameOfSelectedScale">
		Select your scale!
	</label>
	<g:select name="nameOfSelectedScale" optionKey="${ name }" from="${ scales }" value="${ scaleInstance?.nameOfSelectedScale }"/>

</div>

<div class="fieldcontain ${hasErrors(bean: scaleInstance, field: 'options', 'error')} ">
	<label for="numberOfOptions">
		How many Options?		
	</label>
	<g:select name="numberOfOptions" from="${ 2..10 }" value="${scaleInstance?.numberOfOptions}" />

</div>

