<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

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
<!-- juanMap.js CDN --> 
<script src="/javascript/juanMap.js"></script> 
<!-- Mansory CDN 블럭처럼 게시물을 쌓을 수 있도록 만들어주는 CDN입니다! --> 
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>
<!-- 툴바 넣는 CDN 입니다 -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">

<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
<html>
<style>
	body {
		height: 100%
	}
	
	#map {
		height: 85%;
		width: 100%;
		clear: both;
	}

	/* jumbotron 이미지를 넣는 부분 입니다!*/
	.jumbotron {
    margin-bottom: 0px;
    background-image: url(/images/spot/422.jpg);
    background-position: 0% 25%;
    background-size: cover;
    background-repeat: no-repeat;
    color: white;
	}
	
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
		readcount : festival[i].readcount
	};
	locations.push(obj);
/* 	$('.parkImg').append(function(i) {
		// 변수를 선언합니다. 
		var output = '';
		output += ' <div class="col-lg-12"> ';
		output += ' <div class="box box-danger"> ';
		output += '<div class="box-header with-border">';
		output += ' <div class="box-tools pull-right">';
		output += '   <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>';
		output += '   </button>';
		output += '    <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i>';
		output += '   </button>';
		output += '  </div>';
		output += '   </div>';
		output += '    <div class="box-body no-padding">';
		output += '  <ul class="users-list clearfix">';
		output += '     <li>';
		if (typeof festival[i].firstimage == "undefined") {
			output += '       <img src="../images/river/park01.png" height="100" width="100">';
		} else {
			output += '       <img src=" ' + festival[i].firstimage + ' " height="100" width="100">';
		}
		output += '       <a class="users-list-name" href="#"> 조회수 : '
				+ festival[i].readcount
				+ '</a>';
		output += '       <span class="users-list-date">'
				+ festival[i].tel
				+ '</span>';
		output += '     </li>';
		output += '   </ul>';
		output += '  <div class="box-body">';
		output += ' <strong><i class="fa fa-book margin-r-5"></i> 행사 이름</strong>';
		output += ' <p class="text-muted"> '+ festival[i].title+ '</p>';
		output += ' <hr>';
		output += '  <strong><i class="fa fa-map-marker margin-r-5"></i> Location</strong>';
		output += '  <p class="text-muted">'
				+ festival[i].addr1
				+ '</p>';
		output += '  <hr>';
		output += '  <strong><i class="fa fa-pencil margin-r-5"></i> 태그</strong>';
		output += ' <p>';
		output += ' <span class="label label-danger">공원</span>';
		output += '  <span class="label label-success">맛집</span>';
		output += ' <span class="label label-info">축제/전시</span>';
		output += '  <span class="label label-warning">한강</span>';
		output += ' <span class="label label-primary">편의시설</span>';
		output += ' </p>';
		output += '  <hr>';
		output += ' <strong><i class="fa fa-file-text-o margin-r-5"></i> Notes</strong>';
		output += ' <p><a href="javascript:void(0)" class="uppercase">장소 상세보기</a></p>';
		output += ' </div>';
		output += '    </div>';
		output += '  <div class="box-footer text-center">';
		output += '<a href="javascript:void(0)" class="uppercase">장소 상세보기</a>';
		output += '</div>';
		output += '</div>';
		output += '</div>';
		output += ' </div>';
		return output;
	}) */
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
			zoom : 12,
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

		// 내위치 설정
		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {

			// GeoLocation을 이용해서 접속 위치를 얻어옵니다
			navigator.geolocation.getCurrentPosition(function(position) {

				var lat = position.coords.latitude, // 위도
				lon = position.coords.longitude; // 경도

				var nowposition = new google.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
				message = '<div>현재위치</div>'; // 인포윈도우에 표시될 내용입니다

				// 마커와 인포윈도우를 표시합니다
				displayMarker(nowposition, message);

			});

		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

			var nowposition = new google.maps.LatLng(33.450701, 126.570667), message = 'geolocation을 사용할수 없어요..'

			displayMarker(nowposition, message);
		}
		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(nowposition, message) {
			// 마커를 생성합니다
			var marker = new google.maps.Marker({
				map : map,
				position : nowposition
			});

			var iwContent = message, // 인포윈도우에 표시할 내용
			iwRemoveable = false;
			// 인포윈도우를 생성합니다
			var infowindow = new google.maps.InfoWindow({
				content : iwContent,
				removable : iwRemoveable
			});

			// 인포윈도우를 마커위에 표시합니다 
			infowindow.open(map, marker);

			// 지도 중심좌표를 접속위치로 변경합니다
			map.setCenter(nowposition);
		}

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
					icon: icons['festival'].icon
				});
				//인덱스를 꺼내오기.. 중요!!
				markers[i].index = i

				contents[i] = '<div class="box box-primary">'
						+ '<div class="box-body box-profile">'
						+ '<img class="profile-user-img img-responsive img-circle" src=" ' + locations[i].img + ' " alt="User profile picture">'
						+ '<h3 class="profile-username text-center">'+ locations[i].title+ '</h3>'+ '<ul class="list-group list-group-unbordered">'
						+ '<li class="list-group-item">'
						+ '   <b>위치</b> <a class="pull-center">'+ locations[i].addr+ '</a>'+ '</li>'+ '  <li class="list-group-item">'
						+ '<b>대표전화</b> <a class="pull-right">'+ locations[i].tel+ '</a>'+ '</li>'
						+ '<li class="list-group-item">'+ ' <b>조회수</b> <a class="pull-right">'+ locations[i].readcount+ '</a>'+ ' </li>'
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
										infowindows[i].close();}
									infowindows[this.index].open(map,markers[this.index]);
									map.panTo(markers[this.index].getPosition());
								});

				// 마커를 클릭했을때 이벤트 발생 시키기
				google.maps.event.addListener(markers[i],'rightclick', function() {alert("이곳의 위치가 궁금한가?!");
				});
			}
	
	}//end of initmap();	
	
	// Sets the map on all markers in the array.
    function setMapOnAll(map) {
      for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(map);
      }
    }
	
	// Removes the markers from the map, but keeps them in the array.
    function clearMarkers() {
      setMapOnAll(null);
    }

    // Shows any markers currently in the array.
    function showMarkers() {
      setMapOnAll(map);
    }

    // Deletes all markers in the array by removing references to them.
    function deleteMarkers() {
      clearMarkers();
      markers = [];
    }
