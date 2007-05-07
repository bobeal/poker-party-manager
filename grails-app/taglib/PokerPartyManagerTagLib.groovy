import java.text.SimpleDateFormat

class PokerPartyManagerTagLib {

    def dateFormat = { attrs ->
    	out << new SimpleDateFormat().format(attrs.date)
 	}
    
    /**
	 * Only invokes the body if the current user is a system administrator (FIXME : or self).
	 */
	def hasPlayerPagePermission = { attrs, body ->
		if (session.user) {
			def u = session.user
			//if(u.isSuperAdmin || String.valueOf(u.id) == attrs['id']) {
				body()	
			//}
		}
	}
    
    def isAdminOrSelf = { attrs, body ->
		def playerId = attrs['playerId']
		if (session?.user?.isSuperAdmin || session?.user?.id.equals(Long.valueOf(playerId)))
	    	body()
	}

    /**
	 * Only invokes the body if the current user is a system administrator (FIXME : or self).
	 */
    def isAdmin = { attrs, body ->
    	def user = attrs['user']
    	if (user.isSuperAdmin)
    	    out << "Oui"
    	else
    	    return false
	}
    
    /**
	 * Only invokes the body if the current user can manage the given championship.
	 */
    def canManageChampionship = { attrs, body ->
    	if (session.user) {
    	    def championshipId = attrs['championship']
			session.userManagedChampionships.each { managedChampionship ->
				if (managedChampionship.id == championshipId)
				    body()
			}
    	}
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
		linkTagAttrs.'update' = 'positionsContentContainer'
        
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
