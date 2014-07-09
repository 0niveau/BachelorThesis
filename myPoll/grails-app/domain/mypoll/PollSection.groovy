package mypoll

class PollSection {

	String name
	String description
	Boolean needsTestObject

	static hasMany = [items: Item]
	static belongsTo = [poll: Poll]

    List items
	
    static constraints = {
    	name blank: false, maxSize: 50
		description nullable: true, maxSize: 255
    }
	
	static mapping = {
		items cascade: 'all-delete-orphan'
	}
}
