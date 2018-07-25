<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
	<title>너, 나들이 test</title>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

	<!-- toolbar -->
   <script src="/javascript/toolbar.js"></script>
   <link rel="stylesheet" href="/css/toolbar.css">

	<style>	
		 .starter-template {
            padding: 40px 15px;
            text-align: center;
        }
        
	</style>
	
	<!--  javascript -->
	<script type="text/javascript">
	 $(function() {
		 $( "#deleteFriend" ).on("click" , function() {
			
			alert("친구를 삭제하실 건가요?");
			fncDeleteFriend();
		 });
	 });
		
	 function fncDeleteFriend(){
		$("form").attr("method", "POST").attr("action", "/friend/deleteFriend").submit();
		alert("등록된 친구를 삭제했습니다");
	 }
		
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

	<!--  toolbar -->
	<%@ include file="/layout/toolbar.jsp"%>
	
	
	<!-- side bar -->
	<div class="col-sm-2" style="margin-left:3%">
	  <img src = "/images/profile/${user.profileImg}" width="133" height="133" class="img-circle"><br/><br/>
	  <h4><a href="/user/listUser">마이 페이지</a></h4><br/>
	  <a href="/user/getUser">내 정보 보기</a><br/><br/>
	  <a href="/user/updateUser">내 정보 수정</a><br/><br/>
	  <a href="/friend/listFriend">친구 목록</a><br/><br/>
	  <a href="/board/getMyBoardList">작성한 글</a><br/><br/>
	  <a href="/schedule/getMyScheduleList">내 일정</a><br/><br/>
	  <a href="#">장소 바구니</a><br/><br/>
	  
	  	<br/><br/><br/><br/><br/><br/><br/><br/>
  		<a href="/user/logout">로그아웃</a><br/><br/>
	</div>
	
	<div class="col-sm-7" style="margin-left:3%">
	<div class="container">	
	<!-- center area -->
		<div class="page-header text-info">
	       <h3>친구목록조회</h3>
	    </div>
	 
	 <form class="form-horizontal">
   	<!-- TABLE -->
   	<table class="table table-hover table-striped">
	<thead>
		<tr>
			<th class="text-center">No</th>
			<th class="text-center">ID</th>
			<th class="text-center">친구추가</th>
			<th class="text-center">친구삭제</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach var="friend" items="${fList }">
			<tr>
				<td class="text-center">${friend.friendNo }</td>
				<td class="text-center">${friend.friendId }</td>
				<td class="text-center">
				<c:if test="${friend.friendCode == 0 && friend.friendRequest == 'Y' }">
					<button id="addFriend" class="btn btn-default">친구추가</button>
				</c:if>
				</td>
				<td class="text-center">
				<c:if test="${friend.friendCode == 1 }">
					<button id="deleteFriend" class="btn btn-danger">삭제</button>
				</c:if> 
				</td>
			</tr>
		</c:forEach>
	</tbody>
	
	</table>
	</form>
	
	</div>
    </div> 
 	<%-- <!-- PageNavigation Start... -->
	<jsp:include page="/common/pageNavigator.jsp"/>
	<!-- PageNavigation End... --> --%>

</body>
</html>