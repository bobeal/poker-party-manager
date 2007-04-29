import java.io.OutputStream
import org.springframework.validation.BindException;
import org.springframework.validation.Errors;

class PlayerController extends BaseController {
    
    AuthenticationService authenticationService
    
    def index = { redirect(action:list,params:params) }

    def list = {
        [ playerList: Player.list( sort:"login", order:"asc" ) ]
    }

    def welcome = {
    }
    
    def show = {
        [ player : Player.get( params.id ) ]
    }

    def delete = {
        def player = Player.get( params.id )
        if(player) {
            player.delete()
            flash.message = "Player ${params.id} deleted."
            redirect(action:list)
        }
        else {
            flash.message = "Player not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {

        def player = Player.get( params.id )

        if (!player) {
            flash.message = "Player not found with id ${params.id}"
            redirect(action:list)
        } else if (!session.user.isSuperAdmin && !player.login.equals(session.user.login)) {
            flash.message = "You cannot edit personal information of ${player.login}"
            redirect(action:list)
        } else {
            return [ player : player ]
        }
    }

    def update = {
        def player = Player.get( params.id )
        if (player) {
            // temp fix 'til unique constraint validation is fixed
            if (player.login != params.login) {
                log.debug("Login changed from ${player.login} to ${params.login}")
                def tempPlayer = Player.findByLogin(params.login)
                if (tempPlayer) {
                    def returnedPlayer = new Player()
                    returnedPlayer.properties = params
                    Errors errors = new BindException(returnedPlayer, returnedPlayer.getClass().getName());
                    errors.rejectValue("login", "player.login.not_unique")
                    returnedPlayer.errors = errors
                    render(view:'edit', model:[player:returnedPlayer])
                    return
                }
            }
			// end temp fix
            player.properties = params
            def f = request.getFile('photo')
            if (f != null && f.getBytes().length > 0)
	            player.photo = f.getBytes()
           	if (player.newPassword != null && !player.newPassword.equals(""))
            	player.password = authenticationService.encryptPassword(player.newPassword)
           	if (player.save()) {
           	    log.debug("Updated player ${player}")
               	render(view:'show',model:[player:player])
               	// update current logged in user if he changed his own page
               	if (session.user.id.toString().equals(player.id))
	               	session.user = player
           	} else {
           	    log.debug("Got errors for player ${player}")
           	    log.debug("Errors are ${player.errors}")
				render(view:'edit',model:[player:player])
           	}
        } else {
            flash.message = "Player not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
        def player = new Player()
        player.properties = params
        return ['player':player]
    }

    def save = {
        def player = new Player()
        player.properties = params
		// validate before encrypting password
        if (!player.validate(true)) {
            render(view:'create',model:[player:player])
        }
        player.password = authenticationService.encryptPassword(player.password)
        if (player.save()) {
            render(view:'edit',model:[player:player])
        } else {
            render(view:'create',model:[player:player])
        }
    }

    def getPhotoData = {
        def player = Player.get( params.id )
		if (player && player.photo) {
		    OutputStream os = response.getOutputStream()
		    response.setContentType("image/jpeg")
		    response.setContentLength(player.photo.length)
		    os.write(player.photo)
	    	os.flush();
	    	os.close();
		} 
    }
    
    def login = {
   		if (session.user) {
   		  	redirect(controller:"championship",action:"list")	
        } else {
   		  	return
        }
    }

    def handleLogin = {

   		if (params.login && params.pwd) {
			def player = Player.findByLogin(params.login)
   			if (player) {
                def encryptedPassword = authenticationService.encryptPassword(params.pwd)
        		if (player.password == encryptedPassword) {
        		    session.user = player
        		    // FIXME : store them because of LazyInitializationException either
        		    session.userManagedChampionships = player.managedChampionships
        		    redirect(controller:'championship',action:'list')
        		} else {
                   	flash.message = 'player.error.failed_authentication'
                   	render(view:'login')
               	}
   			} else {
   			    flash.message = 'player.error.unknown_login'
   			    render(view:'login')
   			}
   		} else {
			flash.message = 'player.error.missing_login_or_password'
           	render(view:'login')
       	}
   	}

   	def logout = {
      	session.user = null
      	session.userManagedChampionships = null
   		render(view:'login')
   	}
}