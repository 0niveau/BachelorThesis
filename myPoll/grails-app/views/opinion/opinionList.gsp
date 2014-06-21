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
    <g:each in="${ pollInstance.sections}" var="sectionInstance">
    <section class="row white shadow">
        <div class="col">
            <h2>${ sectionInstance.name }</h2>
            <g:each in="${ sectionInstance.items }" status="s" var="itemInstance">
                <h3>${ itemInstance?.question }</h3>
                <table class="itemResults">
                    <tbody>
                        <tr>
                            <th class="thin">${ pollInstance.testObjectUrlA }</th>
                            <g:each in="${ opinionsA }" var="opinionInstance">
                            <td> ${ opinionInstance.selections.get( itemInstance.id as String)?.value }</td>
                            </g:each>
                        </tr>
                        <tr>
                            <th class="thin">${ pollInstance.testObjectUrlB }</th>
                            <g:each in="${ opinionsB }" var="opinionInstance">
                                <td> ${ opinionInstance.selections.get( itemInstance.id as String).value }</td>
                            </g:each>
                        </tr>
                    </tbody>
                </table>
            </g:each>
        </div>
    </section>
    </g:each>
    <section class="row dim greyText shadow">
        <div class="col">
            <g:link action="exportOpinions" params="['testObjectUrl': pollInstance.testObjectUrlA,'pollId': pollInstance.id]">export A</g:link>
            <g:link action="exportOpinions" params="['testObjectUrl': pollInstance.testObjectUrlB,'pollId': pollInstance.id]">export B</g:link>
        </div>
    </section>
</body>
</html>