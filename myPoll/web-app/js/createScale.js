var addNewOptionLink = document.querySelector('#addNewOption')
,   removeLastOptionLink = document.querySelector('#removeLastOption')
,	scaleOptionList = document.querySelector('#scaleOptionList');

if (addNewOptionLink != null) addNewOptionLink.addEventListener('click', addOption, false);
if (removeLastOptionLink != null) removeLastOptionLink.addEventListener('click', removeLastOption, false)

function addOption() {
	var optionCount = scaleOptionList.childElementCount;
	var newOption = createOptionLi(optionCount);
	scaleOptionList.appendChild(newOption);
    removeLastOptionLink.classList.remove('disabled');
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

function removeLastOption() {
    var optionCount = scaleOptionList.childElementCount;
    if (optionCount > 2) {
        scaleOptionList.removeChild(scaleOptionList.lastElementChild);
        var newOptionCount = scaleOptionList.childElementCount;
        if (newOptionCount === 2) removeLastOptionLink.classList.add('disabled');
    }

    return
}