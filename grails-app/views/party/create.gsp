<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Poker Party Manager - <g:message code="party.create_page"/></title>         
    <g:javascript library="prototype" />
  </head>
  <body>
    <div class="body">
      <a href="${createLink(controller:'championship',action:'show',id:params['championship.id'])}">
        <g:message code="party.back_to_championship_action"/>
      </a>
      <h1><g:message code="party.create_page"/></h1>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${party}">
        <div class="errors">
          <g:renderErrors bean="${party}" as="list" />
        </div>
      </g:hasErrors>
      <g:form action="save" method="post" >
        <input type="hidden" name="championship.id" value="${params['championship.id']}"/>
       	<g:render template="/party/fieldlist" model="[party:party]" />
        <div class="buttons">
          <span class="formButton">
            <input type="submit" value="Create"></input>
          </span>
        </div>
      </g:form>
    </div>
  </body>
</html>
            