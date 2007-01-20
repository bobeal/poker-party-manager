<g:form method="post" >
  <fieldset class="embed">
    <legend><g:message code="party.edit_page"/></legend>

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

    <legend for="submit">&nbsp;</legend>
    <g:submitToRemote url="[controller:'party',action:'update']" update="partiestab" value="Update" />
  </fieldset>
</g:form>
            
<g:form controller="score" action="save" method="post" >
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
      value='${score?.points}' id="points">
    </input>
    <br />
    </g:if>
    
    <g:if test="${party?.kind == 'Sit and Go'}">
    <label for='position'><g:message code="score.position"/> :</label>
    <input type='text' class='${hasErrors(bean:score,field:'position','errors')}' name='position' 
      value='${score?.position}'>
    </input>
    <br />
    </g:if>
    
    <label for='refunds'><g:message code="score.rebuys"/> :</label>
    <input type='text' class='${hasErrors(bean:score,field:'refunds','errors')}' 
      name='refunds' value='${score?.refunds}'>
    </input>
    <br />
    
    <label for="submit">&nbsp;</label>
    <g:submitToRemote url="[controller:'score',action:'save']" update="partiestab" value="Create" />
  </fieldset>
</g:form>
            
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
         });
      </script>
      </g:if>
      <g:if test="${party.kind == 'Sit and Go'}">
        <td width="15%" class="even">${score.position}</td>
      </g:if>
      <td width="15%" class="even">${score.refunds}</td>
      <td width="15%" class="even">
        <g:if test="${score.money > 0}">
          <span id="money-${score.player?.login}" style="color:green">${score.money}</span>
        </g:if>
        <g:else>
          <span id="money-${score.player?.login}" style="color:red">${score.money}</span>
        </g:else>
      </td>
      <g:if test="${party.kind == 'Sit and Go'}">
      <script type="text/javascript">
       new Ajax.InPlaceEditor('money-${score.player?.login}', 
         '${createLink(controller:"score",action:"updateMoney",params:["id":score.id])}',
         {highlightcolor:"#578BB8",cancelText:"annuler",
          clickToEditText:"cliquez pour changer la valeur du champ",cols:5,
          onComplete:function(transport,element) {
            var resultData = eval('('+transport.responseText+')');
            $('money-${score.player?.login}').innerHTML = resultData.money;
            if (resultData.money > 0)
              $('money-${score.player?.login}').setAttribute('style','color:green');
            else
              $('money-${score.player?.login}').setAttribute('style','color:red');
          }
         });
      </script>
      </g:if>
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

<g:if test="${party.kind == 'Cash Game'}">
  <div style="float:right;">
    <g:remoteLink action="checkScores" id="${party?.id}" update="scores-check-result">
      <g:message code="score.check"/>
    </g:remoteLink>
  </div>
</g:if>

</div>
</g:if>
