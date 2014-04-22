package mypoll

class NominalScale extends Scale{
	
	static hasMany = [options: Option]
	
	Set<Option> options

    static constraints = {
    }
}
