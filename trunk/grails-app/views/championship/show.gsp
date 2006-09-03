
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
          <meta name="layout" content="main" />
         <title>Visualisation d'un championnat</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Accueil</a></span>
            <span class="menuButton"><g:link action="list">Liste des championnats</g:link></span>
            <span class="menuButton"><g:link action="create">Nouveau championnat</g:link></span>
        </div>
        <div class="body">
           <h1>Visualisation d'un championnat</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <div class="dialog">
                 <table>
                        <tr class="prop">
                          <td valign="top" class="name">Id :</td>
                          <td valign="top" class="value">${championship.id}</td>
                        </tr>
                        <tr class="prop">
                          <td valign="top" class="name">Label :</td>
                          <td valign="top" class="value">${championship.label}</td>
                        </tr>
                        <tr class="prop">
                          <td valign="top" class="name">Date de début :</td>
                          <td valign="top" class="value">${championship.startDate}</td>
                        </tr>
                        <tr class="prop">
                          <td valign="top" class="name">Date de fin :</td>
                          <td valign="top" class="value">${championship.endDate}</td>
                        </tr>
                        <tr class="prop">
                          <td valign="top" class="name">&nbsp;</td>
                          <td valign="top" class="value">
                            <g:link controller='party' 
                              params='["championship.id":championship?.id]' 
                              action='create'>Ajouter une partie</g:link>
                          </td>
                        </tr>
                </table>
           </div>
           <div class="buttons">
               <g:form controller="championship">
                 <input type="hidden" name="id" value="${championship?.id}" />
                 <span class="button"><g:actionSubmit value="Edit" /></span>
                 <span class="button"><g:actionSubmit value="Delete" /></span>
               </g:form>
           </div>
           <div class="dialog">
           	 <table>
               <tr>
                 <th>Id</th>
                 <th>Place</th>
                 <th>Date</th>
                 <g:each var="player" in="${Player.list()}">
                   <th>${player?.login}</th>
                 </g:each>
               </tr>
               <g:each var="p" in="${championship.parties}">
                 <tr>
                 	<td>${p?.id}</td>
                 	<td>${p?.place}</td>
                 	<td>${p?.date}</td>
                 	<g:each var="score" in="${p.scores}">
                 	  <td>${score.player.login} : ${score.points} / ${score.refunds}</td>
                 	</g:each>
                 </tr>
               </g:each>
           	 </table>
           </div>
        </div>
    </body>
</html>
            