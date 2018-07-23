<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>너,나들이</title>

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="/javascript/jquery.counterup.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">

  <style>
  .indexHead {
	background: linear-gradient(rgba(255, 255, 255, 0),rgba(255, 255, 255, 0),
		rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.1),
		rgba(255, 255, 255, 0.3), rgba(255, 255, 255, 1)),
		url(/images/spot/mainSpot.jpg);
	background-attachment: fixed;
	background-position: center;
	background-repeat: no-repeat;
	background-size: cover;
	height: 100vh;
	transition: width 2s ease;
}

.thumbnail {
  width: 180px;
  height: 180px;
  font-size:30px;
  color: white;
  text-align: center;
  border: solid 1px grey;
  border-radius: 12px;
}

.thumbnail img {
  position: absolute; top:0; left: 0;
  width: 90%;
  height: 90%;
  border-radius: 12px;
}

    }
  </style>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
  <script>
    jQuery(document).ready(function( $ ) {
        $('.counter').counterUp({
            delay: 10,
            time: 1500
        });
    });
  </script>
</head>

<body>
      <%@ include file="/layout/toolbar.jsp"%>
	<div class="container-fluid indexHead">
		<div style="width: 100%; height: 70%; margin: 10% auto; text-align: center;">
			<h1>' <span style="font-weight:bold">너, 나들이</span> ' 의 </h1>
				<span class="counter" style="display: inline-block;font-weight: 450; color: black; font-size: 70px"><fmt:formatNumber value="${total}" pattern="##,###"/></span> 가지
			<h1> 장소를 검색해 보세요!</h1>
			<br/>
			<div class="container">

					<div class="col-sm-6 col-md-3" id="main1">
						<a href="/spot/getSpotList?spotCode=0" class="thumbnail"> 공원<img src="/images/spot/parkdefault.jpg" >
						</a>
						<div class="content">  
				        </div> 
					</div>

					<div class="col-sm-6 col-md-3" id="main2">
						<a href="/spot/getFestivalList" class="thumbnail"> 축제/전시<img src="/images/spot/festivaldefault.jpg" >
						</a>
						<div class="content">  
				        </div> 
					</div>

					<div class="col-sm-6 col-md-3" id="main3">
						<a href="/spot/getSpotList?spotCode=10" class="thumbnail"> 맛집<img src="/images/spot/restaurantdefault.jpg" >
						</a>
						 <div class="content">  
				        </div> 
					</div>

					<div class="col-sm-6 col-md-3" id="main4">
						<a href="/spot/getSpotList?spotCode=4" class="thumbnail"> 한강<img src="/images/spot/riverdefault.jpg" >
						</a>
						 <div class="content">  
				        </div> 
					</div>
				</div>
			</div>
		</div>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
    <script src="/javascript/jquery.counterup.min.js"></script>

</body>
</html>