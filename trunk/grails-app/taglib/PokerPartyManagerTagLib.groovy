import java.text.SimpleDateFormat

class PokerPartyManagerTagLib {

    def playersTable = { attrs ->
        def playersLines = attrs['playersLines']
   		def cssClass
        
        playersLines.eachWithIndex { playerLine,index ->
    		if (index % 2 == 0)
    	    	cssClass = "odd"
    		else
    			cssClass = "even"

    		out << "<tr>"
            out << "<td class=\"" << cssClass << "\" width='10%'>" << index + 1 << "</td>"
            out << "<td class=\"" << cssClass << "\" width='20%'>" << playerLine?.playerLogin << "</td>"
            out << "<td class=\"" << cssClass << "\" width='20%'>" << playerLine?.getFormattedTotal() << "</td>"
            out << "<td class=\"" << cssClass << "\" width='10%'>" << playerLine?.partiesWon << "</td>"
            out << "<td class=\"" << cssClass << "\" width='10%'>" << playerLine?.partiesDraw << "</td>"
            out << "<td class=\"" << cssClass << "\" width='10%'>" << playerLine?.partiesLost << "</td>"
            out << "<td class=\"" << cssClass << "\" width='10%'>" << playerLine?.getLpa() << "</td>"
            out << "</tr>"
        }
    }

    def partiesTable = { attrs ->
    	def parties = attrs['parties']
		def playersScores = attrs['playersScores']
		def cssClass

		def df = new SimpleDateFormat()
    	
		out << "<table>"
		out << "  <tr>"
		out << "    <th class=\"embed\"></th>"
		parties.each { party ->
			out << "    <th class=\"embed\">" 
			out	<< df.format(party.date)
			out	<< "</th>"
		}
		out << "  </tr>"
        
		playersScores.keySet().eachWithIndex { playerLogin, index ->
		
			if (index % 2 == 0)
	    		cssClass = "odd"
			else
				cssClass = "even"

			out << "  <tr>"
			out	<< "    <td class=\"" << cssClass << "\">" << playerLogin << "</td>"
			
			playersScores.get(playerLogin).each { money ->
				out << "    <td class=\"" << cssClass << "\">" << money << "</td>"
			}
				
			out << "  </tr>"
		}
		
		out << "</table>"
    }
    
	/**
	 * Only invokes the body if the user within the session is a system administrator
	 */
	def hasPlayerPagePermission = { attrs, body ->
		if(session.user) {
			def u = session.user
			if(u.isSuperAdmin || String.valueOf(u.id.longValue()) == attrs['id']) {
				body()	
			}
		}
	}
    
    def canManageChampionship = { attrs, body ->
    	if (session.user) {
    	    def championshipId = attrs['championship']
			session.userManagedChampionships.each { managedChampionship ->
				if (managedChampionship.id == championshipId)
				    body()
			}
    	}
	}
    
    def escapeHTML = { attrs, body ->
    	def data = attrs['data']
    	if (data)
    	  out << data.replaceAll("'","&apos;")
    	else
    	  out << ""
    }
    
	/**
	 * Creates next/previous links to support pagination for the current controller
	 *
	 * <g:paginate total="${Account.count()}" />
	 */
	def ajaxPaginate = { attrs ->
        if(attrs.total == null)
            throwTagError("Tag [paginate] is missing required attribute [total]")
		
		def mkp = new groovy.xml.MarkupBuilder(out)
		def total = attrs.total.toInteger()
		def max = params.max?.toInteger()
		def offset = params.offset?.toInteger() 
		def action = (attrs.action? attrs.action : 'list')
		def breadcrumb = true
		if(attrs.breadcrumb) breadcrumb = Boolean.valueOf(attrs.breadcrumb)
//		def remote = false
//		if (attrs.remote) remote = Boolean.valueOf(attrs.remote)

		if(!max) max = (attrs.max ? attrs.max.toInteger() : 10)
		if(!offset) offset = (attrs.offset ? attrs.offset.toInteger() : 0)
		
		def linkParams = [offset:offset-max,max:max]
		def linkTagAttrs = ['class':'prevLink',action:action]
		if(attrs.controller) {
			linkTagAttrs.controller = attrs.controller	
		}
		if(attrs.id) {
			linkTagAttrs.id = attrs.id	
		}
		if(attrs.params)linkParams.putAll(attrs.params)
		linkTagAttrs.params = linkParams

//		if (remote) {
//		    if (attrs.remoteUpdate == null)
//	            throwTagError("Tag [paginate] is missing required attribute [remoteUpdate] where attribute [remote] is set")
//    		linkTagAttrs.'update' = attrs.remoteUpdate
//		}
		linkTagAttrs.'update' = 'positionsContent'
        
		def combined = max + offset
		if(offset > 0) {
//		    if (!remote)
//				link(linkTagAttrs.clone(),{out<< (attrs.prev? attrs.prev : 'Previous' ) })
//			else
				remoteLink(linkTagAttrs.clone(),{out<< (attrs.prev? attrs.prev : 'Previous' ) })
		}
		
		if(total > max) {
			linkTagAttrs.'class' = 'step'
			if(breadcrumb) {
				def j = 0
				0.step(total,max) { i ->
					if(offset == i) {
						mkp.a('class':'step',"${++j}")	
					}
					else {
						linkParams.offset=i
//						if (!remote)
//							link(linkTagAttrs.clone(),{out<<++j})
//						else
							remoteLink(linkTagAttrs.clone(),{out<<++j})	
					}
				}			
			}			
		}
		linkParams.offset = offset+max
		if(combined < total) {	
			linkTagAttrs.'class'='nextLink'
//			if (!remote)
//				link(linkTagAttrs,{out<< (attrs.'next'? attrs.'next' : 'Next' )})
//			else
				remoteLink(linkTagAttrs,{out<< (attrs.'next'? attrs.'next' : 'Next' )})
		}
	}
}
