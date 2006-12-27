<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="party.edit_page"/></title>
    <g:javascript library="prototype" />
    <g:javascript library="scriptaculous" />
  </head>
  <body>
    <div class="body">
      <a href="${createLink(controller:'championship',action:'show',id:party?.championship?.id)}">
        <g:message code="party.back_to_championship_action"/>
      </a>
      <h1><g:message code="party.edit_page"/></h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${party}">
        <div class="errors">
          <g:renderErrors bean="${party}" as="list" />
        </div>
      </g:hasErrors>
      <g:form method="post" >
        <input type="hidden" name="id" value="${party?.id}" />
       	<g:render template="/party/fieldlist" model="[party:party]" />
        <div class="buttons">
          <span class="button"><g:actionSubmit value="Update" /></span>
        </div>
      </g:form>
            
      <g:form controller="score" action="save" method="post" >
        <input type="hidden" name="party.id" value="${party?.id}"/>
        <div class="dialog">
          <table>
            <tr class='prop'>
              <td valign='top' class='name'>
                <label for='player'><g:message code="score.player"/> :</label>
              </td>
              <td valign='top' class='value ${hasErrors(bean:score,field:'player','errors')}'>
                <g:select optionKey="id" optionValue="login" from="${Player.list()}" 
                  name='player.id' value='${score?.player?.id}'></g:select>
              </td>
            </tr>
            <tr class='prop'>
              <td valign='top' class='name'>
                <label for='points'><g:message code="score.chips"/> :</label>
              </td>
              <td valign='top' class='value ${hasErrors(bean:score,field:'points','errors')}'>
                <input type='text' name='points' value='${score?.points}'></input>
              </td>
            </tr>
            <tr class='prop'>
              <td valign='top' class='name'>
                <label for='refunds'><g:message code="score.rebuys"/> :</label>
              </td>
              <td valign='top' class='value ${hasErrors(bean:score,field:'refunds','errors')}'>
                <input type='text' name='refunds' value='${score?.refunds}'></input>
              </td>
            </tr>
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
          <th><g:message code="score.player"/></th>
          <th><g:message code="score.chips"/></th>
          <th><g:message code="score.rebuys"/></th>
          <th><g:message code="score.money"/></th>
          <th></th>
        </tr>
		<g:each var='score' in='${Score.findAllByParty(party, [sort:"money", order:"desc"] )}'>
		  <tr>
            <td width="30%">${score.player?.login}</td>
			<td width="15%">
			  <p id="points-${score.player?.login}">${score.points}</p>
			</td>
			<script type="text/javascript">
              new Ajax.InPlaceEditor('points-${score.player?.login}', 
			  	   '${createLink(controller:"score",action:"updatePoints",params:["id":score.id])}',
			  	   {highlightcolor:"#578BB8",cancelText:"annuler",
			  	    clickToEditText:"cliquez pour changer la valeur du champ",cols:5,
			  	    onComplete:function(transport,element) {
			  	    	var resultData = eval('('+transport.responseText+')');
						$('points-${score.player?.login}').innerHTML = resultData.points;
						$('money-${score.player?.login}').innerHTML = resultData.money;
						if (resultData.money > 0)
							$('money-${score.player?.login}').setAttribute('style','color:green');
						else
							$('money-${score.player?.login}').setAttribute('style','color:red');
			   	    }
			   	   });
            </script>
            <td width="15%">${score.refunds}</td>
			<td width="15%">
			  <g:if test="${score.money > 0}">
			  	<span id="money-${score.player?.login}" style="color:green">${score.money}</span>
			  </g:if>
			  <g:else>
			  	<span id="money-${score.player?.login}" style="color:red">${score.money}</span>
			  </g:else>
			</td>
			<td width="35%">
			  <g:link controller='score' params='["id":score?.id, "party_id":party?.id]' 
			    action='delete'><g:message code="score.delete"/></g:link>
			</td>
		  </tr>
        </g:each>
      </table>
            
      <div class="buttons">
        <span class="button">
          <g:remoteLink action="checkScores" id="${party?.id}" 
                        update="success-scores-check">
            <g:message code="score.check"/></g:remoteLink>
        </span>
      </div>

    </div>
  </body>
</html>
            