<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main" />
	<title>${ pollInstance?.name }</title>
</head>
<body>
    <div class="row white shadow top">
        <div class="col">
            <g:hasErrors bean="${opinionInstance}">
                <div class="row">
                    <div class="col">
                        <ul>
                            <g:eachError bean="${opinionInstance}" var="error">
                                <li class="hint"><g:message error="${error}" /></li>
                            </g:eachError>
                        </ul>
                    </div>
                </div>
            </g:hasErrors>
            <div class="row">
                <div class="l-six m-eight s-nine cols">
                    <h1>${ pollInstance?.name }</h1>
                    <p class="margin-bottom">${ pollInstance?.description }</p>
                    <p class="hint">Please answer the questions of the following sections</p>
                </div>
                <div class="l-six m-four s-three cols box centered-text">
                    <g:if test="${!opinionInstance.submitted && submittable}">
                        <g:link class="icon-link big" controller="opinion" action="submitOpinion" id="${opinionInstance.id}">
                            <i class="fa fa-send"></i>
                        </g:link>
                    </g:if>
                    <g:else>
                        <a class="icon-link big disabled"><i class="fa fa-send"></i></a>
                    </g:else>
                </div>
            </div>

            <g:each in="${ pollInstance?.sections }" status="s" var="pollSectionInstance">
                <g:if test="${ s % 3 == 0 }"><div class="row highlight nomargin-bottom"></g:if>

                <div class="l-four m-twelve s-twelve cols boxInside">
                    <div class="row">
                        <div class="col">
                            <h3>${ pollSectionInstance?.name }</h3>
                        </div>
                        <div class="l-ten m-ten s-ten cols">
                            <p class="status margin-bottom">
                                <g:if test="${!opinionInstance.submitted}">
                                    ${answeredItemsPerSection.get(pollSectionInstance)} of ${ pollSectionInstance?.items?.size()} items have already been answered
                                </g:if>
                            </p>
                        </div>
                        <div class="l-two m-two s-two cols nopadding">
                            <g:form controller="opinion" action="answerSectionItems" params="[pollId: pollInstance.id, opinionId: opinionInstance.id, sectionId: pollSectionInstance.id]">
                                <input class="displayWidthInput" name="displayWidth" type="hidden" value="">
                                <input class="icon-submit" type="submit" value="&#xf064;">
                            </g:form>
                        </div>
                        <g:if test="${ pollSectionInstance?.description }">
                            <div class="col">
                                <p>${ pollSectionInstance?.description }</p>
                            </div>
                        </g:if>
                    </div>
                </div>
                <g:if test="${ s % 3 == 2 || s == (pollInstance?.sections?.size() -1)}"></div></g:if>
            </g:each>
        </div>
    </div>
</body>
</html>