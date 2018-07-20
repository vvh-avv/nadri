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
			$('.menuExpand').attr('src','/images/common/more_white.png');
			$('.searchExpand').attr('src','/images/common/search_white.png');
			$('.toggleMenuMob').css('position','fixed');
			$('.toggleMenuMob').css('top','50px');
			$('.toggleMenuMob').css('z-index','999');
			$('.toggleMenuMob').css('opacity','0.8');
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
			$('.menuExpand').attr('src','/images/common/more_black.png');
			$('.searchExpand').attr('src','/images/common/search_black.png');
			$('.toggleMenuMob').css('top','0');
		}

	});
	
/*	$('.popular-contents').slick({
		slidesToShow: 3,
		slidesToScroll: 1,
		autoplay: true,
		autoplaySpeed: 2000,
		arrows: false,
	});*/
	
	
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
			$('.topbar').css('background-color','rgba(255, 255, 255, 0.5)');
			$('.toggleMenuMob').css('display','block');
			$('.toggleMenuMob').html('<li class="userMenus"> 마 이 페 이 지 </li><li class="userMenus"> 나 들 이 백 과 </li><li class="userMenus"> 게 시 판 </li><li class="userMenus"> 일 정 작 성 </li>');;
			valiExpand = true;
			console.log(valiExpand);
		}else{
			$('.toggleMenuMob').css('display','none');
			$('.topbar').css('background-color','rgba(255, 255, 255, 0)');
			valiExpand = false;
			console.log(valiExpand);
		}
	})
	
	$('.searchExpand').on('click',function(){
		if(!searchExpand){
			$('.topbar').css('background-color','rgba(255, 255, 255, 0.5)');
			$('.toggleMenuMob').css('display','block');
			$('.toggleMenuMob').html('<li style="padding:20px 20px;"><input type="text" class="mobSearcher" name="searchKeyword" value=""></li>');;
			searchExpand = true;
			console.log(searchExpand);
		}else{
			$('.toggleMenuMob').css('display','none');
			$('.topbar').css('background-color','rgba(255, 255, 255, 0)');
			searchExpand = false;
			console.log(searchExpand);
		}
	})
	
	$(document).on('click','.userMenus',function(){
		console.log("??");
		$(this).css('background-color','grey');
		$(this).css('color','white');
	})
	
	
})