class ApplicationBootStrap {

     def init = { servletContext ->
     	def application = Application.findByName('Poker Party Manager')
     	if (!application) {
     	    application = new Application()
     	    application.name = 'Poker Party Manager'
     	    application.currentVersion = '1.0-Beta1'
     	} else {
     	    application.currentVersion = '1.0-Beta1'
     	}
 	    application.save()
     }
     def destroy = {
     }
} 