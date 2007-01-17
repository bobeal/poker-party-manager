<g:form action="save" method="post" >
  <fieldset class="embed">
    <legend><g:message code="party.create_page"/></legend>
    
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

    <legend for="submit">&nbsp;</legend>
    <g:submitToRemote url="[action:'save']" update="partiestab" value="Create" />

  </fieldset>
</g:form>

