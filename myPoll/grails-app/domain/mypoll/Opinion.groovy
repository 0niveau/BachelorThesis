package mypoll

class Opinion {
	
	String testObjectURL
	
	static belongsTo = [poll: Poll]
	static hasMany = [selections: Selection]

    static constraints = {
    }
}