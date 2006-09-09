
            
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
        def championshipParties = Party.findAllByChampionship(championship)
        Map playersMap = new HashMap()
        championshipParties.each { p ->
            p.scores.each { s ->
                def player = s.player
                if (playersMap.get(player.login) == null)
                    playersMap.put(player.login, new PlayerTableLine(player.login))
                def playerTableLine = playersMap.get(player.login)
                playerTableLine.addScore(s) 
            }
        }
        Map orderedPlayersLines = new TreeMap()
        playersMap.each { k,v ->
            orderedPlayersLines.put(-v.totalMoney, v)
        }
        render(view:'table',model:[playersLines:orderedPlayersLines.values()])
    }
}