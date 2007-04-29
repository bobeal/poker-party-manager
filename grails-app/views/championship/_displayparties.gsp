<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<g:if test="${parties.size() > 0 }">
        
  <g:ajaxPaginate next="${message(code:'navigation.next')}" 
     prev="${message(code:'navigation.prev')}"
     breadcrumb="true" controller="championship" 
     action="getparties" total="${total}" id="${championshipId}"
     remote="true" remoteUpdate="partiestab" />
       
  <g:partiesTable parties="${parties}" playersScores="${playersScores}" />
          
</g:if>
<g:else>
  <g:message code="championship.no_parties" />
</g:else>
          