<html>
  <head>
    <meta name="layout" content="main" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Poker Party Manager - <g:message code="championship.list_page" /></title>
    <g:javascript library="prototype" />
    <g:javascript>
      var tryingDeleteChampionship = '';
      function displaySuccessDelete() {
        document.getElementById('deleteResultStatus').innerHTML = "<div class=\"message\"><g:message code="championship.success_delete" /></div>";
        document.getElementById(tryingDeleteChampionship).style.display = "none";
        tryingDeleteChampionship = '';
      }
      function displayFailureDelete() {
        document.getElementById('deleteResultStatus').innerHTML = "<div class=\"errors\"><g:message code="championship.failure_delete" /></div>";
        tryingDeleteChampionship = '';
      }
      function confirmDelete(msg) {
        if(confirm(msg))
          return true;
        else
          return false;
      }
    </g:javascript>
  </head>
  <body>
    <div class="body">
      <h1><g:message code="championship.list_page" /></h1>
      <div id="deleteResultStatus"></div>
      <div id="successDelete"></div>
      <div id="failureDelete"></div>
      <g:if test="${flash.message}">
        <div class="message"><g:message code="${flash.message}" /></div>
      </g:if>
      <table>
        <tr>
          <th><g:message code="championship.label" /></th>
          <th><g:message code="championship.start_date" /></th>
          <th><g:message code="championship.end_date" /></th>
          <th></th>
        </tr>
        <g:each in="${championshipList}" var="championship">
          <tr id="${championship.id}">
            <td>${championship.label}</td>
            <td>${championship.startDate}</td>
            <td>${championship.endDate}</td>
            <td class="actionButtons">
              <span class="actionButton">
                <g:link action="show" id="${championship.id}">
                  <g:message code="action.show" />
                </g:link>
              </span>
              <br />
              <g:canManageChampionship championship="${championship.id}">
                <span class="actionButton">
                  <g:link controller='party' 
                    params='["championship.id":championship.id]' action='create'>
                    <g:message code="championship.add_party" />
                  </g:link>
                </span>
                <br />
                <span class="actionButton">
                  <!-- 
                  <g:remoteLink action="delete" id="${championship.id}" 
                    before="confirmDelete('<g:message code='championship.confirm_delete' args='[championship.label]'/>');"
                    update="[update:'successDelete',failure:'failureDelete']">
                    <g:message code="action.delete" />
                  </g:remoteLink>
                  <a href="javascript:void(0);"
                    onclick="if(confirm('<g:message code="championship.confirm_delete" args="[championship.label]"/>')) { tryingDeleteChampionship = '${championship.id}'; ${remoteFunction(action:"delete",id:championship.id,onSuccess="displaySuccessDelete()",onFailure="displayFailureDelete()" )} } return false;">
                    <g:message code="action.delete" />
                  </a>
                  -->
                </span>
              </g:canManageChampionship>
              <span class="actionButton">
                <g:link controller="party" action="invite" id="${championship.id}">
                  <g:message code="party.invite" />
                </g:link>
              </span>
            </td>
          </tr>
        </g:each>
      </table>
    </div>
  </body>
</html>
