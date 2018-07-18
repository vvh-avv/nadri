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
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				
				<div class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="glyphicon glyphicon-user"></span>
				</div>
				<div class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-2"
					aria-expanded="false">
					<span class="glyphicon glyphicon-search"></span>
				</div>
				<a class="navbar-brand" href="#">너나들이</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			
			<div class="row" style="display:flex; justify-content:flex-end;">
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
					<ul class="nav navbar-nav">
						<li>
							<form class="navbar-form" style="display:inline-block">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="Search">
								</div>
								<button type="submit" class="btn btn-default">Submit</button>
							</form>
						</li>
					</ul>
				</div>
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#"><span class="glyphicon glyphicon-send"></span></a></li>
						<li><a href="#"><span
								class="glyphicon glyphicon-envelope"></span></a></li>
						<li><a href="#"><span class="glyphicon glyphicon-bell"></span></a></li>
						<li><a href="#"></a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">
							<span class="glyphicon glyphicon-user"></span></a>
							<ul class="dropdown-menu">
								<li><a href="#">Action</a></li>
								<li><a href="#">Another action</a></li>
								<li><a href="#">Something else here</a></li>
								<li role="separator" class="divider"></li>
								<li><a href="#">Separated link</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
		</div>
		<!-- /.container-fluid -->
	</nav>
	<div class="container">
		<div class="content-box">
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
					<div class="placeImg" style="background-color:black; width:100%; height:300px;"></div>
				</div>
			</div>
		</div>
		<div class="contents">
				
			<div class="col-md-12 section-title" style="display:flex; justify-content:space-between; align-items:center;">
				<h3 style="display:inline-block; font-weight:700;">게시글</h3><div>더보기 >></div>
			</div>
			<hr/>
			
			<c:set var="i" value="0"/>
			<c:forEach var="board" items="${list_all[0]}" end="2">
			<c:set var="i" value="${i+1}"/>
				<div class="col-md-4 col-xs-6 board-box">
					<img src="/images/board/${board.board_img1}" class="boardImg" style="width:100%; height:200px;">
					<div class="boardBox">
						<h3>${board.board_title}</h3>
						${board.board_content}
					</div>
				</div>
			</c:forEach>
			
			<div class="col-md-12 section-title" style="display:flex; justify-content:space-between; align-items:center;">
				<h3 style="display:inline-block; font-weight:700;">일정</h3><div>더보기 >></div>
			</div>
			<hr/>
			
			<c:set var="i" value="0"/>
			<c:forEach var="schedule" items="${list_all[2]}" end="3">
			<c:set var="i" value="${i+1}"/>
				<div class="col-md-6 col-xs-12 board-box">
					<img src="${schedule.img}" class="boardImg" style="width:100%; height:200px;">
					<div class="boardBox">
						<h3>${schedule.title}</h3>
						${schedule.content}
					</div>
				</div>
			</c:forEach>

			
			<div class="col-md-12 section-title" style="display:flex; justify-content:space-between; align-items:center;">
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
			var locations = [
			      ['Bondi Beach', -33.890542, 151.274856, 4],
			      ['Coogee Beach', -33.923036, 151.259052, 5],
			      ['Cronulla Beach', -34.028249, 151.157507, 3],
			      ['Manly Beach', -33.80010128657071, 151.28747820854187, 2],
			      ['Maroubra Beach', -33.950198, 151.259302, 1]
			    ];
	
		    var map = new google.maps.Map(document.getElementById('map'), {
		      zoom: 10,
		      center: new google.maps.LatLng(-33.92, 151.25),
		      mapTypeId: google.maps.MapTypeId.ROADMAP
		      
		    });

		    var infowindow = new google.maps.InfoWindow();

		    var marker, i;

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
		          $('.placeContent').text("information of selected place");
		        }
		      })(marker, i));
		    }
		    
		    $('.placeTitle').text(locations[0][0]);
	        $('.placeContent').text("information of selected place");
		}
    </script>
	<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAq2HYLHx3q-LM3MusYKsjXVZUik30YqUI&callback=initMap">
    </script>
</body>
</html>