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
		height: 65%;
		width: 100%;
		clear: both;
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
		
/*맨위로가게만들어주는 css */
.gotoTop {
     display : none;
     cursor : pointer;
     position: fixed;
     bottom: 10%;
     right: 5%;
     width: 50px;
     height: 50px;
     z-index:999;
   }	
</style>

<head>
<script>

//맨위로 올라가게 만들어 주는 script
$(function(){
    //*스크롤감지
    $(window).scroll(function(){
        var scrollLocation = $(window).scrollTop(); //브라우저의 스크롤 값
        
        if(scrollLocation!=0){ //화면을 내리면 gotoTop 뜨게하고
            $(".gotoTop").fadeIn();
        }else{                    //화면을 올리면 gotoTop 사라지게하기
            $(".gotoTop").fadeOut();
        }
    });
    
    //*상단에 둥둥 떠있는 아이콘 (상단으로 이동)
    $(".gotoTop").on("click", function(){
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

	function initMap() {
		// 공원을 불러오는 메소드로 지도가 세팅되면서 함께 출력됩니다!
		getSpotList(0)
		
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
				position : nowposition,
				icon: icons['myplace'].icon
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
	
	//장소를 불러오는 코드
	function getSpotList(spotCode) {  
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
	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'park' };
	          locations.push(obj); 
	          
	      	// 마커를 만드는 부분입니다.
	     	locations.forEach(function(feature) {
	            marker = new google.maps.Marker({
	              position: feature.position,
	              icon: icons[feature.type].icon,
	              map: map
	            });
	          }); //마커 만드는 거 끝! 
	         
	   $('.spotImg').append(function (index){ 
	  		 // 변수를 선언합니다. 
		      var item = spot[index]; 
		      var output = '';
		      output += '<div class="col-sm-6 col-md-4">';
		      output += '<div class="thumbnail">';
		      output += ' <div class="caption">';
		      output += '<h3>' + spot[i].spotTitle + '</h3>';
			  output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> 위치 </strong>';
			  output += '<p> ' + spot[i].spotAddress+'</p>';
			  output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> 등록날짜 / 수정날짜 </strong>';
			  output += '<p> ' + spot[i].spotCreateTime+' / ' + spot[i].spotModifyTime+'</p>';
			  output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
			 output += ' <p>';
			 output += ' <span class="label label-danger">공원</span>';
			 output += ' </p>';
			  output += '<p><a href="/spot/getSpot?spotNo='+spot[i].spotNo+'" class="btn btn-primary" role="button">상세보기</a> <a href="#" class="btn btn-default" role="button">장소바구니</a></p>';
			  output += '</div>';
			  output += '</div>';
			  output += '</div>';
			  return output; 
		      })//end of append		     		     		      
	     } 
	  } 
	});// end of ajax 
	} // end of getSpotList()
</script>

	<%-- Main content --%>
	<section class="content container-fluid">
	<!-- 상단에 둥둥 떠있는 아이콘 (상단으로 이동) -->
<img class="gotoTop" src="/images/board/gotoTop.png" alt="맨위로!">
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
  				<h1>공원</h1>
  					<p>우리나라 공원을 검색해 보세요!</p>
  					<p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
			</div>
			<div class="spotImg"></div>
				<p></p>
			<br />
			</div>
		</body>
		
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
							spotCode : 0
						}),
						success : function(data) {// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
							var output = '';
							$(data).each(function() {
							      output += '<div class="col-sm-6 col-md-4">';
							      output += '<div class="thumbnail">';
							      output += ' <div class="caption">';
							      output += '<h3>' + this.spotTitle + '</h3>';
								  output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> 위치 </strong>';
								  output += '<p> ' + this.spotAddress+'</p>';
								  output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> 등록날짜 / 수정날짜 </strong>';
								  output += '<p> ' + this.spotCreateTime+' / ' + this.spotModifyTime+'</p>';
								  output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
								 output += ' <p>';
								 output += ' <span class="label label-danger">공원</span>';
								 output += ' </p>';
								  output += '<p><a href="/spot/getSpot?spotNo='+this.spotNo+'" class="btn btn-primary" role="button">상세보기</a> <a href="#" class="btn btn-default" role="button">장소바구니</a></p>';
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
	</html>
