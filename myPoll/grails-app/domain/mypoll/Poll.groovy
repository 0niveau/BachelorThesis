package mypoll

class Poll {

	String name
	String description
	Boolean isActive
	String testObjectUrlA
	String testObjectUrlB

	static hasMany = [sections:PollSection]

    static constraints = {
    	name blank: false
    }
}