</script>

<%-- Content Wrapper. Contains page content --%>
<div class="content-wrapper">
	<%-- Main content --%>
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
			
			<span class="dropdown">
				<button class="btn btn-block btn-normal btn-xs" ><a href="/spot/getSearchSpot">직접검색</a></button>
			</span>
			
			<div id="map">
				<br /> <br />
			</div>
			<div class="jumbotron">
  				<h1>축제</h1>
  					<p>우리나라 축제를 검색해 보세요!</p>
  					<p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
			</div>
			<table class="table table-hover" >
				<tr class="starview">
					<th class="text-center">No</th>
					<th class="text-center">제목</th>
					<th class="text-center">축제이미지</th>
					<th class="text-center">축제장소</th>
					<th class="text-center">전화번호</th>
					<th class="text-center">열리는구</th>
					<th class="text-center">조회수</th>
				</tr>
				<c:set var="i" value="0" />
				<c:forEach var="festival" items="${a.response.body.items.item}">
					<c:set var="i" value="${i+1}" />
					<tr class="ct_list_pop">
						<td align="center" valign="middle">${ i }</td>
						<td align="center">${festival.title}</td>
						<c:if test="${ !empty festival.firstimage}"> <!--  값이 있을때 -->
						<td align="center"><img src="${festival.firstimage}" width="200" height="100" /></td>
						</c:if>
						<c:if test="${ empty festival.firstimage}">
						<td align="center"><img src="/images/spot/festivaldefault.jpg" width="200" height="100" /></td>
						</c:if>
						<td align="center">${festival.addr1}</td>
						<td align="center">${festival.tel}</td>
						<td align="center">${festival.sigungucode}<span class="label label-info">축제/전시</span></td>
					   <td align="center">${festival.readcount}</td>
					</tr>
				</c:forEach>
			</table>
		</body>
</html>
