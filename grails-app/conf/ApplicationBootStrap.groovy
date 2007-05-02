class ApplicationBootStrap {

     def init = { servletContext ->
     	def applicationName = 'Poker Party Manager'
     	def application = Application.findByName(applicationName)
     	if (!application) {
     	    application = new Application()
     	    application.name = applicationName
     	    application.currentVersion = '1.0-Beta1'
     	} else {
     	    application.currentVersion = '1.0-Beta1'
     	}
 	    application.save()
     }
     def destroy = {
     }
} 