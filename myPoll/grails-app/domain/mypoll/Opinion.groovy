package mypoll

class Opinion {
	
	String testObjectUrl
    	
	static belongsTo = [poll: Poll]

    Map selections
	static hasMany = [selections: String]
	
	boolean submittable
	boolean submitted
	
    static constraints = {
        submitted nullable:true
    }

    static mapping = {
        selections type: 'text'
    }

}