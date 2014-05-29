<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main" />
	<title>${ pollInstance?.name }</title>
</head>
<body>
    <div class="row top">
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
            <p>
                <g:link controller="poll" action="answerSectionItems"
                        params="[pollId: pollInstance.id, opinionId: opinionInstance.id, sectionId: pollSectionInstance.id]">To the Questions</g:link>
            </p>
        </div>
    </g:each>
    </div>
</body>
</html>