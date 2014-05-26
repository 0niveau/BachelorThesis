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
        <tr class="selectable ${(i % 2) == 0 ? 'even' : 'odd'}" data-selectionRef="options${scale.id}">
            <td><input type="radio" name="scale" value="${scale.id}" ${ scale.id == idOfSelectedScale ? "checked='checked'" : '' }/></td>
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