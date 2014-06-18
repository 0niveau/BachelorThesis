

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Dashboard</title>
    <meta name="layout" content="main">
</head>
<body>
    <div class="row dim greyText shadow">
        <div class="col">
            <h1>Dashboard</h1>
        </div>
    </div>

    <div class="row flat white shadow">
        <div class="l-four m-twelve s-twelve cols">
            <h2>Polls</h2>
            <p>Currently there are ${mypoll.Poll.count()} polls defined</p>
            <p>${mypoll.Poll.findAll {isActive == true}.size()} poll are currently active</p>
            <g:link controller="poll" action="create">create Poll</g:link>
        </div>
        <div class="l-four m-twelve s-twelve cols">
            <h2>Questions</h2>
            <p>You can use ${mypoll.Question.count()} Questions as Items for your polls</p>
            <g:link controller="question" action="create">create Question</g:link>
        </div>
        <div class="l-four m-twelve s-twelve cols">
            <h2>Scales</h2>
            <p>${mypoll.Scale.count()} Scales are available</p>
            <g:link controller="scale" action="create">create Scale</g:link>
        </div>
    </div>
</body>
</html>