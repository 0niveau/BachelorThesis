package mypoll

class PollSection {

	String name
	String description
	int index
	Boolean needsTestObject
	Poll poll

	static hasMany = [items: Item]

    static constraints = {
    	name blank: false
    	poll nullable: false
    }
}
