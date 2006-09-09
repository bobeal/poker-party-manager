
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
         <meta name="layout" content="main" />
         <title>Create Place</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link action="list">Place List</g:link></span>
        </div>
        <div class="body">
           <h1>Create Place</h1>
           <g:if test="${flash.message}">
                 <div class="message">${flash.message}</div>
           </g:if>
           <g:hasErrors bean="${place}">
                <div class="errors">
                    <g:renderErrors bean="${place}" as="list" />
                </div>
           </g:hasErrors>
           <g:form action="save" method="post" >
               <div class="dialog">
                <table>
                  <tr class='prop'>
                    <td valign='top' class='name'><label for='name'>Name:</label></td>
                    <td valign='top' class='value ${hasErrors(bean:place,field:'name','errors')}'><input type="text" size='40' maxlength='40' name='name' value='${place?.name}'></input></td></tr>
                  <tr class='prop'>
                    <td valign='top' class='name'><label for='description'>Description:</label></td>
                    <td valign='top' class='value ${hasErrors(bean:place,field:'description','errors')}'><input type='text' size='100' name='description' value='${place?.description}' /></td></tr>
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
            