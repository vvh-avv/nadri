<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>너, 나들이</title>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="/images/common/favicon.ico">

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
<!-- toolbar.js CDN -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
<!-- sweet alert CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
	.container{
		padding-top: 10px;
	}
	
	article{
		display: inline-block;
	    position: relative;
	    cursor: pointer;
	}
	article:hover .thumbImg img {
		opacity: 0.3;
	}
	article:hover .links,
	article:hover .linksIcon {
		opacity: 1;
	}
	
	.thumbImg img{
		width: 250px;
		height: 250px;
		opacity: 1;
		transition: .5s ease;
	}
	.links{
	  opacity: 0;
	  position: absolute;
	  text-align: center;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  -ms-transform: translate(-50%, -50%);
	  transition: .5s ease;
	}
	.linksIcon {
	  opacity: 0;
	  position: absolute;
	  top: 10%;
	  left: 90%;
	  transform: translate(-50%, -50%);
	  -ms-transform: translate(-50%, -50%);
	  transition: .5s ease;
	}
	.linksIcon img{
	  width: 15px;
	  height: 15px;
	}
</style>

<script>
$(function(){
	$("article").on("mouseover", function(){
		var scheduleNo = $(this).attr("class");
		
		$.ajax({
			url : "/board/json/checkBoard/"+scheduleNo,
			method : "POST",
			success : function(data){
				if(data==1){ //이미 포스팅 한 일정이라면
					$("#addBoard"+scheduleNo).css("display","none");
				}
			}
		})
	})
	
	$("article").on("click", function(){
		self.location="/schedule/getSchedule?scheduleNo="+$(this).attr("class");
	})
	
	$("button[id^='addBoard']").on("click", function(e){
		e.stopPropagation();
		var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
		$.ajax({
			url : "/board/json/addBoard/"+scheduleNo,
			method : "POST",
			success : function(data){
				swal("글쓰기 완료!", "마이페이지 내 작성한 글 보기에서 확인가능합니다!", "success");
				$("#addBoard"+scheduleNo).css("display","none");
			}
		}) //e.o.ajax
	})
	
	$("img[id^='deleteSchedule']").on("click", function(e){
		e.stopPropagation();
		var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
		swal({
			   title: "일정을 정말 삭제하시겠습니까?",
			   text: "일정에 포함된 경유지와 게시물이 함께 삭제됩니다.",
			   icon: "warning",
			   buttons: ["취소", "삭제"],
			   dangerMode: true,
			 })
			 .then((willDelete) => {
			   if (willDelete) {
				 $.ajax({
					 url : "/restschedule/deleteSchedule/"+scheduleNo,
					 method : "POST",
					 success : function(){
					    swal("일정이 정상적으로 삭제되었습니다.", {
						       icon: "success",
						});
					    $("."+scheduleNo).remove();
					 }
				 }) //e.o.ajax
			   } else {
			     swal("취소하였습니다.",{
			    	 icon: "error",
			     });
			   }
		   });
	})
})
</script>
</head>
<body>

	<!-- 메인툴바 -->
	<%@ include file="/layout/toolbar.jsp"%>
	
	<!-- 서브메뉴 노출 -->
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
	
	<div class="container">
		
		<!-- 작성한 글 리스트 뜨는 부분 -->
		<div class="col-md-10">
			<c:set var="i" value="0"/>
			<c:forEach var="schedule" items="${list}">
				<article class="${schedule.scheduleNo}">
					<!-- 썸네일 형식의 작성한 글 이미지 -->
					<div class="thumbImg" style="width:auto; height:250px;">
						<c:if test="${schedule.scheduleImg==null}">
							<img src="http://placehold.it/250X250" class="img-thumbnail">
						</c:if>
						<c:if test="${schedule.scheduleImg!=null}">
							<c:if test="${(schedule.scheduleImg).contains(',')}"> <img src="/images/schedule/${schedule.scheduleImg.split(',')[0]}" class="img-thumbnail"> </c:if>
							<c:if test="${!(schedule.scheduleImg).contains(',')}"> <img src="/images/schedule/${schedule.scheduleImg}" class="img-thumbnail"> </c:if>
						</c:if>
					
					<!-- 마우스 오버시 보여지는 부분 -->
					<div class="links" style="text-align:center;">
						<b>${schedule.scheduleTitle}</b><br>
						${schedule.scheduleDetail}<br>
						${schedule.hashTag}<br><br>
						<button type="button" class="btn btn-default btn-xs" id="updateSchedule${schedule.scheduleNo}">일정 수정하기</button> 
						<button type="button" class="btn btn-default btn-xs" id="addBoard${schedule.scheduleNo}">게시물로 공유하기</button>
					</div>
					<div class="linksIcon">
						<img id="deleteSchedule${schedule.scheduleNo}" src="/images/board/delete2.png">
					</div></div>
				</article>
			</c:forEach>
			
			<c:if test="${empty list}">
				<span id="defaultText" style="margin-left:40%;">생성하신 일정이 없습니다. ㅠㅠ</span>
			</c:if>
		</div>
	</div> <!-- e.o.container -->
</body>
</html>
