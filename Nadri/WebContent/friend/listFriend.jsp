<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="EUC-KR">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  Bootstrap, jQuery CDN  -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>

<!-- sweet alert CDN -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	//친구 삭제
	$(function() {
		$("button[id^='deleteFriend']").on(
				"click",
				function() {

					var friendNo = $(this).attr("id").replace(/[^0-9]/g, ""); //td로 나뉘어 있는 것들을 tr로 행 기준으로 삼아서 숫자를 제외한 나머지는 nullstring으로 대체
					var friendId = $("#" + friendNo).attr('class');
					var userId = document.getElementById("userId").value;
					
					console.log(friendId);
					//alert("친구 아이디: "+friendId);
					//alert("유저 아이디: "+userId);

					$.ajax({
						url : "/friend/json/deleteFriend?userId=" + userId+ "&friendId=" + friendId,
						method : "GET",
						data : "json",
						success : function(data) {
							swal({
				    			   title: "삭제 완료!",
				    			   text: "회원님이 친구 \""+friendId+"\"를 삭제했습니다!",
				    			   icon: "error",
				    			   buttons: false,
				    			 });

							$("#" + friendNo).remove();
						}
					})
				})
	})

	//친구 추가
	 $(function() {
	 $( "button[id^='acceptFriend']" ).on("click" , function() {

		 var friendNo = $(this).attr("id").replace(/[^0-9]/g,"");
		 var friendId = $("#"+friendNo).attr('class'); 
		 var userId = "<c:out value="${user.userId}"/>"
		 
		 console.log(userId);
		 console.log(friendId);
		 
		 //alert("userId: "+userId);
		 //alert("friendId: "+friendId);
		 
		$.ajax({
			url:"/friend/json/acceptFriend?userId="+userId+"&friendId="+friendId,
			method : "GET",
	 		data:"json",
			success:function(data){
			
				swal({
	    			   title: "친구 추가 완료!",
	    			   text: "회원님이 \""+friendId+"\"를 친구로 추가했습니다!",
	    			   icon: "success",
	    			   buttons: false,
	    			 });
					
					//$("#"+friendNo).remove(); 
			}
		})	
	})	 
	})
</script>

<style>
.user-profile-section {
	padding-top: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	margin-top: 15px;
	margin-bottom: 15px;
	background: white;
	border-radius: 10px;
	box-shadow: 1px 2px 10px 0px #c7c7c7;
}

.user-detail-section {
	background: white;
	margin: 15px 0px 15px 0px;
	border-radius: 10px;
	box-shadow: 1px 2px 10px 0px #c7c7c7;
}

@media only screen and (max-width : 600px) {
	.user-profile-section {
		margin: 0px;
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
						<img src="/images/profile/${user.profileImg}" width="133" height="133" class="img-circle">
						<br />
						<br />
					</c:if>
					<c:if test="${ empty user.profileImg} ">
						<img src="/images/profile/default.png" width="133" height="133" class="img-circle">
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
					<div class="page-header text-info">
						<h3>친구목록조회</h3>
					</div>

					<form id="form" class="form-horizontal">
						<!-- TABLE -->
						<div class="table-responsive">
							<table class="table table-hover table-striped">
								<thead>
									<tr>
										<th class="text-center">No</th>
										<th class="text-center">ID</th>
										<th class="text-center">프로필사진</th>
										<th class="text-center">친구추가</th>
										<th class="text-center">친구삭제</th>
									</tr>
								</thead>

								<tbody>

									<c:forEach var="friend" items="${fList2 }">

										<tr id="${friend.friendNo}" class="${friend.friendId }">
											<td align="center">${friend.friendNo }</td>
											<td align="center">${friend.friendId }</td>
											<td align="center"><img src="/images/profile/${friend.friendId }.png" width="73" height="73" ></td>


											<td class="text-center">
												<c:if test="${friend.friendCode == '0' }">
													<button type="button" class="btn btn-primary" id="acceptFriend${friend.friendNo}">친구추가</button>
												</c:if>
											</td>


											<td class="text-center">
												<c:if test="${friend.friendCode == '1' }">
													<button type="button" class="btn btn-danger" id="deleteFriend${friend.friendNo}">삭제</button>
												</c:if>
											</td>

										</tr>
									</c:forEach>
								</tbody>

							</table>
						</div>
					</form>

				</div>
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