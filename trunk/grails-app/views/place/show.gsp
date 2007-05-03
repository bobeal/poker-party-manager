<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <script type="text/javascript">
      YAHOO.util.Event.onContentReady('showPlaceFieldset', onDefaultSubmitButtonsMarkupReady);
    </script> 
    <title>Poker Party Manager - <g:message code="place.show_page"/></title>
  </head>
  <body>
    <g:form action="edit" id="${place?.id}">
      <fieldset id="showPlaceFieldset">
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
        <input id="wrappedSubmit" type="submit" value="Edit"></input>

      </fieldset>
    </g:form>

  </body>
</html>
            