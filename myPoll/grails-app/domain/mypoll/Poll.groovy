package mypoll

class Poll {

	String name
	String description
	Boolean isActive
	String testObjectUrlA
	String testObjectUrlB

	static hasMany = [sections:PollSection, opinions: Opinion]
	
	List sections = []
	List opinions = []
	
    static constraints = {
    	name blank: false
		isActive nullable: true
		testObjectUrlA blank: false
		testObjectUrlB blank: false
    }
}
