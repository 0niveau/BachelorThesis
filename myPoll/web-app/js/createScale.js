var addNewChoiceLink = document.querySelector('#addNewChoice')
,   removeLastChoiceLink = document.querySelector('#removeLastChoice')
,	scaleChoiceList = document.querySelector('#scaleChoiceList');

if (addNewChoiceLink != null) addNewChoiceLink.addEventListener('click', addChoice, false);
if (removeLastChoiceLink != null) removeLastChoiceLink.addEventListener('click', removeLastChoice, false)

function addChoice() {
	var choiceCount = scaleChoiceList.childElementCount;
	var newChoice = createChoiceLi(choiceCount);
	scaleChoiceList.appendChild(newChoice);
    removeLastChoiceLink.classList.remove('disabled');
}

function createChoiceLi (choiceCount) {
	
	var choiceLi = document.createElement('li');
	var input = document.createElement('input');
	var inputName = 'choices[' + choiceCount + ']';
	input.setAttribute('name', inputName);
	input.setAttribute('type', 'text');
	
	choiceLi.appendChild(input);
	
	return choiceLi;
}

function removeLastChoice() {
    var choiceCount = scaleChoiceList.childElementCount;
    if (choiceCount > 2) {
        scaleChoiceList.removeChild(scaleChoiceList.lastElementChild);
        var newChoiceCount = scaleChoiceList.childElementCount;
        if (newChoiceCount === 2) removeLastChoiceLink.classList.add('disabled');
    }

    return
}