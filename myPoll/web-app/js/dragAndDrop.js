

function handleDragStart(e) {
  this.classList.add('beingDragged');
  e.dataTransfer.effectAllowed = 'move';
  e.dataTransfer.setData('Text', 'BlaBla');
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
  //this / e.target is current target element.
  if (e.stopPropagation) {
    e.stopPropagation(); // stops the browser from redirecting.
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

