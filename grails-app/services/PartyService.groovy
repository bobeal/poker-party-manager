import org.hibernate.SessionFactory;

class PartyService {
    
	def SessionFactory sessionFactory

	def delete(party) {
	    
        if(party) {
            
            println "Gonna delete party ${party.id}"

            // temp hack
            // see http://jira.codehaus.org/browse/GRAILS-563
			try {
			    party.setPlace(null)
	            party.delete()

	            sessionFactory.getCurrentSession().flush()
				println "Party ${party.id} deleted"
				return true
			} catch( Exception ex ) {
				println "Party ${party.id} could not be deleted !"
				ex.printStackTrace()
				return false
			}
        } else {
			println "No party provided !"
            return false
        }
    }
}