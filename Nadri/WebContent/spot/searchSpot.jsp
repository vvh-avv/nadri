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
<!-- 구글맵을 사용하기 위한 CDN -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD7-c6GOHSYIeB4RuWDwIbWPdu2oeRTnpI&libraries=geometry,places,drawing"></script>
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
} */


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
	height: 70%;
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
	   background-image: url(/images/spot/422.jpg);
	   background-position: 0% 25%;
	   background-size: cover;
	   background-repeat: no-repeat;
	   color: #393535;
	   padding-left : 10%;
	   box-shadow : 1px 1px 10px 0px #8080807d;
	}

/*spot에 패딩을 넣는 장소 입니다!!*/
.spotImg{
padding : 5px;
}

#searchKeyword {
	width: 20%;
	float: left;
}

/*모달 위치 비교 css */
.modal {
	top : 20%;
} 

/*로딩이미지를 가져옵니다*/
#loading {
 width: 100%;  
 height: 100%;  
 top: 0px;
 left: 0px;
 position: fixed;  
 display: block;  
 opacity: 0.7;  
 background-color: #fff;  
 z-index: 99;  
 text-align: center; } 
  
#loading-image {  
 position: absolute;  
 top: 50%;  
 left: 50%; 
 z-index: 100; }
 
 /*버튼 중앙에 오게하는거!!*/
 .list-group-item {
    position: relative;
    display: block;
    padding: 10px 15px;
    margin-bottom: -1px;
    border: 1px solid #ddd;
    text-align: center;
}

</style>

<head>
<script>

$(document).ready(function(){
	// 맵을 시작하는 메서드입니다.
	initMap();
}); // 처음 시작될때 클릭버튼 세팅

