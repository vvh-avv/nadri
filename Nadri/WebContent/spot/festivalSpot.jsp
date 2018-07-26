<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="/images/common/favicon.ico">
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Bootstrap CDN -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<!-- common.js / common.css CDN -->
<script src="/javascript/common.js"></script>
<link rel="stylesheet" href="/css/common.css">
<!-- juanMap.js CDN -->
<script src="/javascript/juanMap.js"></script>
<!-- Mansory CDN 블럭처럼 게시물을 쌓을 수 있도록 만들어주는 CDN입니다! -->
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>
<!-- 툴바 넣는 CDN 입니다 -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
<!-- materialize 넣는 css -->
<script src="/javascript/materialize.js"></script>
<link rel="stylesheet" href="/css/materialize.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<html>
<style>
@font-face {
	font-family: 'seoul';
	src: url('/css/fonts/seoulhangangjangm.eot');
	src: url('/css/fonts/seoulhangangjangm.eot?#iefix')
		format('embedded-opentype'), url('/css/fonts/seoulhangangjangm.woff2')
		format('woff2'), url('/css/fonts/seoulhangangjangm.woff')
		format('woff'), url('/css/fonts/seoulhangangjangm.ttf')
		format('truetype'),
		url('/css/fonts/seoulhangangjangm.svg#seoul-hangang-jang-m')
		format('svg');
	font-weight: normal;
	font-style: normal;
}


body {
	height: 100%;
	margin: 0px;
	font-family : seoul;
}

#map {
	height: 65%;
	width: 100%;
	clear: both;
}

/*맨위로가게만들어주는 css */
.gotoTop {
	display: none;
	cursor: pointer;
	position: fixed;
	bottom: 10%;
	right: 5%;
	width: 50px;
	height: 50px;
	z-index: 999;
}

/* jumbotron 이미지를 넣는 부분 입니다!*/
.jumbotron {
	margin-bottom: 0px;
	background-image: url(/images/spot/festival.jpg);
	background-position: 0% 25%;
	background-size: cover;
	background-repeat: no-repeat;
	color: #ffffff;
	padding-left : 10%;
}

/*spot에 패딩을 넣는 장소 입니다!!*/
.spotImg {
padding : 5px;
}

#searchKeyword {
	width: 10%;
}

div#container {
    padding-left: 5%;
    padding-right: 5%;
}

td {
	text-align : center;
}

#img{
	width : 20%;
}

.table>tbody>tr>td{
	line-height: 1;
	border-top : 1px;
	vertical-align: middle;
}

</style>

<head>
<script>

