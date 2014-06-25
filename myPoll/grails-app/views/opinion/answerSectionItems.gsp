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
    <link rel="stylesheet" href="${resource(dir: 'css/font-awesome-4.1.0/css', file: 'font-awesome.min.css')}" type="text/css">
	<g:javascript library="application"/>
	<r:layoutResources />
</head>
<body class="page ${ displayTestObjectInIFrame ? 'full' : '' } darkgrey">
    <div class="row white nomargin-bottom ${ !displayTestObjectInIFrame ? 'shadow top' : '' }">
        <section class="${ displayTestObjectInIFrame ? 'l-three m-twelve s-twelve' : '' } cols">
            <div class="row">
                <div class="col">
                    <h1 class="blueText">Welcome to ${ pollSectionInstance?.name }</h1>
                    <p>${ pollSectionInstance?.description }</p>
                </div>
            </div>

            <div class="row highlight">
                <div class="slider l-twelve m-twelve s-twelve cols">
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
                <g:if test="${ needsTestObject && !displayTestObjectInIFrame }">
                    <div class="l-six m-six s-twelve cols">
                        <p>It seems like you are using a mobile device or a small browser-window. Please open the url below in a second tab to be able to answer the questions.</p>
                        <p><a href="${opinionInstance.testObjectUrl}" class="text-link">${opinionInstance.testObjectUrl}" <i class="fa fa-external-link padding-left"></i></a></p>
                    </div>
                </g:if>
            </div>
            <div class="row">
                <div class="sliderNavigation l-four m-four s-four cols centered-text">
                    <a href="#" class="icon-link" id="prev"><i class="fa fa-arrow-left"></i></a>
                </div>
                <div class="sliderNavigation l-four m-four s-four cols centered-text">
                    <a href="#" class="icon-link" id="next"><i class="fa fa-arrow-right"></i></a>
                </div>
                <div class="l-four m-four s-four cols centered-text">
                    <g:form name="saveSelectionsForm" controller="opinion" action="saveSubjectSelections" id="${ opinionInstance?.id }">
                        <input class="icon-submit" type="submit" value="&#xf0c7;" />
                    </g:form>
                </div>
            </div>
        </section>

        <g:if test="${ displayTestObjectInIFrame }">
            <iframe src="${ opinionInstance?.testObjectUrl }" class="l-nine m-twelve s-twelve cols l-border-left-solidGrey"></iframe>
        </g:if>
    </div>

	<r:layoutResources />
</body>
</html>