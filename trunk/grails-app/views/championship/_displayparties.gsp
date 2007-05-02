<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<g:if test="${!parties.isEmpty()}">
        
  <div id="positionsContent">
    <g:ajaxPaginate next="${message(code:'navigation.next')}" 
      prev="${message(code:'navigation.prev')}"
      breadcrumb="true" controller="championship" 
      action="getparties" total="${total}" id="${championshipId}" />

    <table>
      <tr>
        <th class="embed"></th>
        <g:each in="${parties}" var="party">
          <th class="embed">
            <a href="javascript:void(0);" 
               onclick="javascript:openEditPartyTab('${message(code:"championship.edit_party")}', 
                                                    '${createLink(controller:"party",action:"edit",id:party.id)}');">
              <g:dateFormat date="${party.date}"/>
            </a>
          </th>
        </g:each>
      </tr>
      <g:each in="${playersScores.keySet()}" var="playerLogin" status="index">
        <tr>
          <td class="${index % 2 == 0 ? 'odd' : 'even'}">${playerLogin}</td>
          <g:each in="${playersScores.get(playerLogin)}" var="money">
            <td class="${index % 2 == 0 ? 'odd' : 'even'}">${money}</td>
          </g:each>
        </tr>
      </g:each>
    </table>
    
  </div>        
</g:if>
<g:else>
  <g:message code="championship.no_parties" />
</g:else>
          