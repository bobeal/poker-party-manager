<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}" />
        <title>Poker Party Manager - <g:message code="player.login_page" /></title>
    </head>
    <body>
    	<div class="logo loginLogo">
       		<img src="${createLinkTo(dir:'images',file:'ppm.png')}" alt="Poker" />
        </div>
        <div class="body">
           <g:if test="${flash['message']}">
                 <div class="message">${flash['message']}</div>
           </g:if>
           <g:form action="handleLogin" method="post">
               <div class="loginDialog">
			   	 <p><g:message code="player.login_page.instructions"/> :</p>
                 <table>
                  <tr class='prop'>
                      <td valign='top' style='text-align:left;' width='40%'>
                          <label for='login'><g:message code="player.login"/> :</label>
                      </td>
                      <td valign='top' style='text-align:left;' width='60%'> 
                          <input id="login" type='text' name='login' value='${agent?.login}' />
                      </td>
                  </tr>

                  <tr class='prop'>
                      <td valign='top' style='text-align:left;' width='40%'>
                          <label for='pwd'><g:message code="player.password"/> :</label>
                      </td>
                      <td valign='top' style='text-align:left;' width='60%'> 
                          <input id="pwd" type='password' name='pwd' value='${agent?.pwd}' />
                      </td>
                  </tr>

                  <tr class='prop'>
                      <td valign='top' style='text-align:left;' width='40%'>
                          &nbsp;
                      </td>
                      <td valign='top' style='text-align:left;' width='60%'> 
                          <input type="submit" value="Login"></input>
                      </td>
                  </tr>
                 </table>			   	
               </div>
            </g:form>
        </div>
    </body>
</html>
