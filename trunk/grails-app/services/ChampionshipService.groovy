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
    def getStandings(championshipId) {
        def championship = Championship.get( championshipId )
        def championshipParties = Party.findAllByChampionship(championship)
        Map playersMap = new HashMap()
        championshipParties.each { p ->
            p.scores.each { s ->
                def player = s.player
                if (playersMap.get(player.login) == null)
                    playersMap.put(player.login, new PlayerTableLine(player.login))
                def playerTableLine = playersMap.get(player.login)
                playerTableLine.addScore(s) 
            }
        }
        Map orderedPlayersLines = new TreeMap()
        playersMap.each { k,v ->
            orderedPlayersLines.put(-v.totalMoney, v)
        }

		return orderedPlayersLines.values()
    }

}