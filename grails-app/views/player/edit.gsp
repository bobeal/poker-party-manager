<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<html>
  <head>
    <meta name="layout" content="main">
    <title>Poker Party Manager - <g:message code="player.my_page"/></title>
    <script type="text/javascript">
        YAHOO.util.Event.onContentReady('editPlayerFieldset', onDefaultSubmitButtonsMarkupReady);
    </script>
  </head>
  <body>
    <g:form action="update" method="post" enctype="multipart/form-data">
      <input type="hidden" name="id" value="${player?.id}" />

      <fieldset id="editPlayerFieldset">
        <legend><g:message code="player.my_page"/></legend>
        
        <g:if test="${flash.message}">
          <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${player}">
          <div class="errors">
            <g:renderErrors bean="${player}" as="list" />
          </div>
        </g:hasErrors>

        <label for='login'><g:message code="player.login"/>  :</label>
        <input type='text' class='${hasErrors(bean:player,field:'login','errors')}'
          name='login' value='${player?.login}' />
        <br />

        <label for='password'><g:message code="player.password"/>  :</label>
        <input type='password' class='${hasErrors(bean:player,field:'newPassword','errors')}' 
          name='newPassword' />
        <br />

        <label for='email'><g:message code="player.email"/>  :</label>
        <input type='text' class='${hasErrors(bean:player,field:'email','errors')}' 
          name='email' size="40" value='${player?.email}' />
        <br />

        <label for='photo'><g:message code="player.photo"/>  :</label>
        <g:if test="${player?.photo}">
          <img class='${hasErrors(bean:player,field:'photo','errors')}'
            src="${createLink(action:'getPhotoData',id:player?.id)}"/>
        </g:if>
        <input type="file" name="photo" />
        <br/>

        <label for='favoriteHand'><g:message code="player.favorite_hand"/> :</label>
        <input type='text' class='${hasErrors(bean:player,field:'favoriteHand','errors')}' 
          name='favoriteHand' value="${player?.favoriteHand?.encodeAsHTML()}" />
        <br/>

        <label for='favoriteQuote'><g:message code="player.favorite_quote"/> :</label>
        <textarea class="${hasErrors(bean:player,field:'favoriteQuote','errors')}"
          cols="40" rows="3" name="favoriteQuote">${player?.favoriteQuote?.encodeAsHTML()}</textarea>
        <br/>

        <label for='amulet'><g:message code="player.amulet"/> :</label>
        <input type='text' class='${hasErrors(bean:player,field:'amulet','errors')}' 
          size='40' name='amulet' value="${player?.amulet?.encodeAsHTML()}" />
        <br/>

        <g:if test="${session?.user?.isSuperAdmin}">

          <label for='isSuperAdmin'><g:message code="player.is_super_admin"/>  :</label>
          <g:checkBox name='isSuperAdmin' value='${player?.isSuperAdmin}' />
          <br/>

          <label for='canManageChampionship'><g:message code="player.can_manage_championship"/>  :</label>
          <g:checkBox name='canManageChampionship' value='${player?.canManageChampionship}' />
          <br/>

        </g:if>
        
        <label for="submit"></label>
        <input id="wrappedSubmit" type="submit" value="<g:message code="action.update" />"></input>
      </fieldset>
    </g:form>
  </body>
</html>
