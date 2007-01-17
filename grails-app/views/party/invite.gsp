<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="party.invite"/></title>
  </head>
  <body>
    <g:form name="partInvite" action="sendInvitation" method="post" >
      <fieldset>
        <input type="hidden" name="championship_id" value="${params.id}" />

        <legend><g:message code="party.invite"/></legend>
      
        <g:if test="${flash.message}">
          <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${place}">
          <div class="errors">
            <g:renderErrors bean="${place}" as="list" />
          </div>
        </g:hasErrors>
      
        <div id="invitationStatus"></div>
      
        <label for='place'><g:message code="party.place"/> :</label>
        <g:select optionKey="id" optionValue="name" 
          from="${Place.list()}" name='place_id'></g:select>
        <br />

        <label for='date'><g:message code="party.date"/> :</label>
        <g:datePicker name='date' value='${party?.date}'></g:datePicker>
        <br />

        <label for='date'><g:message code="party.guests"/> :</label>
        <select name="guests" multiple>
          <g:each in="${Player.list()}" var="player">
            <option value="${player.id}">${player.login}</option>
          </g:each>
        </select>
        <br />

        <label for='date'><g:message code="party.invite_message"/> :</label>
        <textarea cols="30" rows="5" name="message"></textarea>
        <br />

        <label for="submit">&nbsp;</label>
        <g:actionSubmit value="Send" />

      </fieldset>
    </g:form>
  </body>
</html>
