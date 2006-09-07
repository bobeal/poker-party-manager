
            
class ChampionshipController {
    def index = { redirect(action:list,params:params) }

    def list = {
        [ championshipList: Championship.list( params ) ]
    }

    def show = {
        [ championship : Championship.get( params.id ) ]
    }

    def delete = {
        def championship = Championship.get( params.id )
        if(championship) {
            championship.delete()
            flash.message = "Championship ${params.id} deleted."
            redirect(action:list)
        }
        else {
            flash.message = "Championship not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def championship = Championship.get( params.id )

        if(!championship) {
                flash.message = "Championship not found with id ${params.id}"
                redirect(action:list)
        }
        else {
            return [ championship : championship ]
        }
    }

    def update = {
        def championship = Championship.get( params.id )
        if(championship) {
             championship.properties = params
            if(championship.save()) {
                redirect(action:show,id:championship.id)
            }
            else {
                render(view:'edit',model:[championship:championship])
            }
        }
        else {
            flash.message = "Championship not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def championship = new Championship()
        championship.properties = params
        return ['championship':championship]
    }

    def save = {
        def championship = new Championship()
        championship.properties = params
        if(championship.save()) {
            redirect(action:show,id:championship.id)
        }
        else {
            render(view:'create',model:[championship:championship])
        }
    }

    def gettable = {
        def championship = Championship.get( params.id )
        render(view:'table',model:[id:params.id])
    }
}