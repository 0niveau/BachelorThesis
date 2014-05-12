package mypoll

class Item {

	String title
	String question
	Long idOfOrigin
	
	static hasMany = [options: Option]
	static belongsTo = [pollSection: PollSection]

    static constraints = {
    }
}
