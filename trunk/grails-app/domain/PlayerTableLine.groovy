import java.text.DecimalFormat
import java.text.NumberFormat

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
    
    def getFormattedTotal() {
        NumberFormat numberFormat = new DecimalFormat("###0.00")
        return numberFormat.format(totalMoney)
    }

    def getLpa() {
    	def tempDouble = ((double) partiesWon / (partiesWon + partiesDraw + partiesLost)) * 10
    	NumberFormat numberFormat = new DecimalFormat("###0.00")
    	return numberFormat.format(tempDouble)
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