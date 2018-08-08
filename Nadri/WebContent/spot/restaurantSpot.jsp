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
<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)" href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>
<!-- materialize 넣는 css -->
<!-- <script src="/javascript/materialize.js"></script>
<link rel="stylesheet" href="/css/materialize.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> -->
<!-- sweet alert를 쓰기위한 CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<html>
<style>
/* @font-face {
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
 */

body {
	height: 100%;
	margin: 0px;
/* 	font-family : seoul; */
}

.expander-box{
	position : absolute;
	top : 70px;
	padding : 17.5px;
	background: #748ea98a;
	color : white;
	z-index : 1;
	right : 100%;
	transition : all 1s;
	border-radius : 50px 0px 0px 50px;
}

#expander-spots:hover{
	cursor : pointer;
}

.spot-top-box{
	width : 100%;
	margin-left:auto;
	margin-right:auto;
	position : absolute;
	top : 70px;
	z-index : 1;
	transition : all 1s;
	left : 0%;
}

@media only screen and (max-width : 600px){
	.spot-top-box{
		top : 50px;
	}
	
	.expander-box{
		top : 50px;
	}
}

.nav-wrapper{
	background: #6d91af94;
}

#nav-mobile{
	list-style: none;
	display : flex;
	margin : 0px;
	justify-content: space-evenly;
	padding : 15px;
	color : white;
}

#nav-mobile:hover{
	z-index : 99;
}

li > span{
	transition : all 1s;
}

li > span:hover{
	cursor : pointer;
	font-weight : 900;
	font-size:20px;
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
	   margin-bottom: 15px;
	   background-image: url(/images/spot/restaurant.jpg);
	   background-position: 0% 25%;
	   background-size: cover;
	   background-repeat: no-repeat;
	   color: #ffffff;
	   padding-left : 10%;
	   box-shadow : 1px 1px 10px 0px #8080807d;
	}

/*spot에 패딩을 넣는 장소 입니다!!*/
.spotImg{
padding : 5px;
}

#searchKeyword {
	width: 150px;
	float: left;
}
</style>

<head>
<script>

