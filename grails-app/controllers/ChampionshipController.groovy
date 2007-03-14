class ChampionshipController extends BaseController {
    
    ChampionshipService championshipService
    
    def index = { redirect(action:list,params:params) }

    def list = {
        [ championshipList: Championship.list( params ) ]
    }

    def show = {
		def championship = Championship.get( params.id )
        [ championship : championship,
          // parties : Party.findAllByChampionship(championship, [sort:'date',order:'desc'], 10)
          playersLines : championshipService.getStandings(params.id)
        ]
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
			    championship.parties.each { party ->
			    	party.delete()
			    }
	            championship.delete()

	            sessionFactory.getCurrentSession().flush()
				log.debug("championship ${params.id} deleted.")
				render(builder:'json') {
         			status('success')
         			msg(getMessage('championship.success_delete'))
  	   			}
			} catch( Exception ex ) {
				log.debug("championship ${params.id} could not be deleted !")
				ex.printStackTrace()
				render(builder:'json') {
         			status('failure')
         			msg(getMessage('championship.failure_delete'))
  	   			}
			}
        } else {
			render(builder:'json') {
     			status('failure')
     			msg(getMessage('championship.failure_delete'))
   			}
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

    // TODO
    def getparties = {
    }
}