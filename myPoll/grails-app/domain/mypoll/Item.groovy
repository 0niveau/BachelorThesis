package mypoll

class Item {

	String question
	Long idOfOrigin
	
	static hasMany = [options: Option]
	static belongsTo = [pollSection: PollSection]

    static constraints = {
    }
}