$(function(){
	
	$("#searchbutton").on("click", function(){
		deleteMarkers();
		map.setZoom(11);
		//$('#searchbutton').unbind('click');
		searchkeyword();
	})
	
});



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
	
	//마커 담는 곳
	/* var spot = ${a};
	for (var i = 0 ; i < spot.length; i++){
		if(spot[i].spotCode=='10'){
			obj = {
					lat : parseFloat(spot[i].spotY),
					lng : parseFloat(spot[i].spotX),
					addr : spot[i].spotAddress,
					detail : spot[i].spotDetail,
					title : spot[i].spotTitle,
					img : spot[i].spotImg,
					no : spot[i].spotNo,
					type : 'samdae'
			};
			locations.push(obj);
		}else{
			obj = {
					lat : parseFloat(spot[i].spotY),
					lng : parseFloat(spot[i].spotX),
					addr : spot[i].spotAddress,
					detail : spot[i].spotDetail,
					title : spot[i].spotTitle,
					img : spot[i].spotImg,
					no : spot[i].spotNo,
					type : 'suyo'
			};
			locations.push(obj);	
		}
	}; */

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
			zoom : 13,
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
		
		//드래그 할때마다 현재 위치를 가져옵니다.
		map.addListener('dragend', function(event) {
			deleteMarkers();
			var a = map.getCenter();
			var lat = ""+a.lat();
			var lon = ""+a.lng();
			searchAroundRestaurant(lat, lon);
		});
		
		/* for (var i = 0; i < locations.length; i++) {
			markers[i] = new google.maps.Marker({
				position : locations[i],
				map : map,
				icon: icons[locations[i].type].icon
			});
			//인덱스를 꺼내오기.. 중요!!
			markers[i].index = i

			contents[i] = '<div class="box box-primary" style="font-family : seoul">'
					+ '<h4 class="profile-username text-center">'+ locations[i].title+ '</h4>'
					+ '<img class="img-rounded" src="/images/spot/'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
					+ '<li class="list-group-item">'
					+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b>'+ locations[i].addr+ '</li>'
					+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
					+ '<b>Tag&nbsp</b></i> <span class="label label-success"> 백과</span><span class="label label-warning">맛집</span></li>'
					+ '<a href="/spot/getSpot?spotNo='+ locations[i].no+ '"" class="waves-effect waves-light btn" style="width:100%" ><b>상세보기</b></a>'
					+ '</div>';

			// 이벤트 정보 넣기
			infowindows[i] = new google.maps.InfoWindow(
					{
						content : contents[i],
						removeable : true
					});

			// 마커를 클릭했을때 이벤트 발생 시키기
			google.maps.event.addListener(markers[i],'click',function() {
								map.setZoom(14);
								// 일단 마커를 모두 닫고
								for (var i = 0; i < markers.length; i++) {
										infowindows[i].close();
									}
								infowindows[this.index].open(map,markers[this.index]);
								map.panTo(markers[this.index].getPosition());
							});
		} */
		
		
		//HJA 현재 위치를 기준으로 맛집을 찍습니다!
		// 나의 위치를 찍어주는 부분입니다!
		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	 	if (navigator.geolocation) {

			// GeoLocation을 이용해서 접속 위치를 얻어옵니다
			navigator.geolocation.getCurrentPosition(function(position) {

				var lat = position.coords.latitude, // 위도
				lon = position.coords.longitude; // 경도

				var nowposition = new google.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
				message = '<div style="font-family : seoul"><div>당신은 지금 여기!!</div></div>'; // 인포윈도우에 표시될 내용입니다

				// 마커와 인포윈도우를 표시합니다
				displayMarker(nowposition, message);
				
				searchAroundRestaurant(lat, lon);
				
			});

		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

			var nowposition = new google.maps.LatLng(37.495460, 127.027304), message = '<div style="font-family : seoul"><div>당신은 지금 여기!!</div></div>'

			displayMarker(nowposition, message);
			deleteMarkers();
			searchAroundRestaurant(37.495460, 127.027304);
		}
		
		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(nowposition, message) {
			// 마커를 생성합니다
			var marker = new google.maps.Marker({
				map : map,
				position : nowposition,
				icon : icons['myplace'].icon
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
		/////////////////////////////////////////////현재위치 찍는 부분 끝!///////////////////////////////////////////////////////////////////////////
		
		
		
		
		
		
		
	}//end of initmap();	
	
	
	// searchkeyword 눌렀을때!!
	function searchkeyword(){
			$.ajax({
				type : 'post', // 요청 method 방식 
				url : '/restspot/getSearchSpotList',// 요청할 서버의 url
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'json', // 서버로부터 되돌려받는 데이터의 타입을 명시하는 것이다.
				data : JSON.stringify({ // 서버로 보낼 데이터 명시 
					searchSpot : 1,
					searchKeyword : $("#searchKeyword").val()
				}),
				success : function(data) {// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
				if(data==''){
					swal("아쉽게도 결과가 없네요?");
				} else {
					var spot = data; 
					for (var i = 0 ; i < spot.length; i++){
						if(spot[i].spotCode=='10'){
							obj = {
									lat : parseFloat(spot[i].spotY),
									lng : parseFloat(spot[i].spotX),
									addr : spot[i].spotAddress,
									detail : spot[i].spotDetail,
									title : spot[i].spotTitle,
									img : spot[i].spotImg,
									no : spot[i].spotNo,
									type : 'samdae'
							};
							locations.push(obj);
						}else{
							obj = {
									lat : parseFloat(spot[i].spotY),
									lng : parseFloat(spot[i].spotX),
									addr : spot[i].spotAddress,
									detail : spot[i].spotDetail,
									title : spot[i].spotTitle,
									img : spot[i].spotImg,
									no : spot[i].spotNo,
									type : 'suyo'
							};
							locations.push(obj);	
						}
					};
			          
					for (var i = 0; i < locations.length; i++) {
						markers[i] = new google.maps.Marker({
							position : locations[i],
							map : map,
							icon: icons[locations[i].type].icon,
							animation: google.maps.Animation.DROP
						});
						//인덱스를 꺼내오기.. 중요!!
						markers[i].index = i

						contents[i] = '<div class="box box-primary" style="font-family : seoul">'
								+ '<h4 class="profile-username text-center">'+ locations[i].title+ '</h4>'
								+ '<img class="img-rounded" src="/images/spot/'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
								+ '<li class="list-group-item">'
								+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b>'+ locations[i].addr+ '</li>'
								+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
								+ '<b>Tag&nbsp</b></i> <span class="label label-success"> 백과</span><span class="label label-warning">맛집</span></li>'
								+ '<a href="/spot/getSpot?spotNo='+ locations[i].no+ '"" class="waves-effect waves-light btn" style="width:100%" ><b>상세보기</b></a>'
								+ '</div>';

						// 이벤트 정보 넣기
						infowindows[i] = new google.maps.InfoWindow(
								{
									content : contents[i],
									removeable : true
								});

						// 마커를 클릭했을때 이벤트 발생 시키기
						google.maps.event.addListener(markers[i],'click',function() {
							map.setZoom(14);
							// 일단 마커를 모두 닫고
							for (var i = 0; i < markers.length; i++) {
									infowindows[i].close();
								}
							infowindows[this.index].open(map,markers[this.index]);
							map.panTo(markers[this.index].getPosition());
						});
					}
				}
						
					$(".spotImg").empty();
					var output = '';
					$(data).each(
									function() {
										output += '<div class="col-sm-3 col-md-3">';
										output += '<div class="thumbnail">';
										output += ' <div class="caption">';
										output += '<h4>'+ this.spotTitle+ '</h4>';
										output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> 위치 </strong>';
										output += '<p> '+ this.spotAddress+ '</p>';
										output += '  <strong><i class="glyphicon glyphicon-pencil"></i> 등록날짜 / 수정날짜 </strong>';
										output += '<p> '+ this.spotCreateTime+ ' / '+ this.spotModifyTime+ '</p>';
										output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
										output += ' <p>';
										output += ' <span class="label label-success">백과</span>';
										output += ' <span class="label label-warning">맛집</span>';
										output += ' </p>';
										output += '<p><a href="/spot/getSpot?spotNo='+ this.spotNo+ '" class="waves-effect waves-light btn" role="button"><i class="tiny material-icons">search</i>상세보기</a></p>';
										output += '</div>';
										output += '</div>';
										output += '</div>';
									});// each
					// 8. 이전까지 뿌려졌던 데이터를 비워주고, <th>헤더 바로 밑에 위에서 만든 str을  뿌려준다.   
					$(".spotImg").append(output);
				}// else
			}// success
		);// ajax
}
	
	function searchAroundRestaurant(lat,lng) { 
		// 앞서 만들어진 마커를 초기화 시킵니다.
		deleteMarkers();
		// 앞서 검색한 부분을 초기화시킵니다.
		 $('.spotImg').empty();
		//1. ajax를 통해서 리스트를 뽑아옵니다.
		$.ajax({
				type : 'POST', // 요청 Method 방식
				url : '/restspot/searchAroundRestaurant', // 요청할 서버의 url
				headers : {
					 "Content-Type" : "application/json",
					 "X-HTTP-Method-Override" : "POST"
				},
				dataType : 'json', // 서버로 부터 되돌려 받는 데이터의 타입을 명시
				data : JSON.stringify({
					spotY : lat,
					spotX : lng
				}),
				success : function(result){ // ajax 가 성공했을시에 수행될 function
			          var spot = result;
			          for ( var i = 0 ; i<spot.length ; i++){ 
			        	  if(parseInt(spot[i].spotCode) == 10){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'samdae' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo, img : spot[i].spotImg};
				  			    locations.push(obj);
				  	        }else if (parseInt(spot[i].spotCode) == 11){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'suyo' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo, img : spot[i].spotImg};
				  			    locations.push(obj)
				  	        };
			        	  
			        	// 이부분은 마커를 추가해주는 부분입니다.
				  		 	for ( var i = 0 ; i < locations.length; i++) { 
				  	          	markers[i] = new google.maps.Marker({
				  	            position: locations[i].position,
				  	          	icon: icons[locations[i].type].icon,
				  	            map: map
				  	          });  
				  	          	
				  	          markers.push(markers[i]);
				  	          //인덱스를 꺼내오기.. 중요!!
				  	          markers[i].index = i

				  	        contents[i] = '<div class="box box-primary" style="font-family : seoul">'
								+ '<h4 class="profile-username text-center">'+ locations[i].title+ '</h4>'
								+ '<img class="img-rounded" src="/images/spot/'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
								+ '<li class="list-group-item">'
								+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b>'+ locations[i].addr+ '</li>'
								+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
								+ '<b>Tag&nbsp</b></i> <span class="label label-success"> 백과</span><span class="label label-warning">맛집</span></li>'
								+ '<a href="/spot/getSpot?spotNo='+ locations[i].no+ '"" class="waves-effect waves-light btn" style="width:100%" ><b>상세보기</b></a>'
								+ '</div>';

								// 이벤트 정보 넣기
								infowindows[i] = new google.maps.InfoWindow(
										{
											content : contents[i],
											removeable : true
										});
				          
								// 마커를 클릭했을때 이벤트 발생 시키기
								google.maps.event.addListener(markers[i],'click',function() {
									//map.setZoom(15);
									// 일단 마커를 모두 닫고
									//for (var i = 0; i < markers.length; i++) {
											//infowindows[i].close();
										//}
									infowindows[this.index].open(map,markers[this.index]);
									map.panTo(markers[this.index].getPosition());
								});
							}
						}
								
							$(".spotImg").empty();
							var output = '';
							$(result).each(
											function() {
												output += '<div class="col-sm-3 col-md-3">';
												output += '<div class="thumbnail">';
												output += ' <div class="caption">';
												output += '<h4>'+ this.spotTitle+ '</h4>';
												output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> 위치 </strong>';
												output += '<p> '+ this.spotAddress+ '</p>';
												output += '  <strong><i class="glyphicon glyphicon-pencil"></i> 등록날짜 / 수정날짜 </strong>';
												output += '<p> '+ this.spotCreateTime+ ' / '+ this.spotModifyTime+ '</p>';
												output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
												output += ' <p>';
												output += ' <span class="label label-success">백과</span>';
												output += ' <span class="label label-warning">맛집</span>';
												output += ' </p>';
												output += '<p><a href="/spot/getSpot?spotNo='+ this.spotNo+ '" class="waves-effect waves-light btn" role="button"><i class="tiny material-icons">search</i>상세보기</a></p>';
												output += '</div>';
												output += '</div>';
												output += '</div>';
											});// each
							// 8. 이전까지 뿌려졌던 데이터를 비워주고, <th>헤더 바로 밑에 위에서 만든 str을  뿌려준다.   
							$(".spotImg").append(output);
						}// else
					}// success
				);// ajax
		}

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
      locations = [];
    }
    
