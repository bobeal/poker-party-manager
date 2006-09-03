
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Edit Party</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link action="list">Party List</g:link></span>
            <span class="menuButton"><g:link action="create">New Party</g:link></span>
        </div>
        <div class="body">
           <h1>Edit Party</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <g:hasErrors bean="${party}">
                <div class="errors">
                    <g:renderErrors bean="${party}" as="list" />
                </div>
           </g:hasErrors>
           <div class="prop">
	         <input type="hidden" name="party.id" value="${party?.id}" />
           </div>           
           <g:form controller="party" method="post" >
               <input type="hidden" name="id" value="${party?.id}" />
               <div class="dialog">
                <table>

                       
                       
				<tr class='prop'><td valign='top' class='name'><label for='championship'>Championship:</label></td><td valign='top' class='value ${hasErrors(bean:party,field:'championship','errors')}'><g:select optionKey="id" from="${Championship.list()}" name='championship.id' value='${party?.championship?.id}'></g:select></td></tr>
                       
				<tr class='prop'><td valign='top' class='name'><label for='date'>Date:</label></td><td valign='top' class='value ${hasErrors(bean:party,field:'date','errors')}'><g:datePicker name='date' value='${party?.date}'></g:datePicker></td></tr>
                       
				<tr class='prop'><td valign='top' class='name'><label for='place'>Place:</label></td><td valign='top' class='value ${hasErrors(bean:party,field:'place','errors')}'><input type='text' name='place' value='${party?.place}' /></td></tr>
                       
				<tr class='prop'><td valign='top' class='name'><label for='scores'>Scores:</label></td><td valign='top' class='value ${hasErrors(bean:party,field:'scores','errors')}'><ul>
    <g:each var='s' in='${party?.scores?}'>
        <li><g:link controller='score' action='show' id='${s.id}'>${s}</g:link></li>
    </g:each>
</ul>
<g:link controller='score' params='["party.id":party?.id]' action='create'>Add Score</g:link>
</td></tr>
                       
                </table>
               </div>

               <div class="buttons">
                     <span class="button"><g:actionSubmit value="Update" /></span>
                     <span class="button"><g:actionSubmit value="Delete" /></span>
               </div>
            </g:form>
            
            <g:form controller="score" action="save" method="post" >
               <div class="dialog">
                <table>
                  <tr class='prop'><td valign='top' class='name'><label for='party'>Party:</label></td><td valign='top' class='value ${hasErrors(bean:score,field:'party','errors')}'><g:select optionKey="id" from="${Party.list()}" name='party.id' value='${score?.party?.id}'></g:select></td></tr>
                  <tr class='prop'><td valign='top' class='name'><label for='player'>Player:</label></td><td valign='top' class='value ${hasErrors(bean:score,field:'player','errors')}'><g:select optionKey="id" from="${Player.list()}" name='player.id' value='${score?.player?.id}'></g:select></td></tr>
                  <tr class='prop'><td valign='top' class='name'><label for='points'>Points:</label></td><td valign='top' class='value ${hasErrors(bean:score,field:'points','errors')}'><input type='text' name='points' value='${score?.points}'></input></td></tr>
                  <tr class='prop'><td valign='top' class='name'><label for='refunds'>Refunds:</label></td><td valign='top' class='value ${hasErrors(bean:score,field:'refunds','errors')}'><input type='text' name='refunds' value='${score?.refunds}'></input></td></tr>
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
            