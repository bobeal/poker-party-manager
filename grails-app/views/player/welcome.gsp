<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="main" />
		<title>Poker Party Manager - <g:message code="message.home"/></title>
	</head>
	<body>
		<h1><g:message code="message.home"/></h1>
		<p style="text-align:center">
			Cette application vous permet de gérer des 
			<a href="${createLink(controller:'championship')}">championnats</a>,
			des <a href="${createLink(controller:'place')}">tripots</a>,
			des <a href="${createLink(controller:'player')}">joueurs</a> et
			vos <a href="${createLink(controller:'player',action:'edit',id:session?.user?.id)}">informations personnelles</a>.
		</p>
		<p style="text-align:center">
			Accéder directement au <a href="${createLink(controller:'championship',action:'show',id:'1')}">championnat en cours</a>
		</p>
	</body>
</html>