</script>

<%-- Main content --%>
<!-- 상단에 둥둥 떠있는 아이콘 (상단으로 이동) -->
<body>
<img class="gotoTop" src="/images/board/gotoTop.png" alt="맨위로!"/>
	
<%@include file="/layout/new_toolbar.jsp"%>
	
<nav class="spot-top-box">
    <div class="nav-wrapper">
      <ul id="nav-mobile" class="right hide-on-med-and-down">
        <li><span class="glyphicon glyphicon-triangle-right" id="unexpanded"></span></li>
        <li><span id="park">공원</span></li>
        <li><span id="restaurant">맛집</span></li>
        <li><span id="festival">축제/전시</span></li>
		<li><span id="river">한강</span></li>
        <li><span id="search">검색</span></li>
      </ul>
    </div>
</nav>
<div class="expander-box">
	<span class="glyphicon glyphicon-triangle-left" id="expander-spots"></span>
</div>
  
	<div id="map">
		<br /> <br />
	</div>
		<div id="container">
			<div class="jumbotron">
				<h1>맛집</h1>
					<p>'tvN 수요미식회' , '삼대천왕' 나들이를 함께할 서울의 맛집을 검색해보세요!</p>
					  <div class="form-group">
					    <label class="sr-only" for="searchKeyword">검색어</label>
					    <div>
					   	 <input type="text" class="form-control" id="searchKeyword" placeholder="검색어" ><a class="waves-effect waves-light btn" id="searchbutton">검색</a></input>					  
					    </div>
					  </div>
			</div>
	
				<div class="spotImg">
				</div>
				<br />  
			</div>	 
			
			
