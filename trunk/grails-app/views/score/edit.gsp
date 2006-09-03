
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Edit Score</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link action="list">Score List</g:link></span>
            <span class="menuButton"><g:link action="create">New Score</g:link></span>
        </div>
        <div class="body">
           <h1>Edit Score</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <g:hasErrors bean="${score}">
                <div class="errors">
                    <g:renderErrors bean="${score}" as="list" />
                </div>
           </g:hasErrors>
           <div class="prop">
	      <span class="name">Id:</span>
	      <span class="value">${score?.id}</span>
	      <input type="hidden" name="score.id" value="${score?.id}" />
           </div>           
           <g:form controller="score" method="post" >
               <input type="hidden" name="id" value="${score?.id}" />
               <div class="dialog">
                <table>

                       
                       
				<tr class='prop'><td valign='top' class='name'><label for='party'>Party:</label></td><td valign='top' class='value ${hasErrors(bean:score,field:'party','errors')}'><g:select optionKey="id" from="${Party.list()}" name='party.id' value='${score?.party?.id}'></g:select></td></tr>
                       
				<tr class='prop'><td valign='top' class='name'><label for='player'>Player:</label></td><td valign='top' class='value ${hasErrors(bean:score,field:'player','errors')}'><g:select optionKey="id" from="${Player.list()}" name='player.id' value='${score?.player?.id}'></g:select></td></tr>
                       
				<tr class='prop'><td valign='top' class='name'><label for='points'>Points:</label></td><td valign='top' class='value ${hasErrors(bean:score,field:'points','errors')}'><input type='text' name='points' value='${score?.points}'></input></td></tr>
                       
				<tr class='prop'><td valign='top' class='name'><label for='refunds'>Refunds:</label></td><td valign='top' class='value ${hasErrors(bean:score,field:'refunds','errors')}'><input type='text' name='refunds' value='${score?.refunds}'></input></td></tr>
                       
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
            