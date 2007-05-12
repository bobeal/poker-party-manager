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
        def championship = championshipService.get(params.id)
        if (championship) {
            championship.properties = params
            if (championship.save()) {
                flash.message = "championship.success_save"
                redirect(action:show,id:championship.id)
            } else {
                flash.message = "championship.failure_save"
                redirect(action:show,id:championship.id)
            }
        } else {
            flash.message = "championship.requested_not_found"
            redirect(action:list)
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
		// values of multiple select are of a different type according to the number
		// of selected entries
        if (params.adminsId && params.adminsId.class.name == 'java.lang.String') {
		    def admin = Player.get(params.adminsId)
		    admin.addChampionship(championship).save()
		} else {
			params.adminsId?.each { adminId ->
				def admin = Player.get(adminId)
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
		def max = params.max ? params.max : 10
		def offset = params.offset ? params.offset : 0

		def partiesResult = championshipService.getParties(params.id, offset, max)
		
		render(template:"displayparties",
		        model:['parties':partiesResult['parties'], 'playersScores':partiesResult['playersScores'], 
		               'total':partiesResult['total'], 'championshipId':params.id])
    }
}