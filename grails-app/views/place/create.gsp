<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<html>
  <head>
    <meta name="layout" content="main">
    <script type="text/javascript">
      YAHOO.util.Event.onContentReady('createPlaceFieldset', onDefaultSubmitButtonsMarkupReady);
    </script> 
    <title>Poker Party Manager - <g:message code="place.create_page"/></title>         
  </head>
  <body>
    <g:form action="save" method="post" >
      <fieldset id="createPlaceFieldset">
        <legend><g:message code="place.create_page"/></legend>
      
        <g:if test="${flash.message}">
          <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${place}">
          <div class="errors">
            <g:renderErrors bean="${place}" as="list" />
          </div>
        </g:hasErrors>

        <label for="name"><g:message code="place.name"/> :</label>
        <input id="name" type="text" class='${hasErrors(bean:place,field:'name','errors')}' 
          size='40' maxlength='40' name='name' value='${place?.name}' />
        <br/>

        <label for='description'><g:message code="place.description"/> :</label>
        <textarea class="${hasErrors(bean:place,field:'description','errors')}"
          cols="40" rows="3" id="description" name="description">
          ${place?.description}
        </textarea>
        <br/>

        <label for="submit">&nbsp;</label>
        <input id="wrappedSubmit" type="submit" value="<g:message code="action.create" />"></input>
      </fieldset>
    </g:form>
  </body>
</html>
