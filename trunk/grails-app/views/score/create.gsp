
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Create Score</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link action="list">Score List</g:link></span>
        </div>
        <div class="body">
           <h1>Create Score</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <g:hasErrors bean="${score}">
                <div class="errors">
                    <g:renderErrors bean="${score}" as="list" />
                </div>
           </g:hasErrors>
           <g:form action="save" method="post" >
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
            