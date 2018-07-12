<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- Bootstrap CDN -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

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

</style>

<head>
<script>

	// 구글 맵에서 쓸 아이콘을 세팅하는 장소입니다!
	var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';
	var icons = {
		park : {
			icon : iconBase + 'partly_cloudy_maps.png'
		},
		snackbar : {
			icon : iconBase + 'snack_bar_maps.png'
		},
		info : {
			icon : iconBase + 'info_maps.png'
		},
		parking : {
			icon : iconBase + 'parking_lot_maps.png'
		},
		cycling : {
			icon : iconBase + 'cycling_maps.png'
		},
		arts : {
			icon : iconBase + 'arts_maps.png'
		}
	};

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

	function initMap() {
		deleteMarkers();
		// 삼대천왕 맛집을 불러옵니다!
		getSpotList(10)

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
			alert("클릭하면 현재 위치의 주소값을 가져옵니다");
			//getAddress(event);
			//zoomChange(event);
		});

	}//end of initmap();	
	
	//장소를 불러오는 메소드
	function getSpotList(spotCode) {  
		deleteMarkers();
		// .parkImg를 비운다.
		$('.parkImg').empty(); 
		 $.ajax({ 
	         type : "GET", 
	         url : "/restspot/getSpotList/"+spotCode, 
	         headers : { 
	             "Content-type" : "application/json", 
	             "X-HTTP-Method-Override" : "POST" 
	         }, 
	         dataType : "text", 
	         success : function (result) { 
	          var result = JSON.parse(result); 
	          var spot = result.spot 
	          for ( var i = 0 ; i<spot.length ; i++){ 
	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)) };
	          //obj = {lat : parseFloat(park[i].parkY), lng : parseFloat(park[i].parkX), detail : park[i].parkDetail }; 
	          locations.push(obj); 
	          
	      	// Create marker
	        locations.forEach(function(feature) {
	            marker = new google.maps.Marker({
	              position: feature.position,
	              //icon: icons[feature.type].icon,
	              map: map
	            });
	          }); //마커 만드는 거 끝!
	          
	   $('.parkImg').append(function (index){ 
	  		 // 변수를 선언합니다. 
		      var item = spot[index]; 
		      var output = ''; 
		      output += '<h1>' + spot[i].spotTitle + '</h1>'; 
		      output += '<img src="/images/spot/ ' + spot[i].spotImg + ' " height="100" width="100" />'; 
		      output += '<h2> 위도 : '  + spot[i].spotX + '</h1>'; 
		      output += '<h2> 경도 : '  + spot[i].spotY + '</h1>'; 
		      return output; 
		      }) 
	     } 
	  } 
	});// end of ajax 
	} // end of dropPark()

	// marker animation으로 찍기!
	function addMarkerWithTimeout(position, timeout) {
		window.setTimeout(function() {
			marker = new google.maps.Marker({
				position : position,
				//icon: icons[feature.type].icon,
				map : map
			}, timeout);
		})
	} // end of addMarkerWithTimeout
	
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
	<%-- Content Header (Page header) --%>
	<section class="content-header">
		<h1>판매지도보기</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 판매관리</a></li>
			<li class="active">판매지도</li>
		</ol>
	</section>
	<div id="weather_info">
		<h1 class="city"></h1>
		<section>
			<p class="w_id"></p>
			<div class="icon"></div>
			<span class="temp"></span> <span class="temp_max"></span> <span
				class="temp_min"></span>
		</section>
	</div>

	<%-- Main content --%>
	<section class="content container-fluid">
		<body>

			<span class="dropdown">
				<button class="btn btn-block btn-info btn-xs" onclick="getSpotList(0)">공원</button>
			</span>

			<span class="dropdown">
				<button class="btn btn-block btn-success btn-xs" onclick="getFestivalList()">축제/전시</button>
				</div>
			</span>

			<span class="dropdown">
				<div class="dropdown-content">
					<a href="#" onclick="getSpotList(10)">삼대천왕</a> 
					<a href="#" onclick="getSpotList(11)">수요미식회</a>
				</div>
			</span>

			<span class="dropdown">
				<button class="btn btn-block btn-danger btn-xs"
					onclick="getRiverList()">한강</button>
				<div class="dropdown-content">
					<a href="#">Link 1</a> 
					<a href="#">Link 2</a> 
					<a href="#">Link3</a>
				</div>
			</span>

			<span class="dropdown">
				<button class="btn btn-block btn-warning btn-xs"
					onclick="getUtilList()">편의시설</button>
				<div class="dropdown-content">
					<a href="#">Link 1</a> 
					<a href="#">Link 2</a>
					<a href="#">Link 3</a>
				</div>
			</span>
			<div id="map">
				<br /> <br />
			</div>
			<div class="parkImg"></div>
			<p></p>
			<div id="dataInfo"></div>
			<br />

		</body>
</html>
