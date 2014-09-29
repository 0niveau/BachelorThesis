<%@ page import="mypoll.Scale" %>

<div class="row fieldcontain ${hasErrors(bean: scaleInstance, field: 'name', 'error')} required">
    <div class="l-ten m-ten s-ten cols">
        <h2 class="property-header"><g:message code="scale.name.label" default="Name" /></h2>
        <g:textField name="name" required="" value="${scaleInstance?.name}"/>
    </div>
    <div class="actions l-two m-two s-two cols">
        <input class="icon-submit" type="submit" form="${ form }" value="&#xf0c7;"/>
    </div>
</div>

<div class="row fieldcontain ${hasErrors(bean: scaleInstance, field: 'choices', 'error')} ">
    <div class="l-ten m-ten s-ten cols">
        <h2 class="property-header"><g:message code="scale.choices.label" default="Define some choices" /></h2>
        <ol id="scaleChoiceList">
            <g:if test="${ scaleInstance?.choices?.size() >= 2 }">
                <g:each in="${ scaleInstance?.choices }" status="i" var="choice">
                    <li>
                        <input name="choices[${ i }]" type="text" value="${choice}" ${ i<=1 ? "required='required'" : ''}/>
                    </li>
                </g:each>
            </g:if>
            <g:else>
                <li><input name="choices[0]" type="text" required="required"/></li>
                <li><input name="choices[1]" type="text" required="required"/></li>
            </g:else>
        </ol>
    </div>
    <div class="l-two m-two s-two cols centered-text">
        <div class="margin-top">
            <a href="#" id="addNewChoice" class="icon-link"><i class="fa fa-plus-square"></i></a>
            <a href="#" id="removeLastChoice" class="icon-link ${ scaleInstance?.choices?.size() <= 2 ? 'disabled' : '' }"><i class="fa fa-minus-square"></i></a>
        </div>
    </div>
</div>
