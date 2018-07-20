<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="com.nadri.service.domain.User"%>
<%@page import="com.nadri.service.domain.Friend"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%User user = (User) request.getAttribute("user");%>
<%Friend friend = (Friend) request.getAttribute("friend");%>

<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">


	<!--   jQuery , Bootstrap CDN  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="/css/toolbar.css">

	<!-- ToolBar Start /////////////////////////////////////-->
	<%@ include file="/layout/toolbar.jsp"%>
	<!-- ToolBar End /////////////////////////////////////-->
	<link rel="stylesheet" type="text/css" href="../resources/css/friendCss/reset.css">
	<link rel="stylesheet" type="text/css" href="../resources/css/friendCss/main_responsive.css">
    <script type="text/javascript" src="../resources/javascript/friendJs/jquery.js"></script>
    <script type="text/javascript" src="../resources/javascript/friendJs/main.js"></script>

	 <link href='http://fonts.googleapis.com/css?family=Roboto:400,300,700&amp;subset=latin,latin-ext' rel='stylesheet' type='text/css'>
        
        <!-- Load css styles -->
       <link rel="stylesheet" type="text/css" href="../resources/css/friendCss/bootstrap-responsive.css" />
       <link rel="stylesheet" type="text/css" href="../resources/css/friendCss/style.css" />

	<style>
	
	body > div.container > section > div > div > div.ficon > a > img{
		width: 81px;
	    height: 81px;
	    border-radius: 150px
	}
	.zoom{
		transition: transform .2s;
	}
	.zoom:hover {
	    transform: scale(1.5); /* (150% zoom - Note: if the zoom is too large, it will go outside of the viewport) */
	}
	.languagepicker {
		background-color: white;
		display: inline-block;
		padding: 0;
		height: 40px;
		overflow: hidden;
		transition: all .3s ease;
		margin: 0 50px 10px 0;
		vertical-align: top;
		float: left;
	}
	.languagepicker:hover {
		/* don't forget the 1px border */
		height: 81px;
	}
	.languagepicker a{
		color: #000;
		text-decoration: none;
	}
	.languagepicker li {
		display: block;
		padding: 0px 20px;
		line-height: 40px;
		border-top: 1px solid #EEE;
	}
	.languagepicker li:hover{
		background-color: #EEE;
	}
	.languagepicker a:first-child li {
		border: none;
		background: #181A1C !important;
		color: white;
	}
	.languagepicker li img {
		margin-right: 5px;
	}
	.roundborders {
		border-radius: 5px;
	}
	.large:hover {
		/* 
		don't forget the 1px border!
		The first language is 40px heigh, 
		the others are 41px
		*/
		height: 245px;
	}
	body > section > section > h3:after {
	  content: "";
	  display: block;
	  width: 100px;
	  border-bottom: 1px solid #181A1C;
	  
	}
	</style>

	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		function fncGetUserList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method", "GET").attr("action", "/friend/listFriend")
					.submit();
		}

		/* $("friend_img").on("click", function() {
			self.location = "/user/getFriend?userId=${user.userName}";
		}); */
	
</script>
</head>

<body>

<!-- 좌측 리스트 화면 -->
<div class="col-xs-2 md-2" style="margin-left:3%">

  <img src = "/images/profile/${user.profileImg}" width="133" height="133" class="img-circle"><br/><br/>
  <h4><a href="/user/listUser">마이 페이지</a></h4><br/>
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


<!--  가운데 화면 -->
<div style="margin-left:23%">	
<div class="col-xs-10 md-10">
<div class="container">
	<section class="features" style="padding-bottom:80px;">
			<div class="title">
                   <h4 style="color: #181A1C;">${user.userName}님의 친구</h4>

             </div>
	<div class="wrapper" style="padding-top: 40px;">
		<c:forEach var="friend" items="${list}" varStatus="status">
			<div class="feature">
				<div class="ficon"><a href="/user/getUser?userId=${user.userId}">
				<c:if test="${!empty friend.profileImg }">
					<img src="/images/${friend.profileImg}" alt="" class="zoom">
				</c:if>
				<c:if test="${empty friend.profileImg }">
					<img src="/images/profile_default.png" alt="" class="zoom">
				</c:if></a>
				</div>
				<div class="details_exp">
					<h3>${friend.userName}</h3>
					<p>${friend.createdDate}에 친구가 되었어요.</p>
					<ul class="languagepicker roundborders">
						<a href="#nl"><li>친구</li></a>
						<a href="#nl"><li>친구 끊기</li></a>
					    <a href="#nl"><li>유저 차단</li></a>
					</ul>
				</div>
			</div>
		</c:forEach>
		</div>
</section>

</div>
</div>
<%-- <div class="col-xs-10 md-10">
<div class="section primary-section" id="service">
           <div class="container">
               	<div class="title">
	                   <h4>알 수도 있는 친구</h4>
	             </div>
       
               <div class="row-fluid">
               	<c:forEach var="friend" items="${recommendList}" varStatus="status">
               	
               		<div class="span4" style="margin-left: 0;">
                        <div class="centered service">
                            <div class="circle-border zoom-in">
                            	<a href="/user/getUser?userId=${friend.userId}">
                            	<c:if test="${!empty friend.profileImg }">
                                	<img class="img-circle" src="../resources/upload_files/images/${friend.profileImg}" alt="service 1">
                                </c:if>
                                <c:if test="${empty friend.profileImg }">
                                	<img class="img-circle" src="../resources/images/profile_default.png" alt="service 1">
                                </c:if></a>
                            </div>
                            <h3>${friend.userName}</h3>
							 <c:set var="i" value="0"/>
								<c:forEach var="countFriend" items="${countFriend}">
									<c:set var="i" value="${ i+1 }" />
                            			<c:if test="${friend.userId eq countFriend.friendId}"><p>함께 아는 친구 ${countFriend.count}명</p></c:if>
                            	</c:forEach>
                        </div>
                    </div>
               	</c:forEach>    
               </div>
           </div>
       </div>
</div> --%>
</div>
</body>
</html>