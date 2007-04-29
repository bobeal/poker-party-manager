<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="player.show_page" args='[player.login]' /></title>
  </head>
  <body>
    <g:form action="edit" id="${player.id}">
      <fieldset>
        <legend><g:message code="player.show_page" args='[player.login]' /></legend>

        <g:if test="${flash.message}">
          <div class="message">${flash.message}</div>
        </g:if>

        <label><g:message code="player.login" /> :</label>
        ${player.login}
        <br/>

        <label><g:message code="player.email" /> :</label>
        ${player.email}
        <br/>
        
        <label><g:message code="player.photo" /> :</label>
        <g:if test="${player?.photo}">
          <img src="${createLink(action:'getPhotoData',id:player?.id)}" />
        </g:if>
        <br/>

        <label><g:message code="player.favorite_hand" /> :</label>
        ${player.favoriteHand}
        <br/>
        
        <label><g:message code="player.favorite_quote" /> :</label>
        ${player.favoriteQuote}
        <br/>
        
        <label><g:message code="player.amulet" /> :</label>
        ${player.amulet}
        <br/>
        
        <g:hasPlayerPagePermission id="${player?.id}">
          <label for="submit">&nbsp;</label>
          <g:actionSubmit value="Edit" />
        </g:hasPlayerPagePermission>
        
      </fieldset>
    </g:form>
  </body>
</html>