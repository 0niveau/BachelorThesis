package mypoll

class ItemAggregation {
	
	Item item
	String question
	List<String> possibleAnswers
	Map<String, Integer> selectionsPerAnswer

    static constraints = {
    }
}
