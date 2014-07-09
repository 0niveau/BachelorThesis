window.addEventListener("load", function() {
	var draggableItems = document.querySelectorAll('.draggableItem')
	, beingDragged
	, beingHovered
	, lastMovedItem
	, draggableItemList;

	[].forEach.call(draggableItems, function(draggableItem) {
		draggableItem.addEventListener('dragstart', handleDragStart, false);
		draggableItem.addEventListener('dragenter', handleDragEnter, false);
		draggableItem.addEventListener('dragover', handleDragOver, false);
		draggableItem.addEventListener('dragleave', handleDragLeave, false);
		draggableItem.addEventListener('drop', handleDropOnItem, false);
		draggableItem.addEventListener('dragend', handleDragEnd, false);
	});

	function handleDragStart(e) {
		if (lastMovedItem != null) {
			lastMovedItem.classList.remove('lastMoved');
		}

		beingDragged = this;
		beingDragged.classList.add('beingDragged');

		draggableItemList = beingDragged.parentElement;
		draggableItemList.classList.add('over');  

		e.dataTransfer.effectAllowed = 'move';
		e.dataTransfer.setData('text/html', this.innerHTML);
		return false;
	}

	function handleDragOver(e) {
		if (e.preventDefault) {
			e.preventDefault(); // Necessary. Allows us to drop.
		}
		e.dataTransfer.dropEffect = 'move';

		return false;
	}

	function handleDragEnter(e) {
		if (beingHovered != null) {
			beingHovered.classList.remove('over');
		}
		beingHovered = this;
		beingHovered.classList.add('over');

		if(this === beingDragged.previousSibling) {
			swapElements(this, beingDragged);
		} else {
			swapElements(beingDragged, this);
		}
		return false;
	}

	function handleDragLeave(e) {

	}

	function handleDropOnItem(e) {
		// stops the browser from redirecting.
		if (e.preventDefault) {
			e.preventDefault();
		}
		if (e.stopPropagation) {
			e.stopPropagation();
		}

		return false;
	}

	function handleDragEnd(e) {
		// this/e.target is the source node.
		beingDragged.classList.remove('beingDragged');

		lastMovedItem = this;
		lastMovedItem.classList.add('lastMoved');

		draggableItemList.classList.remove('over');
		resetIndexes(draggableItemList);

		[].forEach.call(draggableItems, function(draggableItem) {
			draggableItem.classList.remove('over');
		});  
		return false;
	}

	function swapElements (el1,el2) {
		temp = draggableItemList.replaceChild(el1,el2);
		draggableItemList.insertBefore(temp, el1);
	}

	function resetIndexes(parent) {
//		find item id input elements in parent
		var childNodes = parent.childNodes
		,   itemIdInputs = parent.getElementsByClassName('itemIdInput')
		,   loopCount = 0
		,	listedElements = parent.getAttribute('data-listedElements')
		,   attributeValue = '';

//		reset 'name' attribute according to new order
		[].forEach.call(itemIdInputs, function(itemIdInput) {
			attributeValue = listedElements + '[' + loopCount + ']';
			itemIdInput.setAttribute('name', attributeValue);
			loopCount += 1;
		});
	}
}, false);