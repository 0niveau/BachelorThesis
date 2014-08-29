<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title></title>
</head>

<body>
    <div class="row top white shadow">
        <div class="l-eight s-twelve cols offset-2-left">
            <h1 class="border-bottom-blueDotted"><g:message code="welcome.heading" default="Welcome"/></h1>
            <p><g:message code="welcome.presentation" /></p>
            <p><g:message code="welcome.intro" /></p>
            <p><g:message code="welcome.purpose" /></p>
            <p><g:message code="welcome.testObjects" /></p>
            <p><g:message code="welcome.haveFun" /></p>
            <p><g:message code="welcome.greetings" /></p>
            <p><g:link controller="opinion" action="indexSubject" id="${opinionInstance.id}">
                <i class="fa fa-arrow-right"></i>
                <span class=""><g:message code="welcome.start" default="start here"/></span>
            </g:link></p>
        </div>
    </div>
</body>
</html>