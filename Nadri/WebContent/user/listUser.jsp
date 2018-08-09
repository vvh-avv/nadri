<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="EUC-KR">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  Bootstrap, jQuery CDN  -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//=============    검색 / page 두가지 경우 모두  Event  처리 =============	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/user/listUser")
				.submit();
	}
	function fncListPage(currentPage) {
		$("#searchCondition").val("${search.searchCondition}");
		$("#searchKeyword").val("${search.searchKeyword}");
		fncGetList(currentPage);
	}

	//============= "검색"  Event  처리 =============	
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("button.btn.btn-default").on("click", function() {
			fncGetList(1);
		});
	});

	//============= userId 에 회원정보보기  Event  처리(Click) =============	
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("td:nth-child(2)").on("click", function() {
			self.location = "/user/getUser?userId=" + $(this).text().trim();
		});

		//==> userId LINK Event End User 에게 보일수 있도록 
		$("td:nth-child(2)").css("color", "red");
	});

	//============= userId 에 회원정보보기  Event  처리 (double Click)=============
	$(function() {

		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("td:nth-child(5) > i").on(
				"click",
				function() {

					var userId = $(this).next().val();

					$.ajax({
						url : "/user/json/getUser/" + userId,
						method : "GET",
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData, status) {

							var displayValue = "<h6>" + "아이디 : "
									+ JSONData.userId + "<br/>" + "이  름 : "
									+ JSONData.userName + "<br/>" + "이메일 : "
									+ JSONData.email + "<br/>" + "등록일 : "
									+ JSONData.regDate + "<br/>" + "</h6>";
							$("h6").remove();
							$("#" + userId + "").html(displayValue);
						}
					});
					////////////////////////////////////////////////////////////////////////////////////////////
				});

		//==> userId LINK Event End User 에게 보일수 있도록 
		$(".ct_list_pop td:nth-child(3)").css("color", "red");
		$("h7").css("color", "red");

		//==> 아래와 같이 정의한 이유는 ??
		$(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");
	});
</script>

<style>

.user-profile-section{
	padding-top : 20px;
	display : flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	margin-top : 15px;
	margin-bottom : 15px;
	background : white;
	border-radius : 10px;
	box-shadow : 1px 2px 10px 0px #c7c7c7;
}

.user-detail-section{
	background : white;
	margin : 15px 0px 15px 0px;
	border-radius : 10px;
	box-shadow : 1px 2px 10px 0px #c7c7c7;
	height	: 200px;
}

@media only screen and (max-width : 600px) {
	.user-profile-section{
		margin : 0px;
	}
}

</style>

</head>

<body>

	<%@include file="/layout/new_toolbar.jsp"%>
	
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-3">
				<div class="col-md-12 user-profile-section">
					<c:if test="${!empty user.profileImg && user.profileImg!=' '}">
						<img src="/images/profile/${user.profileImg}" width="133"
							height="133" class="img-circle">
						<br />
						<br />
					</c:if>
					<c:if test="${ empty user.profileImg} ">
						<img src="/images/profile/default.png" width="133" height="133"
							class="img-circle">
					</c:if>

					<br /> <a href="/user/getUser">내 정보 보기</a><br /> <br /> 
						<a href="/user/updateUser">내 정보 수정</a><br /> <br /> 
						<a href="/friend/listFriend2">친구 목록</a><br /> <br /> 
						<a href="/board/getMyBoardList">작성한 글</a><br /> <br /> 
						<a href="/schedule/getMyScheduleList">내 일정</a><br /> <br /> 
						<a href="/cart/getMyCartList">장소 바구니</a><br /> <br /> <br /> <br />
					<br /> <br /> <br /> <br /> <br /> <br /> 
						<a href="/user/logout">로그아웃</a><br /> <br />
				</div>
			</div>
			
			<div class="col-xs-12 col-md-9">
			
				<div class="col-md-12 user-detail-section">
					
				</div>
			
			</div>
		</div>


		<div class="row">
			<div style="margin-left: 23%">
				
				<div class="container"></div>
			</div>
		</div>
	</div>
	<!-- HJA 일정등록 transportation navigation -->
	<!-- 처음 입장시 여러가지 정보를 적는 modal 창 start -->
	<div class="modal" id="transportationModal" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">나들이는 뭐타고 가시나요?</h4>
				</div>
				<div class="modal-body">
					<button type="button" class="btn btn-primary" id="car">자동차</button>
					<button type="button" class="btn btn-primary" id="pedestrian">도보</button>
					<button type="button" class="btn btn-primary" id="transit">대중교통</button>
				</div>
				<div class="modal-footer">
					<button type="button" class="waves-effect waves-light btn"
						id="modalinsert">입력!</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>