<%@ page import="mypoll.Scale" %>

<div class="row fieldcontain ${hasErrors(bean: scaleInstance, field: 'name', 'error')} required">
    <div class="l-ten m-ten s-ten cols">
        <h2 class="property-header"><g:message code="Scale.name.label" default="Name" /></h2>
        <g:textField name="name" required="" value="${scaleInstance?.name}"/>
    </div>
    <div class="actions l-two m-two s-two cols">
        <input class="icon-submit" type="submit" form="${ form }" value="&#xf0c7;"/>
    </div>
</div>

<div class="row fieldcontain ${hasErrors(bean: scaleInstance, field: 'options', 'error')} ">
    <div class="l-ten m-ten s-ten cols">
        <h2 class="property-header">Define the options!</h2>
        <ol id="scaleOptionList">
            <g:if test="${ scaleInstance?.options?.size() >= 2 }">
                <g:each in="${ scaleInstance?.options }" status="i" var="option">
                    <li>
                        <input name="options[${ i }]" type="text" value="${option.value}" ${ i<=1 ? "required='required'" : ''}/>
                    </li>
                </g:each>
            </g:if>
            <g:else>
                <li><input name="options[0]" type="text" required="required"/></li>
                <li><input name="options[1]" type="text" required="required"/></li>
            </g:else>
        </ol>
    </div>
    <div class="l-two m-two s-two cols centered-text">
        <div class="margin-top">
            <a href="#" id="addNewOption" class="icon-link"><i class="fa fa-plus-square"></i></a>
            <a href="#" id="removeLastOption" class="icon-link ${ scaleInstance?.options?.size() <= 2 ? 'disabled' : '' }"><i class="fa fa-minus-square"></i></a>
        </div>
    </div>
</div>
