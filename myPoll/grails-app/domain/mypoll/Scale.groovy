package mypoll

class Scale {
	
	String name
	List options
	List questions
	
	static hasMany = [options: Option, questions: Question]
		
    static constraints = {
		name blank: false, maxSize: 25
        options minSize: 2
    }
}