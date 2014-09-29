<%@ page import="mypoll.QuestionType" %>
<table class="selectScaleTable">
    <thead>
    <tr>
        <th class="selectScaleTable__radios"></th>
        <th class="selectScaleTable__scales"><g:message code="scale.label" default="Scale" /></th>
        <th class="selectScaleTable__choices"><g:message code="scale.choices.label" default="Choices" /></th>
    </tr>
    </thead>
    <tbody>
        <g:each in="${ mypoll.Scale.list() }" status="i" var="scale">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}" >
            <td><input type="radio" name="scale" value="${scale.id}" ${ scale.id == idOfSelectedScale ? "checked='checked'" : '' }/></td>
            <td>${ scale.name }</td>
            <td>
                <g:each in="${ scale.choices }" var="choice" >
                <span>'${choice}'</span>
                </g:each>
            </td>
        </tr>
        </g:each>
        <tr>
            <td><input type="radio" name="scale" value="none" ${ questionType == QuestionType.OPEN ? "checked='checked'" : '' }/></td>
            <td colspan="2"><g:message code="question.open" default="Open Question" /></td>
        </tr>
    </tbody>
</table>