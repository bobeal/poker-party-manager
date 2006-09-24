
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
          <meta name="layout" content="main" />
         <title>Show Party</title>
    </head>
    <body>
        <div class="body">
           <h1>Show Party</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <div class="dialog">
                 <table>
                   
                   
                        <tr class="prop">
                              <td valign="top" class="name">Id:</td>
                              
                                    <td valign="top" class="value">${party.id}</td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Championship:</td>
                              
                                    <td valign="top" class="value"><g:link controller="championship" action="show" id="${party?.championship?.id}">${party?.championship?.label}</g:link></td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Date:</td>
                              
                                    <td valign="top" class="value">${party.date}</td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Place:</td>
                              
                                    <td valign="top" class="value">${party.place}</td>
                              
                        </tr>
                   
                        <tr class="prop">
                              <td valign="top" class="name">Scores:</td>
                              
                                     <td  valign="top" style="text-align:left;" class="value">
                                        <ul>
                                            <g:each var="s" in="${party.scores}">
                                                <li><g:link controller="score" action="show" id="${s.id}">${s}</g:link></li>
                                            </g:each>
                                        </ul>
                                     </td>
                              
                        </tr>
                   
                 </table>
           </div>
           <div class="buttons">
               <g:form controller="party">
                 <input type="hidden" name="id" value="${party?.id}" />
                 <span class="button"><g:actionSubmit value="Edit" /></span>
                 <span class="button"><g:actionSubmit value="Delete" /></span>
               </g:form>
           </div>
        </div>
    </body>
</html>
            