class Player { 
	Long id
	Long version

    String login
    String password
    String newPassword
    String email
	Boolean isSuperAdmin = false
    
    byte[] photo
    String favoriteQuote
    String favoriteHand
    String amulet
    
    def optionals = ['isSuperAdmin', 'photo', 'favoriteHand', 'favoriteQuote', 'amulet']
	def transients = ['newPassword']
	                  
    String toString() { "${this.class.name} :  $id" }
	
	boolean equals(other) {
		if(other?.is(this))return true
		if(!(other instanceof Player)) return false
		
		if(!id || !other?.id || id!=other?.id) return false
		
		return true
	}
	
	int hashCode() {
		int hashCode = 0
		hashCode = 29 * (hashCode + ( !id ? 0 : id ^ (id >>> 32) ) )
	}
    
    static constraints = {
        login(length:5..15,blank:false) //,unique:true
        password(minSize:5,blank:false)
        email(blank:false,email:true)
    }
}	
