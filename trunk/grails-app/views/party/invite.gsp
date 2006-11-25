<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="party.invite"/></title>
  </head>
  <body>
    <div class="body">
      <h1><g:message code="party.invite"/></h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${place}">
        <div class="errors">
          <g:renderErrors bean="${place}" as="list" />
        </div>
      </g:hasErrors>
      <div id="invitationStatus"></div>
      <g:form name="partInvite" action="sendInvitation" method="post" >
        <input type="hidden" name="championship_id" value="${params.id}" />
        <div class="dialog">
          <table>
            <tr class='prop'>
              <td valign='top' class='name'>
                <label for='place'><g:message code="party.place"/> :</label>
              </td>
              <td valign='top' class='value'>
                <g:select optionKey="id" optionValue="name" 
                          from="${Place.list()}" name='place_id'></g:select>
              </td>
            </tr>
            <tr class='prop'>
              <td valign='top' class='name'>
                <label for='date'><g:message code="party.date"/> :</label>
              </td>
              <td valign='top' class='value'>
                <g:datePicker name='date' value='${party?.date}'></g:datePicker>
              </td>
            </tr>
            <tr class='prop'>
              <td valign='top' class='name'>
                <label for='date'><g:message code="party.guests"/> :</label>
              </td>
              <td valign='top' class='value'>
                <select name="guests" multiple>
                  <g:each in="${Player.list()}" var="player">
                    <option value="${player.id}">${player.login}</option>
                  </g:each>
                </select>
              </td>
            </tr>
            <tr class='prop'>
              <td valign='top' class='name'>
                <label for='date'><g:message code="party.invite_message"/> :</label>
              </td>
              <td valign='top' class='value'>
                <textarea cols="30" rows="5" name="message"></textarea>
              </td>
            </tr>
          </table>
        </div>
        <div class="buttons">
          <span class="button"><g:actionSubmit value="Send" /></span>
        </div>
      </g:form>
    </div>
  </body>
</html>
