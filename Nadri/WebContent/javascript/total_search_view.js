/**
 * 
 */

$(function() {
	
	$('.placeTitle').on('click',function(){
		console.log($(this).attr('name'));
		self.location = '/spot/getSpot?spotNo='+$(this).attr('name');
	})
	
});
