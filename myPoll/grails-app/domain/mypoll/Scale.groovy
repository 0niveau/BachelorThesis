package mypoll

abstract class Scale {
	
	String name
	
	static hasMany = [options: Option]
	
    static constraints = {
		name blank: false
    }
}