package mypoll

class Opinion {
	
	String testObjectUrl
	
	static belongsTo = [poll: Poll]
	static hasMany = [selections: Selection]
	
	List selections

    static constraints = {
    }
}