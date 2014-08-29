package mypoll

class Opinion {
	
	String testObjectUrl
    	
	static belongsTo = [poll: Poll]

	Map<String, String> selections
	
	boolean submittable
	boolean submitted
	
    static constraints = {
        submitted nullable:true
    }

}