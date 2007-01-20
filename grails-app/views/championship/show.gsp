<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'ajaxtabs.css')}" />
        <title>Poker Party Manager - <g:message code="championship.view_page"/></title>
        <g:javascript src="ajaxtabs.js" />
    </head>
    <body>
      <form>

        <fieldset>
          <legend><g:message code="championship.view_page"/></legend>

          <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
          </g:if>

          <label><g:message code="championship.label"/> :</label>
          ${championship.label}
          <br/>
          
          <label><g:message code="championship.start_date"/> :</label>
          ${championship.startDate}
          <br/>
          
          <label><g:message code="championship.end_date"/> :</label>
          ${championship.endDate}
          <br/>

          <label><g:message code="championship.admins"/> :</label>
          <g:each in="${championship.admins}" var="admin">
            ${admin.login}&nbsp;
          </g:each>

        </fieldset>
      </form>
           <!-- 
           <div class="buttons">
               <g:form controller="championship">
                 <input type="hidden" name="id" value="${championship?.id}" />
                 <span class="button"><g:actionSubmit value="Edit" /></span>
                 <span class="button"><g:actionSubmit value="Delete" /></span>
               </g:form>
           </div>
           -->
           
        <br/><br/>

        <!--  TODO : add a test to only display if sthg to -->           

           
        <ul id="maintab" class="shadetabs">
  		  <li class="selected">
  		    <a href="#default" rel="partiestab">
  		      <g:message code="championship.parties"/>
  		    </a>
  		  </li>
		  <li>
		    <a href="${createLink(action:'gettable',id:championship.id)}" rel="partiestab">
  		      <g:message code="championship.positions"/>
		    </a>
		  </li>
          <li>
            <a href="${createLink(controller:'party',action:'create',id:championship.id)}" rel="partiestab">
              <g:message code="championship.add_party"/>
            </a>
          </li>
          <li style="display:none;" id="entry_menu_edit_party">
            <a id="menu_edit_party" href="javascript:void(0);" rel="partiestab">
              <g:message code="championship.party_edition"/>
            </a>
          </li>
        </ul>

        <div class="embed" id="partiestab">
          <table>
            <tr>
              <th class="embed"><g:message code="party.place"/></th>
              <th class="embed"><g:message code="party.date"/></th>
              <g:each var="player" in="${Player.list()}">
               	<th class="embed">${player.login}</th>
              </g:each>
              <th></th>
            </tr>
            <g:partiesTable parties="${Party.findAllByChampionship(championship, [sort:'date',order:'desc'] )}"/>
          </table>
        </div>

      <script type="text/javascript">
        startajaxtabs("maintab");
      </script>

        
    </body>
</html>
