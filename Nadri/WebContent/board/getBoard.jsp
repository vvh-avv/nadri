<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>게시물 상세보기</title>

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

<!-- flexslider CDN (슬라이드쇼) -->
<link rel="stylesheet" href="/css/flexslider.css" type="text/css">
<script src="/javascript/flexslider.js"></script>

<style>
	#boardTitle{
		height : 50px;
	}
	#boardImg{
		width : 500px;
		height : 500px;
	}
	#boardContent{
		height : 200px;
	}
	#commList{
		display : none;
	}
	.icon{
		cursor : pointer;
		width : 30px;
		height : 30px;
	}
	.iconDetail{
		display : none;
		cursor : pointer;
		width : 30px;
		height : 30px;
	}
	.userList{
		display: flex;
		flex-direction: row;
	}
	.userInfoAndBoardDate{
		display: flex;
		flex-direction: column;
  		justify-content: center;
		margin-left : 10px;
	}
	#more{
		position : relative;
    	margin-left: auto;
	}
	#moreContent{
		position : absolute;
		border-radius: 10%;
		/*background-image : url(/images/board/more_back.png);*/
		background-color : #E8E8E8;
		z-index : 10;
		text-align : center;
	}
	.moreDetail{
		cursor : pointer;
		display : none;
	}
	/* 화면이 작아졌을 때 유저정보가 위로 가게끔 설정 */
	@media only screen and (max-width: 600px) {
		.container{
			display: flex;
			flex-direction: column-reverse;
		}
		.col-md-4{
			flex-direction: row;
		}
	}
</style>

<script>
$(function(){
	//*슬라이드쇼 시작
	$('.flexslider').flexslider({
		animation: "slide"
	});
	
	//*더보기 클릭
	$(".moreImg").on("click", function(){
 		var top =  $(this).offset().top+$(this).outerHeight(true); //떠야하는 상단 위치
 		var right = ($(window).width() - ($(this).offset().left+$(this).outerWidth())); //떠야하는 우측위치
 		
 		$("#moreContent").css("top",top).css("right",right);
	
		if( $(".moreDetail").is(":visible")){
 			$(".moreDetail").slideUp();
		}else{
 			$(".moreDetail").slideDown();
		}
	})
	//*더보기 메뉴
	$("#modifyBoard").on("click", function(){
		$("form").attr("method","GET").attr("action", "/board/updateBoard").submit();
	})
	$("#deleteBoard").on("click", function(){
		var result = confirm('게시물을 정말 삭제하시겠습니까?');
		if(result) {
			$.ajax({
				url : "/board/json/deleteBoard/"+$("#boardNo").val().trim(),
				method : "POST"
			})
			alert("삭제되었습니다.");
			self.location="/board/listBoard.jsp";
		} else {
			alert("취소하였습니다.");
 			$(".moreDetail").slideDown();
		}
	})
	$("#inquireBoard").on("click", function(){
		alert("신고하자..");
	})
	$("#addCart").on("click", function(){
		alert("일정바구니추가하자..")
	})
	//*더보기 영역 외 클릭시 fadeOut();
	$(document).mouseup(function(e){
		if( !$(".moreDetail").is(e.target) ){
			$(".moreDetail").fadeOut();
		}
	})
	
	//*하트 클릭
	$("#likeIcon>.icon").on("click", function(){
		if( $(this).attr("src")=="/images/board/like_empty.png" ){ //좋아요+1
			$.ajax({
				url : "/board/json/addLike/"+$("#boardNo").val().trim(),
				method : "POST",
				success : function(data, status){
					$("#likePrint").text("좋아요 "+data+"개");
				}
			})
			$(this).attr("src","/images/board/like_full.png"); //이미지 변경
		}else{ //좋아요-1
			$.ajax({
				url : "/board/json/deleteLike/"+$("#boardNo").val().trim(),
				method : "POST",
				success : function(data, status){
					$("#likePrint").text("좋아요 "+data+"개");
				}
			})
			$(this).attr("src","/images/board/like_empty.png"); //이미지 변경
		}
	})
	
	//*댓글 클릭
	$("#commIcon").on("click", function(){
		$("#commContent").focus();
	})
	
	//*공유 클릭시 SNS 아이콘 노출
	$("#shareIcon>.icon").on("click", function(){
		if( $(".iconDetail").css("display")=="none" ){
			$(".iconDetail").show("scale");
		}else{
			$(".iconDetail").hide("scale");
		}
	})
	//* SNS공유
	$("#kakaoShare").on("click", function(){
		alert("카카오로 공유합니다.");
	})
	$("#facebookShare").on("click", function(){
		alert("페이스북으로 공유합니다.");
	})
	$("#instagramShare").on("click", function(){
		alert("인스타그램으로 공유합니다.");
	})
})
</script>
</head>

