window.onload = function() {
	var slider
	,  sliderElements = []
	,  elementCount = 0
	,  back
	,  forth
	,  displayedElement;
	
	slider = document.querySelector('.slider');
	elementCount = sliderElements.length;
	back = document.querySelector('#prev');
	forth = document.querySelector('#next');
	
	if (back !== null) back.addEventListener('click', backwardsHandler, false);
	if (forth !== null) forth.addEventListener('click', forwardsHandler, false);
	if (slider !== null ) initializeSlider();
	
	function initializeSlider () {
        [].forEach.call(slider.getElementsByClassName('sliderElement'), function(sliderElement) {
            sliderElements[elementCount] = sliderElement;
            elementCount += 1
        });
		displayedElement = sliderElements[0];
		displayedElement.classList.add('displayed');
		back.classList.add('disabled');
	}
	
	function backwardsHandler (e) {
		var index;
		
		index = sliderElements.indexOf(displayedElement);
		
		if (index === 0) return;
		forth.classList.remove('disabled');
		displayedElement.classList.remove('displayed');
		displayedElement = sliderElements[index - 1];
		displayedElement.classList.add('displayed');
		
		index = index -1;
		if (index === 0) {
			back.classList.add('disabled');
		}
	}
	
	function forwardsHandler (e) {
		var index;
		
		index = sliderElements.indexOf(displayedElement);
		if (index === elementCount - 1) return;
		back.classList.remove('disabled');
		displayedElement.classList.remove('displayed');
		displayedElement = sliderElements[index + 1];
		displayedElement.classList.add('displayed');
		
		index = index +1		
		if (index === elementCount -1) {
			back.classList.add('disabled');
		}
	}
};