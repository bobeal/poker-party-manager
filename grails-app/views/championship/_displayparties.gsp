<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<g:if test="${!parties.isEmpty()}">
    
  <div id="positionsContentContainer">    
  <div id="positionsContent">
  
    <div style="float:right;">
      <g:ajaxPaginate next="${message(code:'navigation.next')}" 
          prev="${message(code:'navigation.prev')}"
          breadcrumb="true" controller="championship" 
          action="getparties" total="${total}" id="${championshipId}" />
    </div>
    <div style="clear:both;"></div>
    
    <table>
      <tr>
        <th class="embed parties-embed"></th>
        <g:each in="${parties}" var="party">
          <th class="embed parties-embed">
            <a href="javascript:void(0);" 
               onclick="javascript:openEditPartyTab('${message(code:"championship.edit_party")}', 
                                                    '${createLink(controller:"party",action:"edit",id:party.id)}');">
              <g:dateFormat date="${party.date}"/>
            </a>
            <br/>
            <!-- 
            <div id="commands-${party.id}" class="commands" style="display: inline;">
              <a href="javascript:void(0);" 
                  onclick="javascript:confirmDelete('${message(code:'party.confirm_delete')}',
                                               '${message(code:'dialog.yes')}',
                                               '${message(code:'dialog.no')}',
                                               '${party.id}',
                                               '${createLink(action:'delete',controller:'party')}');return false;">
                  <g:message code="action.delete" />
              </a>
            </div>
            -->
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
  </div>
</g:if>
<g:else>
  <g:message code="championship.no_parties" />
</g:else>
          