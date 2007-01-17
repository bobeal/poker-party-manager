import org.hibernate.SessionFactory

class ChampionshipController extends BaseController {

    SessionFactory sessionFactory
    
    def index = { redirect(action:list,params:params) }

    def list = {
        [ championshipList: Championship.list( params ) ]
    }

    def show = {
        [ championship : Championship.get( params.id ) ]
    }

    // called asynchronously, only renders operation result that will be displayed
    // in a special div
    def delete = {
        def championship = Championship.get( params.id )
        log.info("Deleting championship ${championship.id}")
        if(championship) {
            
            // temp hack
            // see http://jira.codehaus.org/browse/GRAILS-563
			try {
			    championship.admins.each { admin ->
			    	admin.managedChampionships.remove(championship)
			    }
	            championship.delete()

	            sessionFactory.getCurrentSession().flush()
				log.debug("championship ${params.id} deleted.")
				render "success"
			} catch( Exception ex ) {
				log.debug("championship ${params.id} could not be deleted !")
				ex.printStackTrace()
				render "failure"
			}
        } else {
			render "failure"
        }
    }

    def update = {
        def championship = Championship.get( params.id )
        if(championship) {
            championship.properties = params
            if(championship.save()) {
                redirect(action:show,id:championship.id)
            } else {
                redirect(action:show,id:championship.id)
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
		log.debug("admins id ${params.adminsId}")
		if (params.adminsId && params.adminsId.class.name == 'java.lang.String') {
		    def admin = Player.get(params.adminsId)
		    admin.addChampionship(championship).save()
		} else {
			params.adminsId?.each { adminId ->
				def admin = Player.get(adminId)
				log.debug("adding player ${admin.login} (${admin.id})")
				admin.addChampionship(championship).save()
			}
        }
        if (championship.save()) {
            redirect(action:show,id:championship.id)
        } else {
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