<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<html>
    <head>
        <meta name="layout" content="main">
        <title>Poker Party Manager - <g:message code="championship.view_page"/></title>
        <!-- Tab View CSS -->
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.2.2/build/tabview/assets/tabview.css">
        <!-- optional skin for border tabs -->
        <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.2.2/build/tabview/assets/border_tabs.css">
        
        <!-- Required for dynamic loading of data -->
        <script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/connection/connection-min.js"></script>
        <!-- Tab View JS -->
        <script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/tabview/tabview-min.js"></script>
        <style type="text/css">
          #championshipMenu .loading {
            background-image:url(${createLinkTo(dir:'images',file:'spinner.gif')});
            background-position:center center;
            background-repeat:no-repeat;
          }
          /*
          #championshipMenu .loading * {
            display:none;
          }
          */
        </style>
        <script type="text/javascript">
          var tabView = new YAHOO.widget.TabView({id: 'championshipMenu'});

          YAHOO.example.init = function() {
    
            tabView.addTab(new YAHOO.widget.Tab({
              label: '<g:message code="championship.positions"/>',
              dataSrc: '${createLink(action:"getstandings",id:championship.id)}',
              active: true,
              cacheData: false
            }));
    
            tabView.addTab(new YAHOO.widget.Tab({
              label: '<g:message code="championship.elite_positions"/>',
              dataSrc: '${createLink(action:"getelitestandings",id:championship.id)}',
              cacheData: false
            }));
    
            tabView.addTab(new YAHOO.widget.Tab({
              label: '<g:message code="championship.parties"/>',
              dataSrc: '${createLink(action:"getparties",id:championship.id)}',
              cacheData: false
            }));
    
            var createPartyTab = new YAHOO.widget.Tab({
              label: '<g:message code="championship.add_party"/>',
              dataSrc: '${createLink(controller:"party",action:"create",id:championship.id)}',
              cacheData: false
            })
            tabView.addTab(createPartyTab);
            
            // decorate submit button of the "create party" tab
            var handleContentChange = function(e) {
              onSubmitButtonsMarkupReady('wrappedSubmit','submit');
            }
            createPartyTab.addListener('contentChange', handleContentChange); 
    
            YAHOO.util.Event.onContentReady('tabContent', function() {
              tabView.appendTo('tabContent');
            });

            // remove 'edit party' tab when leaving it
            var handleTabChange = function(e) {
              if (tabView.getTabIndex(e.prevValue) == 3) {
                tabView.removeTab(e.prevValue);
              }
            };
    
            tabView.on('activeTabChange', handleTabChange);
          };

          YAHOO.example.init();
          
          function openEditPartyTab(label, dataSrc) {
            var editPartyTab = new YAHOO.widget.Tab({
              label: label,
              dataSrc: dataSrc,
              active: true
            });
            tabView.addTab(editPartyTab,3);

            // decorate submit button of the "edit party" tab
            // FIXME : duplicate with what is done in edit_embed.gsp
            var handleContentChange = function(e) {
              onSubmitButtonsMarkupReady('wrappedPartySubmit','partySubmit');
              onSubmitButtonsMarkupReady('wrappedScoreSubmit','scoreSubmit');
            }
            editPartyTab.addListener('contentChange', handleContentChange); 
          }
        </script> 
    </head>
    <body>
      <form>

        <fieldset>
          <legend><g:message code="championship.view_page"/></legend>

          <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" /></div>
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

      <br/><br/>

      <div id="tabContent">
      </div>
              
    </body>
</html>
