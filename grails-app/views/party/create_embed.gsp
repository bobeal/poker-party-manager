<div id="addPartyContent">
<g:formRemote name="addPartyForm" url="[action:'save']" method="post" update="addPartyContent">
  <fieldset class="embed" id="addPartyFieldset">
    
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    
    <g:hasErrors bean="${party}">
      <div class="errors">
        <g:renderErrors bean="${party}" as="list" />
      </div>
    </g:hasErrors>

    <input type="hidden" name="championship.id" value="${params['id']}"/>
    
    <g:render template="/party/fieldlist" model="[party:party]" />

    <label for="submit">&nbsp;</label>
    <input class="submit" id="wrappedSubmit" type="submit" value="<g:message code="action.create" />" />
    
  </fieldset>
</g:formRemote>
</div>
