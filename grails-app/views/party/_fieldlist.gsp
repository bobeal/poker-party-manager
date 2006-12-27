<script type="text/javascript">
  function initKindFields(kind) {
  	var elementsToHide;
  	if (kind == "Cash Game") {
  		elementsToHide = document.getElementsByClassName('sitandgo');
  	} else if (kind == "Sit and Go") {
  		elementsToHide = document.getElementsByClassName('cashgame');
  	}
	for (var i = 0; i < elementsToHide.length; i++) {
		Element.hide(elementsToHide[i]);
	}
  }
  
  function switchKindFields() {
  	var selectedKind = $F('kind');
  	var elementsToShow;
  	var elementsToHide;
  	if (selectedKind == "Cash Game") {
  		elementsToShow = document.getElementsByClassName('cashgame');
  		elementsToHide = document.getElementsByClassName('sitandgo');
  	} else if (selectedKind == "Sit and Go") {
  		elementsToShow = document.getElementsByClassName('sitandgo');
  		elementsToHide = document.getElementsByClassName('cashgame');  	
  	}
	for (var i = 0; i < elementsToShow.length; i++) {
		Element.show(elementsToShow[i]);
	}
	for (var i = 0; i < elementsToHide.length; i++) {
		Element.hide(elementsToHide[i]);
	}
  }
</script>
<div class="dialog">
  <table>
	<tr class='prop'>
		<td valign='top' class='name'>
		  <label for='date'><g:message code="party.date" /> :</label>
		</td>
		<td valign='top' class='value ${hasErrors(bean:party,field:'date','errors')}'>
		  <g:datePicker name='date' value='${party?.date}'></g:datePicker>
	    </td>
	</tr>
	<tr class='prop'>
		<td valign='top' class='name'>
		  <label for='place'><g:message code="party.place" /> :</label>
		</td>
		<td valign='top' class='value ${hasErrors(bean:party,field:'place','errors')}'>
		  <g:select optionKey="id" optionValue="name" from="${Place.list()}"
			        name='place.id' value="${party?.place?.id}">
		  </g:select>
		</td>
	</tr>
	<tr class='prop'>
		<td valign='top' class='name'>
		  <label for='kind'><g:message code="party.kind" /> :</label>
		</td>
		<td valign='top' class='value ${hasErrors(bean:party,field:'kind','errors')}'>
		  <g:select id="kind" from="${Party.allKinds}" name='kind' value="${party?.kind}"
			        onchange="javascript:switchKindFields()">
		  </g:select>
		</td>
	</tr>
	<tr class='prop sitandgo'>
		<td valign='top' class='name'>
		  <label for='buyin'><g:message code="party.buyin" /> :</label>
		</td>
		<td valign='top' class='value ${hasErrors(bean:party,field:'buyin','errors')}'>
		  <g:textField name="buyin" value='${party?.buyin}' />
		  <g:message code="party.buyin.example" />
		</td>
	</tr>
	<tr class='prop sitandgo'>
		<td valign='top' class='name'>
		  <label for='coinsPerBuyin'><g:message code="party.coins_per_buyin" /> :</label>
		</td>
		<td valign='top' class='value ${hasErrors(bean:party,field:'coinsPerBuyin','errors')}'>
		  <g:textField name="coinsPerBuyin" value='${party?.coinsPerBuyin}' />
		</td>
	</tr>
	<tr class='prop cashgame'>
		<td valign='top' class='name'><label for='prizePool'>
			<g:message code="party.prize_pool" /> :</label>
		</td>
		<td valign='top' class='value ${hasErrors(bean:party,field:'prizePool','errors')}'>
		  <g:textField name="prizePool" value='${party?.prizePool}' />
		</td>
	</tr>
  </table>
  <script type="text/javascript">
	initKindFields('${party?.kind}');
  </script>
</div>
