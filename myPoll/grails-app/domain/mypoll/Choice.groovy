package mypoll

class Choice {
	
	String value
	
    static constraints = {
		value blank: false, maxSize: 25
    }
}
