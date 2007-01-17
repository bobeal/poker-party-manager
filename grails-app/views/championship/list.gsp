<html>
  <head>
    <meta name="layout" content="main" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Poker Party Manager - <g:message code="championship.list_page" /></title>
    <g:javascript>
      var tryingDeleteChampionship = '';
      function successDelete(t) {
        if (t.responseText == "success") {
          document.getElementById('deleteResultStatus').innerHTML = "<div class=\"message\"><g:message code="championship.success_delete" /></div>";
          Effect.Fade(document.getElementById('row-' + tryingDeleteChampionship));
          Element.remove(document.getElementById('row-' + tryingDeleteChampionship));
        } else {
          document.getElementById('deleteResultStatus').innerHTML = "<div class=\"errors\"><g:message code="championship.failure_delete" /></div>";
        }
        Effect.Appear('deleteResultStatus', {duration: 3.0 });
        new Effect.Highlight('deleteResultStatus', {duration: 2.0});
        Effect.Fade('deleteResultStatus');
        cancelDelete();
      }
      
      function failureDelete() {
        document.getElementById('deleteResultStatus').innerHTML = "<div class=\"errors\"><g:message code="championship.failure_delete" /></div>";
        Effect.Appear('deleteResultStatus', {duration: 3.0 });
        Effect.Highlight('deleteResultStatus', {duration: 2.0});
        Effect.Fade('deleteResultStatus');
        cancelDelete();
      }

      function cancelDelete() {
        Element.remove(document.getElementById('commands-askdelete-' + tryingDeleteChampionship));
        Element.toggle(document.getElementById('commands-' + tryingDeleteChampionship));
        tryingDeleteChampionship = '';
      }
       
      function confirmDelete(msg, championshipId) {
        var yesMsg = "<g:message code="dialog.yes" />";
        var noMsg = "<g:message code="dialog.no" />";
        var yesSubmitBaseUrl = "<g:createLink action="delete" />";
        var yesSubmitUrl = yesSubmitBaseUrl + "/" + championshipId;
        tryingDeleteChampionship = championshipId;
        var commands = document.getElementById('commands-' + championshipId);
        var post = commands.parentNode;
        commands.style.display = 'none';
        var confirmDeleteMethod = 'new Ajax.Updater(\'\',\'' + yesSubmitUrl + '\',{asynchronous:true,evalScripts:true,onSuccess:successDelete,onFailure:failureDelete});return false;';
        var newDiv = Builder.node('div', {className:'commands', id:'commands-askdelete-' + championshipId}, [
          Builder.node('span', {className:'important'}, ' ' + msg + ' '),
          Builder.node('a', {onclick:'javascript:cancelDelete();', href:'javascript:void(0);'}, noMsg),
          ' / ',
          Builder.node('a', {onclick:confirmDeleteMethod, href:'javascript:void(0);'}, yesMsg),
        ]);
        post.appendChild(newDiv);
      }
    </g:javascript>
  </head>
  <body>
    <div class="body">
      <div id="deleteResultStatus" style="display: none;"></div>
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
          <tr id="row-${championship.id}">
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
              <span class="actionButton">
                <g:link controller="party" action="invite" id="${championship.id}">
                  <g:message code="party.invite" />
                </g:link>
              </span>
              <br/>
              <g:canManageChampionship championship="${championship.id}">
                <span class="actionButton">
                  <g:link controller='party' 
                    params='["championship.id":championship.id]' action='create'>
                    <g:message code="championship.add_party" />
                  </g:link>
                </span>
                <br />
                <div id="commands-${championship.id}" class="commands" style="display: inline;">
                  <a href="javascript:void(0);" 
                    onclick="javascript:confirmDelete('${message(code:'championship.confirm_delete')}','${championship.id}');return false;">
                    <g:message code="action.delete" />
                  </a>
                  <br/>
                </div>
              </g:canManageChampionship>
            </td>
          </tr>
        </g:each>
      </table>
    </div>
  </body>
</html>
