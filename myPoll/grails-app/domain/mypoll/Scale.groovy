package mypoll

class Scale {

	String name
	List choices
	List questions

	static hasMany = [choices: String, questions: Question]

    static constraints = {
		name blank: false, maxSize: 25
        choices minSize: 2
    }
}