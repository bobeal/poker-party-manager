
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Create Player</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link action="list">Player List</g:link></span>
        </div>
        <div class="body">
           <h1>Create Player</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <g:hasErrors bean="${player}">
                <div class="errors">
                    <g:renderErrors bean="${player}" as="list" />
                </div>
           </g:hasErrors>
           <g:form action="save" method="post" >
               <div class="dialog">
                <table>

                       
                       
                                  <tr class='prop'><td valign='top' class='name'><label for='email'>Email:</label></td><td valign='top' class='value ${hasErrors(bean:player,field:'email','errors')}'><input type='text' name='email' value='${player?.email}' /></td></tr>
                       
                                  <tr class='prop'><td valign='top' class='name'><label for='login'>Login:</label></td><td valign='top' class='value ${hasErrors(bean:player,field:'login','errors')}'><input type='text' name='login' value='${player?.login}' /></td></tr>
                       
                                  <tr class='prop'><td valign='top' class='name'><label for='password'>Password:</label></td><td valign='top' class='value ${hasErrors(bean:player,field:'password','errors')}'><input type='text' name='password' value='${player?.password}' /></td></tr>
                       
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
            