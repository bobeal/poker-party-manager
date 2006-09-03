
            
class PartyController {
    def index = { redirect(action:list,params:params) }

    def list = {
        [ partyList: Party.list( params ) ]
    }

    def show = {
        [ party : Party.get( params.id ) ]
    }

    def delete = {
        def party = Party.get( params.id )
        if(party) {
            party.delete()
            flash.message = "Party ${params.id} deleted."
            redirect(action:list)
        }
        else {
            flash.message = "Party not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def party = Party.get( params.id )

        if(!party) {
                flash.message = "Party not found with id ${params.id}"
                redirect(action:list)
        }
        else {
            return [ party : party ]
        }
    }

    def update = {
        def party = Party.get( params.id )
        if(party) {
             party.properties = params
            if(party.save()) {
                redirect(action:show,id:party.id)
            }
            else {
                render(view:'edit',model:[party:party])
            }
        }
        else {
            flash.message = "Party not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def party = new Party()
        party.properties = params
        return ['party':party]
    }

    def save = {
        def party = new Party()
        party.properties = params
        if(party.save()) {
            redirect(action:'edit',id:party.id)
        }
        else {
            render(view:'create',model:[party:party])
        }
    }
}