$(function(){
	// search button을 누를때..
	$("#searchbutton").on("click", function(){
		geocodeAddress(geocoder, map);
	});
	
	//*스크롤감지
    $(window).scroll(function(){
        var scrollLocation = $(window).scrollTop(); //브라우저의 스크롤 값
        
        if(scrollLocation!=0){ //화면을 내리면 gotoTop 뜨게하고
            $(".gotoTop").fadeIn();
        }else{                    //화면을 올리면 gotoTop 사라지게하기
            $(".gotoTop").fadeOut();
        }
    })
 
    //*상단에 둥둥 떠있는 아이콘 (상단으로 이동)
    $(".gotoTop").on("click", function(){
        $("body").scrollTop(0);
    });
    
	$("#listbutton").on("click", function() {
		history.go(-1);
	});
	
	$("button.btn.btn-secondary.modalModBtn").on("click", function() {
		swal("Good job!", "장소바구니에 추가했습니다!!", "success")
		addCartSpot();
		//$("#cartModal").modal('hide');
		//sweetalert쓰기위한 javascript
	});
    
    $(document).on('click','#cartbutton', function(){ 
    	var cartTitle = $("#modalTitle").text();
    	var cartX = $("#modalX").val();
    	var cartY = $("#modalY").val();
    	var cartAddress = $("#modalAddress").text();
    	$("#cartTitle").val(cartTitle);
    	$("#cartX").val(cartX);
    	$("#cartY").val(cartY);
    	$("#cartAddress").val(cartAddress);
    }); //end of click
	
})



	//이 부분은 지도 관련 맵 입니다! 
	//중앙 위치값을 세팅해 줍니다. 
	var center = {lat : 37.57593689999999,lng : 126.97681569999997};
	var map;
	var geocoder = new google.maps.Geocoder();
	var infowindownew = new google.maps.InfoWindow();
	var locations = [];
	var infowindows = [];
	var contents = [];
	//마커 저장소
	var markers = [];

	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
	          zoom: 14,
	          center: {lat: 37.566535, lng: 126.9779692},
	          scrollwheel : false
	        });

		map.addListener('dragend', function(event) {
			deleteMarkers();
			var a = map.getCenter();
			var lat = ""+a.lat();
			var lng = ""+a.lng();
			searchAround(lat,lng);
		});
	
		
		// 클릭시 가져오는 란입니다!
		map.addListener('click', function(event) {
			$("#searchKeyword").val('');
			deleteMarkers();
			$('.spotImg').empty();
			// 클릭 지점 lat 값 가져오기
			var lat = ""+event.latLng.lat();
			// 클릭 지점 lng 값 가져오기
			var lng = ""+event.latLng.lng();
			searchAround(lat,lng);
			var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&language=ko&key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs";
			$.getJSON(url, function (data) { 
			     	var address = data.results[0].formatted_address;
			     	geocoder.geocode({'address': address}, function(results, status) {
			            if (status === 'OK') {
			          	 var address= results[0].formatted_address;
			          	 var content = '<div class="box box-primary" style="font-family : seoul">'+
												 	'<h4 id="modalTitle">'+$("#searchKeyword").val()+'</h4>'+
						 						 	'<li class="list-group-item" >'+
						 							'<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b><span id="modalAddress">'+ results[0].formatted_address+ '</span></li>'+
						 						   '<input type="hidden" id="modalY" value='+results[0].geometry.location.lat()+'>'+
						 						  	'<input type="hidden" id="modalX" value='+results[0].geometry.location.lng()+'>'+
						 						  	'<li class="list-group-item" >'+
							 						 ' <button type="button" class="btn btn-secondary" id="cartbutton" data-toggle="modal" data-target="#cartModal" align="center">장소바구니 추가</button>'+
							 						 '</li>'+
							 						'</div>';
			          	 var infowindow = new google.maps.InfoWindow({
			                   content: content
			                 });
			          	 
			             	map.setCenter(results[0].geometry.location);
			         
			                var marker = new google.maps.Marker({
			                map: map,
			                position: results[0].geometry.location,
			                icon : icons['search'].icon,
			                title : address
			              });
			              markers.push(marker);
			              
			  	         // 인포윈도우를 마커위에 표시합니다 
			  			infowindow.open(map, marker);
			  	         
			  			marker.addListener('click', function() {
			  				map.setZoom(15);
			  		         infowindow.open(map, marker);
			  		    });
			  	         
			            } else {
			              swal('입력하신 장소를 찾을 수 없네요! 다시한번 체크해주세요!');
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
				message = '<div style="font-family : seoul"><div>현재위치</div></div>'; // 인포윈도우에 표시될 내용입니다

				// 마커와 인포윈도우를 표시합니다
				displayMarker(nowposition, message);
				
				searchAround(lat, lon);

			});

		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

			var nowposition = new google.maps.LatLng(37.57593689999999, 126.97681569999997), message = '<div style="font-family : seoul"><div>현재위치</div></div>'

			displayMarker(nowposition, message);
			deleteMarkers();
			//searchAround(lat, lon);
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
	
	
	// 장소를 검색해서 나오는 란입니다!
	function geocodeAddress(geocoder, map) {
		deleteMarkers();
        var address = $("#searchKeyword").val();
        geocoder.geocode({'address': address}, function(results, status) {
          if (status === 'OK') {
        	  searchAround(results[0].geometry.location.lat(),results[0].geometry.location.lng());
        	 var address= results[0].formatted_address;
        	 var content = '<div class="box box-primary" style="font-family : seoul">'+
        	 						 	'<h4 id="modalTitle">'+$("#searchKeyword").val()+'</h4>'+
        	 						 	'<li class="list-group-item" >'+
        	 							'<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b><span id="modalAddress">'+ results[0].formatted_address+ '</span></li>'+
        	 						   '<input type="hidden" id="modalY" value='+results[0].geometry.location.lat()+'>'+
        	 						  	'<input type="hidden" id="modalX" value='+results[0].geometry.location.lng()+'>'+
        	 						  	'<li class="list-group-item" >'+
          	 						   ' <button type="button" class="btn btn-secondary" id="cartbutton" data-toggle="modal" data-target="#cartModal" align="center">장소바구니 추가</button>'+
          	 						   '</li>'+
         	 							'</div>';
        	 
        	 var infowindow = new google.maps.InfoWindow({
                 content: content
               });
        	 
              map.setCenter(results[0].geometry.location);
              //마커를 생성하는 부분입니다.
              var marker = new google.maps.Marker({
              map: map,
              position: results[0].geometry.location,
              icon : icons['search'].icon,
              title : address
            });
            markers.push(marker);
            
	         // 인포윈도우를 마커위에 표시합니다 
			infowindow.open(map, marker);
	         
			marker.addListener('click', function() {
				map.setZoom(15);
		         infowindow.open(map, marker);
		    });
	         
          } else {
            alert('입력하신 장소를 찾을 수 없네요! 다시한번 체크해주세요!');
          }
        });
      }
	
	function searchAround(lat,lng) { 
		// 앞서 만들어진 마커를 초기화 시킵니다.
		deleteMarkers();
		// 앞서 검색한 부분을 초기화시킵니다.
		 $('.spotImg').empty();
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
				  	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'river', addr : spot[i].spotAddress, title : spot[i].spotTitle,  no : spot[i].spotNo };
				  	          locations.push(obj); 
				  	        // 주차장
				  	        }else if (parseInt(spot[i].spotCode)>=4200 && parseInt(spot[i].spotCode) <4300){
				  	          obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'parking', addr :spot[i].spotAddress, title : spot[i].spotTitle,  no : spot[i].spotNo};
				  		      locations.push(obj);
				  		     // 안내소
				  	        }else if (parseInt(spot[i].spotCode)>=4300 && parseInt(spot[i].spotCode) <4400){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'info' , addr : spot[i].spotAddress, title : spot[i].spotTitle,  no : spot[i].spotNo};
				  			   locations.push(obj);
				  			 // 자전거 대여소
				  	        }else if (parseInt(spot[i].spotCode)>=4400 && parseInt(spot[i].spotCode) <4500){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'bike', addr :spot[i].spotAddress, title : spot[i].spotTitle,  no : spot[i].spotNo};
				  			   locations.push(obj);
				  			 // 편의점
				  	        }else if (parseInt(spot[i].spotCode)>=4500 && parseInt(spot[i].spotCode) <4600){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'store' , addr : spot[i].spotAddress, title : spot[i].spotTitle,  no : spot[i].spotNo};
				  			    locations.push(obj);
				  	        }else if (parseInt(spot[i].spotCode) == 10){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'samdae' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo};
				  			    locations.push(obj);
				  	        }else if (parseInt(spot[i].spotCode) == 11){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'suyo' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo};
				  			    locations.push(obj)
				  	        }else if (parseInt(spot[i].spotCode) == 0){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'park' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo};
				  			    locations.push(obj)
				  	        }else if (parseInt(spot[i].spotCode) == 30){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'baby' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo};
				  			    locations.push(obj)
				  	        }else if (parseInt(spot[i].spotCode) == 31){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'car' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo};
				  			    locations.push(obj)
				  	        }else if (parseInt(spot[i].spotCode) == 32){
				  	        	obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'bike' , addr : spot[i].spotAddress, title : spot[i].spotTitle, no : spot[i].spotNo};
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
								+ '<h5 class="profile-username text-center">'+ locations[i].title+ '</h5>'
								+ '<li class="list-group-item">'
								+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b>'+ locations[i].addr+ '</li>'
								+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
								+ '<b>Tag&nbsp</b></i> <span class="label label-success"> 백과</span> <span class="label label-default"> 검색</span></li>'
								+ '<a href="/spot/getSpot?spotNo='+ locations[i].no+ '"" class="waves-effect waves-light btn" style="width:100%" ><b>상세보기</b></a>'
								+ '</div>';

					  	       // 이벤트 정보 넣기
					  	      infowindows[i] = new google.maps.InfoWindow({
					                 content: contents[i],
					                 removeable : true
					               });
				          
				  	        // 마커를 클릭했을때 이벤트 발생 시키기
				  	        google.maps.event.addListener(markers[i], 'click', function() {
				  	        	map.setZoom(15);
				  	       		// 일단 마커를 모두 닫고
				  	        	 infowindows[this.index].open(map, markers[this.index]);
				  	        	map.panTo(markers[this.index].getPosition());
				  	        });	  	        
				  	    }// 마커for문
			     } 
			  }//end of success 
			});// end of ajax 
		};//end of searchAround()

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

    //카트 등록을 위한 메소드!
    function addCartSpot(){
    	$.ajax({
    				type : 'post', // 요청 method 방식 
    				url : '/restcart/addCartSpot',// 요청할 서버의 url
    				headers : {
    					"Content-Type" : "application/json",
    					"X-HTTP-Method-Override" : "POST"
    				},
    				dataType : 'json', // 서버로부터 되돌려받는 데이터의 타입을 명시하는 것이다.
    				data : JSON.stringify({ // 서버로 보낼 데이터 명시 
    					spotNo : $("#spotNo").val(),
    					userId : $("#userId").val(),
    					cartDetail : $("#cartDetail").val(),
    					cartTitle : $("#cartTitle").val(),
    					cartAddress :$("#cartAddress").val(),
    					cartX : $("#cartX").val(),
    					cartY : $("#cartY").val(),
    					cartImg : $("#cartImg").val()
    				}),
    				success : function(data) {// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
    				}// success
    	});// ajax
    };
