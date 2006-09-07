
<html>
    <head>
		<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'ajaxtabs.css')}" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Visualisation d'un championnat</title>
        <script type="text/javascript" src="${createLinkTo(dir:'js',file:'ajaxtabs.js')}"></script>
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
        
        <ul id="maintab" class="shadetabs">
			<li class="selected"><a href="#default" rel="partiestab">Parties</a></li>
			<li><a href="${createLink(action:'gettable',id:championship.id)}" rel="partiestab">Classement</a></li>
		</ul>

           <div class="dialog" id="partiestab">
           	 <table>
               <tr>
                 <th>Place</th>
                 <th>Date</th>
                 <g:each var="player" in="${Player.list()}">
                 	<th>${player.login}</th>
                 </g:each>
                 <th></th>
               </tr>
               <g:each var="p" in="${championship.parties}">
                 <tr>
                 	<td>${p?.place}</td>
                 	<td>${p?.date}</td>
					<g:each var="player" in="${Player.list()}">
                 	 	<td>
                 	 	  <g:if test="${Score.findByPlayerAndParty(player,p).money > 0}">
                 	 	  	<span style="color:green">${Score.findByPlayerAndParty(player,p).money}</span>
                 	 	  </g:if>
                 	 	  <g:else>
                 	 	  	<span style="color:red">${Score.findByPlayerAndParty(player,p).money}</span>
                 	 	  </g:else>
                 	 	</td>
					</g:each>
                 	<td>
                 		<g:link controller='party' params='["id":p?.id]' action='edit'>Editer</g:link>
                 		<br/>
                 		<g:link controller='party' params='["id":p?.id]' action='show'>Détails</g:link>
                 	</td>
                 </tr>
               </g:each>
           	 </table>
           </div>
        </div>
        
<script type="text/javascript">
//Start Ajax tabs script for UL with id="maintab" Separate multiple ids each with a comma.
startajaxtabs("maintab")
</script>

        
    </body>
</html>
            