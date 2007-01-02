<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Poker Party Manager - <g:message code="player.my_page"/></title>
         <g:javascript library="prototype"/>
         <script type="text/javascript">
         	function escapeHTML(data) {
         		return data.escapeHTML()
          	}
         </script>
    </head>
    <body>
        <div class="body">
           <h1><g:message code="player.my_page"/></h1>
           <g:if test="${flash.message}">
             <div class="message">${flash.message}</div>
           </g:if>
           <g:hasErrors bean="${player}">
             <div class="errors">
               <g:renderErrors bean="${player}" as="list" />
             </div>
           </g:hasErrors>
           <g:form method="post" enctype="multipart/form-data">
             <input type="hidden" name="id" value="${player?.id}" />
             <div class="dialog">
               <table>
				 <tr class='prop'>
				   <td valign='top' class='name'>
				     <label for='login'><g:message code="player.login"/>  :</label>
				   </td>
				   <td valign='top' class='value ${hasErrors(bean:player,field:'login','errors')}'>
				     <input type='text' name='login' value='${player?.login}' />
				   </td>
				 </tr>
				 <tr class='prop'>
				   <td valign='top' class='name'>
				     <label for='password'><g:message code="player.password"/>  :</label>
				   </td>
				   <td valign='top' class='value ${hasErrors(bean:player,field:'newPassword','errors')}'>
				     <input type='password' name='newPassword' />
				   </td>
				 </tr>
			     <tr class='prop'>
			       <td valign='top' class='name'>
			         <label for='email'><g:message code="player.email"/>  :</label>
			       </td>
			       <td valign='top' class='value ${hasErrors(bean:player,field:'email','errors')}'>
			         <input type='text' name='email' size="50" value='${player?.email}' />
			       </td>
			     </tr>
			     <tr class='prop'>
			       <td valign='top' class='name'>
			         <label for='photo'><g:message code="player.photo"/>  :</label>
			       </td>
			       <td valign='top' class='value ${hasErrors(bean:player,field:'photo','errors')}'>
			       	 <g:if test="${player?.photo}">
  		       		   <img src="${createLink(action:'getPhotoData',id:player?.id)}"/>
  		       		 </g:if>
			       	 <br/>
			         <input type="file" name="photo" />
			       </td>
			     </tr>
				 <tr class='prop'>
				   <td valign='top' class='name'>
				     <label for='favoriteHand'><g:message code="player.favorite_hand"/> :</label>
				   </td>
				   <td valign='top' class='value ${hasErrors(bean:player,field:'favoriteHand','errors')}'>
				     <input type='text' name='favoriteHand' value='<g:escapeHTML data="${player?.favoriteHand}"/>' />
				   </td>
				 </tr>
				 <tr class='prop'>
				   <td valign='top' class='name'>
				     <label for='favoriteQuote'><g:message code="player.favorite_quote"/> :</label>
				   </td>
				   <td valign='top' class='value ${hasErrors(bean:player,field:'favoriteQuote','errors')}'>
				     <input type='text' size='100' name='favoriteQuote' value='<g:escapeHTML data="${player?.favoriteQuote}"/>' />
				   </td>
				 </tr>
				 <tr class='prop'>
				   <td valign='top' class='name'>
				     <label for='amulet'><g:message code="player.amulet"/> :</label>
				   </td>
				   <td valign='top' class='value ${hasErrors(bean:player,field:'amulet','errors')}'>
				     <input type='text' size='50' name='amulet' value='<g:escapeHTML data="${player?.amulet}"/>' />
				   </td>
				 </tr>
			     <tr class='prop'>
			       <td valign='top' class='name'>
			         <label for='isSuperAdmin'><g:message code="player.is_super_admin"/>  :</label>
			       </td>
			       <td valign='top' class='value'>
			         <g:checkBox name='isSuperAdmin' value='${player?.isSuperAdmin}' />
			       </td>
			     </tr>
			     <tr class='prop'>
			       <td valign='top' class='name'>
			         <label for='canManageChampionship'>
			         	<g:message code="player.can_manage_championship"/>  :</label>
			       </td>
			       <td valign='top' class='value'>
			         <g:checkBox name='canManageChampionship' value='${player?.canManageChampionship}' />
			       </td>
			     </tr>
               </table>
             </div>
             <div class="buttons">
               <span class="button"><g:actionSubmit value="Update" /></span>
             </div>
           </g:form>
        </div>
    </body>
</html>