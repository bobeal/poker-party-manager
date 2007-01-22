<label for="date" class="required"><g:message code="party.date" /> :</label>
<g:datePicker class='${hasErrors(bean:party,field:'date','errors')}' 
  name='date' id="date" value='${party?.date}'></g:datePicker>
<br/>

<label for='place' class="required"><g:message code="party.place" /> :</label>
<g:select class='${hasErrors(bean:party,field:'place','errors')}' optionKey="id" 
  optionValue="name" id="place" from="${Place.list()}" name='place.id' value="${party?.place?.id}">
</g:select>
<br/>

<label for='kind' class="required"><g:message code="party.kind" /> :</label>
<g:select class="${hasErrors(bean:party,field:'kind','errors')}"
  from="${Party.allKinds}" name='kind' value="${party?.kind}" id="kind"
  onchange="javascript:switchKindFields();">
</g:select>
<br/>

<label for="buyin" id="buyinLabel" class="${party?.kind == 'Cash Game' ? 'required' : '' }">
  <g:message code="party.buyin" /> :</label>
<g:textField class="${hasErrors(bean:party,field:'buyin','errors')}" name="buyin" 
  value='${party?.buyin}' />
<g:if test="${party?.kind == 'Cash Game'}">
  <g:message code="party.buyin.cashgame_example" />
</g:if>
<br/>
<div id="cashgame" style="${party?.kind == 'Cash Game' ? 'display:inline' : 'display:none;' }">
  <label for="coinsPerBuyin" class="required"><g:message code="party.coins_per_buyin" /> :</label>
  <g:textField class="${hasErrors(bean:party,field:'coinsPerBuyin','errors')}"
    name="coinsPerBuyin" value='${party?.coinsPerBuyin}' />
  <br/>
</div>



