/**
 *  Jquery가 반드시 있어야합니다.
 */

$(function(){
	
	$("a.user-info").on("click",function(){
		self.location.href="${param.uri}user/listUser?userId=${sessionScope.user.userId}";
	});
	
	$('.icons').on('mouseover',function(){
		$(this).css('cursor','pointer');
		$(this).css("color","powderblue");
	})
	
	$('icons').on('mouseout',function(){
		$(this).css('color','');
	})
	
	$('.profile').on('mouseover',function(){
		$(this).css('cursor','pointer');
	})
		
	$('.topele').on("mouseover",function(){
		$(this).css("cursor","pointer");
		$(this).css("color","powderblue");
	})
	
	$('.topele').on("mouseout",function(){
		$(this).css("color","#D4D4D4");
	})
	
	
	$(window).scroll(function() {
		if ($(document).scrollTop() > 0) {
			$('.topbar').attr('class', 'topfixed');
			$('.title').attr('class', 'titlefixed');
			$('.topmenus').hide();
			$('.sidemenu').css('top','0vh');
			$('.searcher').css('top','2vh');
			
			} else {
			$('.topfixed').attr('class', 'topbar');
			$('.titlefixed').attr('class', 'title');
			$('.topmenus').show();
			$('.sidemenu').css('top','6vh');
			$('.searcher').css('top','7vh');	
		}

	});
	
})