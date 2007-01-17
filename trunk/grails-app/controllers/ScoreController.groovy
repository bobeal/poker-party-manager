class ScoreController extends BaseController {
    
    def index = { redirect(action:list,params:params) }

    def list = {
        [ scoreList: Score.list( params ) ]
    }

    def show = {
        [ score : Score.get( params.id ) ]
    }

    def delete = {
        def score = Score.get( params.id )
        if(score) {
            score.delete()
			redirect(controller:'party',action:'forwardToEditEmbed',id:params.party_id)
        } else {
            flash.message = "Score not found with id ${params.id}"
            redirect(action:list)
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
        }
        if(score.save()) {
            redirect(controller:'party',action:'forwardToEditEmbed',id:score.party.id)
        }
        else {
            render(view:'create',model:[score:score])
        }
    }

}