class ChampionshipController extends BaseController {
    
    ChampionshipService championshipService
    LocalizationService localizationService
    
    def index = { redirect(action:list) }

    def list = {
        [ championshipList: championshipService.list() ]
    }

    def show = {
        [ championship : championshipService.get(params.id) ]
    }

    // called asynchronously, only renders operation result that will be displayed
    // in a special div
    def delete = {

        def deleteResult = championshipService.delete(params.id)
        if (deleteResult) {
			render(builder:'json') {
     			status('success')
     			msg(localizationService.getMessage(request,'championship.success_delete'))
	   			}
        } else {
			render(builder:'json') {
     			status('failure')
     			msg(localizationService.getMessage(request,'championship.failure_delete'))
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

    def getstandings = {
    	def playersLines = championshipService.getStandings(params.id)
		render(template:"displaystandings", model:['playersLines':playersLines])
    }
    
    // Load a subset of a championship's parties and render them via the displayparties template
    def getparties = {
		def championship = Championship.get( params.id )
		def max = params.max ? params.max : 10
		def offset = params.offset ? params.offset : 0

		def parties = Party.findAllByChampionship(championship, 
		        [max:max, offset:offset, sort:"date", order:"desc"] )
		// get players that attended at least one party in current championship
		def playersLogins = Player.executeQuery("select distinct(p.login) from Player p, Score s " 
		        + " where p.id = s.player.id "
		        + " and s.party.championship = ? "
		        + " order by p.login asc ", championship)
		def playersScores = new TreeMap()
		// pre-fill an empty score list for each player
		playersLogins.each { playerLogin ->
			def scoresAsList = new ArrayList()
			(1..parties.size).each {
			    scoresAsList.add("-")
			}
			String[] scores = scoresAsList.toArray()
			playersScores[playerLogin] = scores                                               
		}
		// fill the empty score list with real values
		parties.eachWithIndex { party, index ->
		    party.scores.each { score ->
				def playerScoresArray = playersScores[score.player.login]
		    	playerScoresArray[index] = score.formattedTotal()
		    }
		}
		def totalNbParties = Party.countByChampionship(championship)
		render(template:"displayparties",
		        model:['parties':parties, 'playersScores':playersScores, 'total':totalNbParties,
		               'championshipId':params.id])
    }
}