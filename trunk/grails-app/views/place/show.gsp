<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="place.show_page"/></title>
  </head>
  <body>
    <g:form action="edit" id="${place?.id}">
      <fieldset>
        <legend><g:message code="place.show_page"/></legend>

        <g:if test="${flash.message}">
          <div class="message">${flash.message}</div>
        </g:if>

        <label><g:message code="place.name"/> :</label>
        ${place.name}
        <br/>

        <label><g:message code="place.description"/> :</label>
        ${place.description}
        <br/>

        <label for="submit">&nbsp;</label>
        <g:actionSubmit value="Edit" />

      </fieldset>
    </g:form>

  </body>
</html>
            