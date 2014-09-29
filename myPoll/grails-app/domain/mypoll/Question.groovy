package mypoll

class Question {

	String text
    Scale scale
    QuestionType type

    static belongsTo = [scale: Scale]

    static constraints = {
        text maxSize: 255
        scale nullable: true, validator: { val, obj ->
            if (val == null && obj.type == QuestionType.CLOSED) return false
        }
    }
}