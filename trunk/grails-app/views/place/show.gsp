
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
          <meta name="layout" content="main" />
         <title>Show Place</title>
    </head>
    <body>
        <div class="body">
           <h1>Show Place</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <div class="dialog">
                 <table>
                   
                   
                        <tr class="prop">
                              <td valign="top" class="name">Id:</td>
                              
                                    <td valign="top" class="value">${place.id}</td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Name:</td>
                              
                                    <td valign="top" class="value">${place.name}</td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Description:</td>
                              
                                    <td valign="top" class="value">${place.description}</td>
                              
                        </tr>
                   
                 </table>
           </div>
           <div class="buttons">
               <g:form controller="place">
                 <input type="hidden" name="id" value="${place?.id}" />
                 <span class="button"><g:actionSubmit value="Edit" /></span>
                 <span class="button"><g:actionSubmit value="Delete" /></span>
               </g:form>
           </div>
        </div>
    </body>
</html>
            