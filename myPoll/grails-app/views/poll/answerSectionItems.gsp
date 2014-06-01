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
<body class="page full darkgrey">
    <div class="row nomargin bottom">
        <section class="l-three m-twelve s-twelve cols lightgrey">
            <div class="row">
                <div class="col">
                    <h1 class="blueText">Welcome to ${ pollSectionInstance?.name }</h1>
                    <p>${ pollSectionInstance?.description }</p>
                </div>
            </div>


            <div class="row">

                <div class="slider highlight l-twelve m-twelve s-twelve cols">
                    <g:each in="${ pollSectionInstance?.items }" status="s" var="itemInstance">
                        <div class="sliderElement">
                            <p class="blueText bold">${ itemInstance?.question }</p>
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
                </div>
                <div class="sliderNavigation l-four m-four s-four cols">
                    <a href="#" id="prev"><-- prev</a>
                </div>
                <div class="sliderNavigation l-four m-four s-four cols">
                    <a href="#" id="next">next --></a>
                </div>
                <div class="l-four m-four s-four cols">
                    <g:form name="saveSelectionsForm" controller="poll" action="saveSubjectSelections" id="${ opinionInstance?.id }">
                        <g:submitButton name="save" value="Save"></g:submitButton>
                    </g:form>
                </div>
            </div>
        </section>

        <g:if test="${ needsTestObject }">
            <iframe src="${ opinionInstance?.testObjectUrl }" class="l-nine m-twelve s-twelve cols l-border-left-solidGrey"></iframe>
        </g:if>
    </div>

	<r:layoutResources />
</body>
</html>