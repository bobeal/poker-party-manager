<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<g:if test="${!parties.isEmpty()}">
        
  <div id="positionsContent">
  <g:ajaxPaginate next="${message(code:'navigation.next')}" 
     prev="${message(code:'navigation.prev')}"
     breadcrumb="true" controller="championship" 
     action="getparties" total="${total}" id="${championshipId}" />
       
  <g:partiesTable parties="${parties}" playersScores="${playersScores}" />
          
  </div>        
</g:if>
<g:else>
  <g:message code="championship.no_parties" />
</g:else>
          