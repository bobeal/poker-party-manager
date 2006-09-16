class PlayerController extends BaseController {
    def index = { redirect(action:list,params:params) }

    def list = {
        [ playerList: Player.list( params ) ]
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

        if(!player) {
                flash.message = "Player not found with id ${params.id}"
                redirect(action:list)
        }
        else {
            return [ player : player ]
        }
    }

    def update = {
        def player = Player.get( params.id )
        if(player) {
             player.properties = params
            if(player.save()) {
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
        if(player.save()) {
            redirect(action:show,id:player.id)
        }
        else {
            render(view:'create',model:[player:player])
        }
    }

    def login = {
   		if (session.user) {
           	redirect(controller:'championship')	
        } else {
   			return
        }
    }

    def handleLogin = {

   		if (params.login && params.pwd) {
			def player = Player.findByLogin(params.login)
   			if (player) {
        		if (player.password == params.pwd) {
        		    session.user = player
        		    redirect(controller:'championship')
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