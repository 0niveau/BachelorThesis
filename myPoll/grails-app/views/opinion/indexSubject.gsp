<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main" />
	<title>${ pollInstance?.name }</title>
</head>
<body>
    <div class="row white shadow top">
        <div class="col">
            <div class="row l-flat">
                <div class="l-six m-eight s-nine cols">
                    <h1>${ pollInstance?.name }</h1>
                    <p class="margin-bottom">${ pollInstance?.description }</p>
                    <p class="hint">Please answer the questions of the following sections</p>
                </div>
                <div class="l-six m-four s-three cols box centered-text">
                    <g:if test="${!opinionInstance.submitted}">
                        <g:link class="icon-link big" controller="opinion" action="submitOpinion" id="${opinionInstance.id}">
                            <i class="fa fa-send"></i>
                        </g:link>
                    </g:if>
                </div>
            </div>

            <div class="row highlight">
            <g:each in="${ pollInstance?.sections }" status="s" var="pollSectionInstance">
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
                        <div class="l-two m-two s-two cols">
                            <g:link class="icon-link" controller="opinion" action="answerSectionItems" params="[pollId: pollInstance.id, opinionId: opinionInstance.id, sectionId: pollSectionInstance.id]">
                                <i class="fa fa-share"></i>
                            </g:link>
                        </div>
                        <div class="col">
                            <p>${ pollSectionInstance?.description }</p>
                        </div>

                    </div>
                </div>
            </g:each>
            </div>
        </div>
    </div>
</body>
</html>