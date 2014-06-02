package mypoll

class Opinion {
	
	String testObjectUrl
    Map selections
    Boolean submitted
	
	static belongsTo = [poll: Poll]
    static hasMany = [selections: Option]

    static constraints = {
        submitted nullable:true
    }
}