
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Place List</title>
    </head>
    <body>
        <div class="body">
           <h1>Place List</h1>
            <g:if test="${flash.message}">
                 <div class="message">
                       ${flash.message}
                 </div>
            </g:if>
           <table>
               <tr>
                   
                                      
                        <th>Id</th>
                                      
                        <th>Name</th>
                                      
                        <th>Description</th>
                   
                   <th></th>
               </tr>
               <g:each in="${placeList}">
                    <tr>
                       
                            <td>${it.id}</td>
                       
                            <td>${it.name}</td>
                       
                            <td>${it.description}</td>
                       
                       <td class="actionButtons">
                            <span class="actionButton"><g:link action="show" id="${it.id}">Show</g:link></span>
                       </td>
                    </tr>
               </g:each>
           </table>
        </div>
    </body>
</html>
            