import org.hibernate.SessionFactory;

class ChampionshipService {

    PartyService partyService
    
	def SessionFactory sessionFactory

	/**
     * Return a list of championships, ordered by startDate desc.
     */
    def list() {
        return Championship.list( sort:'startDate', order:'desc' )
    }
    
    /**
     * Load championship with the given id.
     */
    def get(championshipId) {
        return Championship.get(championshipId)
    }
    
    /**
     * Delete the championship with the given id.
     */
    def delete(championshipId) {
        def championship = Championship.get(championshipId)
        
        if(championship) {
            
            def championshipLabel = championship.label
            println "Gonna delete championship ${championshipId}"
            
            // temp hack
            // see http://jira.codehaus.org/browse/GRAILS-563
			try {
			    championship.admins.each { admin ->
			    	admin.managedChampionships.remove(championship)
			    }
			    championship.parties.each { party ->
			    	championship.parties.remove(party)
			    	partyService.delete(party.id)
			    }
	            championship.delete()

	            sessionFactory.getCurrentSession().flush()
				println "Championship ${championshipLabel} (${championshipId}) deleted."
				return true
			} catch( Exception ex ) {
				println "Championship ${championshipLabel} (${championshipId}) could not be deleted !"
				ex.printStackTrace()
				return false
			}
        } else {
			println "Championship ${championshipId} not found !"
			return false
        }
    }
    
    /*
     * Return a list of PlayerTableLine objects representing player's scores
     * for a given championship.
     */
    def getStandings(championshipId, onlyRegulars) {
        def championship = Championship.get( championshipId )
        def championshipParties = Party.findAllByChampionship(championship)
        Map playersMap = new HashMap()
        def totalNbOfParties = championshipParties.size()
        championshipParties.each { p ->
            p.scores.each { s ->
                def player = s.player
                if (playersMap.get(player.login) == null)
                    playersMap.put(player.login, new PlayerTableLine(player.login))
                def playerTableLine = playersMap.get(player.login)
                playerTableLine.addScore(s) 
            }
        }
        
        Set orderedStandings = new TreeSet()
        orderedStandings.addAll(playersMap.values())
        if (onlyRegulars) {
            Set regularStandings = new TreeSet()
         	orderedStandings.each { playerTableLine ->
         		def playerAttendedParties = playerTableLine.getAttendedPartiesNb()
         		if (playerAttendedParties > (totalNbOfParties / 4 ))
         		    regularStandings.add(playerTableLine)
         	}
            return regularStandings
        } else {
			return orderedStandings
        }
	}

    def getParties(championshipId, offset, max) {

		def championship = Championship.get(championshipId)
        def parties = Party.findAllByChampionship(championship, 
		        [max:max, offset:offset, sort:"date", order:"desc"] )
		// get players that attended at least one party in current championship
		def playersLogins = Player.executeQuery("select distinct(p.login) from Player p, Score s " 
		        + " where p.id = s.player.id "
		        + " and s.party.championship = ? "
		        + " order by p.login asc ", championship)
		def playersScores = new TreeMap()
		// pre-fill an empty score list for each player
		playersLogins.each { playerLogin ->
			def scoresAsList = new ArrayList()
			(1..parties.size).each {
			    scoresAsList.add("-")
			}
			playersScores[playerLogin] = scoresAsList.toArray()
		}
		// fill the empty score list with real values
		parties.eachWithIndex { party, index ->
		    party.scores.each { score ->
				def playerScoresArray = playersScores[score.player.login]
		    	playerScoresArray[index] = score.formattedTotal()
		    }
		}

		// get total number of parties for pagination
		def totalNbParties = Party.countByChampionship(championship)

    	return ['parties':parties, 'playersScores':playersScores, 'total':totalNbParties]
    }
}