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
                    <p><g:message code="pollSection.description.empty" default=" No description entered so far!" /></p>
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
            <h3 class="propertyDetail-header"><g:message code="pollSection.testObject.label" default="Testobject" /></h3>
            <g:if test="${ pollSection?.needsTestObject }">
            <p><g:message code="pollSection.testObject.needed" default="This section needs a test object"/></p>
            </g:if>
            <g:else>
            <p><g:message code="pollSection.testObject.notNeeded" default="This section does not need a test object"/></p>
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
            <g:set var="itemCount" value="${ pollSection?.items?.size() }"/>
            <p>
            	<g:message code="pollSection.items.count" 
            	args="[itemCount]" 
            	default="You have already added ${ itemCount } items to your section"/>
            </p>
        </div>
        <div class="actions l-two m-two s-two cols">
            <g:link class="icon-link" controller="pollSection" action="showAllItems" id="${pollSection.id}"><i class="fa fa-eye"></i></g:link>
        </div>
    </div>
    
    <div class="row border-bottom-blueDotted">
    	<div class="propertyDetail l-ten m-ten s-ten cols">
    		<h3 class="propertyDetail-header"><g:message code="pollSection.delete" default="Delete this section"/></h3>
    		<p>
    			<g:message code="hint.pollSection.delete.lostOpinions"
    			default="If you delete this section, you are not able to access the opinion results related to it anymore"/></p>
    	</div>
    	<div class="actions l-two m-two s-two cols">
    		<g:if test="${ !pollInstance?.isActive }">
            	<g:form controller="pollSection" action="delete" method="DELETE" id="${ pollSection?.id }">
            		<input class="icon-submit" type="submit" value="&#xf014;" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
            	</g:form>            
           	</g:if>
           	<g:else>
           		<a class="icon-link disabled"><i class="fa fa-trash-o"></i></a>
           	</g:else>
    	</div>
    </div>
</div>

<g:if test="${ (mode == 'addSectionItems') && (pollSection.id == targetId) && !pollSection.poll.isActive}">
    <div class="overlay">
        <div class="overlayContent white">
            <div class="row">
                <div class="l-ten m-ten s-ten cols">
                    <h3 class="propertyDetail-header"><g:message code="pollSection.items.addable" default="Addable Items"/></h3>
                    <g:if test="${ !selectableQuestions?.empty }">
                        <p class="hint">
                        	<g:message code="hint.pollSection.items.add" 
                        	default="Select the items you want to add to this section"/>
                        </p>
                        <p class="hint">
                        	<g:message code="hint.pollSection.items.add.missingItem"
                        	default="If you can't find questions that fit for your purpose, you can easily create your own questions. Just follow this link"/>
                        </p>
                    </g:if>
                    <g:else>
                        <p class="hint">
                        	<g:message code="hint.pollSection.items.add.noItems"
                        	default="You have added all available questions to your section. Follow the link below to create some more."/>
                        </p>
                    </g:else>
                    <g:link controller="question" action="create" params="[pollSectionId: pollSection.id]"><i class="fa fa-hand-o-right padding-right"></i><g:message code="question.new" default="New question" /></g:link>
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
                        <ul class="enclosedItems">
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
                        <p class="hint">
                        	<g:message code="hint.pollSection.items.empty" 
                        	default="No Items added so far. Please add some Items to your section."/></p>
                    </g:if>
                    <g:elseif test="${ pollSection.poll.isActive }">
                        <p class="hint">
                        	<g:message code="hint.pollSection.poll.activated" 
                        	default="Your poll is currently active. you can't change anything :P"/></p>
                    </g:elseif>
                    <g:else>
                        <p class="hint">
                        	<g:message code="hint.pollSection.items.edit" 
                        	default="Sort your items by dragging and dropping or add new items to this section"/>
                        </p>
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
                        <ul class="draggableItemList pollSectionItemList enclosedItems" data-listedElements="items">
                            <g:each in="${ pollSection?.items }" status="i" var="itemInstance">
                                <li class="${ pollSection.poll.isActive ? '' : 'draggableItem'} pollSectionItem ${(i % 2) == 0 ? 'even' : 'odd'}" ${ pollSection.poll.isActive ? '' : "draggable=true" }>
                                    <span>${ itemInstance?.question }</span>
                                    <input type="hidden" class="itemIdInput"
                                           name="items[${i}]" form="reorderItemsForm${ pollSection?.name }" value="${ itemInstance?.id }" />
                                    <g:form controller="item" action="delete" id="${ itemInstance?.id }" params="[pollSectionId: pollSection.id]" method="DELETE">
                                    	<input class="icon-submit inline" type="submit" value="&#xf014;"/>
                                    </g:form>
                                </li>
                            </g:each>
                        </ul>
                    </g:if>
                </div>
            </div>
        </div>
    </div>
</g:elseif>