/**
 *  Jquery가 반드시 있어야합니다.
 */

$(function(){
	
	$("a.user-info").on("click",function(){
		self.location.href="${param.uri}user/listUser?userId=${sessionScope.user.userId}";
	});
	
	$('.profile').on('mouseover',function(){
		$(this).css('cursor','pointer');
	})
		
	$('.topele').on("mouseover",function(){
		$(this).css("cursor","pointer");
		$(this).css("color","black");
	})
	
	$('.topele').on("mouseout",function(){
		$(this).css("color","white");
	})	
	
	$('.join').on('click',function(){
		self.location = '/user/listUser';
	})
	
	$('.login').on('click',function(){
		self.location = '/user/login';
	})
	
	$(window).scroll(function() {
		if ($(document).scrollTop() > 0) {
			$('.topbar').attr('class', 'topfixed');
			$('.title').attr('class', 'titlefixed');
			$('.titlefixed').attr('src', '/images/common/title_colored.png');
			$('.join').attr('src', '/images/user/join_white.png');
			$('.login').attr('src', '/images/user/login_white.png');
			$('.topmenus').hide();
			$('.searcher').css('top','15px');
			$('.sidemenu').css('top','10px');
			$('.right-box > img').css('width','20px');
			
			} else {
			$('.topfixed').attr('class', 'topbar');
			$('.titlefixed').attr('class', 'title');
			$('.title').attr('src', '/images/common/title.png');
			$('.join').attr('src', '/images/user/join_black.png');
			$('.login').attr('src', '/images/user/login_black.png');
			$('.topmenus').show();
			$('.searcher').css('top','7vh');	
			$('.sidemenu').css('top','5vh');
			$('.right-box > img').css('width','35px');
		}

	});
	
	$('.popular-contents').slick({
		slidesToShow: 3,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 2000,
		arrows: false,
	});
	
	
	$('.searcher').on('keypress',function(e){
		if(e.which == 13){
			if($('.searcher').val() == ""){
				alert("검색어를 입력해주세요!");
				return;
			}else{
				self.location = "/searchLog/listSearchLog?searchKeyword="+$('.searcher').val();
			}
		}
	})
	
	
})