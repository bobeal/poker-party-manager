<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<html>
  <head>
    <meta name="layout" content="main">
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
          from="${Place.list(sort:'name', order:'asc')}" name='place_id'></g:select>
        <br />

        <label for='partyDate'><g:message code="party.date"/> :</label>
        <g:datePicker name='partyDate'></g:datePicker>
        <br />

        <label for='guests'><g:message code="party.guests"/> :</label>
        <select name="guests" multiple>
          <g:each in="${Player.list(sort:'login', order:'asc')}" var="player">
            <option value="${player.id}">${player.login}</option>
          </g:each>
        </select>
        <br />

        <label for='message'><g:message code="party.invite_message"/> :</label>
        <textarea cols="30" rows="5" name="message"></textarea>
        <br />

        <label for="submit">&nbsp;</label>
        <g:actionSubmit value="<g:message code="action.invite" />" />

      </fieldset>
    </g:form>
  </body>
</html>
