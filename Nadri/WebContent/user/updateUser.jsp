<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>너, 나들이</title>
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
	//============= "수정"  Event 연결 =============
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("button.btn.btn-primary").on("click", function() {
			fncUpdateUser();
		});
	});

	//============= "탈퇴"  Event 처리 및  연결 =============
	$(function() {
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$("a[href='#' ]")
				.on(
						"click",
						function() {
							self.location = "/user/quitUser?userId=${sessionScope.user.userId}";
						});
	});

	//============="이메일" 유효성Check  Event 처리 =============
	$(function() {

		$("input[id='email']")
				.on(
						"change",
						function() {
							var email = $("input[id='email']").val();
							if (email != ""
									&& (email.indexOf('@') < 1 || email
											.indexOf('.') == -1)) {
								alert("이메일 형식이 아닙니다.");
							}
						});
	});

	///////////////////////////////////////////////////////////////////////
	function fncUpdateUser() {
		var name = $("input[id='userName']").val();
		var password = $("input[id='password_change']").val();

		if (name == null || name.length < 1) {
			alert("이름은 반드시 입력해야 합니다.");
			return;
		}

		if (password == null || password.length < 1) {
			alert("비밀번호는 반드시 입력해야 합니다.");
			return;
		}

		var value = "";
		if ($("input[name='phone2']").val() != "" && $("input[name='phone3']").val() != "") {
			var value = $("option:selected").val() + "-"
					+ $("input[name='phone2']").val() + "-"
					+ $("input[name='phone3']").val();
		}
		$("input:hidden[name='phone']").val(value);

		//프로필 이미지 변경 시 제약조건을 걸어서 값이 없는 경우는 새로 값을 부여하지만 그렇지 않은 경우는 기존의 값을 그대로 유지
		if( $('#profileImg2').val() != null && $('#profileImg2').val() != '') {
			var profileImg = $('#profileImg2').val() ;
			profileImg = profileImg.substring( profileImg.lastIndexOf('\\') + 1 , profileImg.length ) ;
			$('#profileImg').val( profileImg ) ;					//기존 프로필 이미지에서 새로운 프로필 이미지로
			//alert( profileImg ) ;
			//alert($('#profileImg').val());	
		}
		$("form").attr("method", "POST").attr("action", "/user/updateUser").submit();
	}
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
					<div class="page-header text-center">
						<h3 class=" text-info">회원정보수정</h3>
						<h5 class="text-muted">
							자신의 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.
						</h5>
					</div>

					<!-- form Start /////////////////////////////////////-->
					<form class="form-horizontal" enctype="multipart/form-data">

						<div class="form-group">
							<label for="userId"
								class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">아 이 디</label>
							<div class="col-xs-4 col-md-4">
								<input type="text" class="form-control" id = "userId" name = "userId" value="${user.userId }" placeholder="중복확인하세요" readonly> <span id="helpBlock" class="help-block">
									<strong class="text-danger">아이디는 수정불가</strong>
								</span>
							</div>
						</div>

						<div class="form-group">
							<label for="userName" class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">이름</label>
							<div class="col-xs-4 col-md-4">
								<input type="text" class="form-control" id="userName" name = "userName" value="${user.userName}" placeholder="변경회원이름">
							</div>
						</div>

						<div class="form-group">
							<label for="email"
								class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">이메일</label>
							<div class="col-xs-4 col-md-4">
								<input type="text" class="form-control" id="email" name = "email" value="${user.email}" placeholder="변경할 이메일">
							</div>
						</div>

						<div class="form-group">
							<label for="password"
								class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">비밀번호</label>
							<div class="col-xs-4 col-md-4">
								<input type="password" class="form-control" id="password_change" name = "password" value="${user.password }" placeholder="변경할 또는 기존의 비밀번호">
							</div>
						</div>

						<div class="form-group">
							<label for="phone"
								class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">휴대전화번호</label>
							<div class="col-xs-2 col-md-2">
								<select class="form-control" name="phone1" id="phone1">
									<option value="010"
										${ ! empty user.phone1 && user.phone1 == "010" ? "selected" : ""  }>010</option>
									<option value="011"
										${ ! empty user.phone1 && user.phone1 == "011" ? "selected" : ""  }>011</option>
									<option value="016"
										${ ! empty user.phone1 && user.phone1 == "016" ? "selected" : ""  }>016</option>
									<option value="018"
										${ ! empty user.phone1 && user.phone1 == "018" ? "selected" : ""  }>018</option>
									<option value="019"
										${ ! empty user.phone1 && user.phone1 == "019" ? "selected" : ""  }>019</option>
								</select>
							</div>
							<div class="col-xs-4 col-md-2">
								<input type="text" class="form-control" id="phone2" name="phone2" value="${ ! empty user.phone2 ? user.phone2 : ''}" placeholder="변경번호">
							</div>
							<div class="col-xs-2 col-md-2">
								<input type="text" class="form-control" id="phone3" name="phone3" value="${ ! empty user.phone3 ? user.phone3 : ''}" placeholder="변경번호">
							</div>
							<input type="hidden" name="phone" />
						</div>

						<div class="form-group">
							<label for="age"
								class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">나이</label>
							<div class="col-xs-4 col-md-2">
								<input type="text" class="form-control" id="age" name ="age" value="${user.age}" placeholder="나이">
							</div>
							<div class="col-xs-4 col-md-4">
								<strong>세</strong>
							</div>
						</div>
						<br />
						
						<div class="form-group">
							<label for="age"
								class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">성별</label>
							<div class="col-xs-4 col-md-4">
								<input type="text" class="form-control" id="sex" name = "sex" value= ${ user.sex == '0' ? "남성" : "여성" } readonly>
							</div>
						</div>


						<div class="row">
							<label for="profileImg"
								class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">프로필
								사진</label>
							<div class="col-xs-4 md-4">
								<!-- <input type="file" class="form-control" id="profileImg" name="file"> -->
								<input type="hidden" class="form-control" id="profileImg" name = "profileImg" value="${user.profileImg }"> 
								<input multiple="multiple" type="file" class="form-control" id="profileImg2" name="file">
							</div>
							<span class="col-sm-3"></span>
						</div>
						<br />

						<div class="row">
							<label for="introduce"
								class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">자기소개</label>
							<textarea class="col-sm-6" id="introduce" name = "introduce" rows="10">${user.introduce }</textarea>
						</div>
						<br />

						<div class="form-group">
							<div
								class="col-xs-offset-4  col-xs-4 text-center col-md-offset-4  col-md-4 text-center">
								<button type="button" class="btn btn-primary">수 &nbsp;정</button>
								<a class="btn btn-danger" href="#" type="button">탈 &nbsp;퇴</a>
							</div>
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