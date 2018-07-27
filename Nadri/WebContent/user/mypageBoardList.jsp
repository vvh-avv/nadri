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
	article:hover .links {
		opacity: 1;
	}
	
	.thumbImg img{
		width: 250px;
		height: 250px;
		opacity: 1;
		transition: .5s ease;
	}
	.icon{
		width: 15px;
		height: 15px;
	}
	.links {
	  opacity: 0;
	  position: absolute;
	  text-align: center;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  -ms-transform: translate(-50%, -50%);
	  transition: .5s ease;
	}
</style>

<script>
$(function(){
	$("article").on("click", function(){
		self.location="/board/getBoard?boardNo="+$(this).attr("class");
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
	  <a href="/cart/getMyCartList">장소 바구니</a><br/><br/>
	  
	  	<br/><br/><br/><br/><br/><br/><br/><br/>
  		<a href="/user/logout">로그아웃</a><br/><br/>
	
	</div>
	
	<div class="container">
		
		
		
		<!-- 작성한 글 리스트 뜨는 부분 -->
		<div class="col-md-10">
			<c:set var="i" value="0"/>
			<c:forEach var="board" items="${list}">
				<article class="${board.boardNo}">
					<!-- 썸네일 형식의 작성한 글 이미지 -->
					<div class="thumbImg" style="width:auto; height:250px;">
						<c:if test="${board.boardImg==null}">
							<img src="http://placehold.it/250X250" class="img-thumbnail">
						</c:if>
						<c:if test="${board.boardImg!=null}">
							<c:if test="${(board.boardImg).contains(',')}"> <img src="/images/board/posts/${board.boardImg.split(',')[0]}" class="img-thumbnail"> </c:if>
							<c:if test="${!(board.boardImg).contains(',')}"> <img src="/images/board/posts/${board.boardImg}" class="img-thumbnail"> </c:if>
						</c:if>
					</div>
					<!-- 마우스 오버시 보여지는 부분 -->
					<div class="links" style="text-align:center;">
						<b>${board.boardTitle}</b><br>
						<img src="/images/board/like_white.png" class="icon"> ${board.likeCnt}&nbsp;&nbsp;
						<img src="/images/board/comment_white.png" class="icon"> ${board.commCnt}
					</div>
				</article>
			</c:forEach>
			
			<c:if test="${empty list}">
				<span id="defaultText" style="margin-left:40%;">작성하신 글이 없습니다. ㅠㅠ</span>
			</c:if>
		</div>
	</div> <!-- e.o.container -->
</body>
</html>
