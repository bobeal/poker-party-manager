import org.hibernate.SessionFactory;

class ScoreService {
    
	def SessionFactory sessionFactory

    def delete(scoreId) {
        def score = Score.get(scoreId)
        
        if(score) {
            
            println "Gonna delete score ${scoreId}"

            // temp hack
            // see http://jira.codehaus.org/browse/GRAILS-563
			try {
	            score.delete()

	            sessionFactory.getCurrentSession().flush()
				println "Score ${scoreId} deleted"
				return true
			} catch( Exception ex ) {
				println "Score ${scoreId} could not be deleted !"
				ex.printStackTrace()
				return false
			}
        } else {
			println "Score ${scoreId} not found !"
            return false
        }
    }
}