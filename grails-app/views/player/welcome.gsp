<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="main" />
		<title>Accueil de Poker Party Manager</title>
	</head>
	<body>
		<h1>Bienvenue sur Poker Party Manager</h1>
		<p>
			Cette application vous permet de gérer des 
			<a href="${createLink(controller:'championship')}">championnats</a>, 
			vos <a href="${createLink(controller:'player',action:'edit',id:session?.user?.id)}">informations personnelles</a>.
		</p>
	</body>
</html>