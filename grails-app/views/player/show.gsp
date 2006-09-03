
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
          <meta name="layout" content="main" />
         <title>Visualisation d'un joueur</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Accueil</a></span>
            <span class="menuButton"><g:link action="list">Liste des joueurs</g:link></span>
            <span class="menuButton"><g:link action="create">Nouveau joueur</g:link></span>
        </div>
        <div class="body">
           <h1>Visualisation d'un joueur</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <div class="dialog">
                 <table>
                        <tr class="prop">
                              <td valign="top" class="name">Id :</td>
                              <td valign="top" class="value">${player.id}</td>
                        </tr>
                        <tr class="prop">
                              <td valign="top" class="name">Email :</td>
                              <td valign="top" class="value">${player.email}</td>
                        </tr>
                        <tr class="prop">
                              <td valign="top" class="name">Login :</td>
                              <td valign="top" class="value">${player.login}</td>
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
            