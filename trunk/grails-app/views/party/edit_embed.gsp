<div id="editPartyContent">
<script type="text/javascript">
  onSubmitButtonsMarkupReady('wrappedPartySubmit','partySubmit');
  onSubmitButtonsMarkupReady('wrappedScoreSubmit','scoreSubmit');
</script>
<g:formRemote name="editPartyForm" url="[action:'update']" method="post" update="editPartyContent">
  <fieldset class="embed">

    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${party}">
      <div class="errors">
        <g:renderErrors bean="${party}" as="list" />
      </div>
    </g:hasErrors>

    <input type="hidden" name="id" value="${party?.id}" />
   	<g:render template="/party/fieldlist" model="[party:party]" />

    <label for="submit">&nbsp;</label>
    <input class="submit" id="wrappedPartySubmit" type="submit" value="Update" />
  </fieldset>
</g:formRemote>
            
<g:formRemote name="addScoreForm" url="[controller:'score',action:'save']" method="post" update="editPartyContent">
  <input type="hidden" name="party.id" value="${party?.id}"/>

  <fieldset class="embed">
    <legend><g:message code="score.create_page"/></legend>

    <label for='player'><g:message code="score.player"/> :</label>
    <g:select class='${hasErrors(bean:score,field:'player','errors')}' optionKey="id" 
      optionValue="login" from="${Player.list(sort:'login', order:'asc')}" name='player.id' 
      value='${score?.player?.id}'>
    </g:select>
    <br />

    <g:if test="${party?.kind == 'Cash Game'}">
    <label for='points'><g:message code="score.chips"/> :</label>
    <input type='text' class='${hasErrors(bean:score,field:'points','errors')}' name='points' 
      value='${score?.points}' id="points" />
    <br />
    </g:if>
    
    <g:if test="${party?.kind == 'Sit and Go'}">
    <label for='position'><g:message code="score.position"/> :</label>
    <input type='text' class='${hasErrors(bean:score,field:'position','errors')}' name='position' 
      value='${score?.position}' />
    <br />
    </g:if>
    
    <label for='refunds'><g:message code="score.rebuys"/> :</label>
    <input type='text' class='${hasErrors(bean:score,field:'refunds','errors')}' 
      name='refunds' value='${score?.refunds}' />
    <br />
    
    <label for="submit">&nbsp;</label>
    <input class="submit" id="wrappedScoreSubmit" type="submit" value="Create" />
  </fieldset>
</g:formRemote>
            
<div id="scores-check-result">
</div>
<div id="delete-result-status" style="display: none;">
</div>

<g:if test="${Score.countByParty(party) > 0}">
<div style="margin-top:10px;">
<table>
  <tr>
    <th class="embed"><g:message code="score.player"/></th>
    <g:if test="${party.kind == 'Cash Game'}">
      <th class="embed"><g:message code="score.chips"/></th>
    </g:if>
    <g:if test="${party.kind == 'Sit and Go'}">
      <th class="embed"><g:message code="score.position"/></th>
    </g:if>
    <th class="embed"><g:message code="score.rebuys"/></th>
    <g:if test="${party.kind == 'Sit and Go'}">
      <th class="embed"><g:message code="score.prize"/></th>
    </g:if>
    <th class="embed"><g:message code="score.money"/></th>
    <th class="embed"></th>
  </tr>
  <g:each var="score" in="${Score.findAllByParty(party, [sort:'money', order:'desc'] )}">
    <tr id="row-${score.id}">
      <td width="30%" class="even">${score.player?.login}</td>
      <g:if test="${party.kind == 'Cash Game'}">
        <td width="15%" class="even">
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
            }
          );
        </script>
      </g:if>
      <g:if test="${party.kind == 'Sit and Go'}">
        <td width="15%" class="even">${score.position}</td>
      </g:if>
      <td width="15%" class="even">${score.refunds}</td>
      <g:if test="${party.kind == 'Sit and Go'}">
        <td width="15%" class="even">
          <span id="prize-${score.player?.login}">${score.prize}</span>
        </td>
        <script type="text/javascript">
          new Ajax.InPlaceEditor('prize-${score.player?.login}', 
            '${createLink(controller:"score",action:"updatePrize",params:["id":score.id])}',
            {highlightcolor:"#578BB8",cancelText:"annuler",
              clickToEditText:"cliquez pour changer la valeur du champ",cols:5,
              onComplete:function(transport,element) {
                var resultData = eval('('+transport.responseText+')');
                $('prize-${score.player?.login}').innerHTML = resultData.prize;
                $('money-${score.player?.login}').innerHTML = resultData.money;
                if (resultData.money > 0)
                  $('money-${score.player?.login}').setAttribute('style','color:green');
                else
                  $('money-${score.player?.login}').setAttribute('style','color:red');
              }
            }
          );
        </script>
      </g:if>
      <td width="15%" class="even">
        <g:if test="${score.money > 0}">
          <span id="money-${score.player?.login}" style="color:green">${score.money}</span>
        </g:if>
        <g:else>
          <span id="money-${score.player?.login}" style="color:red">${score.money}</span>
        </g:else>
      </td>
      <td width="35%" class="even">
        <div id="commands-${score.id}" class="commands" style="display: inline;">
          <a href="javascript:void(0);" 
             onclick="javascript:confirmDelete('${message(code:'score.confirm_delete')}',
                                               '${message(code:'dialog.yes')}',
                                               '${message(code:'dialog.no')}',
                                               '${score.id}',
                                               '${createLink(action:'delete',controller:'score')}');return false;">
            <g:message code="action.delete" />
          </a>
        </div>
      </td>
    </tr>
  </g:each>
</table>

<div style="float:right;">
  <g:remoteLink action="checkScores" id="${party?.id}" update="scores-check-result">
    <g:message code="score.check"/>
  </g:remoteLink>
</div>

</div>
</g:if>
</div>