<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 

<%@ taglib prefix="g" uri="http://grails.codehaus.org/tags" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><g:layoutTitle default="Poker Party Manager" /></title>

    <!-- Grid and common settings CSS -->
    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.2.2/build/reset-fonts-grids/reset-fonts-grids.css">
    <!-- Menu and Button CSS -->
    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.2.2/build/fonts/fonts-min.css">
    <!-- Menu CSS -->
    <link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css',file:'customizedYuiMenu.css')}">
    <!-- Button CSS -->
    <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.2.2/build/button/assets/button.css">
    <!-- PPM CSS -->
    <link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css',file:'common.css')}">

    <!-- Menu, Button and Tabview JS --> 
    <script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/yahoo-dom-event/yahoo-dom-event.js"></script>
    <!-- Dependency for Menu JS --> 
    <script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/container/container_core-min.js"></script>
    <!-- Menu JS -->
    <script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/menu/menu-min.js"></script>
    <!-- Dependency for Button JS --> 
    <script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/element/element-beta-min.js"></script>
    <!-- Button JS -->
    <script type="text/javascript" src="http://yui.yahooapis.com/2.2.2/build/button/button-beta-min.js"></script>

    <g:javascript library="scriptaculous" />
    <g:javascript library="prototype" />
    <g:javascript src="ppm.js" />
	<g:layoutHead />
  </head>
  <body onload="<g:pageProperty name='body.onload'/>">
    <div id="doc2" class="yui-t1">
      <div id="hd">
        <div style="float:left;">
          <a href="${createLink(controller:'championship',action:'list')}">
        	<img src="${createLinkTo(dir:'images',file:'ppm_banner.png')}" alt="Poker" />
          </a>
          <!-- <img src="${createLinkTo(dir:'images',file:'ppm_header.png')}" /> -->
        </div>
		<span class="userInfo">
		  ${session?.user?.login} - <a href="${createLink(controller:'player',action:'logout')}"><g:message code="action.logout"/></a>
    	</span>
        <div id="hd-footer">&nbsp;</div>
      </div>
    
      <div id="bd">
        <div id="yui-main">
          <div class="yui-b">
            <g:layoutBody />
          </div>
        </div>
        <div class="yui-b">
          <div id="menuwithgroups" class="yuimenu">
            <div class="bd">
              <h6 class="first-of-type"><g:link controller="championship"><g:message code="menu.championship"/></g:link></h6>
              <ul>
                <li class="yuimenuitem">
                  <a href="${createLink(controller:'championship',action:'list')}">
                    <g:message code="action.list"/>
                  </a>
                </li>
                <li class="yuimenuitem">
                  <a href="${createLink(controller:'championship',action:'create')}">
                    <g:message code="action.create"/>
                  </a>
                </li>
              </ul>
              <h6><g:link controller="player"><g:message code="menu.player"/></g:link></h6>
              <ul>
                <li class="yuimenuitem">
                  <a href="${createLink(controller:'player',action:'edit',id:session.user.id)}">
                    <g:message code="player.my_page"/>
                  </a>
                </li>
                <li class="yuimenuitem">
                  <a href="${createLink(controller:'player',action:'list')}">
                    <g:message code="action.list"/>
                  </a>
                </li>
                <li class="yuimenuitem">
                  <a href="${createLink(controller:'player',action:'create')}">
                    <g:message code="action.create"/>
                  </a>
                </li>
              </ul>
              <h6><g:link controller="place"><g:message code="menu.place"/></g:link></h6>
              <ul>
                <li class="yuimenuitem">
                  <a href="${createLink(controller:'place',action:'list')}">
                    <g:message code="action.list"/>
                  </a>
                </li>
                <li class="yuimenuitem">
                  <a href="${createLink(controller:'place',action:'create')}">
                    <g:message code="action.create"/>
                  </a>
                </li>
              </ul>
            </div>
          </div>        
        </div>
      </div>
    
      <div id="ft">
        PPM ${Application.findByName('Poker Party Manager').currentVersion} - Powered by <a href="http://grails.org">Grails</a>
      </div>
    </div>   
  </body>	
</html>
