class ScoreController extends BaseController {
    
    def index = { redirect(action:list,params:params) }

    def list = {
        [ scoreList: Score.list( params ) ]
    }

    def show = {
        [ score : Score.get( params.id ) ]
    }

    // called asynchronously, only renders operation result that will be displayed
    // in a special div
    def delete = {
        def score = Score.get( params.id )
        log.info("Deleting score ${score.id}")
        if(score) {
            
            // temp hack
            // see http://jira.codehaus.org/browse/GRAILS-563
			try {
	            score.delete()

	            sessionFactory.getCurrentSession().flush()
				log.debug("score ${params.id} deleted.")
				render(builder:'json') {
         			status('success')
         			msg(getMessage('score.success_delete'))
  	   			}
			} catch( Exception ex ) {
				log.debug("score ${params.id} could not be deleted !")
				ex.printStackTrace()
				render(builder:'json') {
         			status('failure')
         			msg(getMessage('score.failure_delete'))
  	   			}
			}
        } else {
			render(builder:'json') {
     			status('failure')
     			msg(getMessage('score.failure_delete'))
   			}
        }
    }

    def edit = {
        def score = Score.get( params.id )

        if(!score) {
                flash.message = "Score not found with id ${params.id}"
                redirect(action:list)
        }
        else {
            return [ score : score ]
        }
    }

    def update = {
        def score = Score.get( params.id )
        if(score) {
            score.properties = params
            if(score.save()) {
                redirect(action:show,id:score.id)
            }
            else {
                render(view:'edit',model:[score:score])
            }
        }
        else {
            flash.message = "Score not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    // called asynchronously for parties edition page
    def updatePoints = {
       def score = Score.get(params.id)
       
       score.points = Integer.parseInt(params.value)
       score.money = (score.points - (score.refunds * score.party.coinsPerBuyin)) / (score.party.coinsPerBuyin / score.party.buyin)
       score.save()
       render(builder:'json') {
         points(score.points)
         money(score.money)
  	   }
    }
    
    // called asynchronously for parties edition page
    def updateMoney = {
       def score = Score.get(params.id)
       
       score.money = Double.valueOf(params.value)
       score.save()
       render(builder:'json') {
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
	        score.money = (score.points - (score.refunds * score.party.coinsPerBuyin)) / (score.party.coinsPerBuyin / score.party.buyin)
        } else if (score.party.kind == "Sit and Go") {
            score.money = - (score.refunds * score.party.buyin)
        }
        if(score.save()) {
            redirect(controller:'party',action:'forwardToEditEmbed',id:score.party.id)
        }
        else {
            render(view:'create',model:[score:score])
        }
    }

}