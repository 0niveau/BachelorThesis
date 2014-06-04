<%-- 
	required: pollSection
	optional: targetId, selectableQuestions, mode
--%>
<div id="${'section' + pollSection.id }" class="propertyDetails ${ pollSection.id } ${ pollSection.id == targetId ? 'selected' : '' } row" >
	<div class="col">
        <h2 class="property-header">${ pollSection?.name }</h2>
	</div>

    <div class="propertyDetail col">
        <h3 class="propertyDetail-header"><g:message code="pollSection.description.label" default="Description" /></h3>
        <g:if test="${ toBeEdited == 'sectionDescription' && !pollSection.poll.isActive }">
            <g:form url="[resource: pollSection, action: 'update']" method="PUT">
            	<textarea name="description">${ pollSection?.description }</textarea>
                <g:submitButton name="save" value="${message(code: 'pollSection.property.update', default: 'Save')}" />
            </g:form>
        </g:if>
        <g:else>
            <g:if test="${pollSection?.description}">
                <p>${ pollSection?.description }</p>
            </g:if>
            <g:else>
                <p>No description entered so far!</p>
            </g:else>
            <g:if test="${ !pollSection.poll.isActive }">
            <g:link controller="pollSection" action="edit" id="${ pollSection.id }" params="[toBeEdited: 'sectionDescription']">Edit description</g:link>
            </g:if>
        </g:else>
    </div>

    <div class="propertyDetail col">
        <h3 class="propertyDetail-header"><g:message code="pollSection.testObject.required" default="Testobject required" /></h3>
        <g:if test="${ pollSection?.needsTestObject }">
        <p>This section needs a test object</p>
        </g:if>
        <g:else>
        <p>This section does not need a test object</p>
        </g:else>
        <g:if test="${ !pollSection.poll.isActive }">
        <g:form url="[resource: pollSection, action: 'update']" method="PUT">
            <input type="hidden" name="needsTestObject" value="${ !pollSection.needsTestObject}" />
            <g:submitButton name="save" value="${ message(code: 'pollSection.needsTestObject.toggle', default: 'Toggle') }" />
        </g:form>
        </g:if>
    </div>

    <div class="propertyDetail col">
        <g:if test="${ (mode == 'sectionAddItems') && (pollSection.id == targetId) && !pollSection.poll.isActive}">
            <h3 class="propertyDetail-header"><g:message code="question.selectable" default="Selectable Questions" /></h3>
            <table>
                <thead>
                <tr>
                    <g:sortableColumn property="text" title="${message(code: 'question.text.label', default: 'Text')}" />
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${selectableQuestions}" status="i" var="questionInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td><g:link action="show" id="${questionInstance.id}">${fieldValue(bean: questionInstance, field: "text")}</g:link></td>                   
                        <td><input name="questionIds[${ i }]" form="addItemsToSectionForm" type="checkbox" value="${ questionInstance.id }" /></td>
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
            <h3 class="propertyDetail-header"><g:message code="pollSection.items.added" default="Added Items"/></h3>
            <g:if test="${ pollSection?.items }"> 
            	<table class="pollSectionItemTable">
            		<thead>
            			<tr>
	            			<th>Item</th>
	            			<th></th>
            			</tr>            			
            		</thead>
            		<tbody class="draggableItemList pollSectionItemList" data-listedElements="items">
           			<g:each in="${ pollSection?.items }" status="i" var="itemInstance">
           				<tr class="draggableItem pollSectionItem ${(i % 2) == 0 ? 'even' : 'odd'}" ${ pollSection.poll.isActive ? '' : "draggable='true'" } >
           					<td>${ itemInstance?.question }</td>
           					<td><input type="hidden" class="itemIdInput" 
           						name="items[${i}]" form="reorderItemsForm${ pollSection?.name }" value="${ itemInstance?.id }" /></td>
           				</tr>
           			</g:each>
            		</tbody>
            	</table>
                <g:if test="${!pollSection?.poll?.isActive}">
                <g:form controller="pollSection" action="update" id="${pollSection.id}" method="PUT" name="reorderItemsForm${ pollSection?.name }">
                    <button type="submit">Reihenfolge Speichern</button>
                </g:form>
                </g:if>
            </g:if>
            <g:else>
                <p>No items have been added so far!</p>
            </g:else>
            <g:if test="${!pollSection?.poll?.isActive}">
            <g:link controller="pollSection" action="addableItems" id="${ pollSection.id }" params="[addToSection: 'addToSection']">Item hinzufügen</g:link>
            </g:if>
        </g:else>
    </div>
</div>