class PokerPartyManagerTagLib {

    def playersTable = { attrs ->
        def playersLines = attrs['playersLines']
        
        playersLines.eachWithIndex { playerLine,index ->
            out << "<tr>"
            out << "<td width='10%'>" << index + 1 << "</td>"
            out << "<td width='30%'>" << playerLine?.playerLogin << "</td>"
            out << "<td width='20%'>" << playerLine?.getFormattedTotal() << "</td>"
            out << "<td width='10%'>" << playerLine?.partiesWon << "</td>"
            out << "<td width='10%'>" << playerLine?.partiesDraw << "</td>"
            out << "<td width='10%'>" << playerLine?.partiesLost << "</td>"
            out << "<td width='10%'>" << playerLine?.getLpa() << "</td>"
            out << "</tr>"
        }
    }

    def partiesTable = { attrs ->
        def parties = attrs['parties']
        def players = Player.list()
        
        parties.each { party ->
            out << "<tr>"
            out << "<td>" << party?.place?.name << "</td>"
            out << "<td>" << party?.date << "</td>"
            def playersScores = new HashMap()
            party.scores.each { score ->
            	playersScores.put(score.player.id, score)
            }
            players.each { player ->
                out << "<td>"
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
            out << "<td>"
            out << "<a href=\"" << grailsAttributes.getApplicationUri(request) << "/party/edit/" << party.id << "\">Editer</a>"
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
    
    def escapeHTML = { attrs, body ->
    	def data = attrs['data']
    	if (data)
    	  out << data.replaceAll("'","&apos;")
    	else
    	  out << ""
    }
}