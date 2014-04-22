package mypoll

class PollSection {

	String name
	String description
	Boolean needsTestObject

	static hasMany = [items: Item]
	static belongsTo = [poll: Poll]
	
    static constraints = {
    	name blank: false
		description nullable: true
    }
}
