<%-- 
	required: pollSection
	optional: targetId, selectableQuestions, mode
--%>
<div class="pollSectionDetails ${ pollSection.id } ${ pollSection.id == targetId ? 'selected' : '' }" >
	<h2 class="property-header">${ pollSection?.name }</h2>

    <div class="propertyDetail">
        <h3 class="propertyDetail-header"><g:message code="pollSection.description.label" default="Description" /></h3>
        <g:if test="${ mode == 'sectionDescription' }">
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
            <g:link controller="pollSection" action="edit" id="${ pollSection.id }" params="[toBeEdited: 'sectionDescription']">Edit description</g:link>
        </g:else>
    </div>

    <div class="propertyDetail">
        <h3 class="propertyDetail-header"><g:message code="pollSection.testObject.required" default="Testobject required" /></h3>
        <g:if test="${ pollSection?.needsTestObject }">
        <p>This section needs a test object</p>
        </g:if>
        <g:else>
        <p>This section does not need a test object</p>
        </g:else>
        <g:form url="[resource: pollSection, action: 'update']" method="PUT">
            <input type="hidden" name="needsTestObject" value="${ !pollSection.needsTestObject}" />
            <g:submitButton name="save" value="${ message(code: 'pollSection.needsTestObject.toggle', default: 'Toggle') }" />
        </g:form>
    </div>

    <div class="propertyDetail">
        <g:if test="${ (mode == 'sectionAddItems') && (pollSection.id == targetId) }">
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
            	<ol class="pollSectionItemList">               
	            <g:each in="${ pollSection?.items }" status="i" var="itemInstance">
	            <li class="pollSectionItem " draggable="true">
	                <span>${ itemInstance?.question }</span>
                    <input type="hidden" class="itemIdInput" name="items[${i}]" form="reorderItemsForm${ pollSection?.name }" value="${ itemInstance.id }" />
	                <a href="#" >Delete</a>
	            </li>
	            </g:each>
	            </ol>
                <g:form controller="pollSection" action="update" id="${pollSection.id}" method="PUT" name="reorderItemsForm${ pollSection?.name }">
                    <button type="submit">Reihenfolge Speichern</button>
                </g:form>
            </g:if>
            <g:else>
                <p>No items have been added so far!</p>
            </g:else>
            <g:link controller="pollSection" action="addableItems" id="${ pollSection.id }" params="[addToSection: 'addToSection']">Item hinzufügen</g:link>
        </g:else>
    </div>
</div>