<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main" />
	<title>${ pollSectionInstance?.name }</title>
</head>
<body>
	<h1>Welcome to ${ pollSectionInstance?.name }</h1>
	<p>${ pollSectionInstance?.description }</p>
	
	<g:each in="${ pollSectionInstance?.items }" status="s" var="itemInstance">
	<p>${ itemInstance?.question }</p>
	<ul>
		<g:each in="${ itemInstance?.options }" status="z" var="optionInstance">
		<li><label><input type="radio" name="${ itemInstance?.id }" value="${ optionInstance?.id }" />${ optionInstance?.value }</label></li>
		</g:each>
	</ul>
	</g:each>
</body>
</html>