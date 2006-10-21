<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Poker Party Manager - <g:message code="player.list_page" /></title>
    </head>
    <body>
        <div class="body">
           <h1><g:message code="player.list_page" /></h1>
            <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
            </g:if>
           <table>
               <tr>
                 <th><g:message code="player.login" /></th>
                 <th><g:message code="player.email" /></th>
                 <th></th>
               </tr>
               <g:each in="${playerList}">
                    <tr>
                      <td>${it.login}</td>
                      <td>${it.email}</td>
                       <td class="actionButtons">
                            <span class="actionButton">
                              <g:link action="show" id="${it.id}"><g:message code="action.show" /></g:link>
                            </span>
							<g:hasPlayerPagePermission id="${player?.id}">
                              <span class="actionButton">
                                <g:link action="edit" id="${it.id}"><g:message code="action.edit" /></g:link>
                              </span>
                 			</g:hasPlayerPagePermission>
                       </td>
                    </tr>
               </g:each>
           </table>
        </div>
    </body>
</html>
