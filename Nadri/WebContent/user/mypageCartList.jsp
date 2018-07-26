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
<!-- google map API -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAq2HYLHx3q-LM3MusYKsjXVZUik30YqUI&callback=initMap"></script>

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
	.links{
	  opacity: 0;
	  position: absolute;
	  text-align: center;
	  top: 50%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  -ms-transform: translate(-50%, -50%);
	  transition: .5s ease;
	  width: 80%
	}
	.linksIcon img{
	  position: absolute;
	  top: -5%;
	  left: -5%;
	  width: 70px;
	  height: 70px;
	}
	
	#map {
		height: 500px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
    }
</style>

<script>
function initMap() {
	var map = new google.maps.Map(document.getElementById('map'), {
	      center: new google.maps.LatLng(37.531095,126.977156),
	      zoom: 11, //locations[0][1], locations[0][2]),
	      mapTypeId: google.maps.MapTypeId.ROADMAP
	});
}
</script>

</head>
<body>
	<!-- 메인툴바 -->
	<%@ include file="/layout/toolbar.jsp"%>
	
	<div class="container">
		<!-- 서브메뉴 노출 -->
		<div class="col-md-2">서브메뉴</div>
		
		<div class="col-md-10">
			<!-- 맵 뜨는 부분 -->
			<div class="row">
				<div id="map"></div>
			</div><br>
		
			<!-- 바구니에 담은 장소리스트 보여주는 부분 -->
			<div class="row contents">
				<c:set var="i" value="0"/>
				<c:forEach var="cart" items="${list}">
					<article class="${cart.cartNo}">
						<!-- 썸네일 형식의 장소 이미지 -->
						<div class="thumbImg" style="width:auto; height:250px;">
							<c:if test="${cart.cartImg==null}">
								<img src="http://placehold.it/250X250" class="img-thumbnail">
							</c:if>
							<c:if test="${cart.cartImg!=null}">
								<img src="${cart.cartImg}" class="img-thumbnail">
							</c:if>
						</div>
						<!-- 방문도장 이미지 -->
						<c:if test="${cart.stampCode==1}">
							<div class="linksIcon"> <img id="stamp${schedule.scheduleNo}" src="/images/cart/stamp.png"> </div>
						</c:if>
						<!-- 마우스 오버시 보여지는 부분 -->
						<div class="links" style="text-align:center;">
							<span id="cartTitle"><b>${cart.cartTitle}</b><br></span>
							<span id="cartAddress">${cart.cartAddress}<br><br></span>
							<span id="cartDetail">${cart.cartDetail}</span>
						</div>
					</article>
				</c:forEach>
				
				<c:if test="${empty list}">
					<span id="defaultText" style="margin-left:40%;">바구니가 비었습니다. ㅠㅠ</span>
				</c:if>
			</div>
		</div>
		
	</div> <!-- e.o.container -->
</body>
</html>
