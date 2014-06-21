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

    <g:hasErrors bean="${ pollSectionInstance }">
        <div class="row">
            <div class="col">
                <g:eachError bean="${pollSectionInstance}" var="error">
                    <p class="hint"><g:message error="${error}"/></p>
                </g:eachError>
            </div>
        </div>
    </g:hasErrors>

    <div class="row border-bottom-blueDotted">
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
            <g:else><a class="icon-link disabled"><i class="fa fa-pencil"></i></a></g:else>
        </div>
    </div>

    <div class="row border-bottom-blueDotted">
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
                        <input class="icon-submit redText" type="submit" value="&#xf011;">
                    </g:if>
                    <g:else>
                        <input class="icon-submit greenText" type="submit" value="&#xf011;">
                    </g:else>
                </g:form>
            </g:if>
            <g:else><a class="icon-link disabled"><i class="fa fa-power-off"></i></a></g:else>
        </div>
    </div>

    <div class="row border-bottom-blueDotted">
        <div class="propertyDetail l-ten m-ten s-ten cols">
            <h3 class="propertyDetail-header"><g:message code="pollSection.items.added" default="Added Items"/></h3>
            <p>You have already added ${ pollSection?.items?.size() } items to your section</p>
        </div>
        <div class="actions l-two m-two s-two cols">
            <g:link class="icon-link" controller="pollSection" action="showAllItems" id="${pollSection.id}"><i class="fa fa-eye"></i></g:link>
        </div>
    </div>
</div>

<g:if test="${ (mode == 'addSectionItems') && (pollSection.id == targetId) && !pollSection.poll.isActive}">
    <div class="overlay">
        <div class="overlayContent white">
            <div class="row">
                <div class="l-ten m-ten s-ten cols">
                    <h3 class="propertyDetail-header"><g:message code="pollSection.items.added" default="Addable Items"/></h3>
                    <g:if test="${ !selectableQuestions?.empty }">
                        <p class="hint">Wählen Sie die Fragen aus, die Sie als Items zu ihrer Umfrage hinzufügen wollen</p>
                        <p class="hint">If you can't find questions that fit for your purpose, you can easily create your own questions. Just follow this link</p>
                    </g:if>
                    <g:else>
                        <p class="hint">You have added all available questions to your section. Follow the link below to create some more.</p>
                    </g:else>
                    <g:link controller="question" action="create"><i class="fa fa-hand-o-right padding-right"></i>new Question</g:link>
                </div>
                <div class="actions l-two m-two s-two cols">
                    <g:form id="${ pollSection.id }" name="addItemsToSectionForm" controller="pollSection" action="addItems">
                        <input class="icon-submit" type="submit" value="&#xf00c;"/>
                    </g:form>
                </div>
            </div>
            <g:if test="${ !selectableQuestions?.empty }">
                <div class="row">
                    <div class="col">
                        <ul>
                            <g:each in="${selectableQuestions}" status="i" var="questionInstance">
                                <li class="${(i % 2) == 0 ? 'even' : 'odd'} ">
                                    <input class="padding-right" name="questionIds[${ i }]" form="addItemsToSectionForm" type="checkbox" value="${ questionInstance.id }" />
                                    <span>${fieldValue(bean: questionInstance, field: "text")}</span>
                                </li>
                            </g:each>
                        </ul>
                    </div>
                </div>
            </g:if>
        </div>
    </div>
</g:if>

<g:elseif test="${ (mode == 'showAllItems') && ( pollSection?.id == targetId ) }">
    <div class="overlay">
        <div class="overlayContent white">
            <div class="row">
                <div class="l-nine m-six s-six cols">
                    <h3 class="propertyDetail-header"><g:message code="pollSection.items.added" default="Added Items"/></h3>
                    <g:if test="${ pollSection?.items?.empty }">
                        <p class="hint">No Items added so far. Please add some Items to your section.</p>
                    </g:if>
                    <g:elseif test="${ pollSection.poll.isActive }">
                        <p class="hint">Your poll is currently active. you can't change anything :P</p>
                    </g:elseif>
                    <g:else>
                        <p class="hint">Sortieren Sie die Items mit Drag and Drop oder fügen Sie neue hinzu</p>
                    </g:else>
                </div>
                <div class="actions l-one m-two s-two cols">
                    <g:if test="${ !pollSection.poll.isActive }">
                        <g:link class="icon-link" controller="pollSection" action="addableItems" id="${ pollSection.id }" params="[addToSection: 'addToSection']">
                            <i class="fa fa-plus"></i></g:link>
                    </g:if>
                    <g:else><a class="icon-link disabled"><i class="fa fa-plus"></i></a></g:else>
                </div>
                <div class="actions l-one m-two s-two cols">
                    <g:if test="${ !pollSection.poll.isActive && !pollSection?.items?.isEmpty() }">
                        <g:form controller="pollSection" action="update" params="[mode: 'showAllItems']" id="${pollSection.id}" method="PUT" name="reorderItemsForm${ pollSection?.name }">
                            <input class="icon-submit nomargin-bottom" type="submit" value="&#xf0c7;"/>
                        </g:form>
                    </g:if>
                    <g:else><a class="icon-link disabled"><i class="fa fa-save"></i></a></g:else>
                </div>
                <div class="actions l-one m-two s-two cols">
                    <g:link class="icon-link" controller="pollSection" action="show" id="${ pollSection?.id }"><i class="fa fa-times"></i></g:link>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <g:if test="${ !pollSection?.items?.isEmpty() }">
                        <ul class="draggableItemList pollSectionItemList" data-listedElements="items">
                            <g:each in="${ pollSection?.items }" status="i" var="itemInstance">
                                <li class="${ pollSection.poll.isActive ? '' : 'draggableItem'} pollSectionItem ${(i % 2) == 0 ? 'even' : 'odd'}" ${ pollSection.poll.isActive ? '' : "draggable='true'" }>
                                    <span>${ itemInstance?.question }</span>
                                    <input type="hidden" class="itemIdInput"
                                           name="items[${i}]" form="reorderItemsForm${ pollSection?.name }" value="${ itemInstance?.id }" />
                                </li>
                            </g:each>
                        </ul>
                    </g:if>
                </div>
            </div>
        </div>
    </div>
</g:elseif>