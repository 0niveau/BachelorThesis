package mypoll

class Poll {

	String name
	String description
	Boolean isActive
	String testObjectUrl

	static hasMany = [sections: PollSection, opinions: Opinion]
	
	List sections = []
	List opinions = []
	
    static constraints = {
    	name blank: false, maxSize: 50
        description maxSize: 255
		isActive nullable: true
		testObjectUrl blank: false, maxSize: 255
    }
	
	static mapping = {
		opinions cascade: 'all-delete-orphan'
	}
	
    def List<Item> getPollItems(){
        def pollItems = this.sections.collect { it.items }.flatten()
        return pollItems
    }

    def resetOpinions() {
        this.opinions.clear()
        this.save flush:true
    }
}
