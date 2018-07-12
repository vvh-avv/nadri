<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
<!-- toolbar.js CDN --> 
<script src="/javascript/toolbar.js"></script> 
<!-- juanMap.js CDN --> 
<script src="/javascript/juanMap.js"></script> 
<!-- Mansory CDN 블럭처럼 게시물을 쌓을 수 있도록 만들어주는 CDN입니다! --> 
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>
<!-- googleMap CDN -->
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

<!-- 지도에 떠있는 검색박스를 위한 css입니다 -->
#floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }

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

	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
	          zoom: 14,
	          center: {lat: 37.566535, lng: 126.9779692}
	        });
		geocoder = new google.maps.Geocoder();
		
		document.getElementById('submit').addEventListener('click', function() {
	          geocodeAddress(geocoder, map);
	        });
		
		// 클릭시 이벤트 (클릭시 위치값을 가져와서 거기에 알맞는 마커를 찍습니다!)
		map.addListener('click', function(event) {
			deleteMarkers()
			$('.parkImg').empty();
			// 클릭 지점 lat 값 가져오기
			var lat = ""+event.latLng.lat();
			// 클릭 지점 lng 값 가져오기
			var lng = ""+event.latLng.lng();
			var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&language=ko&key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs";
			$.getJSON(url, function (data) { 
			     	var address = data.results[0].formatted_address;
			     	deleteMarkers();
			     	geocoder.geocode({'address': address}, function(results, status) {
			            if (status === 'OK') {
			          	 alert(JSON.stringify(results[0]));
			          	 var address= results[0].formatted_address;
			          	 var content = '<div>'+results[0].formatted_address+'</div>'+
			          	 						   '<div id="location">'+results[0].geometry.location+'</span>'+
			          	 						   ' <a href="#" id ="abc" class="btn btn-primary btn-block" onclick="aaa()"><b>상세보기</b></a>'+
			          	 						   ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="marking()"><b>장소바구니추가</b></a>'+
			          	 						   ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="searchAround('+results[0].geometry.location.lat()+','+results[0].geometry.location.lng()+')"><b>주변장소검색</b></a>'+
			          	 						   ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="googleAround()"><b>구글장소검색</b></a>'
			          	 
			          	 var infowindow = new google.maps.InfoWindow({
			                   content: content
			                 });
			          	 
			             	map.setCenter(results[0].geometry.location);
			         
			                marker = new google.maps.Marker({
			                map: map,
			                position: results[0].geometry.location,
			                icon : icons['search'].icon,
			                title : address
			              });
			              markers.push(marker);
			              
			  	         // 인포윈도우를 마커위에 표시합니다 
			  			infowindow.open(map, marker);
			  	         
			  			marker.addListener('click', function() {
			  		         infowindow.open(map, marker);
			  		    });
			  	         
			            } else {
			              alert('입력하신 장소를 찾을 수 없네요! 다시한번 체크해주세요!');
			            }
			          });
			     }); 
		});
		
		// 나의 위치를 찍어주는 부분입니다!
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

			var nowposition = new google.maps.LatLng(37.57593689999999, 126.97681569999997), message = '현재 위치를 사용할 수 없으시네요!'

			displayMarker(nowposition, message);
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
	}//end of initmap();	
	
	// 맵에대한 정보를 가져옵니다.
	function geocodeAddress(geocoder, map) {
        var address = document.getElementById('address').value;
        deleteMarkers();
        geocoder.geocode({'address': address}, function(results, status) {
          if (status === 'OK') {
        	 var address= results[0].formatted_address;
        	 var content = '<div>'+results[0].formatted_address+'</div>'+
        	 						   '<div id="location">'+results[0].geometry.location+'</span>'+
        	 						   ' <a href="#" id ="abc" class="btn btn-primary btn-block" onclick="aaa()"><b>상세보기</b></a>'+
        	 						   ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="marking()"><b>장소바구니추가</b></a>'+
        	 						   ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="searchAround('+results[0].geometry.location.lat()+','+results[0].geometry.location.lng()+')"><b>반경 5km 검색!!</b></a>'+
        	 						   ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="googleAround()"><b>구글장소검색</b></a>'
        	 
        	 var infowindow = new google.maps.InfoWindow({
                 content: content
               });
        	 
              map.setCenter(results[0].geometry.location);
              //마커를 생성하는 부분입니다.
              marker = new google.maps.Marker({
              map: map,
              position: results[0].geometry.location,
              icon : icons['search'].icon,
              title : address
            });
            markers.push(marker);
            
	         // 인포윈도우를 마커위에 표시합니다 
			infowindow.open(map, marker);
	         
			marker.addListener('click', function() {
		         infowindow.open(map, marker);
		    });
	         
          } else {
            alert('입력하신 장소를 찾을 수 없네요! 다시한번 체크해주세요!');
          }
        });
      }
	
	function searchAround(lat,lng) { 
		// 앞서 만들어진 마커를 초기화 시킵니다.
		deleteMarkers()
		// 앞서 검색한 부분을 초기화시킵니다.
		 $('.parkImg').empty();
		//1. ajax를 통해서 리스트를 뽑아옵니다.
		$.ajax({
				type : 'POST', // 요청 Method 방식
				url : '/restspot/searchAround', // 요청할 서버의 url
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
			        	  if(parseInt(spot[i].spotCode)>=4100 && parseInt(spot[i].spotCode) <4200){
				  	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'river', spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg, spotNo : spot[i].spotNo };
				  	          locations.push(obj); 
				  	        // 주차장
				  	        }else if (parseInt(spot[i].spotCode)>=4200 && parseInt(spot[i].spotCode) <4300){
				  	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'parking', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg, spotNo : spot[i].spotNo};
				  		      locations.push(obj);
				  		     // 안내소
				  	        }else if (parseInt(spot[i].spotCode)>=4300 && parseInt(spot[i].spotCode) <4400){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'info' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg, spotNo : spot[i].spotNo};
				  			   locations.push(obj);
				  			 // 자전거 대여소
				  	        }else if (parseInt(spot[i].spotCode)>=4400 && parseInt(spot[i].spotCode) <4500){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'bike', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg, spotNo : spot[i].spotNo};
				  			   locations.push(obj);
				  			 // 편의점
				  	        }else if (parseInt(spot[i].spotCode)>=4500 && parseInt(spot[i].spotCode) <4600){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'store' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg, spotNo : spot[i].spotNo};
				  			    locations.push(obj);
				  			 // 배달존
				  	        }else{
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'food' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg, spotNo : spot[i].spotNo};
				  			    locations.push(obj);
				  	        };
			        	  
			        	// 이부분은 마커를 추가해주는 부분입니다.
				  			for ( var i = 0 ; i < locations.length; i++) { 
				  	          	markers[i] = new google.maps.Marker({
				  	            position: locations[i].position,
				  	          	icon: icons[locations[i].type].icon,
				  	            map: map
				  	          });
				  	          //인덱스를 꺼내오기.. 중요!!
				  	          markers[i].index = i

				  	        contents[i] = '<div class="box box-primary">'+ 
				            '<div class="box-body box-profile">'+ 
				              '<img class="profile-user-img img-responsive img-circle" src="/images/spot/ ' + locations[i].spotImg + ' "height="200px" width="200px" >'+ 
				              '<h3 class="profile-username text-center">' + locations[i].spotTitle + '</h3>'+  
				              '<ul class="list-group list-group-unbordered">'+ 
				                '<li class="list-group-item">'+ 
				               '   <b>위치</b> <a class="pull-right">' + locations[i].spotAddress + '</a>'+ 
				                '</li>'+ 
				              '  <li class="list-group-item">'+ 
				                  '<b>대표전화</b> <a class="pull-right">' + locations[i].spotAddress + '</a>'+ 
				                '</li>'+ 
				                '<li class="list-group-item">'+ 
				                 ' <b>조회수</b> <a class="pull-right">' + locations[i].spotAddress + '</a>'+ 
				               ' </li>'+ 
				             ' </ul>'+ 
				             '<span> '+
				             ' <a href="/spot/getSpot?spotNo='+locations[i].spotNo+'" id ="abc" class="btn btn-primary btn-block"><b>상세보기</b></a>'+ 
				             '<span>'+
				             '<span> '+
				             ' <a href="#" id ="marking" class="btn btn-danger btn-block" onclick="marking()"><b>장소바구니추가</b></a>'+ 
				             '</span>'+
				            '</div>';

					  	       // 이벤트 정보 넣기
					  	      infowindows[i] = new google.maps.InfoWindow({
					                 content: contents[i],
					                 removeable : true
					               });
				          
				  	        // 마커를 클릭했을때 이벤트 발생 시키기
				  	        google.maps.event.addListener(markers[i], 'click', function() {
				  	       		// 일단 마커를 모두 닫고
				  	         	for ( var i = 0; i < markers.length ; i++) {
				  	        	 	infowindows[i].close();
				  	        	 } 
				  	        	 infowindows[this.index].open(map, markers[this.index]);
				  	        	map.panTo(markers[this.index].getPosition());
				  	        });

				  	      // 마커를 클릭했을때 이벤트 발생 시키기
				  	        google.maps.event.addListener(markers[i], 'rightclick', function() {
				  	       		alert("이곳의 위치가 궁금한가?!");
				  	        });	  	        
				  	        }// 마커for문
			     } 
			  }//end of success 
			});// end of ajax 
		};//end of searchAround()

		
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
 	<div id="floating-panel">
      <input id="address" type="textbox" value="비트캠프">
      <input id="submit" type="button" value="search">
    </div>

	<%-- Main content --%>
	<section class="content container-fluid">
		<body>
			<div id="map">
				<br /> <br />
			</div>
			<div class="parkImg"></div>
			<p></p>
			<div id="dataInfo"></div>
			<br />

		</body>
</html>
