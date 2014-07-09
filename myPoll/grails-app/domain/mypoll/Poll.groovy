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
    	name blank: false, maxSize: 50
        description maxSize: 255
		isActive nullable: true
		testObjectUrlA blank: false, maxSize: 255
		testObjectUrlB blank: false, maxSize: 255
    }
	
    def List<Item> getPollItems(){
        def pollItems = this.sections.collect { it.items }.flatten()
        return pollItems
    }
}
