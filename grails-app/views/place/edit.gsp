
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Edit Place</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link action="list">Place List</g:link></span>
            <span class="menuButton"><g:link action="create">New Place</g:link></span>
        </div>
        <div class="body">
           <h1>Edit Place</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <g:hasErrors bean="${place}">
                <div class="errors">
                    <g:renderErrors bean="${place}" as="list" />
                </div>
           </g:hasErrors>
           <div class="prop">
	      <span class="name">Id:</span>
	      <span class="value">${place?.id}</span>
	      <input type="hidden" name="place.id" value="${place?.id}" />
           </div>           
           <g:form controller="place" method="post" >
               <input type="hidden" name="id" value="${place?.id}" />
               <div class="dialog">
                <table>

                       
                       
				<tr class='prop'><td valign='top' class='name'><label for='name'>Name:</label></td><td valign='top' class='value ${hasErrors(bean:place,field:'name','errors')}'><input type="text" maxlength='20' name='name' value='${place?.name}'></input></td></tr>
                       
				<tr class='prop'><td valign='top' class='name'><label for='description'>Description:</label></td><td valign='top' class='value ${hasErrors(bean:place,field:'description','errors')}'><input type='text' name='description' value='${place?.description}' /></td></tr>
                       
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
            