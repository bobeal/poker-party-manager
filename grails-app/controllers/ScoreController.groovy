
            
class ScoreController {
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
            //flash.message = "Score ${params.id} deleted."
            redirect(controller:"party",action:"edit",id:params.party_id)
//            redirect(action:list)
        }
        else {
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

    def create = {
        def score = new Score()
        score.properties = params
        return ['score':score]
    }

    def save = {
        def score = new Score()
        score.properties = params
        score.money = (score.points - (score.refunds * 100)) / 40
        if(score.save()) {
            redirect(controller:"party",action:"edit",id:score.party.id)
            //redirect(action:show,id:score.id)
        }
        else {
            render(view:'create',model:[score:score])
        }
    }

}