package mypoll

class ItemAggregation {
	
	Item item
	String question
	List<String> possibleAnswers
	Map<String, Integer> selectionsPerAnswerA
	Map<String, Integer> selectionsPerAnswerB

    static constraints = {
    }
}
