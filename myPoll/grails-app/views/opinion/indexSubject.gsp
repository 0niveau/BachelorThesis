<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main" />
	<title>${ pollInstance?.name }</title>
</head>
<body>
    <div class="row white shadow top">
        <div class="col">
            <div class="row flat">
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
                <div class="l-four m-six s-twelve cols boxInside">
                    <div class="row regular">
                        <div class="col">
                            <h3>${ pollSectionInstance?.name }</h3>
                            <p class="status margin-bottom">
                                <g:if test="${!opinionInstance.submitted}">
                                    ${answeredItemsPerSection.get(pollSectionInstance)} of ${ pollSectionInstance?.items?.size()} items have already been answered
                                    <g:link class="icon-link" controller="opinion" action="answerSectionItems" params="[pollId: pollInstance.id, opinionId: opinionInstance.id, sectionId: pollSectionInstance.id]">
                                        <i class="fa fa-share padding-left"></i>
                                    </g:link>
                                </g:if>
                            </p>
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