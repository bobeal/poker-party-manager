class Party { 
    Long id
	Long version

    Date date
    Championship championship
    Place place
    
    def relatesToMany = [ scores : Score ]
    def belongsTo = [Championship]
                     
    Set scores = new HashSet()
    
    String toString() { "${this.class.name} :  $id" }
	
    def addScore(score) {
        if (!score)
            scores = new HashSet()
        scores.add(score)
        return this
    }
    
	boolean equals(other) {
		if(other?.is(this))return true
		if(!(other instanceof Party)) return false
		
		if(!id || !other?.id || id!=other?.id) return false
		
		return true
	}
	
	int hashCode() {
		int hashCode = 0
		hashCode = 29 * (hashCode + ( !id ? 0 : id ^ (id >>> 32) ) )
	}
}
