class ScoreController extends BaseController {
    
    LocalizationService localizationService
	ScoreService scoreService
	
    def index = { redirect(action:list,params:params) }

    // called asynchronously, only renders operation result that will be displayed
    // in a special div
    def delete = {

		def deleteResult = scoreService.delete(params.id)
        if (deleteResult) {
    		render(builder:'json') {
        		status('success')
        		msg(localizationService.getMessage(request,'score.success_delete'))
    		}
        } else {
    		render(builder:'json') {
        		status('failure')
        		msg(localizationService.getMessage(request,'score.failure_delete'))
    		}
        }
    }

    // called asynchronously from parties edition page
    def updatePoints = {
       def score = Score.get(params.id)
       
       score.points = Integer.parseInt(params.value)
       score.money = (score.points - ( (score.refunds + 1) * score.party.coinsPerBuyin)) / (score.party.coinsPerBuyin / score.party.buyin)
       score.save()
       render(builder:'json') {
         points(score.points)
         money(score.money)
  	   }
    }
    
    // called asynchronously from parties edition page
    def updatePrize = {
       def score = Score.get(params.id)
       
       score.prize = Integer.parseInt(params.value)
       score.money = score.prize - ( (score.refunds + 1) * score.party.buyin)
       score.save()
       render(builder:'json') {
		   prize(score.prize)
		   money(score.money)
  	   }
    }
    
    def create = {
        def score = new Score()
        score.properties = params
        return ['score':score]
    }

    def save = {
        def score = new Score()
        score.properties = params
        
        if (score.party.kind == "Cash Game") {
	        score.money = (score.points - ( (score.refunds + 1) * score.party.coinsPerBuyin)) / (score.party.coinsPerBuyin / score.party.buyin)
        } else if (score.party.kind == "Sit and Go") {
            score.money = - (score.party.buyin * ( 1 + score.refunds) )
        }
        
        if(score.save()) {
            redirect(controller:'party',action:'forwardToEditEmbed',id:score.party.id)
        }
        else {
            redirect(controller:'party',action:'forwardToEditEmbed',id:score.party.id)
        }
    }
}
