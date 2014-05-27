package mypoll

class Opinion {
	
	String testObjectUrl
    Map selections
	
	static belongsTo = [poll: Poll]
    static hasMany = [selections: Option]

    static constraints = {
    }
}