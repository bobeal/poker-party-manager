
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Création d'un championnat</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Accueil</a></span>
            <span class="menuButton"><g:link action="list">Liste des championnats</g:link></span>
        </div>
        <div class="body">
           <h1>Création d'un championnat</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <g:hasErrors bean="${championship}">
                <div class="errors">
                    <g:renderErrors bean="${championship}" as="list" />
                </div>
           </g:hasErrors>
           <g:form action="save" method="post" >
               <div class="dialog">
                <table>
                  <tr class='prop'>
                    <td valign='top' class='name'>
                      <label for='label'>Label :</label>
                    </td>
                    <td valign='top' class='value ${hasErrors(bean:championship,field:'label','errors')}'><input type='text' name='label' value='${championship?.label}' />
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
               </table>
               </div>
               <div class="buttons">
                     <span class="formButton">
                        <input type="submit" value="Create"></input>
                     </span>
               </div>
            </g:form>
        </div>
    </body>
</html>
            