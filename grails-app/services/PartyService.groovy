import org.hibernate.SessionFactory;

class PartyService {
    
	def SessionFactory sessionFactory

	def delete(partyId) {
        def party = Party.get(partyId)
        
        if(party) {
            
            println "Gonna delete party ${partyId}"

            // temp hack
            // see http://jira.codehaus.org/browse/GRAILS-563
			try {
			    party.setPlace(null)
	            party.delete()

	            sessionFactory.getCurrentSession().flush()
				println "Party ${partyId} deleted"
				return true
			} catch( Exception ex ) {
				println "Party ${partyId} could not be deleted !"
				ex.printStackTrace()
				return false
			}
        } else {
			println "Party ${partyId} not found !"
            return false
        }
    }
}