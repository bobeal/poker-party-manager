<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="championship.create_page"/></title>         
  </head>
  <body>
      <g:form action="save" method="post" >
          <fieldset>
            <legend><g:message code="championship.create_page"/></legend>

            <g:if test="${flash.message}">
              <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${championship}">
              <div class="errors">
                <g:renderErrors bean="${championship}" as="list" />
              </div>
            </g:hasErrors>

            <label for="label" class="required"><g:message code="championship.label"/> :</label>
            <input id="label" type='text' name='label' value='${championship?.label}' />
            <br />
            
            <label for='startDate' class="required"><g:message code="championship.start_date"/> :</label>
            <g:datePicker name='startDate' value='${championship?.startDate}'></g:datePicker>
            <br />

            <label for='endDate' class="required"><g:message code="championship.end_date"/> :</label>
            <g:datePicker name='endDate' value='${championship?.endDate}'></g:datePicker>
            <br />
            
            <label for='adminsId'><g:message code="championship.admins"/> :</label>
            <select name="adminsId" multiple>
              <g:each in="${Player.findAllByCanManageChampionship(true)}" var="player">
                <option value="${player.id}">${player.login}</option>
              </g:each>
            </select>
            <br/>

            <label for="submit"></label>
            <input type="submit" id="submit" value="Create"></input>
          </fieldset>
      </g:form>
  </body>
</html>
            