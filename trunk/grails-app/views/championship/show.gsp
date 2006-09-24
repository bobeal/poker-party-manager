
<html>
    <head>
		<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'ajaxtabs.css')}" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Visualisation d'un championnat</title>
        <g:javascript src="ajaxtabs.js" />
    </head>
    <body>
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
               <g:partiesTable parties="${Party.findAllByChampionship(championship, [sort:'date',order:'desc'] )}"/>
           	 </table>
           </div>
        </div>
        
<script type="text/javascript">
//Start Ajax tabs script for UL with id="maintab" Separate multiple ids each with a comma.
startajaxtabs("maintab")
</script>

        
    </body>
</html>
            