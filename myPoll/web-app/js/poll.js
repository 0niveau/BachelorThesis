(function($) {
	var pollSections = $("#pollSectionList").children();
	var pollSectionDetails = $(".pollSectionDetails");
	var clearDetails = $("#clearDetails");
	
	function resetPollSectionSelection() {			
		pollSections.removeClass('selected');
		pollSectionDetails.removeClass('selected');
		clearDetails.addClass('hidden');
	}
	
	function showPollSectionDetails() {
		var pollSectionId = $( this ).attr("data-sectionId");
		var details = $("." + pollSectionId);
		
		resetPollSectionSelection();
		$(this).addClass('selected');
		details.addClass('selected');
		clearDetails.removeClass('hidden');
	}
	
	$( document ).ready(function() {
		pollSections.click(showPollSectionDetails);
		clearDetails.click(resetPollSectionSelection);
	});
})(jQuery);