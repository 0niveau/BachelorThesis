<%-- 
	required: pollSection
	optional: targetId, selectableQuestions, mode
--%>
<div id="${'section' + pollSection.id }" class="propertyDetails ${ pollSection.id } ${ pollSection.id == targetId ? 'selected' : '' }" >
    <div class="row">
        <div class="col">
            <h2 class="property-header">${ pollSection?.name }</h2>
        </div>
    </div>

    <div class="row">
        <div class="propertyDetail l-ten m-ten s-ten cols">
            <h3 class="propertyDetail-header"><g:message code="pollSection.description.label" default="Description" /></h3>
            <g:if test="${ toBeEdited == 'sectionDescription' && !pollSection.poll.isActive }">
                <g:form url="[resource: pollSection, action: 'update']" method="PUT" name="edit${pollSection?.name}DescriptionForm">
                    <textarea name="description">${ pollSection?.description }</textarea>
                </g:form>
            </g:if>
            <g:else>
                <g:if test="${pollSection?.description}">
                    <p>${ pollSection?.description }</p>
                </g:if>
                <g:else>
                    <p>No description entered so far!</p>
                </g:else>
            </g:else>
        </div>
        <div class="actions l-two m-two s-two col">
            <g:if test="${ !pollSection.poll.isActive }">
                <g:if test="${ toBeEdited == 'sectionDescription' }">
                    <input class="icon-submit" type="submit" value="&#xf0c7;" form="edit${pollSection?.name}DescriptionForm">
                </g:if>
                <g:else>
                    <g:link class="icon-link" controller="pollSection" action="edit" id="${ pollSection.id }" params="[toBeEdited: 'sectionDescription']">
                        <i class="fa fa-pencil"></i></g:link>
                </g:else>
            </g:if>
        </div>
    </div>

    <div class="row">
        <div class="propertyDetail l-ten m-ten s-ten cols">
            <h3 class="propertyDetail-header"><g:message code="pollSection.testObject.required" default="Testobject required" /></h3>
            <g:if test="${ pollSection?.needsTestObject }">
            <p>This section needs a test object</p>
            </g:if>
            <g:else>
            <p>This section does not need a test object</p>
            </g:else>
            <g:if test="${ !pollSection.poll.isActive }">

            </g:if>
        </div>
        <div class="actions l-two m-two s-two col">
            <g:if test="${ !pollSection.poll.isActive }">
                <g:form url="[resource: pollSection, action: 'update']" method="PUT">
                    <input type="hidden" name="needsTestObject" value="${ !pollSection.needsTestObject}" />
                    <g:if test="${ pollSection?.needsTestObject }">
                        <input class="icon-submit" type="submit" value="&#xf111;">
                    </g:if>
                    <g:else>
                        <input class="icon-submit" type="submit" value="&#xf10c;">
                    </g:else>
                </g:form>
            </g:if>
        </div>
    </div>

    <div class="row">
        <div class="propertyDetail l-ten m-ten s-ten cols">
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
                </g:if>
                <g:else>
                    <p>No items have been added so far!</p>
                </g:else>
            </g:else>
        </div>
        <div class="actions l-two m-two s-two cols">
            <g:if test="${ !pollSection.poll.isActive }">
                <g:if test="${ mode == "sectionAddItems" && (pollSection.id == targetId) }">
                    <g:form id="${ pollSection.id }" name="addItemsToSectionForm" controller="pollSection" action="addItems">
                        <input class="icon-submit" type="submit" value="&#xf00c;"/>
                    </g:form>
                </g:if>
                <g:else>
                    <g:link class="icon-link" controller="pollSection" action="addableItems" id="${ pollSection.id }" params="[addToSection: 'addToSection']">
                        <i class="fa fa-plus"></i></g:link>
                    <g:form controller="pollSection" action="update" id="${pollSection.id}" method="PUT" name="reorderItemsForm${ pollSection?.name }">
                        <input class="icon-submit" type="submit" value="&#xf0c9;"/>
                    </g:form>
                </g:else>
            </g:if>
        </div>
    </div>
</div>