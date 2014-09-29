<%@ page import="mypoll.QuestionType" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta name="layout" content="main">
    <r:require module="export" />
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
    		<g:link class="icon-link" controller ="poll" action="exportOpinions" id="${ pollInstance.id }" params="['testObjectUrl': pollInstance.testObjectUrl]">
    			<i class="fa fa-download"></i><span class="padding-left">${ pollInstance.testObjectUrl }</span>
    		</g:link>
    	</div>
    </section>
    
    <section class="row white shadow padding-bottom">
        <div class="col">
            <g:each in="${ pollInstance?.sections }" var="sectionInstance">
                <h2 class="blueText">${ sectionInstance?.name }</h2>
                <div class="row">
                    <div class="l-six m-six s-twelve cols">
                        <g:each in="${ aggregatedResults }" var="itemAggregation">
                            <h3 class="orangeText">${ itemAggregation?.question }</h3>
                            <table class="itemResults">
                                <tbody>
                                    <tr>
                                        <th></th>
                                        <td class="thin">Ergebnis</td>
                                    </tr>
                                    <g:each in="${ itemAggregation?.possibleAnswers }" var="answer">
                                    <tr>
                                        <th>${ answer }</th>
                                        <td>${ itemAggregation?.selectionsPerAnswer?.get(answer) }</td>
                                    </tr>
                                    </g:each>
                                </tbody>
                            </table>
                        </g:each>
                    </div>
                    <div class="l-six m-six s-twelve cols">
                        <g:each in="${ sectionInstance?.items?.findAll {item -> item.type == QuestionType.OPEN} }" var="itemInstance">
                            <h3 class="orangeText">${ itemInstance?.question }</h3>
                            <g:each in="${ openAnswersPerQuestion?.get(itemInstance?.id as String) }" var="answer">
                                <p>${ answer }</p>
                                <hr>
                            </g:each>
                        </g:each>
                    </div>
                </div>
            </g:each>
        </div>
   	</section>
</body>
</html>