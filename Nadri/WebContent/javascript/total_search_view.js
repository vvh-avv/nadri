/**
 * 
 */

$(function() {

	/*
	 * $.get('/nadri/nadriIndex',function(data,status){
	 * console.log(data.boardList.length); for(i = 0; i < data.boardList.length;
	 * i++){ console.log(data.boardList[i]); } })
	 */
	var original_width = $('.searcher > input').css('width');
	var top = $('.bottom-section').offset();
	console.log(top);
	
	$('.search-logs').css('width',original_width);
	$('.searcher > input').css('width',original_width);

	$('.spots').on(
			'mouseenter',
			function() {
				var name = $(this).attr('id');
				$('.' + name).closest('label').css('color', '#00000099');
				$('.' + name).closest('label').css('-webkit-background-clip',
						'unset');
				$('.' + name).closest('label').css('background-color',
						'transparent');
				$('img[name=' + name + ']').css('opacity', '0.8');
				$('img[name=' + name + ']').attr('src',
						'/images/common/' + name + '_color.png');
			});

	$('.spots').on(
			'mouseleave',
			function() {
				var name = $(this).attr('id');
				$('.' + name).closest('label').css('color', 'transparent');
				$('.' + name).closest('label').css('-webkit-background-clip',
						'text');
				$('.' + name).closest('label').css('background-color',
						'#56565694');
				$('img[name=' + name + ']').css('opacity', '0.15');
				$('img[name=' + name + ']').attr('src',
						'/images/common/' + name + '.png');
			})

	var t_chk = true;
	$('.title-section').on('click', function() {
		$('#jolly-icon').attr('class', 'glyphicon glyphicon-ice-lolly');
		$('#jolly-icon').css('animation', 'unset');
		var searcherIconTop = $('.searcher-icon').css('top');
		var mainconTop = $('.maincon').css('top');
		if (t_chk) {
			$('.fix-box').css('height', '70px');
			$(this).css('top', '70px');
			$('.top-icons').css('opacity', '1');
			$('.top-icons').css('top', '7px');
			$('.searcher').css('opacity', '1');
			$('.searcher-icon').css('top',searcherIconTop);
			$('.maincon').css('opacity','1');
			$('.maincon').css('top',mainconTop);
			t_chk = false;
		} else {
			$('.fix-box').css('height', '10px');
			$(this).css('top', '10px');
			$(this).css('cursor', 'pointer');
			$('.top-icons').css('opacity', '0');
			$('.top-icons').css('top', '-10px');
			$('.searcher').css('opacity', '0');
			$('.searcher-icon').css('top','-10px');
			$('.maincon').css('opacity','0');
			$('.maincon').css('top','-10px');
			t_chk = true;
		}

	});
	
	var ts_chk = true;
	$('.title-section-small').on('click', function() {
		$('#jolly-icon-small').attr('class', 'glyphicon glyphicon-ice-lolly');
		$('#jolly-icon-small').css('animation', 'unset');
		if (ts_chk) {
			$('.fix-box-small').css('height', '50px');
			$(this).css('top', '50px');
			$('.fix-box-small').css('border-bottom', 'none');
			$('.maincon-small').css('opacity','1');
			$('.maincon-small').css('top','8px');
			$('.expand-out').css('opacity','1');
			$('.expand-out').css('top','15px');
			$('.searcher-small').css('opacity', '1');
			$('.searcher-icon').css('top','28px');
			ts_chk = false;
		} else {
			$('.fix-box-small').css('height', '10px');
			$('.fix-box-small').css('border-bottom', '10px solid #404548');
			$(this).css('top', '10px');
			$(this).css('cursor', 'pointer');
			$('.searcher-small').css('opacity', '0');
			$('.searcher-icon').css('top','-10px');
			$('.maincon-small').css('opacity','0');
			$('.maincon-small').css('top','-10px');
			$('.expand-out').css('opacity','0');
			$('.expand-out').css('top','-10px');
			ts_chk = true;
		}

	});

	$('.title-section').on('mouseenter', function() {
		$('.title-section > span').css('opacity', '0');
		$('.title-section > div').css('opacity', '1');
	})

	$('.title-section').on('mouseleave', function() {
		$('.title-section > span').css('opacity', '1');
		$('.title-section > div').css('opacity', '0');
	})

	$('.more-than-three')
			.slick(
					{
						prevArrow : "<span class='glyphicon glyphicon-triangle-left slide-button'></span>",
						nextArrow : "<span class='glyphicon glyphicon-triangle-right slide-button'></span>",
						centerMode : true,
						centerPadding : '40px',
						slidesToShow : 3,
						autoplay : true,
						autoplaySpeed : 2000,
						responsive : [ {
							breakpoint : 768,
							settings : {
								arrows : true,
								centerMode : true,
								centerPadding : '40px',
								slidesToShow : 1,
								autoplay : true,
								autoplaySpeed : 2000
							}
						}, {
							breakpoint : 480,
							settings : {
								arrows : true,
								centerMode : true,
								centerPadding : '40px',
								slidesToShow : 1,
								autoplay : true,
								autoplaySpeed : 2000
							}
						} ]
					});

	$('.list-element').on('mouseover', function() {
		var id = $(this).attr('id');
		var cls = $(this).attr('class');
		var clsp = cls.split(' ');
		var clsp1 = clsp[1]
		var count = clsp1.charAt(clsp1.length - 1);
		$('.info' + count).css('visibility', 'visible');
	})

	$('.list-element').on('mouseleave', function() {
		var id = $(this).attr('id');
		var cls = $(this).attr('class');
		var clsp = cls.split(' ');
		var clsp1 = clsp[1]
		var count = clsp1.charAt(clsp1.length - 1);
		$('.info' + count).css('visibility', 'hidden');
	})

	$(window).on('scroll', function() {

		var height;
		var searcher
/*		if ($(document).scrollTop() > 100) {
			$('.odometer').html(odo);
		}*/

		if ($(document).scrollTop() < 70) {
			$('.fix-box').css('height', '70px');
			$('.fix-box-small').css('height', '50px');
			$('.fix-box').css('border-bottom', '0px solid #404548');
			$('.fix-box-small').css('border-bottom', '0px solid #404548');
			$('.title-section').css('opacity', '0');
			$('.title-section').css('pointer-events', 'none');
			$('.title-section').css('top', '70px');
			$('.title-section-small').css('opacity', '0');
			$('.title-section-small').css('pointer-events', 'none');
			$('.title-section-small').css('top', '50px');
			$('.top-icons').css('opacity', '1');
			$('.top-icons').css('top', '7px');
			$('.searcher').css('opacity', '1');
			$('.searcher-small').css('opacity', '1');
			$('.searcher-icon').css('top','28px');
			$('.maincon').css('opacity','1');
			$('.maincon').css('top','14px');
			$('.maincon-small').css('opacity','1');
			$('.maincon-small').css('top','8px');
			$('.expand-out').css('opacity','1');
			$('.expand-out').css('top','15px');
		} else {
			$('.fix-box').css('height', '10');
			$('.fix-box-small').css('height', '10');
			$('.fix-box-small').css('border-bottom', '10px solid #404548');
			$('.fix-box').css('border-bottom', '10px solid #404548');
			$('.title-section').css('opacity', '1');
			$('.title-section').css('pointer-events', 'all');
			$('.title-section').css('top', '10px');
			$('.title-section-small').css('opacity', '1');
			$('.title-section-small').css('pointer-events', 'all');
			$('.title-section-small').css('top', '10px');
			$('.top-icons').css('opacity', '0');
			$('.top-icons').css('top', '-10px');
			$('.searcher').css('opacity', '0');
			$('.searcher-small').css('opacity', '0');
			$('.searcher-icon').css('top','-10px');
			$('.maincon').css('opacity','0');
			$('.maincon').css('top','-10px');
			$('.maincon-small').css('opacity','0');
			$('.maincon-small').css('top','-10px');
			$('.expand-out').css('opacity','0');
			$('.expand-out').css('top','-10px');
		}
	})

	$('.spots').on('click', function() {
		var id = $(this).attr('id');
		if (id == 'rivers') {
			self.location = '/spot/getSpotList?spotCode=4';
		} else if (id == 'parks') {
			self.location = '/spot/getSpotList?spotCode=0';
		} else if (id == 'festivals') {
			self.location = '/spot/getFestivalList';
		} else {
			self.location = '/spot/getSpotList?spotCode=1';
		}
	})

	$('.side-section > span').on('click', function() {
		var id = $(this).attr('id');
		if (id == 'login-open') {
			self.location = '/user/login';
		} else if (id == 'chat-open') {
			self.location = '/board/listBoard';
		} else if (id == 'join-open') {
			self.location = '/user/listUser';
		} else if (id == 'admin-page') {
			self.location = '/admin/adminIndex';
		} else if (id == 'log-out') {
			self.location = '/user/logout';
		} else if (id == 'pencil') {
			self.location = '/schedule/addSchedule';
		}
	})
	
	$('.side-section-icons > span').on('click', function() {
		var id = $(this).attr('id');
		if (id == 'login-open') {
			self.location = '/user/login';
		} else if (id == 'chat-open') {
			self.location = '/board/listBoard';
		} else if (id == 'join-open') {
			self.location = '/user/listUser';
		} else if (id == 'admin-page') {
			self.location = '/admin/adminIndex';
		} else if (id == 'log-out') {
			self.location = '/user/logout';
		} else if (id == 'pencil') {
			self.location = '/schedule/addSchedule';
		}
	})

	$('.post-title').on('click', function() {
		var id = $(this).attr('id');
		console.log(id);
		self.location = '/board/getBoard?boardNo=' + id;
	});

	$('.schedule-button').on('click', function() {
		var check = $('#session-checker').val();
		console.log(check);
		if (check != 'no_user') {
			console.log("session 여부 : 있음");
			self.location = '/schedule/addSchedule';

		} else {
			console.log("session 여부 : 없음");
			swal({
				title : "회원만 이용하실 수 있어요!",
				text : "일정작성을 위해 가입 또는 로그인을 해주세요.",
				icon : "error",
				button : " 닫 기 ",
			});
		}
	});

	var width;
	var big_width;

	$('.searcher > input').on('focusin', function() {
		var check = $('#session-checker').val();
		width = $(this).css('width');
		big_width = $('.searcher').css('width');
		$(this).attr('placeholder', '');
		$(this).css('width', '100%');
		$('.side-section').css('top', '-50px');
		$('.side-section').css('opacity', '0');
		$('.searcher-icon').css('left','24px');
		$('.maincon').css('opacity','0');
		$('.maincon').css('top','-50px');
		if(check != 'no_user'){		
				$('.search-logs').css('opacity','1');
				$('.search-logs').css('width',big_width);
		}
	})

	$('.searcher > input').on('focusout', function() {
		var check = $('#session-checker').val();
		$(this).attr('placeholder', '검색어를 입력해주세요.');
		$(this).css('width', width);
		$('.side-section').css('top', '10px');
		$('.side-section').css('opacity', '1');
		$('.searcher-icon').css('left','490px');
		$('.maincon').css('opacity','1');
		$('.maincon').css('top','14px');
		if(check != 'no_user'){
			$('.search-logs').css('opacity','0');
			$('.search-logs').css('width',width);
		}
	})
	
	$('.search-history > div').on('click',function(){
		alert($(this).attr('name'));
	});

	$('.searcher > input').on(
			'keydown',
			function(e) {
				console.log(e.which);
				if (e.which == 13) {
					self.location = "/searchLog/listSearchLog?searchKeyword="
							+ $(this).val();
				}
			})
			
	$('.searcher-small > input').on(
			'keydown',
			function(e) {
				console.log(e.which);
				if (e.which == 13) {
					self.location = "/searchLog/listSearchLog?searchKeyword="
							+ $(this).val();
				}
			})

	$('.expand-out').on('click',function(){
		$('.maincon-small').css('opacity','0');
		$('.maincon-small').css('z-index','0');
		$('.maincon-small').css('top','-10px');
		$('.expand-out').css('opacity','0');
		$('.expand-out').css('top','-10px');
		$('.searcher-small').css('opacity', '0');
		$('.middle-section-small').css('top', '-30px');
		$('.searcher-icon').css('top','-10px');
		$('.side-section-icons').css('left','0%');
	})
	
	$('.expand-in').on('click',function(){
		$('.maincon-small').css('opacity','1');
		$('.maincon-small').css('z-index','5');
		$('.maincon-small').css('top','8px');
		$('.expand-out').css('opacity','1');
		$('.expand-out').css('top','15px');
		$('.searcher-small').css('opacity', '1');
		$('.middle-section-small').css('top', '-10px');
		$('.searcher-icon').css('top','28px');
		$('.side-section-icons').css('left','100%');
	})
	
	$('.maincon').on('click',function(){
		self.location = '/nadri/nadriIndex';
	})
	$('.maincon-small').on('click',function(){
		self.location = '/nadri/nadriIndex';
	})

});
