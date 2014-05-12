<%-- 
	required: pollSection
	optional: targetId, selectableQuestions, mode
--%>
<div class="col pollSectionDetails ${ pollSection.id } ${ pollSection.id == targetId ? 'selected' : '' }">		
	<h2>${ pollSection?.name }</h2>		
	
	<g:if test="${ (mode == 'sectionAddItems') && (pollSection.id == targetId) }">
	<h3><g:message code="question.selectable" default="Selectable Questions" /></h3>
	<table>
		<thead>
			<tr>		
				<g:sortableColumn property="text" title="${message(code: 'question.text.label', default: 'Text')}" />		
				<g:sortableColumn property="title" title="${message(code: 'question.title.label', default: 'Title')}" />			
				<th></th>
			</tr>
		</thead>
		<tbody>
		<g:each in="${selectableQuestions}" status="i" var="questionInstance">
			<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">		
				<td><g:link action="show" id="${questionInstance.id}">${fieldValue(bean: questionInstance, field: "title")}</g:link></td>		
				<td>${fieldValue(bean: questionInstance, field: "text")}</td>			
				<td><input name="questionIds[${ i }]" form="addItemsToSectionForm" type="checkbox" value="${ questionInstance.id }"></td>		
			</tr>
		</g:each>
		</tbody>
	</table>

	<div class="pagination">
		<g:paginate total="${questionInstanceCount ?: 0}" />
	</div>
	
	<g:form id="${ pollSection.id }" name="addItemsToSectionForm" controller="pollSection" action="addItems">
		<button type="submit">Auswahl hinzufügen</button>
	</g:form>
	</g:if>
	
	<g:else>
		<h3><g:message code="pollSection.items.added" default="Added Items"/></h3>
		<g:if test="${ pollSection?.items }">
		<ul>						
			<g:each in="${ pollSection?.items }" var="i">
			<li>${ i?.title }</li>
			</g:each>
		</ul>
		</g:if>
		<g:else>
		<p>No items have been added so far!</p>
		</g:else>
		<g:link controller="pollSection" action="addableItems" id="${ pollSection.id }" params="[addToSection: 'addToSection']">Item hinzufügen</g:link>
	</g:else>
		
</div>