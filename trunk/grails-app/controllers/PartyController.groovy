import org.springframework.web.servlet.support.RequestContextUtils as RCU
import java.text.SimpleDateFormat
import java.text.DateFormat

class PartyController extends BaseController {
    
    EmailerService emailerService
    LocalizationService localizationService
	PartyService partyService
	
    def index = { redirect(controller:'championship',action:'list',params:params) }

    def delete = {

        def deleteResult = partyService.delete(params.id)
        if (deleteResult) {
			flash.message = 'party.success_delete'
			redirect(controller:'championship',action:'getparties',id:championshipId)
        } else {
			flash.message = 'party.failure_delete'
			redirect(controller:'championship',action:'getparties',id:championshipId)
        }
    }

    def edit = {
        def party = Party.get( params.id )

        if(!party) {
			flash.message = "Party not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            render(view:'edit_embed',model:[party:party],contentType:'text/javascript')
        }
    }

    def update = {
        def party = Party.get( params.id )
        if (party) {
            party.properties = params
            party.setDefaults()
            if(party.save()) {
                render(view:'edit_embed',model:[party:party],contentType:'text/javascript')
            } else {
                flash.message = "Error updating party ${params.id}"
                render(view:'edit_embed',model:[party:party],contentType:'text/javascript')
            }
        } else {
            flash.message = "Party not found with id ${params.id}"
            redirect(controller:'championship',action:'list')
        }
    }

    def create = {
        def party = new Party()
        render(view:'create_embed',model:['party':party,'id':params.id])
    }

    def save = {
        def party = new Party()
        party.properties = params
        party.setDefaults()
        if(party.save()) {
            render(view:'edit_embed',model:[party:party],contentType:'text/javascript')
        } else {
            render(view:'create_embed',model:[party:party])
        }
    }
    
    def forwardToEditEmbed = {
		def party = Party.get( params.id )
    	render(view:'edit_embed',model:[party:party],contentType:'text/javascript')
    }
    
    def checkScores = {
        def party = Party.get( params.id )
        
        def totalMoney = 0
        def totalPoints = 0
        
        party.scores.each { score ->
            totalMoney += score.money
            totalPoints += score.points - ((score.refunds + 1) * score.party.coinsPerBuyin)
        }
        
        if ((party.kind == 'Cash Game' && totalPoints == 0)
                || (party.kind == 'Sit and Go' && totalMoney == 0)) {
            render(template:'resultscorescheck',
                   model:['resultClass':'message_embed','resultMsg':'score.success_check'])
        } else {
            if (party.kind == 'Cash Game')
                render(template:'resultscorescheck',
                        model:['resultClass':'errors_embed','resultMsg':'score.failure_check',
                               'resultArgs':[totalPoints] ])
			else
                render(template:'resultscorescheck',
                        model:['resultClass':'errors_embed','resultMsg':'score.failure_check',
                               'resultArgs':[totalMoney] ])
        }
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

        InvitationDataWrapper invitationWrapper = new InvitationDataWrapper()
        bindData(invitationWrapper, params)
		def dayAsText = DateFormat.getDateInstance(DateFormat.FULL, RCU.getLocale(request) ).format(invitationWrapper.partyDate)
		def hourAsText = new SimpleDateFormat("HH:mm:ss", RCU.getLocale(request) ).format(invitationWrapper.partyDate)
		def subject = localizationService.getMessage(request, "party.invitation_subject", 
		        [ session.user.login, place.name, dayAsText, hourAsText ])

		// Each "email" is a simple Map
	    def email = [
	    	replyTo: session.user.email == null ? null : session.user.email,
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