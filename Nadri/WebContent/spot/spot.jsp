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
		
		var a = ${list};

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

	//줌을 변경하는 메소드
	function zoomChange(event) {
		//줌 축소 고정
		if (map.getZoom() > 10) {
			map.setZoom(13);
		}
	}//end of zoomChange

	//주소를 가져오는 메소드
	function getAddress(event) {
		var strData = "";
		addMarker(event.latLng, map);
		// getJSON 방식으로 데이터를 데이터를 가져오는 방식 파라미터를 설정해서 각종 옵션 변경이 가능하다. 
		var lat = "" + event.latLng.lat();
		var lng = "" + event.latLng.lng();
		var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
				+ lat + "," + lng
				+ "&language=ko&key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs";
		var strData = "";
		$.getJSON(url, function(data) {
			if (data.status == google.maps.GeocoderStatus.OK) {
				strData += "<p>results[0].formatted_address : "
						+ data.results[0].formatted_address + "</p>";
				document.getElementById("dataInfo").innerHTML = strData;
			}
		});
	}

	//마커를 생성하는 메소드
	// 지도에 마커 추가
	function addMarker(location, map) {
		marker = new google.maps.Marker({
			position : location,
			title : "현재위치",
			map : map
		});

		var latPosition = "" + location.lat(); // 현재 클릭 위도 가져오기
		latPosition = latPosition.substring(0, 10);
		var lngPosition = "" + location.lng();//현재 클릭 경도 가져오기
		lngPosition = lngPosition.substring(0, 10);

		// 말풍선 안에 들어갈 내용
		var content = "<div>" + "위도 : " + latPosition + "<br/> 경도 : "
				+ lngPosition + "</div>";
		// 마커를 클릭했을때 말풍선 표시 이벤트
		var infowindow = new google.maps.InfoWindow({
			content : content
		});

		// 말풍선 표시
		infowindow.open(map, marker);

		// 리스너에 마커 클릭 이벤트를 셋팅
		google.maps.event.addListener(marker, "click", function() {
			// 마커를 클릭하면 마커가 오버레이에서 지워집니다.
			marker.setMap(null);
		});
	}

	//장소 불러오는 메소드
	function getSpotList(spotCode) {
		deleteMarkers();
		$('.parkImg').empty();
		$.ajax({
			type : "GET",
			url : "/restspot/getSpotList/" + spotCode,
			headers : {
				"Content-type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : "json",
			success : function(result) {
				alert(result);
				locations.push(result);
				for (var i = 0; i < result.length; i++) {
					markers[i] = new google.maps.Marker({
						position : locations[i],
						map : map
					});
					obj = { position : new google.maps.LatLng(parseFloat(result[i].spotY),parseFloat(result[i].spotX))};
					locations.push(obj);

					// Create marker
					locations.forEach(function(feature) {
						var marker = new google.maps.Marker({
							position : feature.position,
							//icon: icons[feature.type].icon,
							map : map
						});
						markers.push(marker);
					}); //마커 만드는 거 끝!

							$('.parkImg').append(function(index) {
								// 변수를 선언합니다. 
								var item = spot[index];
								var output = '';
								output += '<h1>'+ spot[i].spotTitle+ '</h1>';
								output += '<img src=" ' + spot[i].spotImg + ' " height="100" width="100" />';
								output += '<h2> 주소 : '+ spot[i].spotAddress+ '</h1>';
								output += '<h2> 설명 : '+ spot[i].spotDetail	+ '</h1>';
								output += '<h3> 생성시간 : '+ spot[i].spotCreateTime+ '</h1>';
								output += '<h3> 수정시간 : '+ spot[i].spotModifyTime	+ '</h1>';
								return output;
							})
						}
					}
				});// end of ajax 
	} // end of getSpotList()

	//한강부분 메소드!
	function getRiverList() {
		clearMarkers();
		deleteMarkers()
		$('.parkImg').empty();
		$.ajax({
			type : "post",
			url : "/spot/getRiverList",
			headers : {
				"Content-type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : "text",
			success : function(result) {
				var result = JSON.parse(result);
				var river = result.river
				for (var i = 0; i < river.length; i++) {
					//park추가입니다.
					if (parseInt(river[i].spotCode) >= 5100&& parseInt(river[i].spotCode) < 5200) {
						obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY),parseFloat(river[i].spotX)),type : 'park'};
						locations.push(obj);
					} else if (parseInt(river[i].spotCode) >= 5200&& parseInt(river[i].spotCode) < 5300) {
						obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY),parseFloat(river[i].spotX)),type : 'parking'};
						locations.push(obj);
					} else if (parseInt(river[i].spotCode) >= 5300&& parseInt(river[i].spotCode) < 5400) {
						obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY),parseFloat(river[i].spotX)),type : 'info'};
						locations.push(obj);
					} else if (parseInt(river[i].spotCode) >= 5400&& parseInt(river[i].spotCode) < 5500) {
						obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY),parseFloat(river[i].spotX)),type : 'cycling'};
						locations.push(obj);
					} else if (parseInt(river[i].spotCode) >= 5500&& parseInt(river[i].spotCode) < 5600) {
						obj = {position : new google.maps.LatLng(parseFloat(river[i].spotY),parseFloat(river[i].spotX)),type : 'arts'};
						locations.push(obj);
					} else if (parseInt(river[i].spotCode) >= 5700&& parseInt(river[i].spotCode) < 5800) {
						obj = {	position : new google.maps.LatLng(parseFloat(river[i].spotY),parseFloat(river[i].spotX)),type : 'snackbar'};
						locations.push(obj);
					};

					// Create marker
					locations.forEach(function(feature) {
						marker = new google.maps.Marker({
							position : feature.position,
							icon : icons[feature.type].icon,
							map : map
						});
					}); //마커 만드는 거 끝!
				}
			}
		});// end of ajax 
	} // end of getRiverList()

	function aaa() {
		alert("장바구니추가완료!")
	}

	function marking() {
		alert("이곳을 마킹합니다!")
	}

	function getFestivalList() {
		deleteMarkers()
		// .parkImg를 비운다.
		$('.parkImg').empty();
		var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=Vb0jmUo%2BoqFihhoFRCLFAblLhxt3%2FbySc4fVdPJU%2B1SmB3AXejpBHSazfVyQr232n7jNWjyUr3KtxKi0UJQuoA%3D%3D&MobileOS=ETC&areaCode=1&numOfRows=999&MobileApp=AppTest&arrange=A&listYN=Y&eventStartDate=20180704&&_type=json";
		$.getJSON(url,function(data) {
							//var data = JSON.parse(JSON.stringify(data));
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
								alert(JSON.stringify(obj));
								locations.push(obj);
								// 이부분은 마커를 추가해주는 부분입니다.
								for (var i = 0; i < locations.length; i++) {
									//마커 각각의 ID를 설정
									//locationsfestival[i].index = i;
									markers[i] = new google.maps.Marker({
										position : locations[i],
										map : map
									});
									//인덱스를 꺼내오기.. 중요!!
									markers[i].index = i

									contents[i] = '<div class="box box-primary">'
											+ '<div class="box-body box-profile">'
											+ '<img class="profile-user-img img-responsive img-circle" src=" ' + locations[i].img + ' " alt="User profile picture">'
											+ '<h3 class="profile-username text-center">'
											+ locations[i].title
											+ '</h3>'
											+ '<ul class="list-group list-group-unbordered">'
											+ '<li class="list-group-item">'
											+ '   <b>위치</b> <a class="pull-right">'
											+ locations[i].addr
											+ '</a>'
											+ '</li>'
											+ '  <li class="list-group-item">'
											+ '<b>대표전화</b> <a class="pull-right">'
											+ locations[i].tel
											+ '</a>'
											+ '</li>'
											+ '<li class="list-group-item">'
											+ ' <b>조회수</b> <a class="pull-right">'
											+ locations[i].readcount
											+ '</a>'
											+ ' </li>'
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
								//obj = {lat : parseFloat(park[i].parkY), lng : parseFloat(park[i].parkX), detail : park[i].parkDetail }; 
								// locations.push(obj);
								$('.parkImg')
										.append(
												function(index) {
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
													output += ' <p class="text-muted"> '
															+ festival[i].title
															+ '</p>';
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
												})
							}
						});// end of getJSON
	} // end of dropFestival()

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
					<a href="#">Link 1</a> <a href="#">Link 2</a> <a href="#">Link
						3</a>
				</div>
			</span>


			<div id="map">
				<br /> <br />
			</div>
			<div class="parkImg"></div>
			<p></p>
			<div id="dataInfo"></div>
			<br />
			<br />
			<br />
			<br />
			<br />
			<!--  클릭시 모달창을 띄우는 코딩 -->
			<!-- Modal -->

		</body>
</html>
