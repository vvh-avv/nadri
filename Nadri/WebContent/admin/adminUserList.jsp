<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- Bootstrap CDN -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- admin index 전용  -->
<link rel="stylesheet" href="/css/adminIndex.css">
<link rel="stylesheet" href="/css/adminIndexSmall.css">
<link rel="stylesheet" href="/css/adminList.css">
<link rel="stylesheet" href="/css/adminInquireSmall.css">
<script src="/javascript/adminIndex.js"></script>

<title>너나들이 어드민 회원목록 페이지</title>
	
<style>

.admin-sub-navbar div:first-child{
	color : #337ab7;
	border-bottom : 3px solid #337ab7;
	cursor: not-allowed;
 	pointer-events: none;
}

.inquire-detail-title{
	display :flex;
	align-items: center;
}

.check-boxes{
	display: flex;
	justify-content: center;
}

</style>	
	
<script type="text/javascript">
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/admin/listUser").submit();
	}

	$(function() {

		$('.inquirebutton').on(
				'click',
				function() {
					var id = $(this).attr('id');
					console.log(id);

					var code = $('#inq' + id + " td:nth-child(2)").text();
					var no = $('#inq' + id + " td:nth-child(1)").text();
					$('.inquireTransaction > span:nth-child(2)').text(code);
					$('.inquireTransaction > span:nth-child(2)').css(
							'font-weight', '800');
					$('.inquireTransaction > span:nth-child(1)').text(no);
					$('.inquireTransaction > span:nth-child(1)').css(
							'font-weight', '800');

					$('#modal1').modal();
				});

		$('td[colspan=7]').hide();

		$('.texts').on('click', function() {
			var id = $(this).attr('id');
			if (id.length == 4) {
				var lastindex = id.charAt(id.length - 1);
				$('.' + lastindex).toggle();

			} else {
				console.log(id);
				var sublast = id.charAt(id.length - 1);
				console.log(sublast);
				var lastindex = id.lastIndexOf(sublast);
				console.log(lastindex);
				var realcount = id.substring(3, lastindex + 1);
				console.log(realcount);
				$('.' + realcount).toggle();
			}
		})

		$('img').on('mouseover', function() {
			$(this).css('cursor', 'pointer');
			$(this).css('opacity', '0.5');
		})

		$('img').on('click', function() {
			window.open($(this).attr('src'), "_blank");
		})

		$('img').on('mouseleave', function() {
			$(this).css('opacity', '1');
		})
		
		var chk = true;
		var male;
		$('.switch').on('change',function(){
			
			if(chk){
				console.log("hihi");
				$('.option-box > div').css('height','200px');
				console.log($('.inquire-title').css('margin-left'));
				male = $('.inquire-title').css('margin-left');
				$('.inquire-title').css('margin-left','0%');
				chk = false;
			}else{
				console.log("byebye");
				$('.option-box > div').css('height','50px');
				$('.inquire-title').css('margin-left',male);
				
				chk = true;
			}
		})
		
		$('.inquireKeyword').on('focusin',function(){
			$('.inquireKeyword').attr('placeholder','');
			$('.glyphicon-search').css('color','#1c2144');
			$('.options > div').css('border','1px solid #1c2144');
		})
		
		$('.inquireKeyword').on('focusout',function(){
			$('.inquireKeyword').attr('placeholder','검색어를 입력해주세요');
			$('.glyphicon-search').css('color','#adadad');
			$('.options > div').css('border','1px solid #c1c1c154');
		})

		$('.inquireKeyword').on('keydown',function(e){
			console.log($('input:radio[name=searchCondition]').is(':checked'));
			var radio = $('input:radio[name=searchCondition]').is(':checked');
			if(e.which == 13){
				if(radio){
					fncGetList(0);	
				}else{
					alert('검색조건을 하나이상 선택해주세요!');
				}
			}
		})
		

	});
</script>

</head>

