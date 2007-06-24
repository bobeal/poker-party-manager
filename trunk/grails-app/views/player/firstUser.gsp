<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 

<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'login.css')}">
    <link rel="shortcut icon" href="${createLinkTo(dir:'images',file:'favicon.ico')}" type="image/vnd.microsoft.icon">
    
    <!-- Grid and common settings CSS -->
    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.2.2/build/reset-fonts-grids/reset-fonts-grids.css">
    <!-- Menu and Button CSS -->
    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.2.2/build/fonts/fonts-min.css">
    <!-- Button CSS -->
    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.2.2/build/button/assets/button.css">

    <!-- Menu, Button and Tabview JS --> 
    <script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/yahoo-dom-event/yahoo-dom-event.js"></script>
    <!-- Dependency for Button JS --> 
    <script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/element/element-beta-min.js"></script>
    <!-- Button JS -->
    <script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/button/button-beta-min.js"></script>

    <g:javascript src="ppm.js" />
    
    <script type="text/javascript">
      YAHOO.util.Event.onContentReady('createPlayerFieldset', onDefaultSubmitButtonsMarkupReady);
    </script>
    
    <title>Poker Party Manager - <g:message code="player.first_user_page" /></title>
  </head>
  <body>
    <div id="doc" class="yui-t7">
      <div id="hd" class="loginLogo">
      <img src="${createLinkTo(dir:'images',file:'ppm.png')}" alt="Poker" />
      </div>
      <div id="bd" class="body">
        <div id="yui-main">
          <div class="yui-b">
            <div style="margin-left:20%;margin-right:20%;">

    <g:form action="saveFirstAdmin" method="post" >
      <fieldset id="createPlayerFieldset">
        <legend><g:message code="player.first_user_page" /></legend>
    
        <div class="message"><g:message code="player.first_user_notice" /></div>
        
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
        <input id="wrappedSubmit" type="submit" value="<g:message code="action.create" />"></input>

      </fieldset>
    </g:form>
    
    
                </div>
          </div>
        </div>
      </div>
      <div id="ft">Powered by <a href="http://grails.org">Grails</a></div>
    </div>
  </body>
</html>
