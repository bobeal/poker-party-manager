
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Party List</title>
    </head>
    <body>
        <div class="body">
           <h1>Party List</h1>
            <g:if test="${flash.message}">
                 <div class="message">
                       ${flash.message}
                 </div>
            </g:if>
           <table>
               <tr>
                   
                                      
                        <th>Id</th>
                                      
                        <th>Championship</th>
                                      
                        <th>Date</th>
                                      
                        <th>Place</th>
                   
                   <th></th>
               </tr>
               <g:each in="${partyList}">
                    <tr>
                       
                            <td>${it.id}</td>
                       
                            <td>${it.championship}</td>
                       
                            <td>${it.date}</td>
                       
                            <td>${it.place}</td>
                       
                       <td class="actionButtons">
                            <span class="actionButton"><g:link action="show" id="${it.id}">Show</g:link></span>
                       </td>
                    </tr>
               </g:each>
           </table>
        </div>
    </body>
</html>
            