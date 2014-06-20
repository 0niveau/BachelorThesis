package mypoll

class Question {

	String text	
	Scale scale

    static constraints = {
        text maxSize: 255
    }
}