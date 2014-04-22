package mypoll

class Item {

	String title
	String question
	
	static hasMany = [options: Option]

    static constraints = {
    }
}
