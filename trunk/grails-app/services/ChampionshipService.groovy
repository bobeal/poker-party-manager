class ChampionshipService {

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