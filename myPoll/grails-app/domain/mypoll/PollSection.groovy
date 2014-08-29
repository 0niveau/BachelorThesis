package mypoll

class PollSection {

	String name
	String description
	Boolean needsTestObject

    static belongsTo = [poll: Poll]
	static hasMany = [items: Item]

    List items
	
    static constraints = {
    	name blank: false, maxSize: 50
		description nullable: true, maxSize: 255
    }
	
	static mapping = {
		items cascade: 'all-delete-orphan'
	}
}
