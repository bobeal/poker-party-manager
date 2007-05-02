<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<html>
  <head>
    <meta name="layout" content="main" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Poker Party Manager - <g:message code="championship.list_page" /></title>
  </head>
  <body>
    <div class="body">
      <div id="delete-result-status" style="display: none;"></div>
      <g:if test="${flash.message}">
        <div class="message"><g:message code="${flash.message}" /></div>
      </g:if>
      <g:if test="${!championshipList.isEmpty()}">
      <table>
        <tr>
          <th><g:message code="championship.label" /></th>
          <th><g:message code="championship.start_date" /></th>
          <th><g:message code="championship.end_date" /></th>
          <th></th>
        </tr>
        <g:each in="${championshipList}" var="championship" status="index">
          <tr id="row-${championship.id}">
            <td class="${index % 2 == 0 ? 'odd' : 'even'}">${championship.label}</td>
            <td class="${index % 2 == 0 ? 'odd' : 'even'}">${championship.startDate}</td>
            <td class="${index % 2 == 0 ? 'odd' : 'even'}">${championship.endDate}</td>
            <td class="actionButtons ${index % 2 == 0 ? 'odd' : 'even'}">
              <span class="actionButton">
                <g:link action="show" id="${championship.id}">
                  <g:message code="action.show" />
                </g:link>
              </span>
              <br />
              <!-- 
              <span class="actionButton">
                <g:link controller="party" action="invite" id="${championship.id}">
                  <g:message code="party.invite" />
                </g:link>
              </span>
              <br/>
              -->

              <!-- 
              <g:link controller='party' 
                      params='["championship.id":championship.id]' action='create'>
                <g:message code="championship.add_party" />
              </g:link>
   
              <br />
              <div id="commands-${championship.id}" class="commands" style="display: inline;">
                <a href="javascript:void(0);" 
                   onclick="javascript:confirmDelete('${message(code:'championship.confirm_delete')}',
                                                     '${message(code:'dialog.yes')}',
                                                     '${message(code:'dialog.no')}',
                                                     '${championship.id}',
                                                     '${createLink(action:'delete',controller:'championship')}'
                                                     'successDeleteJson');return false;">
                  <g:message code="action.delete" />
                </a>
                <br/>
              </div>
              -->
              
            </td>
          </tr>
        </g:each>
      </table>
      </g:if>
    </div>
  </body>
</html>
