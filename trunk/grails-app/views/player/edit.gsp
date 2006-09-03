
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Edition d'un joueur</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Accueil</a></span>
            <span class="menuButton"><g:link action="list">Liste des joueurs</g:link></span>
            <span class="menuButton"><g:link action="create">Nouveau joueur</g:link></span>
        </div>
        <div class="body">
           <h1>Edition d'un joueur</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <g:hasErrors bean="${player}">
                <div class="errors">
                    <g:renderErrors bean="${player}" as="list" />
                </div>
           </g:hasErrors>
           <div class="prop">
	      <span class="name">Id:</span>
	      <span class="value">${player?.id}</span>
	      <input type="hidden" name="player.id" value="${player?.id}" />
           </div>           
           <g:form controller="player" method="post" >
               <input type="hidden" name="id" value="${player?.id}" />
               <div class="dialog">
                <table>
  				  <tr class='prop'><td valign='top' class='name'><label for='email'>Email :</label></td><td valign='top' class='value ${hasErrors(bean:player,field:'email','errors')}'><input type='text' name='email' value='${player?.email}' /></td></tr>
				  <tr class='prop'><td valign='top' class='name'><label for='login'>Login :</label></td><td valign='top' class='value ${hasErrors(bean:player,field:'login','errors')}'><input type='text' name='login' value='${player?.login}' /></td></tr>
				  <tr class='prop'><td valign='top' class='name'><label for='password'>Password :</label></td><td valign='top' class='value ${hasErrors(bean:player,field:'password','errors')}'><input type='password' name='password' value='${player?.password}' /></td></tr>
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
            