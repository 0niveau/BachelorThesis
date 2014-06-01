<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCYPE html>
<html>
<head>
  <title></title>
  <meta name="layout" content="main">
</head>
<body>
    <nav class="row">
        <ul class="navigation">
            <li class="navigation__links"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
            <li class="navigation__links"><g:link controller="poll" action="show" id="${ pollInstance?.id }">${pollInstance?.name}</g:link></li>
        </ul>
    </nav>

    <section class="row">
        <div class="col">
            <h1>${ pollInstance.name }</h1>
        </div>
    </section>
    <g:each in="${ pollInstance.sections}" var="sectionInstance">
    <section class="row">
        <div class="col">
            <h2>${ sectionInstance.name }</h2>
            <table class="sectionResults">
                <tbody>
                    <g:each in="${ sectionInstance.items }" status="s" var="itemInstance">
                    <tr>
                        <th class>
                            ${ itemInstance?.question }
                        </th>
                        <g:each in="${ opinions }" var="opinionInstance">
                        <td> ${ opinionInstance.selections.get( itemInstance.id as String).value }</td>
                        </g:each>
                    </tr>
                    </g:each>
                </tbody>
            </table>
        </div>
    </section>
    </g:each>
</body>
</html>