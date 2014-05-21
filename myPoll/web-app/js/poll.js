var currentProperty;
var currentPropertyDetails;

var clearDetails = document.querySelector('#clearDetails');
if (clearDetails != null) clearDetails.addEventListener('click', resetPropertyDetailsSelection, false);

var propertyValues = document.querySelectorAll('.property-value.selectable');
[].forEach.call(propertyValues, function(propertyValue) {
	propertyValue.addEventListener('click', clickHandler, false);
});

function clickHandler(e) {
	resetPropertyDetailsSelection();
	
	currentProperty = this;
	currentProperty.classList.add('selected');
	
	var propertyRef = currentProperty.getAttribute('data-propertyRef');
	
	currentPropertyDetails = document.querySelector('#' + propertyRef);
	currentPropertyDetails.classList.add('selected');
}

function resetPropertyDetailsSelection () {
	currentSelection = document.querySelectorAll('.selected');
	[].forEach.call(currentSelection, function(selected) {
		selected.classList.remove('selected');
	});
}
