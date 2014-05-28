<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main" />
	<title>${ pollInstance?.name }</title>
</head>
<body>
	<h1>Welcome to the party!</h1>
	<p>${ pollInstance?.description }</p>
	<h2>You have to answer the questions of the following sections</h2>
	<g:each in="${ pollInstance?.sections }" status="s" var="pollSectionInstance">
		<div>
			<h3>${ pollSectionInstance?.name }</h3>
            <h4>(${answeredItemsPerSection.get(pollSectionInstance)} of ${ pollSectionInstance?.items.size()} items have already been answered)</h4>
			<p>${ pollSectionInstance?.description }</p>
			<g:link controller="poll" action="answerSectionItems" 
				params="[pollId: pollInstance.id, opinionId: opinionInstance.id, sectionId: pollSectionInstance.id]">Start the party!</g:link>
		</div>
	</g:each>	
</body>
</html>