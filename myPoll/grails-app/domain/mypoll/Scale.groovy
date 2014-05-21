package mypoll

class Scale {
	
	String name
	
	static hasMany = [options: Option]
	List options
	
    static constraints = {
		name blank: false
    }
}