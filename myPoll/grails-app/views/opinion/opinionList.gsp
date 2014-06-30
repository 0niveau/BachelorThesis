<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCYPE html>
<html>
<head>
    <title></title>
    <meta name="layout" content="main">
    <r:require module="export"></r:require>
</head>
<body>
    <nav class="row">
        <ul class="navigation">
            <li class="navigation__links"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            <li class="navigation__links"><g:link controller="poll" action="show" id="${ pollInstance?.id }">${pollInstance?.name}</g:link></li>
        </ul>
    </nav>

    <section class="row dim greyText shadow">
        <div class="col">
            <h1>${ pollInstance.name }</h1>
        </div>
    </section>
    <g:each in="${ pollInstance?.sections }" var="sectionInstance">
    	<section class="row white shadow">
    		<div class="col">
    			<h2>${ sectionInstance?.name }</h2>
    			<g:each in="${ sectionInstance?.items }" var="itemInstance">
    				<g:set var="itemAggregation" value="${ aggregatedResults.find { aggregation -> aggregation.item.equals(itemInstance) } }"></g:set>
    				<h3>${ itemAggregation?.question }</h3>
    				<table class="itemResults">
    					<thead>
    						<tr>
    							<th></th>
    							<th class="thin">${ pollInstance?.testObjectUrlA }</th>
    							<th class="thin">${ pollInstance?.testObjectUrlB }</th>
    							    							
    						</tr>
    					</thead>
    					<tbody>
    						<g:each in="${ itemAggregation?.possibleAnswers }" var="answer">    							
    						<tr>
    							<th>${ answer }</th>
    							<td>${ itemAggregation?.selectionsPerAnswerA.get(answer) }</td>    							
    							<td>${ itemAggregation?.selectionsPerAnswerB.get(answer) }</td>  							
    						</tr>
    						</g:each>
    					</tbody>
    				</table>
    			</g:each>
    		</div>
    	</section>
    </g:each>
    
    
    <section class="row dim greyText shadow">
        <div class="col">
            <g:link action="exportOpinions" params="['testObjectUrl': pollInstance.testObjectUrlA,'pollId': pollInstance.id]">export ${ pollInstance?.testObjectUrlA }</g:link>
            <g:link action="exportOpinions" params="['testObjectUrl': pollInstance.testObjectUrlB,'pollId': pollInstance.id]">export ${ pollInstance?.testObjectUrlB }</g:link>
        </div>
    </section>
</body>
</html>