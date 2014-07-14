package mypoll

class Item {

	String question
	Long idOfOrigin
	
	static hasMany = [choices: Choice]
	static belongsTo = [pollSection: PollSection]

    List choices

    static constraints = {
    }
}
