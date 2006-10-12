
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Liste des joueurs</title>
    </head>
    <body>
        <div class="body">
           <h1>Liste des joueurs</h1>
            <g:if test="${flash.message}">
                 <div class="message">
                       ${flash.message}
                 </div>
            </g:if>
           <table>
               <tr>
                 <th>Login</th>
                 <th>Email</th>
                 <th></th>
               </tr>
               <g:each in="${playerList}">
                    <tr>
                      <td>${it.login}</td>
                      <td>${it.email}</td>
                       <td class="actionButtons">
                            <span class="actionButton"><g:link action="show" id="${it.id}">Détails</g:link></span>
                       </td>
                    </tr>
               </g:each>
           </table>
        </div>
    </body>
</html>
            