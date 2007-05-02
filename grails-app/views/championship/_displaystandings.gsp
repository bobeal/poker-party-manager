<div id="standingsContent">
<table>

  <tr>
    <th class="embed"><g:message code="championship.position"/></th>
    <th class="embed"><g:message code="championship.player"/></th>
	<th class="embed"><g:message code="championship.total"/></th>
	<th class="embed"><g:message code="championship.parties_won"/></th>
	<th class="embed"><g:message code="championship.parties_draw"/></th>
	<th class="embed"><g:message code="championship.parties_lost"/></th>
	<th class="embed"><g:message code="championship.lpa_index"/></th>
  </tr>
  
  <g:each in="${playersLines}" var="playerLine" status="index">
    <tr>
      <td class="${index % 2 == 0 ? 'odd' : 'even'}" width='10%'>${index + 1}</td>
      <td class="${index % 2 == 0 ? 'odd' : 'even'}" width='20%'>${playerLine?.playerLogin}</td>
      <td class="${index % 2 == 0 ? 'odd' : 'even'}" width='20%'>${playerLine?.getFormattedTotal()}</td>
      <td class="${index % 2 == 0 ? 'odd' : 'even'}" width='10%'>${playerLine?.partiesWon}</td>
      <td class="${index % 2 == 0 ? 'odd' : 'even'}" width='10%'>${playerLine?.partiesDraw}</td>
      <td class="${index % 2 == 0 ? 'odd' : 'even'}" width='10%'>${playerLine?.partiesLost}</td>
      <td class="${index % 2 == 0 ? 'odd' : 'even'}" width='10%'>${playerLine?.getLpa()}</td>
    </tr>
  </g:each>
  
</table>

</div>
