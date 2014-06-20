package mypoll

class Option {
	
	String value
	
    static constraints = {
		value blank: false, maxSize: 25
    }
}