<body>
	<jsp:include page="/layout/toolbar.jsp"/>

	<!-- 더보기 버튼 클릭시 노출될 항목 --> 
	<span id="moreContent">
		<span class="moreDetail" id="modifyBoard">게시물수정</span><br>
		<span class="moreDetail" id="deleteBoard">게시물삭제</span><br>
		<span class="moreDetail" id="inquireBoard" name="${board.boardNo}">게시물신고</span><br>
		<span class="moreDetail" id="addCart">일정바구니 추가</span>
	</span>
					
	<div class="container">
		<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}">
		
		<div class="col-md-8"> <!-- 제목+이미지+내용 -->
			<form id="firstForm" class="form-horizontal">
				<!-- 제목 -->
				<div id="boardTitle" class="bg-warning">${board.boardTitle}</div>
				<br>
				
				<!-- 이미지 -->
				<div class="flexslider">
					<ul class="slides">
						<c:forTokens var="images" items="${board.boardImg}" delims=",">
    						<li><img src="/images/board/posts/${images}"/></li>
						</c:forTokens>
					</ul>
				</div>
				
				<!-- 해시태그 -->
				<div id="hashTag" class="bg-warning">${board.hashTag}</div>
				
				<!-- 내용 -->
				<div id="boardContent" class="bg-warning">${board.boardContent}</div>
			</form>
		</div>
		
		<div class="col-md-4"> <!-- 유저정보+게시물기능(좋아요+댓글+공유)+댓글 -->
			<form id="lastForm" class="form-horizontal">
				<!-- 유저정보 -->
				<div class="userList">
				    <div id="userProfile"><img src="/images/board/imgUpload.png" class="img-circle"></div>
					<div class="userInfoAndBoardDate">
						<div id="userInfo"><b>${user.userName}</b> (${user.userId})</div>
						<div id="boardDate"><fmt:formatDate value="${board.boardDate}" pattern="yyyy년 MM월 dd일 hh:mm:ss"/></div>
					</div>
					<div id="more"><img class="moreImg" src="/images/board/more.png" style="cursor:pointer;width:20px;height:20px;margin-top:10px"></div>
				</div>
				<br>
				
				<!-- 아이콘(좋아요+댓글+공유) -->
				<div id="iconList">
					<span id="likeIcon">
						<c:if test="${likeFlag==0}"><img class="icon" src="/images/board/like_empty.png"></c:if>
						<c:if test="${likeFlag!=0}"><img class="icon" src="/images/board/like_full.png"></c:if>
					</span>&nbsp;&nbsp;
					<span id="commIcon"><img class="icon" src="/images/board/comment.png"></span>&nbsp;&nbsp;
					<!-- 공유하기 버튼 클릭시 노출될 항목 -->
					<span id="shareIcon">
						<img class="icon" src="/images/board/share.png">&nbsp;&nbsp;
						<img class="iconDetail" id="kakaoShare" src="/images/board/share/kakao.png">
						<img class="iconDetail" id="facebookShare" src="/images/board/share/facebook.png">
						<img class="iconDetail" id="instagramShare" src="/images/board/share/instagram.png">
					</span>
				</div>
				<br>
				
				<!-- 좋아요@개+댓글@개 -->
				<div id="viewList">
					<span id="likePrint">좋아요 ${likeCount}개</span>&nbsp;&nbsp;
					<span id="commPrint">댓글 ${commentCount}개</span>
				</div>
				<br>
				
				<!-- 댓글리스트 -->
				<div id="commList"></div>
				<br>
				
				<!-- 댓글입력폼 -->
				<div id="commProm">
					<input class="form-control" type="text" id="commContent" name="commContent" placeholder="댓글을 입력해주세요..">
				</div>
			</form>
		</div>
		
	</div><!-- e.o.container -->
</body>
</html>