<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 

<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'login.css')}">

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
      YAHOO.util.Event.onContentReady('loginFieldset', onDefaultSubmitButtonsMarkupReady);
    </script>
    
    <title>Poker Party Manager - <g:message code="player.login_page" /></title>
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
            <g:form action="handleLogin" method="post">
              <fieldset id="loginFieldset">
                <legend><g:message code="player.login_page.instructions"/></legend>
                <g:if test="${flash['message']}">
                  <p class="message">${message(code:flash['message'])}</p>
                </g:if>
                <label for="login" class="required"><g:message code="player.login"/> :</label>
                <input id="login" type='text' name='login' value='${agent?.login}' />
                <br />
                <label for="pwd" class="required"><g:message code="player.password"/> :</label>
                <input id="pwd" type='password' name='pwd' value='${agent?.pwd}' />
                <br />
                <label for="submit">&nbsp;</label>
                <input class="submit" id="wrappedSubmit" type="submit" value="Login" />
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