<body>

	<nav class="admin-navbar">
		<a href="/admin/adminIndex"><h2 class="title">너나들이 Admin</h2></a>
		<div class="navbar-side">
			<a href="/"><div class="glyphicon glyphicon-home"></div></a>
			<div class="profile-photo"
				style="background:url(/images/profile/${user.profileImg}); background-size:contain;">
			</div>
		</div>
	</nav>
	<nav class="admin-sub-navbar">
		<div class="userList">회원목록</div>
		<div class="graph">통계보기</div>
		<div class="spot">백과관리</div>
		<div class="inquire">문의관리</div>
	</nav>

	<div class="container">
		<div class="row option-box">
			<div class="col-md-12 col-xs-12">
				<div class="inquire-title">회원목록 조회하기</div>
				<div class="open-searcher">
					<label class="switch"> <input type="checkbox"> <span
						class="slider round"></span>
					</label>
				</div>
				<div class="row options">
					<form name="inquire-search-form" class="inquire-search-form">
						<div class="col-md-10 col-xs-12">
							<div class="glyphicon glyphicon-search"></div>
							<input type="text" class="inquireKeyword" name="searchKeyword" placeholder="검색어를 입력해주세요"
								value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
							<input style="display:none;">

							<div class="row check-boxes">

								<div class="col-md-3 col-xs-3">
									<input type="radio" name="searchCondition" class="conditions"
										value="0"><label class="cons-label" id="inclCon">
										유저 아이디로 검색 </label>
								</div>

								<div class="col-md-3 col-xs-3">
									<input type="radio" name="searchCondition" class="conditions"
										value="1"><label class="cons-label" id="beginCon">
										유저명으로 검색 </label>
								</div>

								<div class="col-md-3 col-xs-3">
									<input type="checkbox" name="noChecked" class="conditions"
										value="quitNot"><label class="cons-label" id="noChecked">
										탈퇴회원제외</label>
								</div>
							</div>
							<div class="row order-option">
							
								<div class="col-md-6 option-align">
									<div>가입일순</div>
									<div class="glyphicon glyphicon-arrow-up option-icons"></div>
									<div class="glyphicon glyphicon-arrow-down option-icons"></div>
								</div>
								
								<div class="col-md-6 option-align">
									<div>아이디순</div>
									<div class="glyphicon glyphicon-arrow-up option-icons"></div>
									<div class="glyphicon glyphicon-arrow-down option-icons"></div>
								</div>
								
							</div>
						</div>
						<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						<input type="hidden" id="currentPage" name="currentPage" value="" />
						
					</form>
				</div>
			</div>
		</div>
		<div class="row inquire-lists">
			<div class="col-md-12 col-xs-12">
				<c:if test="${list.size()==0}">
					<div class="non-inquire">
						<div>조회된 회원목록이 없습니다.</div>
					</div>
				</c:if>
				<c:if test="${list.size() > 0}">
					<div class="tableset">
						<div class="row">
							<div class="col-md-6 text-right">
								<p class="text-primary">전체 ${resultPage.totalCount } 건수, 현재
									${resultPage.currentPage == 0 ? 1 : resultPage.currentPage} 페이지</p>
							</div>
						</div>
						<table class="table">
							<tr class="firstLine">
								<th>회원아이디</th>
								<th>회원이름</th>
								<th>검색공개유무</th>
								<th>가입일</th>
								<th>유저상태</th>
							</tr>
							<c:set var="i" value="0" />
							<c:forEach var="user" items="${list}">
								<c:set var="i" value="${ i+1 }" />
								<tr id="inq${i}" class="texts">
									<td>${user.userId}</td>
									<td>${user.userName}</td>
									<td>${user.infoOption==0 ? "공개" : "비공개"}</td>
									<td>${user.regDate}</td>
									<td>${user.status==0 ? "정상" : (user.status == 1 ? "차단" : "탈퇴")}</td>
								</tr>
								<tr>
									<td colspan="7" class="${i} body-box">
										<div class="inquireBody">
											<div class="inquire-detail-title">
											<div class="user-profile-img" style="border: 5px solid #33aef7; width:50px; height:50px; border-radius:50%; background:url('/images/profile/${user.profileImg}') no-repeat; background-size : cover;"></div>
											${user.userName}(${user.userId})회원정보 상세보기
											</div>
											<ul>
												<li class="ele-inquire">이메일 : ${user.email} </li>
												<li class="ele-inquire">성별 : ${user.sex} </li>
												<li class="ele-inquire">휴대전화번호 : ${user.phone} </li>
												<li class="ele-inquire">나이 : ${user.age} </li>
												<li class="ele-inquire">자기소개 : ${user.introduce} </li>
												<c:if test="${user.status==2}">
												<li class="ele-inquire">탈퇴일 : ${user.quitDate} </li>
												<li class="ele-inquire">탈퇴사유 : ${user.quitReason} </li>
												</c:if>
											</ul>
										</div>
									</td>
								<tr>
							</c:forEach>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
					</div>
					<!-- PageNavigation Start... -->
					<jsp:include page="../common/pageNavigator.jsp" />
					<!-- PageNavigation End... -->
				</c:if>
			</div>
		</div>
	</div>

	<!-- modal start (do not mess with below) -->


	<div class="modal fade" id="modal2" role="dialog">

		<div class="modal-dialog modal-lg">
			<div class="modal-content user-modal">
				<div class="modal-header inquired-user-header">
					<span class="userIdLog"></span> 회원님의 활동 정보입니다.
				</div>
				<div class="modal-body chart-body">
					<div id="chart_div"></div>
					<div class="chart-duration">
						<select name="duration" class="duration">
							<option value="all">전체</option>
							<option value="week">주간</option>
							<option value="month">월간</option>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<div class="user-log-buttons">
						<button class="btn btn-danger block-user" data-toggle="modal" data-target="#modal3">차단하기</button>
						<button class="btn btn-default closer" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>

	</div>
	
	<div class="modal fade" id="modal3" role="dialog">

		<div class="modal-dialog modal-lg">
			<div class="modal-content user-modal">
				<div class="modal-header inquired-user-header">
					<span class="userIdLog"></span> 회원을 정말로 차단하시겠습니까?
				</div>
				<div class="modal-body chart-body">
					차단확인 혹은 취소를 눌러주세요.
				</div>
				<div class="modal-footer">
					<div class="user-log-buttons">
						<button class="btn btn-danger block-fine">차단확인</button>
						<button class="btn btn-default closer" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>

	</div>
	
	<div class="modal fade" id="inquire-taken" role="dialog">

		<div class="modal-dialog modal-lg">
			<div class="modal-content user-modal">
				<div class="modal-header inquired-user-header">
					신고 내역 처리하기
				</div>
				<div class="modal-body chart-body">
					
				</div>
				<div class="modal-footer">
					<div class="user-log-buttons">
						<button class="btn btn-danger block-user" data-toggle="modal" data-target="#modal3">차단하기</button>
						<button class="btn btn-default closer" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>

	</div>

</body>
</html>