class Championship { 
	Long id
	Long version
    
    static belongsTo = [Player]
	static hasMany = [ admins:Player, parties:Party ]
	                   
    String label
    Date startDate
    Date endDate
    
    String toString() { "${this.class.name} :  $id" }
	
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
