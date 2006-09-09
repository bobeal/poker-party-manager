
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Ajout d'une partie</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Accueil</a></span>
            <span class="menuButton"><g:link action="list">Liste des parties</g:link></span>
        </div>
        <div class="body">
           <h1>Ajout d'une partie au championnat </h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <g:hasErrors bean="${party}">
                <div class="errors">
                    <g:renderErrors bean="${party}" as="list" />
                </div>
           </g:hasErrors>
           <g:form action="save" method="post" >
           	   <input type="hidden" name="championship.id" value="${params['championship.id']}"/>
               <div class="dialog">
                <table>
                  <tr class='prop'>
                    <td valign='top' class='name'>
                      <label for='date'>Date :</label>
                    </td>
                    <td valign='top' class='value ${hasErrors(bean:party,field:'date','errors')}'>
                      <g:datePicker name='date' value='${party?.date}'></g:datePicker>
                    </td>
                  </tr>
                  <tr class='prop'>
                    <td valign='top' class='name'>
                      <label for='place'>Lieu :</label>
                    </td>
                    <td valign='top' class='value ${hasErrors(bean:party,field:'place','errors')}'>
                      <g:select optionKey="id" optionValue="name" from="${Place.list()}" name='place.id'></g:select>
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
            