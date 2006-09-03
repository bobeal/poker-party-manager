class Championship { 
	Long id
	Long version
    
    def relatesToMany = [ parties : Party ]

    String label
    Date startDate
    Date endDate
    
    Set parties = new HashSet()
    
    String toString() { "${this.class.name} :  $id" }
	
    def addParty(party) {
        if (!parties)
            parties = new HashSet()
        parties.add(party)
        return this
    }
    
	boolean equals(other) {
		if(other?.is(this))return true
		if(!(other instanceof Championship)) return false
		
		if(!id || !other?.id || id!=other?.id) return false
		
		return true
	}
	
	int hashCode() {
		int hashCode = 0
		hashCode = 29 * (hashCode + ( !id ? 0 : id ^ (id >>> 32) ) )
	}
}	
