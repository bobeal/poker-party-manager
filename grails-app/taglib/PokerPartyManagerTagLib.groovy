class PokerPartyManagerTagLib {

    @Property playersTable = { attrs ->
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

    @Property partiesTable = { attrs ->
        def parties = attrs['parties']
        def players = Player.list()
        
        parties.each { party ->
            out << "<tr>"
            out << "<td>" << party?.place?.name << "</td>"
            out << "<td>" << party?.date << "</td>"
            players.each { player ->
                out << "<td>"
                def playersScoreForParty = Score.findByPlayerAndParty(player,party)
                if (playersScoreForParty != null) {
                    if (playersScoreForParty.money > 0)
                        out << "<span style=\"color:green\">" << playersScoreForParty.formattedTotal() << "</span>"
                    else if (playersScoreForParty.money < 0)
                        out << "<span style=\"color:red\">" << playersScoreForParty.formattedTotal() << "</span>"
                    else
                        out << playersScoreForParty.formattedTotal()
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
	@Property hasPlayerPagePermission = { attrs, body ->
		if(session.user) {
			def u = session.user
			if(u.isSuperAdmin || String.valueOf(u.id.longValue()) == attrs['id']) {
				body()	
			}
		}
	}
    
    @Property escapeHTML = { attrs, body ->
    	def data = attrs['data']
    	out << data.replaceAll("'","&apos;")
    }
}