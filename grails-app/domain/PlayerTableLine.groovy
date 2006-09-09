class PlayerTableLine {
    
    String playerLogin
    Double totalMoney
    int partiesWon
    int partiesDraw
    int partiesLost
    
    def PlayerTableLine(login) {
        playerLogin = login
        totalMoney = new Double(0.0)
        partiesWon = 0
        partiesLost = 0
        partiesDraw = 0
    }
    
    def addScore(score) {
        totalMoney = new Double(totalMoney + score.money)
        
        if (score.money > 0)
            partiesWon += 1
        else if (score.money < 0)
            partiesLost += 1
        else
            partiesDraw += 1
    }
}