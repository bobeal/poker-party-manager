<g:if test="${parties.size() > 0 }">
        
  <g:paginate next="Forward" prev="Back"
     breadcrumb="true" controller="party" 
     action="list" total="${parties.size()}" />
        
  <table>
    <tr>
      <th class="embed"></th>
      <g:each in="${parties}" var="party">
        <th class="embed">${party.place} - ${party.date}</th>
      </g:each>
    </tr>
    
    <g:each in="${Player.findAll()}" var="player">
      <tr>
        <td class="embed">${player.login}</td>
        <g:each in="${parties}" var="party">
          <td>${Score.findByPartyAndPlayer(party,player)?.formattedTotal()}</td>
        </g:each>
      </tr>
    </g:each>
    
  </table>
        
</g:if>
<g:else>
  <g:message code="championship.no_parties" />
</g:else>
          