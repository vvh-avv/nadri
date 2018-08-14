/**
 * 
 */

$(function() {
	
	$('.placeTitle').on('click',function(){
		console.log($(this).attr('name'));
		self.location = '/spot/getSpot?spotNo='+$(this).attr('name');
	})
	
	$('.board-link').on('click',function(){
		var link = $(this).attr('id');
		window.open('/board/getBoard?boardNo='+link,'_blank');
	})
	
	$('.schedule-link').on('click',function(){
		var link = $(this).attr('id');
		window.open('/schedule/getSchedule?scheduleNo='+link,'_blank');
	})
	
});
