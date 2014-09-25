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
    <div class="row white nomargin-bottom ${ !displayTestObjectInIFrame ? 'shadow top' : '' }" id="containsTestObject">
        <section class="${ displayTestObjectInIFrame ? 'l-three m-twelve s-twelve' : '' } cols" id="myPollContent">
            <div class="row border-bottom-blueDotted">
                <div class="col">
                	<g:set var="sectionName" value="${ pollSectionInstance?.name }" />
                    <h1 class="blueText"><g:message code="opinion.answerSectionItems.welcome" args="[sectionName]" default="Welcome to section: '${ sectionName }'"/></h1>
                    <p>${ pollSectionInstance?.description }</p>
                </div>

                <div class="col">
                    <g:if test="${ needsTestObject }">
                        <p class="hint">
                            <g:if test="${!displayTestObjectInIFrame}">
                                <g:message code="hint.opinion.smallDisplay"
                                           default="It seems like you are using a mobile device or a small browser-window. Please open the url below in a second tab to be able to answer the questions."/>
                            </g:if>
                            <g:else>
                                <g:message code="hint.opinion.openInNewTab"
                                           default="If the page on the right is not displayed correctly or if you encounter any other problems, you may open the site in a new tab using the link below."/>
                            </g:else>
                        </p>
                        <p><a href="${opinionInstance.testObjectUrl}" class="text-link" target="_blank" onclick="viewHandler()"><g:message code="opinion.openInNewTab.link" default="to the website"/> <i class="fa fa-external-link padding-left"></i></a></p>
                    </g:if>
                </div>
            </div>

            <g:if test="${!answersComplete}">
                <div class="row dim">
                    <div class="col">
                        <p class="centered-text bold greyText"><g:message code="opinion.items.missingAnswers" default="Ooops! Seems like some answers are missing. Please make sure you have answered all the questions. Thank you!"/></p>
                    </div>
                </div>
            </g:if>

            <g:form name="saveSelectionsForm" controller="opinion" action="saveSubjectSelections" id="${ opinionInstance?.id }" params="[sectionId: pollSectionInstance?.id]">
                <div class="row">
                    <div class="slider col">
                        <g:set var="numberOfItems" value="${pollSectionInstance?.items?.size()}" />
                        <g:each in="${ pollSectionInstance?.items }" status="s" var="itemInstance">
                            <div class="sliderElement">
                                <div class="row ">
                                    <div class="col text-right bold">
                                        <g:message code="opinion.items.progress" args="[s+1, numberOfItems]" default="Question ${ s + 1} of ${ numberOfItems}" />
                                    </div>
                                </div>
                                <div class="row nomargin-bottom highlight">
                                    <div class="col">
                                        <p class="bold">${ itemInstance?.question }</p>
                                        <ul>
                                            <g:each in="${ itemInstance?.choices }" status="z" var="choiceInstance">
                                                <li>
                                                    <label>
                                                        <input type="radio" class="radio" form="saveSelectionsForm" name="selections[${itemInstance?.id}]" value="${ choiceInstance?.value }"
                                                            ${ opinionInstance?.selections?.get(itemInstance?.id as String) == choiceInstance?.value ? "checked='checked" : '' }/>
                                                        ${ choiceInstance?.value }
                                                    </label>
                                                </li>
                                            </g:each>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </g:each>
                    </div>
                </div>
                <div class="row">
                    <div class="sliderNavigation l-four m-four s-four cols centered-text">
                        <a href="#" class="icon-link" id="prev"><i class="fa fa-arrow-left"></i></a>
                    </div>
                    <div class="sliderNavigation l-four m-four s-four cols centered-text">
                        <a href="#" class="icon-link" id="next"><i class="fa fa-arrow-right"></i></a>
                    </div>
                    <div class="l-four m-four s-four cols centered-text">

                            <input class="displayWidthInput" name="displayWidth" type="hidden" value="">
                            <input class="icon-submit" type="submit" value="&#xf00c;" id="finish"/>
                    </div>
                </div>
            </g:form>
        </section>

        <r:layoutResources />

        <g:if test="${ displayTestObjectInIFrame }">
            <script>
                function viewHandler() {
                    var body = document.querySelector('body');
                    var wrap = document.querySelector('#containsTestObject');
                    var testObject = document.querySelector('#testObjectIFrame');
                    var myPollContent = document.querySelector('#myPollContent');

                    body.classList.remove('full');
                    wrap.classList.add('top', 'shadow');
                    testObject.classList.add('hidden');
                    myPollContent.classList.remove('l-three');
                }

                //doesn't block the load event
                function createIframe(){
                    var i = document.createElement("iframe");
                    i.src = "${ opinionInstance?.testObjectUrl }";
                    i.id = "testObjectIFrame"
                    i.className = "l-nine m-twelve s-twelve cols l-border-left-solidGrey"
                    document.getElementById("containsTestObject").appendChild(i);
                };

                // Check for browser support of event handling capability
                if (window.addEventListener)
                    window.addEventListener("load", createIframe, false);
                else if (window.attachEvent)
                    window.attachEvent("onload", createIframe);
                else window.onload = createIframe;

            </script>
            <%-- <iframe src="${ opinionInstance?.testObjectUrl }" class=""></iframe> --%>
        </g:if>
    </div>
</body>
</html>