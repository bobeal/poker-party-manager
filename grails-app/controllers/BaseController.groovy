abstract class BaseController {
	def beforeInterceptor = [action:this.&auth,except:['login','handleLogin']]
	
	def auth() {
			if(!session.user) {
				redirect(controller:'player',action:'login')
				return false
			}
	}
}

