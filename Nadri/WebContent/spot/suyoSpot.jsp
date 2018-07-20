<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<!-- 툴바 넣는 CDN 입니다 -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
<!-- juanMap.js CDN -->
<script src="/javascript/juanMap.js"></script>
<!-- Mansory CDN 블럭처럼 게시물을 쌓을 수 있도록 만들어주는 CDN입니다! -->
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
<html>
<style>
	body {
		height: 100%
	}

	#map {
		height: 80%;
		width: 100%;
		clear: both;
	}

	/* jumbotron 이미지를 넣는 부분 입니다!*/
	.jumbotron {
    margin-bottom: 0px;
    background-image: url(/images/spot/362.jpg);
    background-position: 0% 25%;
    background-size: cover;
    background-repeat: no-repeat;
    color: white;
	}
	
	/* Mansory에 관련된 CSS 입니다! */
	 .item {
        width: 100%;
        height: 100%;
        float: left;
        margin: 10px;
        border-radius :10px;
        background-color:#CEF6F5;
      }
      
      .big { 
	      width : 30%; 
	      height: 85%; 
	      }
	      
      .normal { width : 15%; height:300px;}
      .small { width : 100px ; height:100px;}
      
      /*드랍다운 들어가는 css*/
	.dropbtn {
		    background-color: #4CAF50;
		    color: white;
		    padding: 16px;
		    font-size: 16px;
		    border: none;
		}

		span.dropdown {
			width: 16.6%;
			float: left;
		}

		.dropdown {
		    position: relative;
		    display: inline-block;
		}

		.dropdown-content {
		    display: none;
		    position: absolute;
		    background-color: #f1f1f1;
		    min-width: 160px;
		    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
		    z-index: 1;
		}

		.dropdown-content a {
		    color: black;
		    padding: 12px 16px;
		    text-decoration: none;
		    display: block;
		}
		
		.dropdown-content a:hover {background-color: #ddd;}
		
		.dropdown:hover .dropdown-content {display: block;}
		
		.dropdown:hover .dropbtn {background-color: #3e8e41;}

</style>

<head>
<script>

	//이 부분은 지도 관련 맵 입니다! 
	//중앙 위치값을 세팅해 줍니다. 
	var center = {
		lat : 37.57593689999999,
		lng : 126.97681569999997
	};
	var map, geocoder, infowindow;
	var locations = [];
	var infowindows = [];
	var contents = [];
	//마커 저장소
	var markers = [];
	
	//마커 담는 곳
	var spot = ${a};
	for (var i = 0 ; i < spot.length; i++){
		obj = {
				lat : parseFloat(spot[i].spotY),
				lng : parseFloat(spot[i].spotX),
				addr : spot[i].spotAddress,
				detail : spot[i].spotDetail,
				title : spot[i].spotTitle,
				img : spot[i].spotImg
		};
		locations.push(obj);
	};
	
	function initMap() {

		// 맵 스타일 속성에 필요한 배열 생성 
		var styles = [];

		//새로운 styleMapType를 생성하며 커스터마이징한 스타일을 적용 시킨 객체를 만든다. 
		var styledMap = new google.maps.StyledMapType(styles, {
			name : "Styled Map"
		});

		// 맵에 세팅될 각종 옵션을 적용 시킨다. 
		var mapOptions = {
			//최초 맵 로딩 시 위치 값 셋팅 
			center : center,
			// 줌 레벨 셋팅 
			zoom : 14,
			//스크롤 휠 페이지 검색
			scrollwheel : false,
			// 스타일 맵 적용 
			mapTypeControlOptions : {
				mapTypeIds : [ google.maps.MapTypeId.ROADMAP, 'map_style' ]
			}
		};

		// 맵 객체 생성 
		map = new google.maps.Map(document.getElementById('map'), mapOptions);
		// 시군구를 표현할 수 있도록 경계를 칠해주는 코딩입니다!
		map.data.loadGeoJson('https://raw.githubusercontent.com/southkorea/seoul-maps/master/kostat/2013/json/seoul_municipalities_geo.json');
		// Set the stroke width, and fill color for each polygon
		map.data.setStyle(function(feature) {
			var color = '#F1F8E0';
			if (feature.getProperty('isColorful')) {
				color = '';
			}
			return ({
				fillColor : color,
				strokeWeight : 0.2
			});
		});

		geocoder = new google.maps.Geocoder;

		// When the user clicks, set 'isColorful', changing the color of the letters.
		map.data.addListener('click', function(event) {
			event.feature.setProperty('isColorful', true);
		});

		map.data.addListener('mouseover', function(event) {
			map.data.revertStyle();
			map.data.overrideStyle(event.feature, {
				fillColor : '#F2F79B'
			});
		});

		map.data.addListener('mouseout', function(event) {
			map.data.revertStyle();
		});

		// 클릭시 이벤트 리스너 셋팅
		map.data.addListener('click', function(event) {
			alert("클릭하면 현재 위치의 주소값을 가져옵니다");
			//getAddress(event);
			//zoomChange(event);
		});
		
		// 이부분은 마커를 추가해주는 부분입니다.
		for (var i = 0; i < locations.length; i++) {
			markers[i] = new google.maps.Marker({
				position : locations[i],
				map : map,
				icon: icons['suyo'].icon
			});
			//인덱스를 꺼내오기.. 중요!!
			markers[i].index = i

			contents[i] = '<div class="box box-primary">'
					+ '<div class="box-body box-profile">'
					+ '<img class="profile-user-img img-responsive img-circle" src="/images/spot/ ' + locations[i].img + ' " alt="User profile picture">'
					+ '<h3 class="profile-username text-center">'+ locations[i].title+ '</h3>'+ '<ul class="list-group list-group-unbordered">'
					+ '<li class="list-group-item">'
					+ '   <b>위치</b> <a class="pull-center">'+ locations[i].addr+ '</a>'+ '</li>'+ '  <li class="list-group-item">'
					+ '<li class="list-group-item">'+ ' <b>조회수</b> <a class="pull-right">'+ locations[i].detail+ '</a>'+ ' </li>'
					+ ' </ul>'
					+ '<span> '
					+ ' <a href="#" id ="abc" class="btn btn-primary btn-block" onclick="aaa()"><b>상세보기</b></a>'
					+ '<span>'
					+ '<span> '
					+ ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="marking()"><b>장소바구니추가</b></a>'
					+ '</span>' + '</div>';

			// 이벤트 정보 넣기
			infowindows[i] = new google.maps.InfoWindow(
					{
						content : contents[i],
						removeable : true
					});

			// 마커를 클릭했을때 이벤트 발생 시키기
			google.maps.event.addListener(markers[i],'click',function() {
								// 일단 마커를 모두 닫고
								for (var i = 0; i < markers.length; i++) {
										infowindows[i].close();
									}
								infowindows[this.index].open(map,markers[this.index]);
								map.panTo(markers[this.index].getPosition());
							});

			// 마커를 클릭했을때 이벤트 발생 시키기
			google.maps.event.addListener(markers[i],'rightclick', function() {alert("이곳의 위치가 궁금한가?!");
			});
		}
	}//end of initmap();	
	
</script>
<section class="content container-fluid">
		<body>
		   <%@ include file="/layout/toolbar.jsp"%>
			<span class="dropdown">
				<button class="btn btn-block btn-info btn-xs" ><a href="/spot/getSpotList?spotCode=0">공원</a></button>
			</span>

			<span class="dropdown">
				<button class="btn btn-block btn-success btn-xs" ><a href="/spot/getFestivalList">축제/전시</a></button>
				</div>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-success btn-xs" >맛집</a></button>
					<div class="dropdown-content">
					<a href="/spot/getSpotList?spotCode=10">삼대천왕</a>
					<a href="/spot/getSpotList?spotCode=11">수요미식회</a>
				</div>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-danger btn-xs" ><a href="/spot/getSpotList?spotCode=4">한강</a></button>
			</span>
			
			<span class="dropdown">
				<button class="btn btn-block btn-warning btn-xs">편의시설</button>
				<div class="dropdown-content">
					<a href="/spot/getSpotList?spotCode=30">수유실</a> 
					<a href="/spot/getSpotList?spotCode=31">자동차</a>
					<a href="/spot/getSpotList?spotCode=32">자전거</a>
				</div>
			</span>
			<div id="map">
				<br /> <br />
			</div>
			<div class="jumbotron">
  				<h1>수요미식회</h1>
  					<p>tvN의 먹방 프로그램! 서울의 수요미식회를 찾아보세요!</p>
  					<p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
			</div>
			<div class="parkImg">
			<c:set var="i" value="0" />
				<c:forEach var="spot" items="${list}">
					<c:set var="i" value="${i+1}" />
					<tr class="ct_list_pop">
						<td align="center" valign="middle">${ i }</td>
						<td align="center">${spot.spotTitle}</td>
						<td align="center"><img src="/images/spot/${spot.spotImg}" width="200" height="100" /></td>
						<td align="center">${spot.spotAddress}</td>
						<td align="center">${spot.spotDetail}</td>
						<td align="center">${spot.spotProvince}<span class="label label-info">축제/전시</span></td>
						<br/>
					</tr>
				</c:forEach>
			</div>
		</body>
	</section>
	<script>
	var page = -1;
	// 1. 스크롤 이벤트 발생
	$(window).scroll(function() {
		if ($(window).scrollTop() >= $(document).height() - $(window).height() - 100) {
          ++page;
       // 4. ajax를 이용하여 현재 뿌려진 게시글의 마지막 bno를 서버로 보내어 그 다음 20개의 게시물 데이터를 받아온다. 
			$.ajax({
						type : 'post', // 요청 method 방식 
						url : '/restspot/infinityscrollDown',// 요청할 서버의 url
						headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "POST"
						},
						dataType : 'json', // 서버로부터 되돌려받는 데이터의 타입을 명시하는 것이다.
						data : JSON.stringify({ // 서버로 보낼 데이터 명시 
							spotNo : page,
							spotCode : 11
						}),
						success : function(data) {// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
							var output = '';
							$(data).each(function() {
								output += '<div class="item big">';
							       output += '<div class="thumbnail">';
							      output += '<img src="/images/spot/ ' + this.spotImg + ' " height="200px" width="100%"/>';
							      output += ' <div class="caption">';
							      output += '<h3>' + this.spotTitle + '</h3>';
								  output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> Location</strong>';
								  output += '<p> ' + this.spotAddress+'</p>';
								  output += '  <strong><i class="glyphicon glyphicon-earphone"></i> Detail</strong>';
								  output += '<p> ' + this.spotDetail+'</p>';
								  output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
								 output += ' <p>';
								 output += ' <span class="label label-danger">맛집</span>';
								 output += '  <span class="label label-warning">수요미식회</span>';
								 output += ' </p>';
								  output += '<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>';
								  output += '</div>';
								  output += '</div>'; 
								  output += '</div>';
							});// each
								// 8. 이전까지 뿌려졌던 데이터를 비워주고, <th>헤더 바로 밑에 위에서 만든 str을  뿌려준다.   
								$(".parkImg").append(output);
							}// else
						}// success

					);// ajax
        }//end of if
    });
</script>
</html>
