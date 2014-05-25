var currentSelection;
var currentSelectionDetails;

var clearDetails = document.querySelector('#clearDetails');
if (clearDetails != null) clearDetails.addEventListener('click', resetDetailsSelection, false);

var selectableValues = document.querySelectorAll('.selectable');
[].forEach.call(selectableValues, function(selectableValue) {
	selectableValue.addEventListener('click', clickHandler, false);
});

function clickHandler(e) {
    var selectionRef;

	resetDetailsSelection();
	
	currentSelection = this;
	currentSelection.classList.add('selected');
	
	selectionRef = currentSelection.getAttribute('data-selectionRef');
	
	currentSelectionDetails = document.querySelector('#' + selectionRef);
	currentSelectionDetails.classList.add('selected');
}

function resetDetailsSelection () {
	currentSelection = document.querySelectorAll('.selected');
	[].forEach.call(currentSelection, function(selected) {
		selected.classList.remove('selected');
	});
}
