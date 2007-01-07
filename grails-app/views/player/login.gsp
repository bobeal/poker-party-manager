<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'login.css')}" />
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'reset-fonts-grids.css')}" />
    <title>Poker Party Manager - <g:message code="player.login_page" /></title>
    </style>
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
              <fieldset>
                <legend><g:message code="player.login_page.instructions"/></legend>
                <g:if test="${flash['message']}">
                  <p class="message">${flash['message']}</p>
                </g:if>
                <label for="login" class="required"><g:message code="player.login"/> :</label>
                <input id="login" type='text' name='login' value='${agent?.login}' />
                <br />
                <label for="pwd" class="required"><g:message code="player.password"/> :</label>
                <input id="pwd" type='password' name='pwd' value='${agent?.pwd}' />
                <br />
                <label for="submit"></label>
                <input class="submit" type="submit" value="Login" />
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
