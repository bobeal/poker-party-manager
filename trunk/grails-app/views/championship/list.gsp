
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Liste des championnats</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Accueil</a></span>
            <span class="menuButton"><g:link action="create">Nouveau championnat</g:link></span>
        </div>
        <div class="body">
           <h1>Liste des championnats</h1>
            <g:if test="${flash.message}">
                 <div class="message">
                       ${flash.message}
                 </div>
            </g:if>
           <table>
               <tr>
                        <th>Id</th>
                        <th>Label</th>
                        <th>Date de d�but</th>
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
                            <span class="actionButton"><g:link action="show" id="${it.id}">Voir</g:link></span>
                       </td>
                    </tr>
               </g:each>
           </table>
        </div>
    </body>
</html>
            