class Place { 
	Long id
	Long version

    String name
    String description
    
    String toString() { "${this.class.name} :  $id" }
	
	boolean equals(other) {
		if(other?.is(this))return true
		if(!(other instanceof Place)) return false
		
		if(!id || !other?.id || id!=other?.id) return false
		
		return true
	}
	
	int hashCode() {
		int hashCode = 0
		hashCode = 29 * (hashCode + ( !id ? 0 : id ^ (id >>> 32) ) )
	}
    
    static constraints = {
        name(minSize:5,maxSize:40,blank:false)
    }
}	
