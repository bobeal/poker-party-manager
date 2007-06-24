import java.text.DecimalFormat
import java.text.NumberFormat

class Score { 
	Long id
	Long version
	
	// common properties
    int refunds
    Double money

    // cash game specific properties
    int points

    // sit and go specific properties
    int place
	int prize    
    
    static belongsTo = [Player,Party]

    Player player
    Party party
    
    String toString() { "${this.class.name} :  $id" }
	
    def formattedTotal() {
        NumberFormat numberFormat = new DecimalFormat("###0.00")
        return numberFormat.format(money)
    }

	boolean equals(other) {
		if(other?.is(this))return true
		if(!(other instanceof Score)) return false
		
		if(!id || !other?.id || id!=other?.id) return false
		
		return true
	}
	
	int hashCode() {
		int hashCode = 0
		hashCode = 29 * (hashCode + ( !id ? 0 : id ^ (id >>> 32) ) )
	}
}	
