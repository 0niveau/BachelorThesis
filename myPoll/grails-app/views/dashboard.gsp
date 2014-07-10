

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title><g:message code="sites.dashboard" default="Dashboard"/></title>
    <meta name="layout" content="main">
</head>
<body>
    <div class="row dim greyText shadow">
        <div class="col">
            <h1><g:message code="sites.dashboard" default="Dashboard"/></h1>
        </div>
    </div>

    <div class="row white shadow">
        <div class="l-six m-twelve s-twelve cols boxInside">
            <div class="row border-bottom-blueDotted">
                <div class="l-ten m-ten s-ten cols">
                    <h2><g:message code="poll.plural" default="Polls" /></h2>
                    <p>
                    	<g:if test="${ mypoll.Poll.count() > 0 }">
                    		<g:message code="poll.count.existing" 
                    		args="${ mypoll.Poll.count() }" 
                    		default="Currently there are ${mypoll.Poll.count()} polls defined"/>
                    	</g:if>
                    	<g:else>
                    		<g:message code="poll.count.existing.zero" default="Currently no polls are defined" />
                    	</g:else>                    	
               		</p>
                    <p>
                    	<g:if test="${mypoll.Poll.findAll {isActive == true}.size() > 0}">
                    		<g:message code="poll.count.active" 
                    		args="${mypoll.Poll.findAll {isActive == true}.size()}" 
                    		default="${mypoll.Poll.findAll {isActive == true}.size()} polls are currently active"/>
                    	</g:if>
                    	<g:else>
                    		<g:message code="poll.count.active.zero" default="Currently no polls are active" />
                    	</g:else>                    	
               		</p>                    
                </div>
                <div class="actions l-two m-two s-two cols">
                    <g:link class="icon-link" controller="poll" action="create"><i class="fa fa-plus"></i></g:link> <br>
                    <g:link class="icon-link" controller="poll"><i class="fa fa-list"></i></g:link>
                </div>
            </div>

            <div class="row border-bottom-blueDotted">
                <div class="l-ten m-ten s-ten cols">
                    <h2><g:message code="question.plural" default="Questions" /></h2>
                    <p>
                    	<g:if test="${ mypoll.Question.count() > 0 }">
                    		<g:message code="question.count.existing"
                    		args="${ mypoll.Question.count() }"
                    		default="You can use ${mypoll.Question.count()} Questions as Items for your polls" />
                    	</g:if>
                    	<g:else>
                    		<g:message code="question.count.existing.zero" default="Currently no questions are defined" />
                    	</g:else>                    	
                    </p>
                </div>
                <div class="actions l-two m-two s-two cols">
                    <g:link class="icon-link" controller="question" action="create"><i class="fa fa-plus"></i></g:link> <br>
                    <g:link class="icon-link" controller="question"><i class="fa fa-list"></i></g:link>
                </div>
            </div>

            <div class="row border-bottom-blueDotted">
                <div class="l-ten m-ten s-ten cols">
                    <h2><g:message code="scale.plural" default="Scales" /></h2>
                    <p>
                    	<g:if test="${mypoll.Scale.count() > 0 }">
                    		<g:message code="scale.count.existing"
	                    	args="${mypoll.Scale.count()}"
	                    	default="${mypoll.Scale.count()} Scales are available" />
                    	</g:if>
                    	<g:else>
                    		<g:message code="scale.count.existing.zero" default="Currently no scales are defined" />          
                    	</g:else>                    	
                    </p>
                </div>
                <div class="actions l-two m-two s-two cols">
                    <g:link class="icon-link" controller="scale" action="create"><i class="fa fa-plus"></i></g:link> <br>
                    <g:link class="icon-link" controller="scale"><i class="fa fa-list"></i></g:link>
                </div>
            </div>
        </div>
    </div>
</body>
</html>