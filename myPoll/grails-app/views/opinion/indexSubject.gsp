<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main" />
	<title>${ pollInstance?.name }</title>
</head>
<body>
    <div class="row white shadow top">
        <div class="col">
            <div class="row">
                <div class="l-six m-six s-twelve cols">
                    <h1>${ pollInstance?.name }</h1>
                    <p class="nomargin bottom">${ pollInstance?.description }</p>
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <p class="hint">Please answer the questions of the following sections</p>
                </div>
            </div>

            <div class="row highlight">
            <g:each in="${ pollInstance?.sections }" status="s" var="pollSectionInstance">
                <div class="l-four m-six s-twelve cols
                        ${ s == 0 ? 'first' : ''}
                        ${ s == pollSectionInstance?.items?.size() -2 ? 'last' : ''} ">
                    <h3>${ pollSectionInstance?.name }</h3>
                    <p class="status">${answeredItemsPerSection.get(pollSectionInstance)} of ${ pollSectionInstance?.items?.size()} items have already been answered</p>
                    <p>${ pollSectionInstance?.description }</p>
                    <g:if test="${!opinionInstance.submitted}">
                    <p class="margin-bottom">
                        <g:link controller="opinion" action="answerSectionItems"
                                params="[pollId: pollInstance.id, opinionId: opinionInstance.id, sectionId: pollSectionInstance.id]">To the Questions</g:link>
                    </p>
                    </g:if>
                </div>
            </g:each>
            </div>
            <g:if test="${!opinionInstance.submitted}">
            <div class="row">
                <div class="col">
                    <g:form url="[resource: opinionInstance, action: 'submitOpinion']">
                        <g:submitButton name="submit" value="Submit"></g:submitButton>
                    </g:form>
                </div>
            </div>
            </g:if>
        </div>
    </div>
</body>
</html>