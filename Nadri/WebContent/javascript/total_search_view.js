/**
 * 
 */

$(function() {
	
	$('.placeTitle').on('click',function(){
		console.log($(this).attr('name'));
		var texts = $(this).text();
		if(texts=='검색결과가 없습니다.'){
			swal({
	            title: "검색 결과가 없습니다!",
	            text: "다른 검색어를 시도해보시는건 어떨까요?",
	            icon: "warning",
	            buttons: false,
	          });
		}else{
			window.open('/spot/getSpot?spotNo='+$(this).attr('name'),'_blank');			
		}
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
