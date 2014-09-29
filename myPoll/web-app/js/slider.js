window.onload = function() {


    var slider
        ,  sliderElements = []
        ,  radios = document.querySelectorAll('.radio')
        ,  textAreas = document.querySelectorAll('.textArea')
        ,  elementCount = 0
        ,  back
        ,  forth
        ,  finish
        ,  displayedElement;

    slider = document.querySelector('.slider');
    elementCount = sliderElements.length;
    back = document.querySelector('#prev');
    forth = document.querySelector('#next');
    finish = document.querySelector('#finish');

    if (back !== null) back.addEventListener('click', backwardsHandler, false);
    if (forth !== null) forth.addEventListener('click', forwardsHandler, false);
    if (finish !== null) finish.addEventListener('click', finishHandler, false);
    if (slider !== null ) initializeSlider();

    function initializeSlider () {
        [].forEach.call(slider.getElementsByClassName('sliderElement'), function(sliderElement) {
            sliderElements[elementCount] = sliderElement;
            elementCount += 1
        });
        [].forEach.call(radios, function(radio) {
            radio.addEventListener('click', handleAnswer, false);
        });
        [].forEach.call(textAreas, function(textArea) {
            textArea.addEventListener('input', handleAnswer, false);
        });
        displayedElement = sliderElements[0];
        displayedElement.classList.add('displayed');
        back.classList.add('disabled');
        forth.classList.add('disabled');
        finish.classList.add('disabled');
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
        if (forth.classList.contains('disabled')) return;
        var index;

        index = sliderElements.indexOf(displayedElement);
        if (index === elementCount - 1) return;
        back.classList.remove('disabled');
        displayedElement.classList.remove('displayed');
        displayedElement = sliderElements[index + 1];
        displayedElement.classList.add('displayed');

        if(!displayedElement.classList.contains('answered')) {
            forth.classList.add('disabled');
        }

        index = index +1;
        if (index === elementCount -1) {
            forth.classList.add('disabled');
        }
    }

    function handleAnswer () {
        var sliderElement = this.parentElement;
        while(!sliderElement.classList.contains('sliderElement')) {
            sliderElement = sliderElement.parentElement;
        }
        sliderElement.classList.add('answered');
        if (isLastElement(sliderElement)) {
            finish.classList.remove('disabled');
        } else {
            forth.classList.remove('disabled');
        }
    }

    function finishHandler (e) {
        if (finish.classList.contains('disabled')) e.preventDefault();
    }

    function isLastElement(sliderElement) {
        var index;

        index = sliderElements.indexOf(sliderElement);
        if (index === elementCount -1) {
            return true;
        }
        return false;
    }


    // keep for later comparison

    /*
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
        if (elementCount <= 1 ) {
            forth.classList.add('disabled');
        }
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
			forth.classList.add('disabled');
		}
	}
	*/
};