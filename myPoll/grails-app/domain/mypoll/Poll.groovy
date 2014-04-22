package mypoll

class Poll {

	String name
	String description
	Boolean isActive
	String testObjectUrlA
	String testObjectUrlB

	static hasMany = [sections:PollSection, opinions: Opinion]
	
	List sections
	
    static constraints = {
    	name blank: false
		isActive nullable: true
		testObjectUrlA nullable: true
		testObjectUrlB nullable: true
    }
}
