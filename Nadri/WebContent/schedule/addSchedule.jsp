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
<!-- toolbar.js CDN --> 
<script src="/javascript/toolbar.js"></script> > 
<!-- Mansory CDN 블럭처럼 게시물을 쌓을 수 있도록 만들어주는 CDN입니다! --> 
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>
<!-- 폰트 넣는 css  -->
<link rel="stylesheet" href="/css/commonfont.css">
<!-- T-map 지도를 쓰기위한 선언 -->
<script src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=cadda216-ac54-435a-a8ea-a32ba3bb3356"></script>
<!-- Import materialize.min.js -->
<script type="text/javascript" src="/javascript/materialize.min.js"></script>
<link rel="stylesheet" href="/css/materialize.min.css">
<script src="/javascript/juangeolocation.js?ver=2"></script>
<!-- DatePicker CDN -->
<script src="/javascript/wickedpicker.min.js"></script>
<link rel="stylesheet" href="/css/wickedpicker.min.css">
<html>
<head>
<title>Insert title here</title>
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

* {
font-family : 'seoul';
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
</style>

<script>

var options = {
		now: "00:00", //hh:mm 24 hour format only, defaults to current time
        twentyFour: true,  //Display 24 hour format, defaults to false
        upArrow: 'wickedpicker__controls__control-up',  //The up arrow class selector to use, for custom CSS
        downArrow: 'wickedpicker__controls__control-down', //The down arrow class selector to use, for custom CSS
        close: 'wickedpicker__close', //The close class selector to use, for custom CSS
        hoverState: 'hover-state', //The hover state class to use, for custom CSS
        title: '시간을 선택하세요!', //The Wickedpicker's title,
        showSeconds: false, //Whether or not to show seconds,
        timeSeparator: ':', // The string to put in between hours and minutes (and seconds)
        secondsInterval: 1, //Change interval for seconds, defaults to 1,
        minutesInterval: 1, //Change interval for minutes, defaults to 1
        beforeShow: null, //A function to be called before the Wickedpicker is shown
        afterShow: null, //A function to be called after the Wickedpicker is closed/hidden
        show: null, //A function to be called when the Wickedpicker is shown
        clearable: false, //Make the picker's input clearable (has clickable "x")
    };
    
	$(function() {
		
		initTmap();
		
		// 0.2초의 시간을 줘야지 자바스크립트가 먼저 실행되지 않습니다!!
		$(".waves-effect").click(function(){
			    setTimeout(function(){
			    	distance();
			    }, 200);
			}); //end of click
		
		  $( "#datepicker" ).datepicker({
		    dateFormat: 'yy-mm-dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    dayNames: ['일','월','화','수','목','금','토'],
		    dayNamesShort: ['일','월','화','수','목','금','토'],
		    dayNamesMin: ['일','월','화','수','목','금','토'],
		    showMonthAfterYear: true,
		    changeMonth: true,
		    changeYear: true,
		    yearSuffix: '년'
		  }); //end of datepicker
		  
		 $("#hi").on("click", function() {
				$("form").attr("method", "POST").attr("action","/schedule/addSchedule").submit();
			});
	  
		$('.timepicker').wickedpicker(options);
		
	});
	
</script>
</head>
<body>
     <div id="img" style='background-image: url(/images/spot/parkdefault.png)'> 
        <div class="content">  
           <h1>환영합니다 일정등록입니다!</h1>
            <!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" >섬네일 바꾸시기 원하시면 클릭하세요!</button> -->
             <a class="waves-effect waves-light btn modal-trigger" href="#modal1">섬네일 바꾸시기 원하시면 클릭하세요!</a>
            <input style="display: none;" type="file" id="testfile" name="testfile" >
        </div> 
        <div id="img-cover"></div> 
    </div> 
	<form>
			<div class="form-group">
  				<label for="usr">제목 :</label>
  				<input type="text" class="form-control" name="scheduleTitle">
			</div>
			<div class="form-group">
  				<label for="usr">작성자 :</label>
  				<input type="text" class="form-control" name="userId">
			</div>
			<div class="form-group">
  				<label for="usr">나들이가는 날짜 :</label>
  				<input type="text" class="form-control" id="datepicker" name="scheduleDate">
			</div>
			<div class="form-group">
  				<label for="usr">이미지명 :</label>
  				<input type="text" class="form-control" name="scheduleImg">
			</div>
			<div class="md-form">
				<label for="input_starttime">출발시간:</label>
			    <input type="text" class="timepicker" id="timepicker" name="startHour"/>
			</div>
			<div class="form-group">
					<label for="sel1">어떤교통수단을 이용하시겠어요? :</label>
						<select class="form-control" name="transportationCode" id="transportationCode" onclick="hello();">
					        <option value="0">자동차</option>
					        <option value="1">도보</option>
					        <option value="2">대중교통</option>
					    </select>
			</div>
		<h2>경유지를 입력해주세요</h2>
		<div id="map_div"></div>
			<table border="1">
				<tr>
					<th>경유지</th>
					<th>제목</th>
					<th>사진이름(썸네일값)</th>
					<th>X(hidden)</th>
					<th>Y(hidden)</th>
					<th>주소</th>
					<th>상세설명</th>
					<th>머무는시간(분)</th>
					<th>이동시간(분)</th>
					<th>네비게이션</th>
					<th>경유지추가버튼</th>
				</tr>
				<tr>
					<td>시작</td>
					<td><input type="text" name="wayPoints[0].wayPointTitle" value="비트캠프" id="wayPointTitle0"/></td>
					<td><input type="text" name="wayPoints[0].wayPointImg" value="startdefault.jpg"/></td>
					<td><input type="hidden" name="wayPoints[0].wayPointX" value="127.027583000005"></td>	
					<td><input type="hidden" name="wayPoints[0].wayPointY" value="37.494541"></td>
					<td><input type="text" name="wayPoints[0].wayPointAddress" id="waypoint0"></td>
					<td><input type="text" name="wayPoints[0].wayPointDetail" value="시작지점!"/></td>
					<td><input type="number" name="wayPoints[0].stayTime" id="wayPointStayTime0" /></td>
					<td><input type="number" name="wayPoints[0].moveTime" id="wayPointMoveTime0" readonly/></td>
					<td><input type="hidden" name="wayPoints[0].wayPointNav" id="wayPointNav0" /></td>
					<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="출발지 등록" onclick="search('#waypoint0') ;"></td>        
				</tr>
				<tr>
					<td>1번경유지</td>
					<td><input type="text" name="wayPoints[1].wayPointTitle" value="여의도한강공원 " id="wayPointTitle1" /></td>
					<td><input type="text" name="wayPoints[1].wayPointImg" value="417.jpg"/></td>
					<td><input type="hidden" name="wayPoints[1].wayPointX" value="126.934301199999"></td>
					<td><input type="hidden" name="wayPoints[1].wayPointY" value="37.5284017"></td>
					<td><input type="text" name="wayPoints[1].wayPointAddress" id="waypoint1" ></td>
					<td><input type="text" name="wayPoints[1].wayPointDetail" id="a0" /></td>
					<td><input type="number"  name="wayPoints[1].stayTime" id="wayPointStayTime1"  ></td>
				 	<td><input type="number"  name="wayPoints[1].moveTime"  id="wayPointMoveTime1" readonly/></td>
				 	<td><input type="hidden" name="wayPoints[1].wayPointNav" id="wayPointNav1" /></td>
				 	<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="출발지 등록" onclick="search('#waypoint1');"></td>
				</tr>
				<tr>
					<td>2번경유지</td>				
					<td><input type="text" name="wayPoints[2].wayPointTitle" value="오케이버거" id="wayPointTitle2"/></td>
					<td><input type="text" name="wayPoints[2].wayPointImg" value="329.jpg"/></td>
					<td><input type="hidden" name="wayPoints[2].wayPointX" value="126.9241293999"></td>
					<td><input type="hidden" name="wayPoints[2].wayPointY" value="37.5238324"></td>
					<td><input type="text" name="wayPoints[2].wayPointAddress" id="waypoint2" ></td>
					<td><input type="text" name="wayPoints[2].wayPointDetail" id="a1" /></td>
					<td><input type="number"  name="wayPoints[2].stayTime" id="wayPointStayTime2" /></td>
					<td><input type="number" name="wayPoints[2].moveTime" id="wayPointMoveTime2" readonly/></td>
					<td><input type="hidden" name="wayPoints[2].wayPointNav" id="wayPointNav2" /></td>
					<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="출발지 등록" onclick="search('#waypoint2');"></td>
				</tr>
				 <tr>
					<td>3번경유지</td>				 
					<td><input type="text" name="wayPoints[3].wayPointTitle" value="광나루자전거대여소" id="wayPointTitle3"/></td>
					<td><input type="text" name="wayPoints[3].wayPointImg"value="startdefault.jpg" /></td>
					<td><input type="hidden" name="wayPoints[3].wayPointX" value="127.119887899999"></td>
					<td><input type="hidden" name="wayPoints[3].wayPointY" value="37.5451999"></td>
					<td><input type="text" name="wayPoints[3].wayPointAddress" id="waypoint3" ></td>
					<td><input type="text" name="wayPoints[3].wayPointDetail" id="a2" /></td>
					<td><input type="number" name="wayPoints[3].stayTime" id="wayPointStayTime3" /></td>
					<td><input type="number" name="wayPoints[3].moveTime" id="wayPointMoveTime3" readonly/></td>
					<td><input type="hidden" name="wayPoints[3].wayPointNav" id="wayPointNav3" /></td>
					<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="출발지 등록" onclick="search('#waypoint3');"></td>
				</tr>
				<tr>
					<td>4번경유지</td>				
					<td><input type="text" name="wayPoints[4].wayPointTitle" value="엄마손만두" id="wayPointTitle4"/></td>
					<td><input type="text" name="wayPoints[4].wayPointImg" value="157.jpg"/></td>
					<td><input type="hidden" name="wayPoints[4].wayPointX" value="127.1257514"></td>
					<td><input type="hidden" name="wayPoints[4].wayPointY" value="37.541669"></td>
					<td><input type="text" name="wayPoints[4].wayPointAddress" id="waypoint4" ></td>
					<td><input type="text" name="wayPoints[4].wayPointDetail"  id="a3"/></td>
					<td><input type="number" name="wayPoints[4].stayTime" id="wayPointStayTime4" /></td>
					<td><input type="text" name="wayPoints[4].moveTime" id="wayPointMoveTime4" readonly/></td>
					<td><input type="hidden" name="wayPoints[4].wayPointNav" id="wayPointNav4" /></td>
					<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="출발지 등록" onclick="search('#waypoint4');"></td>
				</tr>
				<tr>
					<td>5번경유지</td>				
					<td><input type="text" name="wayPoints[5].wayPointTitle"  value="영동족발" id="wayPointTitle5" /></td>
					<td><input type="text" name="wayPoints[5].wayPointImg" value="158.jpg"/></td>
					<td><input type="hidden" name="wayPoints[5].wayPointX" value="127.0379898999"></td>
					<td><input type="hidden" name="wayPoints[5].wayPointY" value="37.4845391"></td>
					<td><input type="text" name="wayPoints[5].wayPointAddress" id="waypoint5" ></td>
					<td><input type="text" name="wayPoints[5].wayPointDetail" id="a4" /></td>
					<td><input type="number" name="wayPoints[5].stayTime" id="wayPointStayTime5" /></td>
					<td><input type="number" name="wayPoints[5].moveTime" id="wayPointMoveTime5" readonly/></td>
					<td><input type="hidden" name="wayPoints[5].wayPointNav" id="wayPointNav5" /></td>
					<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="출발지 등록" onclick="search('#waypoint5');"></td>
				</tr>
				<tr>
					<td>6번경유지</td>				
					<td><input type="text" name="wayPoints[6].wayPointTitle"  value="비트캠프" id="wayPointTitle6"/></td>
					<td><input type="text" name="wayPoints[6].wayPointImg" value="startdefault.jpg"/></td>
					<td><input type="hidden" name="wayPoints[6].wayPointX" value="127.027583"></td>
					<td><input type="hidden" name="wayPoints[6].wayPointY" value="37.494541"></td>
					<td><input type="text" name="wayPoints[6].wayPointAddress" id="waypoint6" ></td>
					<td><input type="text" name="wayPoints[6].wayPointDetail" id="a5" /></td>
					<td><input type="number" name="wayPoints[6].stayTime" id="wayPointStayTime6" /></td>
					<td><input type="hidden" name="wayPoints[6].wayPointNav" id="wayPointNav6" /></td>
					<td><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="출발지 등록" onclick="search('#waypoint6');"></td>
				</tr>
			</table>
			<div class="form-group">
  				<label for="sel1">공개범위 :</label>
			      <select class="form-control" name="openRange">
			        <option value="0">모두공개</option>
			        <option value="1">친구만공개</option>
			        <option value="2">비공개</option>
			      </select>
			</div>	
			
			
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
            
            <!-- materialize 모달창 start -->
            <div id="modal1" class="modal modal-fixed-footer">
			   <div class="modal-content">
			     <h4>Modal Header</h4>
			     <p>A bunch of text</p>
			   </div>
			   <div class="modal-footer">
			     <a href="#!" class="modal-close waves-effect waves-green btn-flat">Agree</a>
			   </div>
			 </div> 
			
			
			
			
		<button type="button" class="btn btn-warning" id="hi">등록!!!</button>
	</form>
</body>
</html>