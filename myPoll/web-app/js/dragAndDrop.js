

function handleDragStart(e) {
  this.classList.add('beingDragged');
  
  beingDragged = this;
  pollSectionItemList = beingDragged.parentElement;
  pollSectionItemList.classList.add('over');

  // extract this into own function ?
  var li = document.createElement('li');
  li.setAttribute('id', 'lastPollSectionItem');
  li.classList.add('pollSectionItem');
  li.addEventListener('dragenter', handleDragEnter, false);
  li.addEventListener('dragover', handleDragOver, false);
  li.addEventListener('dragleave', handleDragLeave, false);
  li.addEventListener('drop', handleDrop, false);
  li.addEventListener('dragend', handleDragEnd, false);
  pollSectionItemList.appendChild(li);
  lastPollSectionItem = li;
  
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
  this.classList.add('over');
  
  return false;
}

function handleDragLeave(e) {
  this.classList.remove('over');
}

function handleDrop(e) {
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

function handleDragEnd(e) {
  // this/e.target is the source node.
  this.classList.remove('beingDragged');
  pollSectionItemList.removeChild(lastPollSectionItem);
  pollSectionItemList.classList.remove('over');

  [].forEach.call(pollSectionItems, function(pollSectionItem) {
    pollSectionItem.classList.remove('over');
  });
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

var pollSectionItems = document.querySelectorAll('.pollSectionItem');
[].forEach.call(pollSectionItems, function(pollSectionItem) {
  pollSectionItem.addEventListener('dragstart', handleDragStart, false);
  pollSectionItem.addEventListener('dragenter', handleDragEnter, false);
  pollSectionItem.addEventListener('dragover', handleDragOver, false);
  pollSectionItem.addEventListener('dragleave', handleDragLeave, false);
  pollSectionItem.addEventListener('drop', handleDrop, false);
  pollSectionItem.addEventListener('dragend', handleDragEnd, false);
});

var beingDragged;
var lastPollSectionItem;
var pollSectionItemList;