/**
 *  Jquery가 반드시 있어야합니다.
 */

$(function(){
	
	$("a.user-info").on("click",function(){
		self.location.href="${param.uri}user/listUser?userId=${sessionScope.user.userId}";
	});
	
	$('.profile').on('mouseover',function(){
		$(this).css('cursor','pointer');
		$(this).css('border','4px solid #60daaa');		
	})
	
	$('.profile').on('mouseleave',function(){
		$(this).css('border','4px solid white');		
	})
	
	$('.friend').on('click',function(){
		self.location = '/user/listUser';
	})
	
	$('.friend').on('mouseover',function(){
		$(this).attr("src","/images/common/users_green.png");
	})
	
	$('.friend').on('mouseleave',function(){
		$(this).attr("src","/images/common/user_white.png");
	})
	
	$('.chat').on('mouseover',function(){
		$(this).attr("src","/images/common/chat_green.png");
	})
	
	$('.chat').on('mouseleave',function(){
		$(this).attr("src","/images/common/chat_white.png");
	})
	
	$('.bell').on('mouseover',function(){
		$(this).attr("src","/images/common/bell_green.png");
	})
	
	$('.bell').on('mouseleave',function(){
		$(this).attr("src","/images/common/bell_white.png");
	})
	
	$('.login').on('click',function(){
		self.location = '/user/login';
	})
	
	$(window).scroll(function() {
		if ($(document).scrollTop() > 0) {
			$('.topbar').attr('class', 'topfixed');
			$('.title').attr('class', 'titlefixed');
			$('.topmenus').hide();
			$('.searcher').css('top','9px');
			$('.sidemenu').css('top','4px');
			$('.right-box').css('top','15px');
		} else {
			$('.topfixed').attr('class', 'topbar');
			$('.titlefixed').attr('class', 'title');
			$('.topmenus').show();
			$('.searcher').css('top','7vh');
			$('.sidemenu').css('top','5vh');
			$('.right-box').css('top','6vh');
		}

	});
	
	$(".arrowDonw").click(function() {
	    $('html,body').animate({
	        scrollTop: $(".middle-bar").offset().top
	    }, 1000);
	});
	
/*	$('.popular-contents').slick({
		slidesToShow: 3,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 2000,
		arrows: false,
	});*/
	
	$('.searcher').on('focusin',function(){
		$(this).attr('placeholder',"");
	});
	
	$('.searcher').on('focusout',function(){
		$(this).attr('placeholder',"검색어를 입력해주세요.");
	});
	
	$('.searcher').on('keypress',function(e){
		if(e.which == 13){
			if($('.searcher').val() == ""){
				alert("검색어를 입력해주세요!");
				return;
			}else{
				$('body').css('overflow','hidden');
				$('#loadStatus').css('display','block');
				$('.indexHead').css('background','white');
				self.location = "/searchLog/listSearchLog?searchKeyword="+$('.searcher').val();
			}
		}
	})
	
	$(document).on('keypress','.mobSearcher',function(e){
		if(e.which == 13){
			if($(this).val() == ""){
				alert("검색어를 입력해주세요!");
				return;
			}else{
				self.location = "/searchLog/listSearchLog?searchKeyword="+$(this).val();
			}
		}
	})
	
	$("button").on('click',function(){
		$('.indexHead').css('background','url(/images/common/img4.jpg)');
	})
	
	$('.boards').on('click',function(){
		self.location="/board/listBoard";
	})
	
	var valiExpand = false;
	var searchExpand = false;
	
	$('.menuExpand').on('click',function(){
		if(!valiExpand){
			var top = $(document).scrollTop();
			$('.tobbleMunuMob').css('top',top);
			$('.toggleMenuMob').css('width','80%');
			$('.userMenus').css('display','flex');
			$('.userMenus').css('background','white');
			$('.userMenus').css('color','black');
			$('.mobSearcher').css('z-index','99');
			valiExpand = true;
			console.log(valiExpand);
		}
	})
	
	$('.userMenus:first-child').on('click',function(){
		$('.toggleMenuMob').css('width','0%');
		$('.userMenus').css('display','none');
		$('.mobSearcher').css('z-index','9999');
		valiExpand = false;
		console.log(valiExpand);
	})	
	
	$('.mobSearcher').on('click',function(){
		if(!searchExpand){
			searchExpand = true;
			console.log(searchExpand);
		}
	})
	
	$('.mobSearcher').on('focusin',function(){
		$('.mobSearcher').attr('placeholder','');
	})
	
	$('.mobSearcher').on('focusout',function(){
		$('.mobSearcher').attr('placeholder','검색어를 입력해주세요.');
	})
	
	$(document).on('click','.userMenus',function(){
		$(this).css('background-color','grey');
		$(this).css('color','white');
	})
	
	$('.schedules').on('click',function(){
		self.location = "/schedule/addSchedule";
	})
	
	$('.spots').on('click',function(){
		self.location = "/spot/getSpotList?spotCode=0";
	}) 
	
	$('.profile2').on('click',function(){
		$('body').css('overflow','hidden');
		$('.sidecatalogue').css('width','30%');
		$('.floatbackground').css('display','block');
	})
	
	$('.closeAll').on('click',function(){
		$('body').css('overflow','auto');
		$('.sidecatalogue').css('width','0%');
		$('.floatbackground').css('display','none');
	})
	
	$('.friendAlert').on('click',function(){
		$('.friendSmall').css('display','block');
	})

	
	
})