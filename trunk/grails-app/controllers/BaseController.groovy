import org.springframework.web.servlet.support.RequestContextUtils as RCU;
import org.hibernate.SessionFactory;

abstract class BaseController {
	def beforeInterceptor = [action:this.&authAndAuthz,except:['login','handleLogin']]
	def SessionFactory sessionFactory
	                         
	def authAndAuthz() {

		if(!session.user) {
			redirect(controller:'player',action:'login')
			return false
		}
		
		log.debug("Request servlet path : ${request.servletPath}")
		log.debug("Request path info : ${request.pathInfo}")
		if (request.servletPath == "/party") {
		    if (request.pathInfo == "/create") {
		        def championshipId = request.getParameter("championship.id")
		        return session.user.canManageChampionship(championshipId)
		    }
		} else if (request.servletPath == "/player") {
		    if (request.pathInfo ==~ "/edit") {
		        def playerId = request.getParameter("id")
		        log.debug("got player id : ${playerId}")
		        return session.user.isAdminOrSelf(playerId)
		    }
		}
	}

	def getMessage(code) {
        def messageSource = grailsAttributes.getApplicationContext().getBean("messageSource")
		def message = messageSource.getMessage( code, null, "", RCU.getLocale(request) )

		return message
	}
}

