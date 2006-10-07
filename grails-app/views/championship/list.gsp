<html>
    <head>
         <meta name="layout" content="main" />
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <title>Liste des championnats</title>
    </head>
    <body>
        <div class="body">
           <h1>Liste des championnats</h1>
            <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
            </g:if>
           <table>
               <tr>
                   <th>Id</th>
                   <th>Label</th>
                   <th>Date de début</th>
                   <th>Date de fin</th>
                   <th></th>
               </tr>
               <g:each in="${championshipList}">
                    <tr>
                       <td>${it.id}</td>
                       <td>${it.label}</td>
                       <td>${it.startDate}</td>
                       <td>${it.endDate}</td>
                       <td class="actionButtons">
                            <span class="actionButton">
                              <g:link action="show" id="${it.id}">Voir</g:link>
                            </span>
                            <br/>
                            <span class="actionButton">
                              <g:link controller='party' 
                                params='["championship.id":it.id]' 
                                action='create'>Ajouter une partie</g:link>
                            </span>
                       </td>
                    </tr>
               </g:each>
           </table>
        </div>
    </body>
</html>
            