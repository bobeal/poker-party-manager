import org.springframework.web.servlet.support.RequestContextUtils as RCU;
import java.text.SimpleDateFormat
import java.text.DateFormat

class PartyController extends BaseController {
    
    EmailerService emailerService

    def index = { redirect(action:list,params:params) }

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
                redirect(action:edit,id:party.id)
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
    
    def checkScores = {
        def party = Party.get( params.id )
        def totalMoney = 0
        def totalPoints = 0
        
        party.scores.each { score ->
            totalMoney += score.money
            totalPoints += score.points - (score.refunds * 100)
        }

        if (totalPoints == 0)
            render "<div class=\"message\">Le compte est bon !</div>"
        else
            render "<div class=\"errors\">Too bad, il y a un &eacute;cart de ${totalPoints}</div>" 
    }
    
    def invite = {
    }
    
    def sendInvitation = {
		def place = Place.get(params.place_id)
		def guestList = []
		params.guests.each { guest ->
			def email = Player.get(guest).email
			if (email) {
			    log.debug("sending invitation to ${email}")
				guestList.add(email)
			}
		}

        def messageSource = grailsAttributes
        						.getApplicationContext()
        						.getBean("messageSource")
        def date = new Date()
        bindData(date, params.date)
		def dayAsText = DateFormat.getDateInstance(DateFormat.FULL, RCU.getLocale(request) ).format(date)
		def hourAsText = new SimpleDateFormat("HH:mm:ss", RCU.getLocale(request) ).format(date)
		def subject = messageSource.getMessage( "party.invitation_subject",
        	                                    [ place.name, dayAsText, hourAsText ].toArray(),
                                                "",
                                                RCU.getLocale(request) )
		// Each "email" is a simple Map
	    def email = [
	       to: guestList,        // "to" expects a List, NOT a single email address
	       subject: subject,
	       text: params.message         // "text" is the email body
	    ]
	    // sendEmails expects a List
	    emailerService.sendEmails([email])

		flash.message = "party.invitation_sent"
		redirect(controller:'championship',action:'list')
    }
}