class Party { 
    Long id
	Long version

    Date date
    Championship championship
    Place place
	String kind = allKinds.get(0)
	
	Double buyin
	Integer coinsPerBuyin

    static hasMany = [ scores : Score ]
    static belongsTo = [Championship]
                     
    static optionals = [ "buyin", "coinsPerBuyin" ]
    static transients = [ "allKinds" ]

    String toString() { "${this.class.name} :  $id" }

    static allKinds = [ "Cash Game", "Sit and Go"]

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
	
	static constraints = {
	    coinsPerBuyin(matches:"[0-9]",blank:false)
		buyin(matches:"[(0-9)*.(0-9)*]",blank:false)
	    /*
	    buyin(validator : {
	        val, obj ->
	        	println obj.properties['kind']
	        	println val
	        	if (obj.properties['kind'] == "Cash Game" && val == null)
	        		return false
	    	}
	    )
	    */
	}
}