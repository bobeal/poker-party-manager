
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Score List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link action="create">New Score</g:link></span>
        </div>
        <div class="body">
           <h1>Score List</h1>
            <g:if test="${flash.message}">
                 <div class="message">
                       ${flash.message}
                 </div>
            </g:if>
           <table>
               <tr>
                   
                                      
                        <th>Id</th>
                                      
                        <th>Party</th>
                                      
                        <th>Player</th>
                                      
                        <th>Points</th>
                                      
                        <th>Refunds</th>
                   
                   <th></th>
               </tr>
               <g:each in="${scoreList}">
                    <tr>
                       
                            <td>${it.id}</td>
                       
                            <td>${it.party}</td>
                       
                            <td>${it.player}</td>
                       
                            <td>${it.points}</td>
                       
                            <td>${it.refunds}</td>
                       
                       <td class="actionButtons">
                            <span class="actionButton"><g:link action="show" id="${it.id}">Show</g:link></span>
                       </td>
                    </tr>
               </g:each>
           </table>
        </div>
    </body>
</html>
            