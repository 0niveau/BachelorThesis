<%--
  Created by IntelliJ IDEA.
  User: nbecker
  Date: 02.06.14
  Time: 23:10
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title></title>
</head>
<body>
    <g:hasErrors bean="${opinionInstance}">
        <div class="row">
            <div class="col">
                <g:eachError bean="${opinionInstance}" var="error">
                    <p class="hint"><g:message error="${error}"></g:message></p>
                </g:eachError>
            </div>
        </div>
    </g:hasErrors>
    <g:link controller="opinion" action="indexSubject" id="${opinionInstance.id}">okay</g:link>

</body>
</html>