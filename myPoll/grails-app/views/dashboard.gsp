

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

    <div class="row white shadow">
        <div class="l-six m-twelve s-twelve cols boxInside">
            <div class="row border-bottom-blueDotted">
                <div class="l-ten m-ten s-ten cols">
                    <h2>Polls</h2>
                    <p>Currently there are ${mypoll.Poll.count()} polls defined</p>
                    <p>${mypoll.Poll.findAll {isActive == true}.size()} polls are currently active</p>
                </div>
                <div class="actions l-two m-two s-two cols">
                    <g:link class="icon-link" controller="poll" action="create"><i class="fa fa-plus"></i></g:link> <br>
                    <g:link class="icon-link" controller="poll"><i class="fa fa-list"></i></g:link>
                </div>
            </div>

            <div class="row border-bottom-blueDotted">
                <div class="l-ten m-ten s-ten cols">
                    <h2>Questions</h2>
                    <p>You can use ${mypoll.Question.count()} Questions as Items for your polls</p>
                </div>
                <div class="actions l-two m-two s-two cols">
                    <g:link class="icon-link" controller="question" action="create"><i class="fa fa-plus"></i></g:link> <br>
                    <g:link class="icon-link" controller="question"><i class="fa fa-list"></i></g:link>
                </div>
            </div>

            <div class="row border-bottom-blueDotted">
                <div class="l-ten m-ten s-ten cols">
                    <h2>Scales</h2>
                    <p>${mypoll.Scale.count()} Scales are available</p>
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