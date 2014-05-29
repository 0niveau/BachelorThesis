<!DOCTYPE html>
<html>
<head>
	<title>${ pollSectionInstance?.name }</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
	<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
	<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
	<g:javascript library="application"/>
	<g:javascript library="jquery"/>			
	<r:layoutResources />
</head>
<body class="page full">
	<h1>Welcome to ${ pollSectionInstance?.name }</h1>
	<p>${ pollSectionInstance?.description }</p>
	
	<g:if test="${ needsTestObject }">
		<iframe src="${ opinionInstance?.testObjectUrl }" class="col"></iframe>
	</g:if>
	
	<div class="slider">	
		<a href="#" id="prev">prev</a>
		<g:each in="${ pollSectionInstance?.items }" status="s" var="itemInstance">	
		<div class="sliderElement">
			<p>${ itemInstance?.question }</p>
			<ul>
				<g:each in="${ itemInstance?.options }" status="z" var="optionInstance">
				<li>
		            <label>
		                <input type="radio" form="saveSelectionsForm" name="selections[${itemInstance?.id}]" value="${ optionInstance?.id }"
		                    ${ opinionInstance?.selections?.get(itemInstance?.id as String) == optionInstance ? "checked='checked" : '' }/>
		                ${ optionInstance?.value }
		            </label>
		        </li>
				</g:each>
			</ul>
		</div>		
		</g:each>
		<a href="#" id="next">next</a>
	</div>

    <g:form name="saveSelectionsForm" controller="poll" action="saveSubjectSelections" id="${ opinionInstance?.id }">
        <g:submitButton name="save" value="Save"></g:submitButton>
    </g:form>

	<r:layoutResources />
</body>
</html>