<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
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
    
    <section class="row shadow">
    	<div class="col actions left-text">
    		<g:link class="icon-link" action="exportOpinions" params="['testObjectUrl': pollInstance.testObjectUrlA,'pollId': pollInstance.id]">
    			<i class="fa fa-download"></i><span class="padding-left">${ pollInstance.testObjectUrlA }</span>
    		</g:link>
    	</div>
    	<div class="col actions left-text">
    		<g:link class="icon-link" action="exportOpinions" params="['testObjectUrl': pollInstance.testObjectUrlB,'pollId': pollInstance.id]">
    			<i class="fa fa-download"></i><span class="padding-left">${ pollInstance.testObjectUrlB }</span>
    		</g:link>
    	</div>
    </section>
    
    <section class="row white shadow padding-bottom">
    	<g:each in="${ pollInstance?.sections }" var="sectionInstance">  
    		<div class="col">
    			<h2 class="blueText">${ sectionInstance?.name }</h2>
    			<g:each in="${ sectionInstance?.items }" var="itemInstance">
    				<g:set var="itemAggregation" value="${ aggregatedResults.find { aggregation -> aggregation.item.equals(itemInstance) } }"></g:set>
    				<h3 class="orangeText">${ itemAggregation?.question }</h3>
    				<table class="itemResults">
						<tbody>
    						<tr>
    							<th></th>
    							<td class="thin">A</td>
    							<td class="thin">B</td>
    							    							
    						</tr>
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
    	</g:each>
   	</section>
</body>
</html>