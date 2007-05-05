class PlaceController extends BaseController {
    def index = { redirect(action:list,params:params) }

    def list = {
        [ placeList: Place.list( sort:"name", order:"asc" ) ]
    }

    def show = {
        [ place : Place.get( params.id ) ]
    }

    def delete = {
        def place = Place.get( params.id )
        if(place) {
            place.delete()
            flash.message = "Place ${params.id} deleted."
            redirect(action:list)
        }
        else {
            flash.message = "Place not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def place = Place.get( params.id )

        if(!place) {
                flash.message = "Place not found with id ${params.id}"
                redirect(action:list)
        }
        else {
            return [ place : place ]
        }
    }

    def update = {
        def place = Place.get( params.id )
        if(place) {
             place.properties = params
            if(place.save()) {
                redirect(action:show,id:place.id)
            }
            else {
                render(view:'edit',model:[place:place])
            }
        }
        else {
            flash.message = "Place not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def place = new Place()
        place.properties = params
        return ['place':place]
    }

    def save = {
        def place = new Place()
        place.properties = params
        if(place.save()) {
            redirect(action:show,id:place.id)
        }
        else {
            render(view:'create',model:[place:place])
        }
    }

}