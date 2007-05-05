<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<html>
  <head>
    <meta name="layout" content="main">
    <title>Poker Party Manager - <g:message code="place.list_page"/></title>
  </head>
  <body>
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>

    <g:if test="${!placeList.isEmpty()}">
    <table>
      <tr>
        <th><g:message code="place.name"/></th>
        <th><g:message code="place.description"/></th>
        <th></th>
      </tr>
      <g:each in="${placeList}" var="place" status="index">
        <tr>
          <td class="${index % 2 == 0 ? 'odd' : 'even'}">${place.name}</td>
          <td class="${index % 2 == 0 ? 'odd' : 'even'}">${place.description}</td>
          <td class="${index % 2 == 0 ? 'odd' : 'even'}">
            <g:link action="show" id="${place.id}"><g:message code="action.show"/></g:link>
            <g:if test="${session?.user?.isSuperAdmin}">
              <br />
              <g:link action="edit" id="${place.id}"><g:message code="action.edit" /></g:link>
            </g:if>
          </td>
        </tr>
      </g:each>
    </table>
    </g:if>
  </body>
</html>
            