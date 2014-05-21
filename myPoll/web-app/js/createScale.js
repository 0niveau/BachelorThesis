var addNewOption = document.querySelector('#addNewOption')
,	scaleOptionList = document.querySelector('#scaleOptionList');

if (addNewOption != null) addNewOption.addEventListener('click', addOption, false);	

function addOption() {
	var optionCount = scaleOptionList.childElementCount;
	var newOption = createOptionLi(optionCount);
	scaleOptionList.appendChild(newOption);
	scaleOptionList.classList.remove('hidden');
	if (em)
	document.remove(emptyListHint);
}

function createOptionLi (optionCount) {
	
	var optionLi = document.createElement('li');
	var input = document.createElement('input');
	var inputName = 'options[' + optionCount + ']';
	input.setAttribute('name', inputName);
	input.setAttribute('type', 'text');
	
	optionLi.appendChild(input);
	
	return optionLi;
}