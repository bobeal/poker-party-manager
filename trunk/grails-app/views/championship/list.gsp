<html>
    <head>
         <meta name="layout" content="main" />
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <title>Poker Party Manager - <g:message code="championship.list_page"/></title>
    </head>
    <body>
        <div class="body">
           <h1><g:message code="championship.list_page"/></h1>
            <g:if test="${flash.message}">
                 <div class="message"><g:message code="${flash.message}"/></div>
            </g:if>
           <table>
               <tr>
                   <th><g:message code="championship.label"/></th>
                   <th><g:message code="championship.start_date"/></th>
                   <th><g:message code="championship.end_date"/></th>
                   <th></th>
               </tr>
               <g:each in="${championshipList}">
                    <tr>
                       <td>${it.label}</td>
                       <td>${it.startDate}</td>
                       <td>${it.endDate}</td>
                       <td class="actionButtons">
                         <span class="actionButton">
                           <g:link action="show" id="${it.id}">
                             <g:message code="action.show"/>
                           </g:link>
                         </span>
                         <br/>
                         <span class="actionButton">
                           <g:link controller='party' 
                                   params='["championship.id":it.id]' 
                                   action='create'>
                             <g:message code="championship.add_party"/>
                           </g:link>
                         </span>
						 <br/>
                         <span class="actionButton">
                           <g:link controller="party" action="invite" id="${it.id}">
                             <g:message code="party.invite"/>
                           </g:link>
                         </span>
                       </td>
                    </tr>
               </g:each>
           </table>
        </div>
    </body>
</html>
            