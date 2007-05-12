class ApplicationBootStrap {

     def init = { servletContext ->
     	def applicationName = 'Poker Party Manager'
     	def application = Application.findByName(applicationName)
     	if (!application) {
     	    application = new Application()
     	    application.name = applicationName
     	    application.currentVersion = '1.0-Beta3'
     	} else {
     	    application.currentVersion = '1.0-Beta3'
     	}
 	    application.save()
     }
     def destroy = {
     }
} 