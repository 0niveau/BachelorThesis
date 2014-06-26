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
                <div class="l-six m-twelve s-twelve cols">
                    <h1>${ pollInstance?.name }</h1>
                    <p class="margin-bottom">${ pollInstance?.description }</p>
                    <g:if test="${ !opinionInstance.submittable }">
	                    <p class="hint">Please answer the questions of the following sections.</p>
	                    <g:form controller="opinion" action="answerSectionItems" id="${ opinionInstance.id }" params="[pollId: pollInstance.id, opinionId: opinionInstance.id]">
	                        <input class="displayWidthInput" name="displayWidth" type="hidden" value="">
	                        <label class="iconSubmitLabel"><input class="icon-submit nopadding" type="submit" value="&#xf14c;"><span class="padding-left">Click here to start</span></label>                       
	                    </g:form>
	                </g:if>
	                <g:else>
	                	<div class="row">	                
	                		<div class="col">
			                	<g:link class="icon-link" controller="opinion" action="submitOpinion" id="${opinionInstance.id}">
		                            <i class="fa fa-send"></i><span class="padding-left">To submit your opinion, please click here</span>
		                        </g:link>
	                		</div>
	                	</div>	           	                	
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
                        <div class="col">
                            <p class="status margin-bottom">
                                <g:if test="${!opinionInstance.submitted}">
                                    ${answeredItemsPerSection.get(pollSectionInstance)} of ${ pollSectionInstance?.items?.size()} items have already been answered
                                </g:if>
                            </p>
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