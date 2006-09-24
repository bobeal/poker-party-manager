<html>
	<head>
		<title><g:layoutTitle default="Poker Party Manager" /></title>
		<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}"></link>
		<link rel="stylesheet" href="${createLinkTo(dir:'js/yahoo-full/assets',file:'menu.css')}"></link>
		<g:javascript library="yahoofull" />
        <script type="text/javascript">
            // "load" handler for the window
            YAHOO.example.onWindowLoad = function(p_oEvent) {
                // Hides submenus of the root Menubar instance
                function hideSubmenus() {
                    if(oMenuBar.activeItem) {
                        var oSubmenu = oMenuBar.activeItem.cfg.getProperty("submenu");
                        if(oSubmenu) {
                            oSubmenu.hide();
                        }
                    }

                }    

                // Cancels the call to "hideSubmenus"
                function cancelTimer() {
                    if(nTimeoutId) {
                       window.clearTimeout(nTimeoutId);
                    }
                }
    
                // "mouseout" event handler for each submenu of the menubar
                function onSubmenuMouseOut(p_sType, p_aArguments, p_oMenu) {
                    cancelTimer();
                    nTimeoutId = window.setTimeout(hideSubmenus, 750);
                }
    
                // "mouseover" handler for each item in the menubar
                function onMenuBarItemMouseOver(p_sType, p_aArguments, p_oMenuItem) {
                    var oActiveItem = this.parent.activeItem;
                    // Hide any other submenus that might be visible
                    if(oActiveItem && oActiveItem != this) {
                        this.parent.clearActiveItem();
                    }
                
                    // Select and focus the current MenuItem instance
                    this.cfg.setProperty("selected", true);
                    this.focus();
                
                    // Show the submenu for this instance
                    var oSubmenu = this.cfg.getProperty("submenu");
                    if(oSubmenu) {
                        oSubmenu.show();
                    }
                }
    
                // "mouseout" handler for each item in the menubar
                function onMenuBarItemMouseOut(p_sType, p_aArguments, p_oMenuItem) {
                    this.cfg.setProperty("selected", false);
                    var oSubmenu = this.cfg.getProperty("submenu");
                    if(oSubmenu) {
                        var oDOMEvent = p_aArguments[0],
                            oRelatedTarget = YAHOO.util.Event.getRelatedTarget(oDOMEvent);
                        if(
                            !(
                                oRelatedTarget == oSubmenu.element || 
                                this._oDom.isAncestor(oSubmenu.element, oRelatedTarget)
                            )
                        ) {
                            oSubmenu.hide();
                        }
                    }
                }

                var nTimeoutId;

                // Instantiate and render the menubar and corresponding submenus
                var oMenuBar = new YAHOO.widget.MenuBar("menu", { submenualignment: ["tl","bl"]} );
                oMenuBar.render();

                // Add a "mouseover" and "mouseout" event handler each item 
                // in the menu bar 

                var aMenuBarItems = oMenuBar.getItemGroups()[0],
                    i = aMenuBarItems.length - 1;

                do {
                    aMenuBarItems[i].mouseOverEvent.subscribe(onMenuBarItemMouseOver);
                    aMenuBarItems[i].mouseOutEvent.subscribe(onMenuBarItemMouseOut);
                }
                while(i--);


                // Assign event handlers

                // Add a "mouseover" handler to the menubar

                oMenuBar.mouseOverEvent.subscribe(cancelTimer);

                var oChampionship = oMenuBar.getItem(0).cfg.getProperty("submenu"),
                    oPlayer = oMenuBar.getItem(1).cfg.getProperty("submenu"),
                    oPlace = oMenuBar.getItem(2).cfg.getProperty("submenu");

                // Add a "mouseover" event handler to each submenu
                oChampionship.mouseOverEvent.subscribe(cancelTimer);
                oPlayer.mouseOverEvent.subscribe(cancelTimer);
                oPlace.mouseOverEvent.subscribe(cancelTimer);

                // Add a "mouseout" event handler to each submenu
                oChampionship.mouseOutEvent.subscribe(onSubmenuMouseOut, oChampionship, true);
                oPlayer.mouseOutEvent.subscribe(onSubmenuMouseOut, oPlayer, true);
                oPlace.mouseOutEvent.subscribe(onSubmenuMouseOut, oPlace, true);


                // Add a "click" handler to the document
                YAHOO.util.Event.addListener(document, "click", hideSubmenus);
            }

            // Add a "load" handler for the window
            YAHOO.util.Event.addListener(window, "load", YAHOO.example.onWindowLoad);
        </script>
		<g:layoutHead />
	</head>
	<body onload="<g:pageProperty name='body.onload'/>">
        <div class="logo">
        	<img src="${createLinkTo(dir:'images',file:'grails_logo.jpg')}" alt="Poker" />
        </div>
		<div class="userInfo">
		  ${session?.user?.login} - <a href="${createLink(controller:'player',action:'logout')}">Déconnexion</a>
    	</div>
		<div class="yuimenubar" id="menu">
			<div class="bd">
			<ul class="first-of-type">
				<li class="yuimenubaritem first-of-type">
					<g:link controller="championship">Championnats</g:link>
					<div id="championship" class="yuimenu">
                      <div class="bd">
					    <ul>
						  <li class="yuimenuitem">
						    <a href="${createLink(controller:'championship',action:'create')}">Créer</a>
						  </li>
						  <li class="yuimenuitem">
						    <a href="${createLink(controller:'championship',action:'list')}">Voir</a>
						  </li>
					    </ul>
					  </div>
					</div>
				</li>
				<li class="yuimenubaritem">
					<g:link controller="player">Joueurs</g:link>
					<div id="player" class="yuimenu">
                      <div class="bd">
						<ul>
						  <li class="yuimenuitem">
						    <a href="${createLink(controller:'player',action:'edit',id:session.user.id)}">Ma page</a>
						  </li>
						  <li class="yuimenuitem">
						    <a href="${createLink(controller:'player',action:'list')}">Voir</a>
						  </li>
					    </ul>
					  </div>
					</div>
				</li>
				<li class="yuimenubaritem">
					<g:link controller="place">Tripots</g:link>
					<div id="place" class="yuimenu">
                      <div class="bd">
						<ul>
						  <li class="yuimenuitem">
						    <a href="${createLink(controller:'place',action:'create')}">Créer</a>
						  </li>
						  <li class="yuimenuitem">
						    <a href="${createLink(controller:'place',action:'list')}">Voir</a>
						  </li>
					    </ul>
					  </div>
					</div>
				</li>
			</ul>
			</div>
		</div>
		<g:layoutBody />
	</body>	
</html>
