
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
          <meta name="layout" content="main" />
         <title>Show Score</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link action="list">Score List</g:link></span>
            <span class="menuButton"><g:link action="create">New Score</g:link></span>
        </div>
        <div class="body">
           <h1>Show Score</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <div class="dialog">
                 <table>
                   
                   
                        <tr class="prop">
                              <td valign="top" class="name">Id:</td>
                              
                                    <td valign="top" class="value">${score.id}</td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Party:</td>
                              
                                    <td valign="top" class="value"><g:link controller="party" action="show" id="${score?.party?.id}">${score?.party}</g:link></td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Player:</td>
                              
                                    <td valign="top" class="value"><g:link controller="player" action="show" id="${score?.player?.id}">${score?.player}</g:link></td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Points:</td>
                              
                                    <td valign="top" class="value">${score.points}</td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Refunds:</td>
                              
                                    <td valign="top" class="value">${score.refunds}</td>
                              
                        </tr>
                   
                 </table>
           </div>
           <div class="buttons">
               <g:form controller="score">
                 <input type="hidden" name="id" value="${score?.id}" />
                 <span class="button"><g:actionSubmit value="Edit" /></span>
                 <span class="button"><g:actionSubmit value="Delete" /></span>
               </g:form>
           </div>
        </div>
    </body>
</html>
            