<%@ page import="mypoll.Question" %>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'text', 'error')} ">
	<label for="text">
		<g:message code="question.text.label" default="Text" />
		
	</label>
	<textarea name="text">${questionInstance?.text}</textarea>

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'scale', 'error')} required">
	<table class="selectScaleTable">
        <thead>
            <tr>
                <th class="selectScaleTable__radios"></th>
                <th class="selectScaleTable__scales">Scale</th>
                <th class="selectScaleTable__options">Options</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${ mypoll.Scale.list() }" status="i" var="scale">
            <tr>
                <td><input type="radio" name="scale" value="${scale.id}"/></td>
                <td>${ scale.name }</td>
                <td>
                    <g:each in="${ scale.options }" var="option" >
                    <span>'${option.value}'</span>
                    </g:each>
                </td>
            </tr>
            </g:each>
        </tbody>
    </table>
</div>