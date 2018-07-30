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
	
	<!-- jQuery CDN -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- Bootstrap CDN -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

	<!-- sweet alert CDN -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

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
	//친구 삭제
	$(function() {
		 $( "button[id^='deleteFriend']" ).on("click" , function() {
	
			 	var friendNo = $(this).attr("id").replace(/[^0-9]/g,"");			//td로 나뉘어 있는 것들을 tr로 행 기준으로 삼아서 숫자를 제외한 나머지는 nullstring으로 대체
			 	var friendId = $("#"+friendNo).attr('class');							
			 	
			 	console.log(friendId);
			 	
		 	$.ajax({
		 		url:"/friend/json/deleteFriend?userId="+userId+"&friendId="+friendId,
		 		method : "GET",
		 		data:"json",
		 		success:function(data){
		 					swal("친구가 삭제되었습니다","success");	
							
		 				 $("#"+friendNo).remove(); 
		 		}
		 	})
		 })
	}) 
	

	 //친구 추가
	 $(function() {
		 $( "button[id^='acceptFriend']" ).on("click" , function() {

			 var friendNo = $(this).attr("id").replace(/[^0-9]/g,"");
			 var friendId = $("#"+friendNo).attr('class');
			 
			 console.log(userId);
			 console.log(friendId);
			 
			$.ajax({
				url:"/friend/json/acceptFriend?userId="+userId+"&friendId="+friendId,
				method : "GET",
		 		data:"json",
				success:function(data){
				
						swal("친구가 되었습니다","success");
						
						$("#"+friendNo).remove(); 
				}
			})	
		})	 
	 }) 
		
	
	 
	</script>

</head>

<body bgcolor="#ffffff" text="#000000">

	<!--  toolbar -->
	<%@ include file="/layout/toolbar.jsp"%>
	
	
	<!-- side bar -->
	<div class="col-xs-12 col-md-2" style="margin-left:3%">
	  <img src = "/images/profile/${user.profileImg}" width="133" height="133" class="img-circle"><br/><br/>
	  <h4><a href="/user/listUser">마이 페이지</a></h4><br/>
	  <a href="/user/getUser">내 정보 보기</a><br/><br/>
	  <a href="/user/updateUser">내 정보 수정</a><br/><br/>
	  <a href="/friend/listFriend">친구 목록</a><br/><br/>
	  <a href="/board/getMyBoardList">작성한 글</a><br/><br/>
	  <a href="/schedule/getMyScheduleList">내 일정</a><br/><br/>
	  <a href="/cart/getMyCartList">장소 바구니</a><br/><br/>
	  
	  	<br/><br/><br/><br/><br/><br/><br/><br/>
  		<a href="/user/logout">로그아웃</a><br/><br/>
	</div>
	
	<div class="col-xs-12 col-md-7" style="margin-left:3%">
	<div class="container">	
	<!-- center area -->
		<div class="page-header text-info">
	       <h3>친구목록조회</h3>
	    </div>
	 
	 <form id="form" class="form-horizontal">
   	<!-- TABLE -->
  <div class="table-responsive">
   	<table class="table table-hover table-striped">
	<thead>
		<tr>
			<th align="center">No</th>
			<th align="center">ID</th>
			<th align="center">친구추가</th>
			<th align="center">친구삭제</th>
		</tr>
	</thead>
	
	<tbody>
	
		<c:forEach var="friend" items="${fList }">
	
			<tr id="${friend.friendNo}" class="${friend.friendId }">
				<td align="center">${friend.friendNo }</td>
				<td align="center">${friend.friendId }</td>
				
					<td class="text-center" >
					<c:if test="${ friend.friendCode == '0' }">
						<button type="button" class="btn btn-primary" id="acceptFriend${friend.friendNo}">친구추가</button>
					</c:if>
					</td>
				
					<td class="text-center" >
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
 	<%-- <!-- PageNavigation Start... -->
	<jsp:include page="/common/pageNavigator.jsp"/>
	<!-- PageNavigation End... --> --%>

</body>
</html>