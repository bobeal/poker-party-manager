<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="player.list_page" /></title>
  </head>
  <body>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>

    <table>
      <tr>
        <th><g:message code="player.login" /></th>
        <th><g:message code="player.email" /></th>
        <th></th>
      </tr>
      <g:each in="${playerList}" var="player" status="index">
        <tr>
          <td class="${index % 2 == 0 ? 'odd' : 'even'}">${player.login}</td>
          <td class="${index % 2 == 0 ? 'odd' : 'even'}">${player.email}</td>
          <td class="${index % 2 == 0 ? 'odd' : 'even'}">
            <g:link action="show" id="${player?.id}"><g:message code="action.show" /></g:link>
			<g:hasPlayerPagePermission id="${player?.id}">
              <br />
              <g:link action="edit" id="${player?.id}"><g:message code="action.edit" /></g:link>
   			</g:hasPlayerPagePermission>
          </td>
        </tr>
      </g:each>
    </table>
  </body>
</html>
