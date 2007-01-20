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
            out << "<td class=\"" << cssClass << "\" width='30%'>" << playerLine?.playerLogin << "</td>"
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
        def players = Player.list()
		def cssClass
        
		parties.eachWithIndex { party, index ->
        
        	if (index % 2 == 0)
        	    cssClass = "odd"
        	else
        		cssClass = "even"
        	
            out << "<tr>"
            out << "<td class=\"" << cssClass << "\">" << party?.place?.name << "</td>"
            out << "<td class=\"" << cssClass << "\">" << party?.date << "</td>"
            def playersScores = new HashMap()
            party.scores.each { score ->
            	playersScores.put(score.player.id, score)
            }
            players.each { player ->
                out << "<td class=\"" << cssClass << "\">"
                def score = playersScores.get(player.id)
                if (score != null) {
					if (score.money > 0)
                    	out << "<span style=\"color:green\">" << score.formattedTotal() << "</span>"
                    else if (score.money < 0)
                    	out << "<span style=\"color:red\">" << score.formattedTotal() << "</span>"
					else
                    	out << score.formattedTotal()
                }
            }

            out << "</td>"
            out << "<td class=\"" << cssClass << "\">"
            out << "<a href=\"javascript:void(0);\""
//			out	<< " onclick=\"setChampionshipTab('menu_edit_party');" << remoteFunction(controller:"party",action:"edit",id:party.id,update:"partiestab") << "\">"
			out	<< " onclick=\"setChampionshipTab('menu_edit_party','" << grailsAttributes.getApplicationUri(request) << "/party/edit/" << party.id << "');\">"
				// << grailsAttributes.getApplicationUri(request) << "/party/edit/" << party.id << "\">Editer</a>"
			out	<< "Editer" << "</a>"
            out << "</td>"
            out << "</tr>"
        }
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
    	    if (session.user.canManageChampionship(championshipId))
    	        body()
    	}
	}
    
    def escapeHTML = { attrs, body ->
    	def data = attrs['data']
    	if (data)
    	  out << data.replaceAll("'","&apos;")
    	else
    	  out << ""
    }
}