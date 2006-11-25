<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="place.show_page"/></title>
  </head>
  <body>
    <div class="body">
      <h1><g:message code="place.show_page"/></h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <div class="dialog">
        <table>
          <tr class="prop">
            <td valign="top" class="name"><g:message code="place.name"/> :</td>
            <td valign="top" class="value">${place.name}</td>
          </tr>
          <tr class="prop">
            <td valign="top" class="name"><g:message code="place.description"/> :</td>
            <td valign="top" class="value">${place.description}</td>
          </tr>
        </table>
      </div>
      <div class="buttons">
        <g:form controller="place">
          <input type="hidden" name="id" value="${place?.id}" />
          <span class="button"><g:actionSubmit value="Edit" /></span>
        </g:form>
      </div>
    </div>
  </body>
</html>
            