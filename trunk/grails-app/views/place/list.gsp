<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="place.list_page"/></title>
  </head>
  <body>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>

    <table>
      <tr>
        <th><g:message code="place.name"/></th>
        <th><g:message code="place.description"/></th>
        <th></th>
      </tr>
      <g:each in="${placeList}">
        <tr>
          <td>${it.name}</td>
          <td>${it.description}</td>
          <td>
            <g:link action="show" id="${it.id}"><g:message code="action.show"/></g:link>
          </td>
        </tr>
      </g:each>
    </table>
  </body>
</html>
            