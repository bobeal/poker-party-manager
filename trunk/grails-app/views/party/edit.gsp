
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Edition d'une partie</title>
         <g:javascript library="prototype" />
    </head>
    <body>
        <div class="body">
           <h1>Edition d'une partie</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <g:hasErrors bean="${party}">
                <div class="errors">
                    <g:renderErrors bean="${party}" as="list" />
                </div>
           </g:hasErrors>
           <div class="prop">
	         <input type="hidden" name="party.id" value="${party?.id}" />
           </div>           
           <g:form controller="party" method="post" >
               <input type="hidden" name="id" value="${party?.id}" />
               <div class="dialog">
                <table>
				  <tr class='prop'>
				    <td valign='top' class='name'><label for='championship'>Championnat :</label></td>
				    <td valign='top' class='value ${hasErrors(bean:party,field:'championship','errors')}'>
				      <g:select optionKey="id" optionValue="label" from="${Championship.list()}" name='championship.id' value='${party?.championship?.id}'></g:select></td>
				  </tr>
				  <tr class='prop'>
				    <td valign='top' class='name'><label for='date'>Date :</label></td>
				    <td valign='top' class='value ${hasErrors(bean:party,field:'date','errors')}'>
				      <g:datePicker name='date' value='${party?.date}'></g:datePicker>
				    </td>
				  </tr>
				  <tr class='prop'>
				    <td valign='top' class='name'><label for='place'>Place :</label></td>
				    <td valign='top' class='value ${hasErrors(bean:party,field:'place','errors')}'>
				      <g:select optionKey="id" optionValue="name" from="${Place.list()}" name='place.id' value="${party?.place?.id}"></g:select>
				    </td>
				  </tr>
                </table>
               </div>

               <div class="buttons">
                     <span class="button"><g:actionSubmit value="Update" /></span>
                     <!-- <span class="button"><g:actionSubmit value="Delete" /></span> -->
               </div>
               
            </g:form>
            
            <g:form controller="score" action="save" method="post" >
               <input type="hidden" name="party.id" value="${party?.id}"/>
               <div class="dialog">
                <table>
                  <tr class='prop'><td valign='top' class='name'><label for='player'>Joueur :</label></td><td valign='top' class='value ${hasErrors(bean:score,field:'player','errors')}'><g:select optionKey="id" optionValue="login" from="${Player.list()}" name='player.id' value='${score?.player?.id}'></g:select></td></tr>
                  <tr class='prop'><td valign='top' class='name'><label for='points'>Points :</label></td><td valign='top' class='value ${hasErrors(bean:score,field:'points','errors')}'><input type='text' name='points' value='${score?.points}'></input></td></tr>
                  <tr class='prop'><td valign='top' class='name'><label for='refunds'>Caves :</label></td><td valign='top' class='value ${hasErrors(bean:score,field:'refunds','errors')}'><input type='text' name='refunds' value='${score?.refunds}'></input></td></tr>
               </table>
               </div>
               <div class="buttons">
                     <span class="formButton">
                        <input type="submit" value="Create"></input>
                     </span>
               </div>
            </g:form>
            
            <div id="success-scores-check">
            </div>
            
            <table>
              <tr>
              	<th>Joueur</th>
              	<th>Points</th>
              	<th>Caves</th>
              	<th>Moneeeeyyy</th>
              	<th></th>
              </tr>
			  <g:each var='score' in='${Score.findAllByParty(party, [sort:"money", order:"desc"] )}'>
			   	<tr>
			   		<td width="30%">${score.player?.login}</td>
			   		<td width="15%">${score.points}</td>
			   		<td width="15%">${score.refunds}</td>
			   		<td width="15%">
			   			<g:if test="${score.money > 0}">
			   				<span style="color:green">${score.money}</span>
			   			</g:if>
			   			<g:else>
			   				<span style="color:red">${score.money}</span>
			   			</g:else>
			   		</td>
			   		<td width="35%">
			   		  <g:link controller='score' params='["id":score?.id, "party_id":party?.id]' action='delete'>Supprimer</g:link>
			   		</td>
				</tr>
              </g:each>
            </table>
            
            <div class="buttons">
              <span class="button">
                <g:remoteLink action="checkScores" id="${party?.id}" 
                  update="success-scores-check">Check</g:remoteLink>
              </span>
            </div>
            
        </div>
    </body>
</html>
            