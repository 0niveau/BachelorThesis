package mypoll

class Item {

	String question
	Long idOfOrigin
    QuestionType type
	
	static hasMany = [choices: String]
	static belongsTo = [pollSection: PollSection]

    List choices

    static constraints = {
    }
}
