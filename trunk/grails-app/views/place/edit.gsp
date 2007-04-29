<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="place.edit_page"/></title>
  </head>
  <body>
    <g:form method="post" action="update" id="${place?.id}">
      <fieldset>
        <legend><g:message code="place.edit_page"/></legend>
      
        <g:if test="${flash.message}">
          <div class="message">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${place}">
          <div class="errors">
            <g:renderErrors bean="${place}" as="list" />
          </div>
        </g:hasErrors>
        
		<label for='name'><g:message code="place.name"/> :</label>
        <input id="name" type="text" class='${hasErrors(bean:place,field:'name','errors')}' 
          size='40' maxlength='40' name='name' value='${place?.name}' />

        <label for='description'><g:message code="place.description"/> :</label>
        <textarea class="${hasErrors(bean:place,field:'description','errors')}"
          cols="40" rows="3" id="description" name="description" 
          value="${place?.description}">${place?.description}</textarea>
        <br/>

        <label for="submit">&nbsp;</label>
        <input id="submit" type="submit" value="Update"></input>

      </fieldset>
    </g:form>
  </body>
</html>
            