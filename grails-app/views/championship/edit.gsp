
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Edition d'un championnat</title>
    </head>
    <body>
        <div class="body">
           <h1>Edition d'un championnat</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <g:hasErrors bean="${championship}">
                <div class="errors">
                    <g:renderErrors bean="${championship}" as="list" />
                </div>
           </g:hasErrors>
           <div class="prop">
	      <input type="hidden" name="championship.id" value="${championship?.id}" />
           </div>           
           <g:form controller="championship" method="post" >
               <input type="hidden" name="id" value="${championship?.id}" />
               <div class="dialog">
                <table>
				  <tr class='prop'>
				    <td valign='top' class='name'>
				      <label for='label'>Label :</label>
				    </td>
				    <td valign='top' class='value ${hasErrors(bean:championship,field:'label','errors')}'>
				      <input type='text' name='label' value='${championship?.label}' />
				    </td>
				  </tr>
				  <tr class='prop'>
				    <td valign='top' class='name'>
				      <label for='startDate'>Date de début :</label>
				    </td>
				    <td valign='top' class='value ${hasErrors(bean:championship,field:'startDate','errors')}'>
				      <g:datePicker name='startDate' value='${championship?.startDate}'></g:datePicker>
				    </td>
				  </tr>
				  <tr class='prop'>
				    <td valign='top' class='name'>
				      <label for='endDate'>Date de fin :</label>
				    </td>
				    <td valign='top' class='value ${hasErrors(bean:championship,field:'endDate','errors')}'>
				      <g:datePicker name='endDate' value='${championship?.endDate}'></g:datePicker>
				    </td>
				  </tr>
				  <tr class='prop'><td valign='top' class='name'><label for='parties'>Parties:</label></td><td valign='top' class='value ${hasErrors(bean:championship,field:'parties','errors')}'><ul>
    <g:each var='p' in='${championship?.parties?}'>
        <li><g:link controller='party' action='show' id='${p.id}'>${p}</g:link></li>
    </g:each>
</ul>
<g:link controller='party' params='["championship.id":championship?.id]' action='create'>Add Party</g:link>
</td></tr>
                       
                       
                </table>
               </div>

               <div class="buttons">
                     <span class="button"><g:actionSubmit value="Update" /></span>
                     <span class="button"><g:actionSubmit value="Delete" /></span>
               </div>
            </g:form>
        </div>
    </body>
</html>
            