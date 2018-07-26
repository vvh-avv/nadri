<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- Bootstrap CDN -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<title>너나들이 통합검색결과</title>
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>

<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">

<!--  slick  -->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<style>
	#map {
		height: 500px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
    }
    .place-info{
    	margin-top:1vh;
    	width:100%;
    	hegiht:200px;
    }
    .contents{
    	margin: 1vh 0vh;
    }
    .insta-box{
    	margin-bottom:1vh;
    }
    
    .section-title{
    	margin-top:5vh;
    }

</style>
</head>
<body>
	<%@ include file="/layout/toolbar.jsp"%>
	<div class="container">
		<div class="content-box">
		<div><h2><span style="font-weight:700">${searchKeyword}</span>의 검색결과입니다.</h2></div>
			<div class="row contents">
				<div class="col-md-12">
					<div id="map"></div>
				</div>
			</div>
			<div class="row place-info contents">
				<div class="col-md-6 col-xs-12">
					<h3 class="placeTitle"></h3>
					<div class="placeContent"></div>
				</div>
				<div class="col-md-6 col-xs-12">
					<img src="https://ih0.redbubble.net/image.133161613.9621/flat,1000x1000,075,f.jpg" class="placeImg" style="background-color:black; width:100%; height:300px;">
				</div>
			</div>
		</div>
		<div class="contents">
				
			<div class="col-md-12 col-xs-12 section-title" style="display:flex; justify-content:space-between; align-items:center;">
				<h3 style="display:inline-block; font-weight:700;">게시글</h3><div>더보기 >></div>
			</div>
			<hr/>
			<c:if test="${!empty list_board}">
			<c:set var="i" value="0"/>
			<c:forEach var="board" items="${list_board}" end="2">
			<c:set var="i" value="${i+1}"/>
				<div class="col-md-4 col-xs-6 board-box">
					<img src="/images/board/posts/${board.board_img}" class="boardImg" style="width:100%; height:200px;">
					<div class="boardBox">
						<h3>${board.board_title}</h3>
						${board.board_content}
					</div>
				</div>
			</c:forEach>
			</c:if>
			<c:if test="${empty list_board}">
				<div class="col-md-12 col-xs-12 board-box">
					<img src="https://ih0.redbubble.net/image.133161613.9621/flat,1000x1000,075,f.jpg" class="boardImg" style="width:100%; height:200px; opacity:0.5;">
				</div>
			</c:if>
			
			<div class="col-md-12 col-xs-12 section-title" style="display:flex; justify-content:space-between; align-items:center;">
				<h3 style="display:inline-block; font-weight:700;">일정</h3><div>더보기 >></div>
			</div>
			<hr/>
			
			<c:if test="${!empty list_schedule}">
			<c:set var="i" value="0"/>
			<c:forEach var="schedule" items="${list_schedule}" end="3">
			<c:set var="i" value="${i+1}"/>
				<div class="col-md-6 col-xs-12 board-box">
					<img src="/images/schedule/${schedule.img}" class="boardImg" style="width:100%; height:200px;">
					<div class="boardBox">
						<h3>${schedule.title}</h3>
						${schedule.content}
					</div>
				</div>
			</c:forEach>
			</c:if>
			<c:if test="${empty list_schedule}">
				<div class="col-md-12 col-xs-12 board-box">
					<img src="https://ih0.redbubble.net/image.133161613.9621/flat,1000x1000,075,f.jpg" class="boardImg" style="width:100%; height:200px; opacity:0.5;">
				</div>
			</c:if>

			
			<div class="col-md-12 col-xs-12 section-title" style="display:flex; justify-content:space-between; align-items:center;">
				<h3 style="display:inline-block; font-weight:700;">인스타그램</h3><div>더보기 >></div>
			</div>
			<hr/>
			
			<c:set var="i" value="0"/>
			<c:forEach var="insta" items="${insta_list}">
			<c:set var="i" value="${i+1}"/>
			<div class="col-md-3 col-xs-4 insta-box">
				<a href="https://www.instagram.com/p/${insta.shortLink}" target="_blank"><img src="${insta.img}" class="boardImg" style="width:100%; height:250px;"></a>
			</div>
			</c:forEach>
		</div>
	</div>
	<script>
		// Initialize and add the map
		function initMap() {
			var locations;
			var size = ${spot_location.size()};
			if(size==0){
				locations = ['검색결과가 없습니다.',37.581095,126.977156];
				var map = new google.maps.Map(document.getElementById('map'), {
				      zoom: 15,
				      center: new google.maps.LatLng(37.581095,126.977156),
				      mapTypeId: google.maps.MapTypeId.ROADMAP
				      
				    });
			}else{
				locations = ${spot_location};
				var map = new google.maps.Map(document.getElementById('map'), {
				      zoom: 10,
				      center: new google.maps.LatLng(locations[0][1], locations[0][2]),
				      mapTypeId: google.maps.MapTypeId.ROADMAP
				      
				    });
			}


		    var infowindow = new google.maps.InfoWindow();

		    var marker, i;
		    
		    if(size==0){
		    	console.log('검색결과가 없습니다.');
		    	$('.placeTitle').text("검색결과가 없습니다 ㅠㅠ");
		        $('.placeContent').text("미아내오 준비하께오ㅜㅜㅜㅜㅠㅠㅠㅠㅠ");
		        $('.placeImg').attr("src","https://ih0.redbubble.net/image.133161613.9621/flat,1000x1000,075,f.jpg");
		    }else{
		    	for (i = 0; i < locations.length; i++) {  
				      marker = new google.maps.Marker({
				        position: new google.maps.LatLng(locations[i][1], locations[i][2]),
				        map: map
				      });
	
				      google.maps.event.addListener(marker, 'click', (function(marker, i) {
				        return function() {
				          infowindow.setContent(locations[i][0]);
				          infowindow.open(map, marker);
				          $('.placeTitle').text(locations[i][0]);
				          $('.placeContent').text(locations[i][3]);
				          $('.placeImg').attr("src","/images/spot/"+locations[i][4]);
				        }
				      })(marker, i));
				    }
				    
			    $('.placeTitle').text(locations[0][0]);
		        $('.placeContent').text("information of selected place");
		        $('.placeImg').attr("src","/images/spot/"+locations[0][4]);
		    }

		    
		}
    </script>
	<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAq2HYLHx3q-LM3MusYKsjXVZUik30YqUI&callback=initMap">
    </script>
</body>
</html>