class PlayersTableTagLib {

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
                        out << "<span style=\"color:green\">" << playersScoreForParty.money << "</span>"
                    else
                        out << "<span style=\"color:red\">" << playersScoreForParty.money << "</span>"
                }
            }
            out << "</td>"
            out << "<td>"
            out << "<a href=\"" << grailsAttributes.getApplicationUri(request) << "/party/edit/" << party.id << "\">Editer</a>"
            out << "</td>"
            out << "</tr>"
        }
    }
}