<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="place.list_page"/></title>
  </head>
  <body>
    <div class="body">
      <h1><g:message code="place.list_page"/></h1>
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
            <td class="actionButtons">
              <span class="actionButton">
                <g:link action="show" id="${it.id}"><g:message code="action.show"/></g:link>
              </span>
            </td>
          </tr>
        </g:each>
      </table>
    </div>
  </body>
</html>
            