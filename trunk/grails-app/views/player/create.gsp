<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="player.create_page" /></title>         
    <script type="text/javascript">
      YAHOO.util.Event.onContentReady('createPlayerFieldset', onDefaultSubmitButtonsMarkupReady);
    </script> 
  </head>
  <body>
    <g:form action="save" method="post" >
      <fieldset id="createPlayerFieldset">
        <legend><g:message code="player.create_page" /></legend>
    
        <g:if test="${flash.message}">
          <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${player}">
          <div class="errors">
            <g:renderErrors bean="${player}" as="list" />
          </div>
        </g:hasErrors>

        <label for='email'><g:message code="player.email"/> :</label>
        <input type='text' class='${hasErrors(bean:player,field:'email','errors')}' 
          name='email' value='${player?.email}' />
        <br/>

        <label for='login'><g:message code="player.login"/> :</label>
        <input type='text' class='${hasErrors(bean:player,field:'login','errors')}' 
          name='login' value='${player?.login}' />
        <br/>

        <label for='password'><g:message code="player.password"/> :</label>
        <input type='password' class='${hasErrors(bean:player,field:'password','errors')}' 
          name='password' value='${player?.password}' />
        <br/>

        <label for="submit">&nbsp;</label>
        <input id="wrappedSubmit" type="submit" value="Create"></input>

      </fieldset>
    </g:form>
  </body>
</html>