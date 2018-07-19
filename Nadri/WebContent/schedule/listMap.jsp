<%@ page language="java" contentType="text/html; charset=EUC-KR" 
pageEncoding="EUC-KR"%> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
<html> 

<style>
		body {
		height : 100%
		}
		
  		#map { 
        height: 80%;
        width: 100%;
        clear : both;
       } 
        
	    #img{ 
	    position: relative;                                                           
	    height: 30vh; 
	    background-size: cover; 
		} 
        
       #img-cover{ 
	   position: absolute; 
	   height: 100%; 
	   width: 100%; 
	   background-color: rgba(0, 0, 0, 0.4);                                                                  
	   z-index:1; 
		} 

		#img .content{ 
	     position: absolute; 
	     top:50%; 
	     left:50%; 
	     transform: translate(-50%, -50%);                                                                    
	     font-size:5rem; 
	     color: white; 
	     z-index: 2; 
	     text-align: center; 
	     } 
     
		#file { 
		display :none; 
		} 

		.form-group{
		width:300px;
		height:300px;
		}

		.dropbtn {
		    background-color: #4CAF50;
		    color: white;
		    padding: 16px;
		    font-size: 16px;
		    border: none;
		}

		span.dropdown {
			width: 20%;
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
    var center = {lat: 37.57593689999999 , lng: 126.97681569999997}; 
    var map, geocoder, infowindow; 
    var locations = []; 
    var infowindows = [];
    var contents = [];	
    //마커 저장소
    var marker = [];
   
    function initMap(){ 
	
     // 맵 스타일 속성에 필요한 배열 생성 
     var styles =[ 
     ]; 
     
     //새로운 styleMapType를 생성하며 커스터마이징한 스타일을 적용 시킨 객체를 만든다. 
     var styledMap = new google.maps.StyledMapType(styles, {name : "Styled Map"}); 
    
     // 맵에 세팅될 각종 옵션을 적용 시킨다. 
     var mapOptions = { 
     //최초 맵 로딩 시 위치 값 셋팅 
     center : center, 
     // 줌 레벨 셋팅 
     zoom : 11, 
     //스크롤 휠 페이지 검색
     scrollwheel: false,
     // 스타일 맵 적용 
     mapTypeControlOptions : { 
     		mapTypeIds : [google.maps.MapTypeId.ROADMAP, 'map_style'] 
     	} 
     }; 
     
     // 맵 객체 생성 
     map = new google.maps.Map(document.getElementById('map'), mapOptions); 
     // 시군구를 표현할 수 있도록 경계를 칠해주는 코딩입니다!
     map.data.loadGeoJson('https://raw.githubusercontent.com/southkorea/seoul-maps/master/kostat/2013/json/seoul_municipalities_geo.json');
     // Set the stroke width, and fill color for each polygon
     map.data.setStyle(function(feature) {
    	 var color = '#F1F8E0';
    	 if(feature.getProperty('isColorful')){
    		 color = '';
    	 }
    	 return ({
       fillColor: color,
       strokeWeight: 0.2
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
    
    var nowposition = new google.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation을 사용할수 없어요..'
        
    displayMarker(nowposition, message);
}
// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(nowposition, message) {
    // 마커를 생성합니다
    var marker = new google.maps.Marker({  
        map: map, 
        position: nowposition
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
         map.data.overrideStyle(event.feature, {fillColor: '#F2F79B'});
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
function zoomChange(event){
	//줌 축소 고정
	if(map.getZoom() > 10){
		map.setZoom(13);
	}
}//end of zoomChange

//주소를 가져오는 메소드
 function getAddress(event){ 
     var strData = ""; 
     addMarker(event.latLng, map); 
     // getJSON 방식으로 데이터를 데이터를 가져오는 방식 파라미터를 설정해서 각종 옵션 변경이 가능하다. 
     var lat = ""+event.latLng.lat(); 
     var lng =""+event.latLng.lng(); 
     var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&language=ko&key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs"; 
     var strData = ""; 
     $.getJSON(url, function (data) { 
     if (data.status == google.maps.GeocoderStatus.OK){ 
     strData += "<p>results[0].formatted_address : "+data.results[0].formatted_address+"</p>"; 
     document.getElementById("dataInfo").innerHTML = strData; 
     } 
     }); 
    } 
     	
    //마커를 생성하는 메소드
    	 // 지도에 마커 추가
        function addMarker(location, map){
        	marker = new google.maps.Marker({
        		position : location,
        		title : "현재위치",
        		map : map
        	});
        	
        	var latPosition = ""+location.lat(); // 현재 클릭 위도 가져오기
        	latPosition = latPosition.substring(0,10);
        	var lngPosition = ""+location.lng();//현재 클릭 경도 가져오기
        	lngPosition = lngPosition.substring(0,10);
        	
        	// 말풍선 안에 들어갈 내용
        	var content = "<div>"+
        							"위도 : "+latPosition+"<br/> 경도 : "+lngPosition +
        							"</div>"; 
        	// 마커를 클릭했을때 말풍선 표시 이벤트
        	var infowindow = new google.maps.InfoWindow({
        		content : content
        	});
        	
        	// 말풍선 표시
        	infowindow.open(map,marker);
        	
        	// 리스너에 마커 클릭 이벤트를 셋팅
        	google.maps.event.addListener(marker, "click" , function() {
        		// 마커를 클릭하면 마커가 오버레이에서 지워집니다.
        		marker.setMap(null);
        	}); 
        }
    
	//공원부분 메소드!
	function getParkList() {  
		deleteMarkers();
		// .parkImg를 비운다.
		$('.parkImg').empty(); 
		 $.ajax({ 
	         type : "post", 
	         url : "/spot/park/listPark", 
	         headers : { 
	             "Content-type" : "application/json", 
	             "X-HTTP-Method-Override" : "POST" 
	         }, 
	         dataType : "text", 
	         success : function (result) { 
	          var result = JSON.parse(result); 
	          var park = result.park 
	          for ( var i = 0 ; i<park.length ; i++){ 
	          obj = {position : new google.maps.LatLng(parseFloat(park[i].parkY), parseFloat(park[i].parkX)) };
	          //obj = {lat : parseFloat(park[i].parkY), lng : parseFloat(park[i].parkX), detail : park[i].parkDetail }; 
	          locations.push(obj); 
	          
	          // Create marker
	      	// Create marker
	        locations.forEach(function(feature) {
	            marker = new google.maps.Marker({
	              position: feature.position,
	              //icon: icons[feature.type].icon,
	              map: map
	            });
	          }); //마커 만드는 거 끝!
	          
		        /* locations.forEach(function(feature) {
		        	addMarkerWithTimeout(locations[i], i * 10);
		          }); //마커 만드는 거 끝! */
		          
	   $('.parkImg').append(function (index){ 
	  		 // 변수를 선언합니다. 
		      var item = park[index]; 
		      var output = ''; 
		      output += '<h1>' + park[i].parkName + '</h1>'; 
		      output += '<img src=" ' + park[i].parkImg + ' " height="100" width="100" />'; 
		      output += '<h2> 위도 : '  + park[i].parkX + '</h1>'; 
		      output += '<h2> 경도 : '  + park[i].parkY + '</h1>'; 
		      return output; 
		      }) 
	     } 
	  } 
	});// end of ajax 

	} // end of dropPark()
	
	
	
	function aaa() {
		alert("장바구니추가완료!")
	}	
	
	function marking() {
		alert("이곳을 마킹합니다!")
	}	
	
	// marker animation으로 찍기!
	function addMarkerWithTimeout(position, timeout) { 
	        window.setTimeout(function() { 
	          marker = new google.maps.Marker({
	              position: position,
	              //icon: icons[feature.type].icon,
	              map: map
	        }, timeout); 
	        })
	} // end of addMarkerWithTimeout
	
	// Sets the map on all markers in the array.
	 function clearMarkers() {
	        setMapOnAll(null);
	      }
	
	 function deleteMarkers() {
	        clearMarkers();
	        marker = [];
	      }
	 
	// Deletes all markers in the array by removing references to them.
	 function setMapOnAll(map) {
	        for (var i = 0; i < marker.length; i++) {
	        	marker[i].setMap(map);
	        }
	      }
	</script> 

<script> 
$(document).ready(function (){ 
//이벤트를 연결합니다. 
	$('#img').on('click', function() { 
		$('#myModal').modal("hide"); 
		}) 
	}); 

	$(function() { 
	 	$( '#abc' ).on("click" , function() { 
	 		alert("장바구니추가완료!");
	 });  	 
}); 
	
	//드래그앤 드랍 파일 업로드 부분
	$(function () {
    var obj = $("#dropzone");
    var a = $("#img");
    var upload = $('input:file')[0]
    
    obj.on('dragenter', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '2px solid #5272A0');
    });

    obj.on('dragleave', function (e) {
         e.stopPropagation();
         e.preventDefault();
         $(this).css('border', '2px dotted #8296C2');
    });

    obj.on('dragover', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });
    
    $(obj).on("click" , function name() {
		$(upload).click();
	})
    
    /////1. 터치해서 업로드/////
    $(upload).on("change", function (e) {
		e.preventDefault();  // 기본적인 서브밋 행동을 취소합니다
		
	
		var file = upload.files[0]
		
		var reader = new FileReader();
	
		reader.onload = function (event) {
			obj.text("");
			var img = new Image();
			img.src = event.target.result;
			var a = (img.src).split(',');
			
			//obj.append(img);
			//$("#img").css("background-image","url(image)");
			$("#img").append(img);
			}
		reader.readAsDataURL(file);// File에서 읽어 오는 역할
		
		return false;
         
         if(file.length < 1)
              return;
    });
	////////////////////////////////////////////////
	
	
	////2. 드래그앤 드롭 업로드 /////
    obj.on('drop', function (e) {
    	console.log(obj.text())
    	obj.text("");
         e.preventDefault();
         $(this).css('border', '2px dotted #8296C2');

         var file = e.originalEvent.dataTransfer.files[0];
         var reader = new FileReader();
         
		reader.onload = function (event) {
			var img = new Image();
			img.src = event.target.result;
			
			//obj.append(img);
			$("#img").css("background-image","url(image)");
			$("#img").append(img);
		}
         //})
		reader.readAsDataURL(file);// File에서 읽어 오는 역할
		
		return false;
         
         if(file.length < 1)
              return;

    });

});

</script> 
<%--head.jsp--%> 
<body class="hold-transition skin-blue sidebar-mini layout-boxed"> 
<div class="wrapper"> 

<%--main_header.jsp--%> 
<%-- Main Header --%> 

<%--left_column.jsp--%> 
<%-- Left side column. contains the logo and sidebar --%> 

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
		<div class="icon"> </div> 
	<span class="temp"></span>
	<span class="temp_max"></span> 
	<span  class="temp_min"></span> 
</section> 
</div> 

<%-- Main content --%> 
  <body> 
    <div id="img" style="background-image: url(../images/park01.png)"> 
        <div class="content">  
            <h2>Where are you going?</h2>
            <div id="dropzone">사진을 드래그</div>
            <!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="dropzone">섬네일 바꾸시기 원하시면 클릭하세요!</button>  -->
            <input style="display: none;" type="file" id="testfile" name="testfile" >
        </div> 
        <div id="img-cover"></div> 
    </div> 
    <br/> 
    <br/> 
    
   <span class="dropdown">
 	 <button class="btn btn-block btn-info btn-xs" onclick="getParkList()">공원</button>
  		<div class="dropdown-content">
		    <a href="#">Link 1</a>
		    <a href="#">Link 2</a>
		    <a href="#">Link 3</a>
 		 </div>
	</span>
	
	<span class="dropdown">
 	 <button class="btn btn-block btn-success btn-xs" onclick="getFestivalList()">축제/전시</button>
  		<div class="dropdown-content">
		    <a href="#">Link 1</a>
		    <a href="#">Link 2</a>
		    <a href="#">Link 3</a>
 		 </div>
	</span>
	
	<span class="dropdown">
 	 <button class="btn btn-block btn-Primary btn-xs">맛집</button>
  		<div class="dropdown-content">
		    <a href="#">Link 1</a>
		    <a href="#">Link 2</a>
		    <a href="#">Link 3</a>
 		 </div>
	</span>
	
	<span class="dropdown">
 	 <button class="btn btn-block btn-danger btn-xs" onclick="getRiverList()">한강</button>
  		<div class="dropdown-content">
		    <a href="#">Link 1</a>
		    <a href="#">Link 2</a>
		    <a href="#">Link 3</a>
 		 </div>
	</span>
	
	<span class="dropdown">
 	 <button class="btn btn-block btn-warning btn-xs" onclick="getUtilList()">편의시설</button>
  		<div class="dropdown-content">
		    <a href="#">Link 1</a>
		    <a href="#">Link 2</a>
		    <a href="#">Link 3</a>
 		 </div>
	</span>
    
    
    <div id="map"> 
    <br/>
    <br/>
    </div> 
     <div class="parkImg"></div> 
     <p></p> 
    <div id="dataInfo"></div>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
   <!--  클릭시 모달창을 띄우는 코딩 --> 
    <!-- Modal --> 


<!-- 댓글작성 modal 창 start --> 
            <div class="modal fade" id="myModal" role="dialog"> 
                <div class="modal-dialog"> 
                    <div class="modal-content"> 
                        <div class="modal-header"> 
                            <button type="button" class="close" data-dismiss="modal">&times;</button> 
                            <h4 class="modal-title">어느 피크닉 장소를 가세요?</h4> 
                        </div> 
                        <div class="modal-body"> 
                            <div class="form-group"> 
                                <label for="replyDetail">장소를 간단히 설명해주세요!!</label> 
                                <input class="form-control" id="replyDetail" name="replyDetail" placeholder="댓글 내용을 입력해주세요"> 
                            </div> 
                            <div class="form-group"> 
                                <label for="InputFile">썸네일로 쓰실 사진을 올려주세요</label> 
                                <input type="file" id="InputFile"> 
                            </div> 
                        </div> 
                        <div class="modal-footer"> 
                            <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button> 
                            <button type="button" class="btn btn-danger modalModBtn">수정</button> 
                        </div> 
                    </div> 
                </div> 
            </div> 
       
    </div> 

    </body> 
</html> 
