<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- jQuery CDN -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<!-- Bootstrap CDN -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	
	<!-- common.js / common.css CDN -->
	<script src="/javascript/common.js"></script>
	<link rel="stylesheet" href="/css/common.css">
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
   
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   <link rel="stylesheet" href="/css/toolbar.css">
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>

     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
		//============= 회원정보수정 Event  처리 =============	
		 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( "button.btn.btn-primary" ).on("click" , function() {
					self.location = "/user/updateUser?userId=${user.userId}"
				});
		});

	</script>	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<%-- <jsp:include page="/layout/toolbar.jsp" />  --%>
	<%@ include file="/layout/toolbar.jsp"%>
   	<!-- ToolBar End /////////////////////////////////////-->
   	
	<div class="col-sm-2" style="margin-left:3%">
	
	  <img src = "/images/profile/${user.profileImg}" width="133" height="133" class="img-circle"><br/><br/>
	  <h3><a href="/user/listUser">마이 페이지</a></h3><br/>
	  <a href="/user/getUser.jsp">내 정보 보기</a><br/><br/>
	  <a href="/user/updateUser.jsp">내 정보 수정</a><br/><br/>
	  <a href="/friend/listFriend.jsp">친구 목록</a><br/><br/>
	  <a href="#">작성한 글</a><br/><br/>
	  <a href="#">작성한 일정</a><br/><br/>
	  <a href="#">일정 바구니</a><br/><br/>
	  <a href="#">장소 바구니</a><br/><br/>
	  
	  	<br/><br/><br/><br/><br/><br/><br/><br/>
  		<a href="/user/logout">로그아웃</a><br/><br/>
	
	</div>
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="col-sm-9">
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">회원정보조회</h3>
	       <h5 class="text-muted">내 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>프로필 사진</strong></div>
				<%--  <div class="col-xs-8 col-md-4">${user.profileImg}</div>  --%>
					<c:if test="${!empty user.profileImg && user.profileImg!=' '}">
						<img src = "/images/profile/${user.profileImg}" width="133" height="133" class="img-circle">
					</c:if>
		</div>
		
		<hr/>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>이 름</strong></div>
			<div class="col-xs-8 col-md-4">${user.userName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>아 이 디</strong></div>
			<div class="col-xs-8 col-md-4">${user.userId}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2">
	  			<strong>이 메 일</strong>
	  		</div>
			<div class="col-xs-8 col-md-6">
				${user.email}    
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>성 별</strong></div>
	  		<div class="col-xs-8 col-md-4">
		  		<c:if test="${ ! empty user.sex && user.sex == 0}">남성</c:if>
		  		<c:if test="${ ! empty user.sex && user.sex == 1}">여성</c:if>
			</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>휴대전화번호</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty user.phone ? user.phone : ''}	</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>나이</strong></div>
			<div class="col-xs-8 col-md-4">${!empty user.age ? user.age : ''}	</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>자기소개</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty user.introduce ? user.introduce : ''}	</div>
		</div>
		
		<hr/>
						
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary">회원정보수정</button>
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	</div>
 	<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>