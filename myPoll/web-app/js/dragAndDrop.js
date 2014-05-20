var pollSectionItems = document.querySelectorAll('.pollSectionItem');
[].forEach.call(pollSectionItems, function(pollSectionItem) {
  pollSectionItem.addEventListener('dragstart', handleDragStart, false);
  pollSectionItem.addEventListener('dragenter', handleDragEnter, false);
  pollSectionItem.addEventListener('dragover', handleDragOver, false);
  pollSectionItem.addEventListener('dragleave', handleDragLeave, false);
  pollSectionItem.addEventListener('drop', handleDropOnItem, false);
  pollSectionItem.addEventListener('dragend', handleDragEnd, false);
});

var pollSectionItemLists = document.querySelectorAll('.pollSectionItemList');
[].forEach.call(pollSectionItemLists, function(pollSectionItemList) {
	pollSectionItemList.addEventListener('drop', handleDropOnList, false);
})

var beingDragged;
var beingHovered;
var lastMovedItem;
var lastPollSectionItem;
var pollSectionItemList;

function handleDragStart(e) {
  if (lastMovedItem != null) {
	lastMovedItem.classList.remove('lastMoved');
  }	
	
  this.classList.add('beingDragged');
  
  beingDragged = this;
  pollSectionItemList = beingDragged.parentElement;
  pollSectionItemList.classList.add('over');

  // extract this into own function ?
  var tr = document.createElement('tr');
  tr.setAttribute('id', 'lastPollSectionItem');
  tr.classList.add('pollSectionItem');
  tr.addEventListener('dragenter', handleDragEnter, false);
  tr.addEventListener('dragover', handleDragOver, false);
  tr.addEventListener('dragleave', handleDragLeave, false);
  tr.addEventListener('drop', handleDropOnItem, false);
  tr.addEventListener('dragend', handleDragEnd, false);
  pollSectionItemList.appendChild(tr);
  lastPollSectionItem = tr;
  
  e.dataTransfer.effectAllowed = 'move';
  e.dataTransfer.setData('text/html', this.innerHTML);
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

  var parent = this.parentElement;
  // Don't do anything if beingDragged is dropped on itself
  if(beingDragged != this) {
	parent.insertBefore(beingDragged, this);
  }

  resetIndexes(parent);
  
  return false;
}

function handleDropOnList(e) {
	if (e.preventDefault) {
		e.preventDefault();
	  }
	  if (e.stopPropagation) {
	    e.stopPropagation();
	  }
	  
	  this.appenChild(beingDragged);
}

function handleDragEnd(e) {
  // this/e.target is the source node.
  this.classList.remove('beingDragged');
  
  pollSectionItemList.removeChild(lastPollSectionItem);
  pollSectionItemList.classList.remove('over');

  [].forEach.call(pollSectionItems, function(pollSectionItem) {
    pollSectionItem.classList.remove('over');
  });

  lastMovedItem = this;
  lastMovedItem.classList.add('lastMoved');
}

function resetIndexes(parent) {
// find input elements in parent
    var childNodes = parent.childNodes
    ,   inputNodes = []
    ,   itemIdInputs = parent.getElementsByTagName('input')
    ,   loopCount = 0
    ,   attributeValue = '';

    [].forEach.call(childNodes, function(childNode) {
        if(childNode.tagName === 'input') {
            inputNodes.add(childNode);
        }
    });

    // reset 'name' attribute according to new order
    [].forEach.call(itemIdInputs, function(itemIdInput) {
        attributeValue = 'items[' + loopCount + ']';
        itemIdInput.setAttribute('name', attributeValue);
        loopCount += 1;
    });
}