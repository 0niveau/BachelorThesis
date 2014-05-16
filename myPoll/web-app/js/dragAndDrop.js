

function handleDragStart(e) {
  this.classList.add('beingDragged');
  
  beingDragged = this;
  
  e.dataTransfer.effectAllowed = 'move';
  e.dataTransfer.setData('text/html', this.innerHTML);
}

function handleDragOver(e) {
  if (e.preventDefault) {
    e.preventDefault(); // Necessary. Allows us to drop.
  }
  e.dataTransfer.dropEffect = 'move';
  
  this.classList.add('over');
  
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
  
  // Don't do anything if beingDragged is dropped on itself
  if(beingDragged != this) {
	parent = this.parentElement;
	parent.insertBefore(beingDragged, this);	
  }
  
  return false;
}

function handleDragEnd(e) {
  // this/e.target is the source node.
  this.classList.remove('beingDragged');
  [].forEach.call(pollSectionItems, function(pollSectionItem) {
    pollSectionItem.classList.remove('over');
  });
  [].forEach.call(pollSectionItemLists, function(pollSectionItemList) {
    pollSectionItemList.classList.remove('over');
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

var pollSectionItemLists = document.querySelectorAll('.pollSectionItemList');
[].forEach.call(pollSectionItemLists, function(pollSectionItemList) {
  pollSectionItemList.addEventListener('dragover', handleDragOver, false);
  pollSectionItemList.addEventListener('dragenter',handleDragEnter, false);
  pollSectionItemList.addEventListener('dragleave', handleDragLeave, false);
});