</script>

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

  		<div class="jumbotron">
  				<h1>검색</h1>
  					<p>찾으시는 장소가 없으세요? 직접 검색해보세요!</p>
  					 <div class="form-group">
					    <label class="sr-only" for="searchKeyword">검색어</label>
					    <div>
					   	 <input type="text" class="form-control" id="searchKeyword" placeholder="주소나 건물명 위치 장소명등등 적어주세요!" ><a class="waves-effect waves-light btn" id="searchbutton">검색</a></input>					  
					    </div>
					  </div>
		</div>
  		<div id="map">
  			<br /> <br />
  		</div>	
  		<br />
			
				<!-- 장바구니추가 modal 창 start -->
				<form id=cart>
					<div class="modal fade" id="cartModal" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">장소바구니</h4>
								</div>
								<div class="modal-body">
									<div class="form-group">
										<label for="cartTitle">어떤 이름으로 추가하시겠어요?</label> 
										<input class="form-control" id="cartTitle" name="cartTitle" value="${spot.spotTitle}" >
									</div>
										<input type="hidden" id="cartX" name="cartX" value="${spot.spotX}" readonly>
										<input type="hidden" id="cartY" name="cartY" value="${spot.spotY}" readonly>
										<input type="hidden"  id="cartAddress" name="cartAddress" value="${spot.spotAddress}" readonly>
									<div class="form-group">
										<label for="cartDetail">어떤일로 추가하셨나요?</label> 
										 <input type="text" class="form-control" name="cartDetail" id="cartDetail" value="" />
									</div>
										<input type="hidden"  id="userId" name="userId" value="${sessionScope.user.userId}" readonly>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary pull-left" data-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-secondary modalModBtn" data-dismiss="modal">추가</button>
								</div>
							</div>
						</div>
					</div>
				</form>	
				
	<!-- HJA 일정등록 transportation navigation -->
	<!-- 처음 입장시 여러가지 정보를 적는 modal 창 start --> 
            <div class="modal" id="transportationModal" role="dialog"> 
                <div class="modal-dialog modal-sm"> 
                    <div class="modal-content"> 
                        <div class="modal-header"> 
                            <button type="button" class="close" data-dismiss="modal">&times;</button> 
                            <h4 class="modal-title">나들이는 뭐타고 가시나요?</h4> 
                        </div>
					<div class="modal-body">
							<button type="button" class="btn btn-primary" id="car">자동차</button>
							<button type="button" class="btn btn-primary" id="pedestrian">도보</button>
							<button type="button" class="btn btn-primary" id="transit">대중교통</button>
					</div>
						<div class="modal-footer"> 
                            <button type="button" class="waves-effect waves-light btn" id="modalinsert">입력!</button> 
                        </div> 
                    </div> 
                </div> 
            </div>
	</body>
		
</html>
