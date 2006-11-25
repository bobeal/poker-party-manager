import java.io.OutputStream

class PlayerController extends BaseController {
    
    AuthenticationService authenticationService
    
    def index = { redirect(action:list,params:params) }

    def list = {
        [ playerList: Player.list( params ) ]
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
        } else if (!player.login.equals(session.user.login)) {
            flash.message = "You cannot edit personal information of ${player.login}"
            redirect(action:list)
        } else {
            return [ player : player ]
        }
    }

    def update = {
        def player = Player.get( params.id )
        if(player) {
            player.properties = params
            def f = request.getFile('photo')
            if (f != null && f.getBytes().length > 0)
	            player.photo = f.getBytes()
            if (!player.validate()) {
                render(view:'edit',model:[player:player])
            }
            if (!player.password.startsWith('{SHA}'))
	            player.password = authenticationService.encryptPassword(player.password)
            if(player.save(false)) {
                redirect(action:show,id:player.id)
            }
            else {
                render(view:'edit',model:[player:player])
            }
        }
        else {
            flash.message = "Player not found with id ${params.id}"
            redirect(action:edit,id:params.id)
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
        if (!player.validate()) {
            render(view:'create',model:[player:player])
        }
        player.password = authenticationService.encryptPassword(player.password)
        if(player.save(false)) {
            redirect(action:show,id:player.id)
        }
        else {
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
        		    render(view:'welcome')
        		} else {
                   	flash.message = "Echec d'authentification pour le login '${params.login}' "
                   	render(view:'login')
               	}
   			}
   		} else {
			flash.message = 'Identifiant ou mot de passe non fourni'
           	render(view:'login')
       	}
   	}

   	def logout = {
      	session.user = null
   		render(view:'login')
   	}
}