</body>

<script>
	var page = -1;
	// 1. 스크롤 이벤트 발생
	$(window).scroll(
					function() {
						if ($(window).scrollTop() >= $(document).height()- $(window).height() - 100) {
							++page;
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
											spotCode : 1
										}),
										success : function(data) {// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
											var output = '';
											$(data).each(
															function() {
																output += '<div class="col-sm-3 col-md-3">';
																output += '<div class="thumbnail">';
																output += ' <div class="caption">';
																output += '<h4>'+ this.spotTitle+ '</h4>';
																output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> 위치 </strong>';
																output += '<p> '+ this.spotAddress+ '</p>';
																output += '  <strong><i class="glyphicon glyphicon-pencil"></i> 등록날짜 / 수정날짜 </strong>';
																output += '<p> '+ this.spotCreateTime+ ' / '+ this.spotModifyTime+ '</p>';
																output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
																output += ' <p>';
																output += ' <span class="label label-success">백과</span>';
																output += ' <span class="label label-warning">맛집</span>';
																output += ' </p>';
																output += '<p><a href="/spot/getSpot?spotNo='+ this.spotNo+ '" class="waves-effect waves-light btn" role="button"><i class="tiny material-icons">search</i>상세보기</a></p>';
																output += '</div>';
																output += '</div>';
																output += '</div>';
															});// each
											// 8. 이전까지 뿌려졌던 데이터를 비워주고, <th>헤더 바로 밑에 위에서 만든 str을  뿌려준다.   
											$(".spotImg").append(output);
										}// else
									}// success
								);// ajax
						}//end of if
					});
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
</html>
