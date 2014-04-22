package mypoll

class OrdinalScale extends Scale {
	
	static hasMany = [options: Option]
	
	SortedSet<Option> options

    static constraints = {
    }
}
