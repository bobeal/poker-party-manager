
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
          <meta name="layout" content="main" />
         <title>Show Player</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link action="list">Player List</g:link></span>
            <span class="menuButton"><g:link action="create">New Player</g:link></span>
        </div>
        <div class="body">
           <h1>Show Player</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <div class="dialog">
                 <table>
                   
                   
                        <tr class="prop">
                              <td valign="top" class="name">Id:</td>
                              
                                    <td valign="top" class="value">${player.id}</td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Email:</td>
                              
                                    <td valign="top" class="value">${player.email}</td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Login:</td>
                              
                                    <td valign="top" class="value">${player.login}</td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Password:</td>
                              
                                    <td valign="top" class="value">${player.password}</td>
                              
                        </tr>
                   
                 </table>
           </div>
           <div class="buttons">
               <g:form controller="player">
                 <input type="hidden" name="id" value="${player?.id}" />
                 <span class="button"><g:actionSubmit value="Edit" /></span>
                 <span class="button"><g:actionSubmit value="Delete" /></span>
               </g:form>
           </div>
        </div>
    </body>
</html>
            