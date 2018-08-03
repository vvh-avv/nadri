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

.spot-top-box{
	width : 65%;
	margin-left:auto;
	margin-right:auto;
}

@media only screen and (max-width : 600px){
	.spot-top-box{
		width : 100%;
		margin-left:auto;
		margin-right:auto;
	}
}

.nav-wrapper{
	border-radius: 0px 0px 60px 60px;
	background: #6d91af94;
	margin: 0px 15px 15px 15px;
	box-shadow : 1px 2px 10px 0px #a7a7a7;
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

.waves-light:hover{
	background : white;
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
	width: 10%;
	float: left;
}
</style>

<head>
<script>

$(document).ready(function(){
	// materialboxed
	$('.materialboxed').materialbox();
	$("#searchbutton").on("click", function(){

			$.ajax({
				type : 'post', // 요청 method 방식 
				url : '/restspot/getSearchSpotList',// 요청할 서버의 url
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'json', // 서버로부터 되돌려받는 데이터의 타입을 명시하는 것이다.
				data : JSON.stringify({ // 서버로 보낼 데이터 명시 
					searchSpot : 4,
					searchKeyword : $("#searchKeyword").val()
				}),
				success : function(result) {// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
					$(".spotImg").empty();
					var output = '';
					$(data).each(
									function() {
										output += '<div class="col-sm-3 col-md-3">';
										output += '<div class="thumbnail">';
										output += ' <div class="caption">';
										output += '<h5>'+ this.spotTitle+ '</h5>';
										output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> 위치 </strong>';
										output += '<p> '+ this.spotAddress+ '</p>';
										output += '  <strong><i class="glyphicon glyphicon-pencil"></i> 등록날짜 / 수정날짜 </strong>';
										output += '<p> '+ this.spotCreateTime+ ' / '+ this.spotModifyTime+ '</p>';
										output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
										output += ' <p>';
										output += ' <span class="label label-success">백과</span>';
										output += ' <span class="label label-primary">한강</span>';
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
  });
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
	var spot = ${a};
	for (var i = 0 ; i < spot.length; i++){
		// spotCode에 따라서 각기 다른 마커 이미지를 넣어주는 부분입니다.
		// 공원
	      if(parseInt(spot[i].spotCode)>=4100 && parseInt(spot[i].spotCode) <4200){
	        //obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg };
	        obj = {
	    			lat : parseFloat(spot[i].spotY),
	    			lng : parseFloat(spot[i].spotX),
	    			addr : spot[i].spotAddress,
	    			title : spot[i].spotTitle,
	    			img : spot[i].spotImg,
	    			no : spot[i].spotNo,
	    			type : 'river'
	    	};
	        locations.push(obj); 
	      // 주차장
	      }else if (parseInt(spot[i].spotCode)>=4200 && parseInt(spot[i].spotCode) <4300){
	        //obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'parking', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
	        obj = {
	    			lat : parseFloat(spot[i].spotY),
	    			lng : parseFloat(spot[i].spotX),
	    			addr : spot[i].spotAddress,
	    			title : spot[i].spotTitle,
	    			img : spot[i].spotImg,
	    			no : spot[i].spotNo,
	    			type : 'parking'
	    	};  
	        locations.push(obj);
		     // 안내소
	      }else if (parseInt(spot[i].spotCode)>=4300 && parseInt(spot[i].spotCode) <4400){
	      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'info' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
			obj = {
	    			lat : parseFloat(spot[i].spotY),
	    			lng : parseFloat(spot[i].spotX),
	    			addr : spot[i].spotAddress,
	    			title : spot[i].spotTitle,
	    			img : spot[i].spotImg,
	    			no : spot[i].spotNo,
	    			type : 'info'
	    	};    
	      	locations.push(obj);
			 // 자전거 대여소
	      }else if (parseInt(spot[i].spotCode)>=4400 && parseInt(spot[i].spotCode) <4500){
	      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'bike', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
	      	obj = {
	    			lat : parseFloat(spot[i].spotY),
	    			lng : parseFloat(spot[i].spotX),
	    			addr : spot[i].spotAddress,
	    			title : spot[i].spotTitle,
	    			img : spot[i].spotImg,
	    			no : spot[i].spotNo,
	    			type : 'bike'
	    	};    
	      	locations.push(obj);
			 // 편의점
	      }else if (parseInt(spot[i].spotCode)>=4500 && parseInt(spot[i].spotCode) <4600){
	      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'store' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
	      	obj = {
	    			lat : parseFloat(spot[i].spotY),
	    			lng : parseFloat(spot[i].spotX),
	    			addr : spot[i].spotAddress,
	    			title : spot[i].spotTitle,
	    			img : spot[i].spotImg,
	    			no : spot[i].spotNo,
	    			type : 'store'
	    	};        
	      	locations.push(obj);
			 // 배달존
	      }else if(parseInt(spot[i].spotCode)>=4600 && parseInt(spot[i].spotCode) <4700){
	      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'food' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
			obj = {
	    			lat : parseFloat(spot[i].spotY),
	    			lng : parseFloat(spot[i].spotX),
	    			addr : spot[i].spotAddress,
	    			title : spot[i].spotTitle,
	    			img : spot[i].spotImg,
	    			no : spot[i].spotNo,
	    			type : 'delivery'
	    	};           
	      	locations.push(obj);    
	      };
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
		
		for (var i = 0; i < locations.length; i++) {
			markers[i] = new google.maps.Marker({
				position : locations[i],
				map : map,
				icon: icons[locations[i].type].icon
			});
			//인덱스를 꺼내오기.. 중요!!
			markers[i].index = i

			contents[i] = '<div class="box box-primary" style="font-family : seoul">'
					+ '<h5 class="profile-username text-center">'+ locations[i].title+ '</h5>'
					+ '<img class="img-rounded" src="/images/spot/'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
					+ '<li class="list-group-item">'
					+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b>'+ locations[i].addr+ '</li>'
					+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
					+ '<b>Tag&nbsp</b></i> <span class="label label-success"> 백과</span> <span class="label label-primary"> 한강</span></li>'
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
	}//end of initmap();	

	// searchkeyword 눌렀을때!!
	function searchkeyword(spotCode){
		deleteMarkers();
		map.setZoom(11);
			$.ajax({ 
		        type : "GET", 
		        url : "/restspot/getSpotList/"+spotCode, 
		        headers : { 
		            "Content-type" : "application/json", 
		            "X-HTTP-Method-Override" : "POST" 
		        }, 
		        dataType : "json", 
				success : function(data) {// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
				if(data==''){
					swal("아쉽게도 결과가 없네요?");
				} else {
					var spot = data.spot; 
					for (var i = 0 ; i < spot.length; i++){
						// spotCode에 따라서 각기 다른 마커 이미지를 넣어주는 부분입니다.
						// 공원
					      if(parseInt(spot[i].spotCode)>=4100 && parseInt(spot[i].spotCode) <4200){
					        //obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg };
					        obj = {
					    			lat : parseFloat(spot[i].spotY),
					    			lng : parseFloat(spot[i].spotX),
					    			addr : spot[i].spotAddress,
					    			title : spot[i].spotTitle,
					    			img : spot[i].spotImg,
					    			no : spot[i].spotNo,
					    			type : 'river'
					    	};
					        locations.push(obj); 
					      // 주차장
					      }else if (parseInt(spot[i].spotCode)>=4200 && parseInt(spot[i].spotCode) <4300){
					        //obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'parking', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
					        obj = {
					    			lat : parseFloat(spot[i].spotY),
					    			lng : parseFloat(spot[i].spotX),
					    			addr : spot[i].spotAddress,
					    			title : spot[i].spotTitle,
					    			img : spot[i].spotImg,
					    			no : spot[i].spotNo,
					    			type : 'parking'
					    	};  
					        locations.push(obj);
						     // 안내소
					      }else if (parseInt(spot[i].spotCode)>=4300 && parseInt(spot[i].spotCode) <4400){
					      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'info' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
							obj = {
					    			lat : parseFloat(spot[i].spotY),
					    			lng : parseFloat(spot[i].spotX),
					    			addr : spot[i].spotAddress,
					    			title : spot[i].spotTitle,
					    			img : spot[i].spotImg,
					    			no : spot[i].spotNo,
					    			type : 'info'
					    	};    
					      	locations.push(obj);
							 // 자전거 대여소
					      }else if (parseInt(spot[i].spotCode)>=4400 && parseInt(spot[i].spotCode) <4500){
					      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'bike', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
					      	obj = {
					    			lat : parseFloat(spot[i].spotY),
					    			lng : parseFloat(spot[i].spotX),
					    			addr : spot[i].spotAddress,
					    			title : spot[i].spotTitle,
					    			img : spot[i].spotImg,
					    			no : spot[i].spotNo,
					    			type : 'bike'
					    	};    
					      	locations.push(obj);
							 // 편의점
					      }else if (parseInt(spot[i].spotCode)>=4500 && parseInt(spot[i].spotCode) <4600){
					      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'store' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
					      	obj = {
					    			lat : parseFloat(spot[i].spotY),
					    			lng : parseFloat(spot[i].spotX),
					    			addr : spot[i].spotAddress,
					    			title : spot[i].spotTitle,
					    			img : spot[i].spotImg,
					    			no : spot[i].spotNo,
					    			type : 'store'
					    	};        
					      	locations.push(obj);
							 // 배달존
					      }else if(parseInt(spot[i].spotCode)>=4600 && parseInt(spot[i].spotCode) <4700){
					      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'food' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
							obj = {
					    			lat : parseFloat(spot[i].spotY),
					    			lng : parseFloat(spot[i].spotX),
					    			addr : spot[i].spotAddress,
					    			title : spot[i].spotTitle,
					    			img : spot[i].spotImg,
					    			no : spot[i].spotNo,
					    			type : 'store'
					    	};           
					      	locations.push(obj);    
					      };
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
						if(locations[i].img === ''){ 
							contents[i] = '<div class="box box-primary" style="font-family : seoul">'
									+ '<h4 class="profile-username text-center">'+ locations[i].title+ '</h4>'
									+ '<li class="list-group-item">'
									+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b>'+ locations[i].addr+ '</li>'
									+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
									+ '<b>Tag&nbsp</b></i> <span class="label label-success"> 백과</span><span class="label label-warning">맛집</span></li>'
									+ '<a href="/spot/getSpot?spotNo='+ locations[i].no+ '"" class="waves-effect waves-light btn" style="width:100%" ><b>상세보기</b></a>'
									+ '</div>';
						} else {
							contents[i] = '<div class="box box-primary" style="font-family : seoul">'
								+ '<h4 class="profile-username text-center">'+ locations[i].title+ '</h4>'
								+ '<img class="img-rounded" src="/images/spot/'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
								+ '<li class="list-group-item">'
								+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b>'+ locations[i].addr+ '</li>'
								+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
								+ '<b>Tag&nbsp</b></i> <span class="label label-success"> 백과</span><span class="label label-warning">맛집</span></li>'
								+ '<a href="/spot/getSpot?spotNo='+ locations[i].no+ '"" class="waves-effect waves-light btn" style="width:100%" ><b>상세보기</b></a>'
								+ '</div>';	
						}

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
					$(data.spot).each(
									function() {
										output += '<div class="col-sm-3 col-md-3">';
										output += '<div class="thumbnail">';
										output += ' <div class="caption">';
										output += '<h5>'+ this.spotTitle+ '</h5>';
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
	
	function searchRiver(spotCode){
		deleteMarkers();
		map.setZoom(11);
			$.ajax({ 
		        type : "GET", 
		        url : "/restspot/getRiverList/"+spotCode, 
		        headers : { 
		            "Content-type" : "application/json", 
		            "X-HTTP-Method-Override" : "POST" 
		        }, 
		        dataType : "json", 
				success : function(data) {// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
				if(data==''){
					swal("아쉽게도 결과가 없네요?");
				} else {
					var spot = data.spot; 
					for (var i = 0 ; i < spot.length; i++){
						// spotCode에 따라서 각기 다른 마커 이미지를 넣어주는 부분입니다.
						// 공원
					      if(parseInt(spot[i].spotCode)>=4100 && parseInt(spot[i].spotCode) <4200){
					        //obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg };
					        obj = {
					    			lat : parseFloat(spot[i].spotY),
					    			lng : parseFloat(spot[i].spotX),
					    			addr : spot[i].spotAddress,
					    			title : spot[i].spotTitle,
					    			img : spot[i].spotImg,
					    			no : spot[i].spotNo,
					    			type : 'river'
					    	};
					        locations.push(obj); 
					      // 주차장
					      }else if (parseInt(spot[i].spotCode)>=4200 && parseInt(spot[i].spotCode) <4300){
					        //obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'parking', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
					        obj = {
					    			lat : parseFloat(spot[i].spotY),
					    			lng : parseFloat(spot[i].spotX),
					    			addr : spot[i].spotAddress,
					    			title : spot[i].spotTitle,
					    			img : spot[i].spotImg,
					    			no : spot[i].spotNo,
					    			type : 'parking'
					    	};  
					        locations.push(obj);
						     // 안내소
					      }else if (parseInt(spot[i].spotCode)>=4300 && parseInt(spot[i].spotCode) <4400){
					      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'info' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
							obj = {
					    			lat : parseFloat(spot[i].spotY),
					    			lng : parseFloat(spot[i].spotX),
					    			addr : spot[i].spotAddress,
					    			title : spot[i].spotTitle,
					    			img : spot[i].spotImg,
					    			no : spot[i].spotNo,
					    			type : 'info'
					    	};    
					      	locations.push(obj);
							 // 자전거 대여소
					      }else if (parseInt(spot[i].spotCode)>=4400 && parseInt(spot[i].spotCode) <4500){
					      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'bike', spotAddress :spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
					      	obj = {
					    			lat : parseFloat(spot[i].spotY),
					    			lng : parseFloat(spot[i].spotX),
					    			addr : spot[i].spotAddress,
					    			title : spot[i].spotTitle,
					    			img : spot[i].spotImg,
					    			no : spot[i].spotNo,
					    			type : 'bike'
					    	};    
					      	locations.push(obj);
							 // 편의점
					      }else if (parseInt(spot[i].spotCode)>=4500 && parseInt(spot[i].spotCode) <4600){
					      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'store' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
					      	obj = {
					    			lat : parseFloat(spot[i].spotY),
					    			lng : parseFloat(spot[i].spotX),
					    			addr : spot[i].spotAddress,
					    			title : spot[i].spotTitle,
					    			img : spot[i].spotImg,
					    			no : spot[i].spotNo,
					    			type : 'store'
					    	};        
					      	locations.push(obj);
							 // 배달존
					      }else if(parseInt(spot[i].spotCode)>=4600 && parseInt(spot[i].spotCode) <4700){
					      	//obj = {position : new google.maps.LatLng(parseFloat(spot[i].spotY), parseFloat(spot[i].spotX)), type : 'food' , spotAddress : spot[i].spotAddress, spotTitle : spot[i].spotTitle, spotImg : spot[i].spotImg};
							obj = {
					    			lat : parseFloat(spot[i].spotY),
					    			lng : parseFloat(spot[i].spotX),
					    			addr : spot[i].spotAddress,
					    			title : spot[i].spotTitle,
					    			img : spot[i].spotImg,
					    			no : spot[i].spotNo,
					    			type : 'store'
					    	};           
					      	locations.push(obj);    
					      };
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
						if(locations[i].img === ''){ 
							contents[i] = '<div class="box box-primary" style="font-family : seoul">'
									+ '<h4 class="profile-username text-center">'+ locations[i].title+ '</h4>'
									+ '<li class="list-group-item">'
									+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b>'+ locations[i].addr+ '</li>'
									+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
									+ '<b>Tag&nbsp</b></i> <span class="label label-success"> 백과</span><span class="label label-warning">맛집</span></li>'
									+ '<a href="/spot/getSpot?spotNo='+ locations[i].no+ '"" class="waves-effect waves-light btn" style="width:100%" ><b>상세보기</b></a>'
									+ '</div>';
						} else {
							contents[i] = '<div class="box box-primary" style="font-family : seoul">'
								+ '<h4 class="profile-username text-center">'+ locations[i].title+ '</h4>'
								+ '<img class="img-rounded" src="/images/spot/'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
								+ '<li class="list-group-item">'
								+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b>'+ locations[i].addr+ '</li>'
								+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
								+ '<b>Tag&nbsp</b></i> <span class="label label-success"> 백과</span><span class="label label-warning">맛집</span></li>'
								+ '<a href="/spot/getSpot?spotNo='+ locations[i].no+ '"" class="waves-effect waves-light btn" style="width:100%" ><b>상세보기</b></a>'
								+ '</div>';	
						}

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
					$(data.spot).each(
									function() {
										output += '<div class="col-sm-3 col-md-3">';
										output += '<div class="thumbnail">';
										output += ' <div class="caption">';
										output += '<h5>'+ this.spotTitle+ '</h5>';
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

	
	
</script>

<!-- 상단에 둥둥 떠있는 아이콘 (상단으로 이동) -->
<img class="gotoTop" src="/images/board/gotoTop.png" alt="맨위로!">
<body>
	
<%@include file="/layout/new_toolbar.jsp"%>
	
	<nav class="spot-top-box">
	    <div class="nav-wrapper">
	      <ul id="nav-mobile" class="right hide-on-med-and-down">
	        <li><span id="park">공원</span></li>
	        <li><span id="restaurant">맛집</span></li>
	        <li><span id="festival">축제/전시</span></li>
			<li><span id="river">한강</span></li>
	        <li><span id="search">검색</span></li>
	      </ul>
	    </div>
  </nav>
  
  
	<div id="map">
		<br /> <br />
	</div>
		<div id="container">
			<div class="jumbotron">
				<h1>한강</h1>
					<p>한강의 나들이를 즐겨보세요!</p>
						<span><a class="waves-effect waves-light btn" role="button" onclick="searchRiver(1)">광나루</a></span>
					  	<span><a class="waves-effect waves-light btn" role="button" onclick="searchRiver(2)">잠실</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchRiver(3)">뚝섬</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchRiver(4)">잠원</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchRiver(5)">반포</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchRiver(6)">이촌</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchRiver(7)">여의도</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchRiver(8)">망원</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchRiver(9)">난지</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchRiver(10)">강서</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchRiver(11)">양화</a></span>
	  					<p></p>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchkeyword(4)">전체</a></span>
					  	<span><a class="waves-effect waves-light btn" role="button" onclick="searchkeyword(41)">한강공원</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchkeyword(42)">주차장</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchkeyword(43)">안내소</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchkeyword(44)">자전거</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchkeyword(45)">편의점</a></span>
	  					<span><a class="waves-effect waves-light btn" role="button" onclick="searchkeyword(46)">배달존</a></span>
					 	
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
											spotCode : 41
										}),
										success : function(data) {// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
											var output = '';
											$(data).each(
															function() {
																output += '<div class="col-sm-3 col-md-3">';
																output += '<div class="thumbnail">';
																output += ' <div class="caption">';
																output += '<h5>'+ this.spotTitle+ '</h5>';
																output += '  <strong><i class="glyphicon glyphicon-tree-deciduous"></i> 위치 </strong>';
																output += '<p> '+ this.spotAddress+ '</p>';
																output += '  <strong><i class="glyphicon glyphicon-pencil"></i> 등록날짜 / 수정날짜 </strong>';
																output += '<p> '+ this.spotCreateTime+ ' / '+ this.spotModifyTime+ '</p>';
																output += '  <strong><i class="glyphicon glyphicon-ok-circle"></i> Tag</strong>';
																output += ' <p>';
																output += ' <span class="label label-success">백과</span>';
																output += ' <span class="label label-primary">한강</span>';
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
