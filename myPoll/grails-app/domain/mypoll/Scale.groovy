package mypoll

abstract class Scale {
	
	static hasMany = [options: Option]

    static constraints = {
    }
}