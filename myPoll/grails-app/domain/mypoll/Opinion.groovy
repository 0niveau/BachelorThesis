package mypoll

class Opinion {
	
	String testObjectUrl
    	
	static belongsTo = [poll: Poll]
    static hasMany = [selections: Option]

	Map selections = [:]
	
	boolean submittable
	boolean submitted
	
    static constraints = {
        submitted nullable:true
    }
}