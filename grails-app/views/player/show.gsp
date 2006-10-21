<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
          <meta name="layout" content="main" />
         <title>Poker Party Manager - <g:message code="player.show_page" args='[player.login]' /></title>
    </head>
    <body>
        <div class="body">
           <h1><g:message code="player.show_page" args='[player.login]'/></h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <div class="dialog">
                 <table>
                        <tr class="prop">
                              <td valign="top" class="name"><g:message code="player.login"/> :</td>
                              <td valign="top" class="value">${player.login}</td>
                        </tr>
                        <tr class="prop">
                              <td valign="top" class="name"><g:message code="player.email"/> :</td>
                              <td valign="top" class="value">${player.email}</td>
                        </tr>
                        <tr class="prop">
                              <td valign="top" class="name"><g:message code="player.photo"/> :</td>
                              <td valign="top" class="value">
                               	 <g:if test="${player?.photo}">
  		       		   				<img src="${createLink(action:'getPhotoData',id:player?.id)}"/>
								 </g:if>
                              </td>
                        </tr>
                        <tr class="prop">
                              <td valign="top" class="name"><g:message code="player.favorite_hand"/> :</td>
                              <td valign="top" class="value">${player.favoriteHand}</td>
                        </tr>
                        <tr class="prop">
                              <td valign="top" class="name"><g:message code="player.favorite_quote"/> :</td>
                              <td valign="top" class="value">${player.favoriteQuote}</td>
                        </tr>
                        <tr class="prop">
                              <td valign="top" class="name"><g:message code="player.amulet"/> :</td>
                              <td valign="top" class="value">${player.amulet}</td>
                        </tr>
                 </table>
           </div>
           <div class="buttons">
               <g:form controller="player">
                 <input type="hidden" name="id" value="${player?.id}" />
                 <g:hasPlayerPagePermission id="${player?.id}">
                   <span class="button"><g:actionSubmit value="Edit" /></span>
                 </g:hasPlayerPagePermission>
               </g:form>
           </div>
        </div>
    </body>
</html>