/**
 *    jquery 필수 입니다.
 */

function realtimeClock() {
	var d = new Date();

	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2);
	  var t = 
	    leadingZeros(d.getHours(), 2) + ':' +
	    leadingZeros(d.getMinutes(), 2) + ':' +
	    leadingZeros(d.getSeconds(), 2);
	  $('.date').text(s);
	  $('.time').text(t);
	  setTimeout("realtimeClock()", 1000);
}


function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}


$(function(){	

	/* index page animation start */

	$('.admin-sub-navbar > div').on('click', function() {
		var way = $(this).attr('class');
		if (way == "inquire") {
			self.location = '/admin/listInquire';
		} else if (way == "spot") {
			self.location = '/admin/listSpot';
		} else if (way == "graph") {
			self.location = '/admin/listGraph?duration=day';
		} else if (way == "userList") {
			self.location = '/admin/listUser';
		} else if (way == "userLog") {
			self.location = '/admin/listLog';
		}
	})

	/* index page animation end */
	
	$(window).scroll(function() {
		if ($(document).scrollTop() > 80) {
			$('.admin-sub-navbar').css('position','fixed');
			$('.admin-sub-navbar').css('top','0');
			$('.admin-sub-navbar').css('z-index','99');
			$('.admin-navbar').css('height','120px');
		} else {
			$('.admin-sub-navbar').css('position','relative');
			$('.admin-sub-navbar').css('z-index','3');
			$('.admin-navbar').css('height','80px');
		}
	});
	
	$('.choose').on('click',function(){
		var count = $(this).attr('name');
		var lastindex = count.charAt(count.length - 1);
		console.log(lastindex);
		$('.stacking').css('z-index','9');
		$('.stacking'+lastindex).css('z-index','10');
	})
	
	$('.stacking').on('mouseover',function(){
		$('.filler').css('visibility','visible');
		$('.stack-text').css('visibility','visible');
	})
	
	$('.stacking').on('mouseleave',function(){
		$('.filler').css('visibility','hidden');
		$('.stack-text').css('visibility','hidden');
	})
	
	$('li').on('focusin',function(){
		
	})
	      
	
})