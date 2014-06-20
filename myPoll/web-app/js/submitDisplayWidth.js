window.addEventListener("load", function() {
    var displayWidthInputs = document.querySelectorAll('.displayWidthInput');
    var displayWidth = window.innerWidth;

    [].forEach.call(displayWidthInputs, function(displayWidthInput) {
        displayWidthInput.setAttribute('value', displayWidth.toString());
    });

}, false);