package mypoll

class Item {

	String title
	String question
	
	static hasMany = [options: Option]
	static belongsTo = [pollSection: PollSection]

    static constraints = {
    }
}