//맨위로 올라가게 만들어 주는 script
$(function() {
	//*스크롤감지
	$(window).scroll(function() {
		var scrollLocation = $(window).scrollTop(); //브라우저의 스크롤 값

		if (scrollLocation != 0) { //화면을 내리면 gotoTop 뜨게하고
			$(".gotoTop").fadeIn();
		} else { //화면을 올리면 gotoTop 사라지게하기
			$(".gotoTop").fadeOut();
		}
	});

	//*상단에 둥둥 떠있는 아이콘 (상단으로 이동)
	$(".gotoTop").on("click", function() {
		$("body").scrollTop(0);
	});
});

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
	var data = ${a};
	var festival = data.response.body.items.item;
	for (var i = 0; i < festival.length; i++) {
		obj = {
			lat : parseFloat(festival[i].mapy),
			lng : parseFloat(festival[i].mapx),
			img : festival[i].firstimage,
			title : festival[i].title,
			tel : festival[i].tel,
			addr : festival[i].addr1,
			readcount : festival[i].readcount,
			contentid : festival[i].contentid
		};
		locations.push(obj);
	}
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
			zoom : 11,
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
			//alert("클릭하면 현재 위치의 주소값을 가져옵니다");
			//getAddress(event);
			//zoomChange(event);
		});

		// 이부분은 마커를 추가해주는 부분입니다.
		for (var i = 0; i < locations.length; i++) {
			markers[i] = new google.maps.Marker({
				position : locations[i],
				map : map,
				icon : icons['festival'].icon
			});
			//인덱스를 꺼내오기.. 중요!!
			markers[i].index = i
			
			contents[i] = '<div class="box box-primary" style="font-family : seoul">'
				+ '<h4>'+ locations[i].title+ '</h4>'
				+ '<img class="img-rounded" src="'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
				+ '<li class="list-group-item">'
				+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b>'+ locations[i].addr+ '</li>'
				+ '<li class="list-group-item">'
				+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>대표전화  </b>'+ locations[i].tel+ '</li>'
				+ '<li class="list-group-item">'
				+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>조회수  </b>'+ locations[i].readcount+ '</li>'
				+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
				+ '<b>Tag&nbsp</b></i> <span class="label label-success"> 백과</span> <span class="label label-info">축제/전시</span></li>'
				+ '<a href="/spot/getFestival?spotNo='+ locations[i].contentid+'"" class="waves-effect waves-light btn" style="width:100%" ><b>상세보기</b></a>'
				+ '</div>';
				
			// 이벤트 정보 넣기
			infowindows[i] = new google.maps.InfoWindow({
				content : contents[i],
				removeable : true
			});

			// 마커를 클릭했을때 이벤트 발생 시키기
			google.maps.event.addListener(markers[i], 'click', function() {
				// 일단 마커를 모두 닫고
				for (var i = 0; i < markers.length; i++) {
					infowindows[i].close();
				}
				infowindows[this.index].open(map, markers[this.index]);
				map.panTo(markers[this.index].getPosition());
			});
		}

	}//end of initmap();	
	
	$(function(){
	// 상세보기로 넘어갑니다.
		$(".spot").on('click', function() {
			self.location = "/spot/getFestival?spotNo=" +$(this).children(':first').text();
		});
	});
</script>
<img class="gotoTop" src="/images/board/gotoTop.png" alt="맨위로!">
	<%-- Main content --%>
	<body>
		<%@ include file="/layout/toolbar.jsp"%>
		
		<nav>
		    <div class="nav-wrapper">
		      <ul id="nav-mobile" class="right hide-on-med-and-down">
		        <li><span id="park">공원</span></li>
		        <li><span id="festival">축제/전시</span></li>
		        <li><span id="restaurant">맛집</span></li>
		        <li><span id="search">검색</span></li>
		      </ul>
		    </div>
	  </nav>

<div id="map">
	<br /> <br />
</div>
<div class="jumbotron">
	<h1>축제</h1>
	<p>서울시에서 시행되고 있는 '축제/전시' 를 조회순으로 만나보세요!</p>
</div>
	<div class="table-responsive" id="container">
		<table class="table table-hover">
			<thead>
				<tr>
					<th class="text-center" width="5%" >번호</th>
					<th class="text-center" width="20%">제목</th>
					<th class="text-center" id="img" >축제이미지</th>
					<th class="text-center"  width="20%">축제장소</th>
					<th class="text-center">전화번호</th>
					<th class="text-center">태그</th>
					<th class="text-center">조회수</th>
				</tr>
			</thead>
			<c:set var="i" value="0" />
			<c:forEach var="festival" items="${a.response.body.items.item}">
				<c:set var="i" value="${i+1}" />
				<tbody>
					<tr class="spot">
						<td>${festival.contentid}</td>
						<td>${festival.title}</td>
						<c:if test="${ !empty festival.firstimage}">
							<!--  값이 있을때 -->
							<td><img src="${festival.firstimage}" width="100px"height="100px"  /></td>
						</c:if>
						<c:if test="${ empty festival.firstimage}">
							<td><img src="/images/spot/festivaldefault.jpg"width="100px" height="100px" /></td>
						</c:if>
						<td align="center">${festival.addr1}</td>
						<td align="center">${festival.tel}</td>
						<td align="center"><span class="label label-success"> 백과</span><span class="label label-info">축제/전시</span></td>
						<td align="center">${festival.readcount}</td>
					</tr>
				</tbody>
			</c:forEach>
		</table>
	</div>
</body>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
</html>
