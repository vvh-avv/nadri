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
<!-- 폰트 넣는 css  -->
<link rel="stylesheet" href="/css/commonfont.css">
<!-- T-map 지도를 쓰기위한 선언 -->
<script src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=cadda216-ac54-435a-a8ea-a32ba3bb3356"></script>
<script src="/javascript/juangeolocation.js?ver=1"></script>
<!-- DatePicker CDN -->
<script src="/javascript/wickedpicker.min.js?ver=1"></script>
<link rel="stylesheet" href="/css/wickedpicker.min.css">
<!-- 툴바 넣는 CDN 입니다 -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
<!-- sweet alert를 쓰기위한 CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<html>
<head>
<title>Insert title here</title>
<style>
	.container {
    padding-right: 30px;
    padding-left: 30px;
    margin-right: auto;
    margin-left: auto;
	}

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
		
		#scheduleTitle2 {
		font-size : 60px;
		}
		
		#scheduleDetail2 {
		font-size : 35px;
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
	     
/*고정 바를 만들어주는 css*/	     
.sidenav {
    width: 17%;
    position: fixed;
    z-index: 1;
    top: 100px;
    left: 10px;
    background: #eee;
    overflow-x: hidden;
    max-height : 60%;
    border : 0.3px solid black;
}

/*고정 바 탑일때 css*/
.sidenav1 {
    width: 18%;
    position: fixed;
    z-index: 1;
    top: 100px;
    left: 10px;
    background: #eee;
    overflow-x: hidden;
    max-height : 60%;
    border : 0.3px solid black;
}

.sidenav a {
    padding: 6px 8px 6px 16px;
    text-decoration: none;
    font-size: 25px;
    color: #2196F3;
    display: block;
}

.sidenav a:hover {
    color: #064579;
}

.main {
    margin-left: 140px; /* Same width as the sidebar + left position in px */
    font-size: 28px; /* Increased text to enable scrolling */
    padding: 0px 10px;
}

@media screen and (max-height: 450px) {
    .sidenav {padding-top: 15px;}
    .sidenav a {font-size: 18px;}
}

/*링크별로이쁘게 펼쳐주기(장바구니)*/
/* Style tab links */
.tablink {
  background-color: #dadada;
  color: white;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  font-size: 17px;
  width: 50%;
}

.tablink:hover {
  background-color: #777;
}

/* Style the tab content (and add height:100% for full page content) */
body, html {
  height: 100%;
  margin: 0;
  padding: 1px;
}

.tabcontent {
  display: none;
  padding: 50px 5px 10px;
  height: 80%;
}

#Home {background-color: #f5f5f5;}
#News {background-color: #f5f5f5;}
#Contact {background-color: #f5f5f5;}

	/*cartcontents만 글씨 작게해서 이쁘게 하는 부분*/
    td{
    font-size : 12px;
    } 
    
    .dropdown-menu>li>a {
    display: block;
    padding: 3px 20px;
    clear: both;
    font-weight: 400;
    line-height: 1.42857143;
    color: #333;
    white-space: nowrap;
    font-size: 12px;
}

.dropdown-menu{
    min-width: 100%;
}
</style>

<script>
// 전역변수를 선언해줘서 값을 cart에서 schedule로 옮겨 줍니다!!
// 주소값
var wayPointAddress='';
// 이미지값
var wayPointImg='';
// 상세내용값
var wayPointDetail='';
// 제목값
var wayPointTitle='';

// 증가시키기 위한 flag
var w=2;

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
	
	$(window).scroll(function(){
        var scrollLocation = $(window).scrollTop(); //브라우저의 스크롤 값
        
        if(scrollLocation > 180){ //화면을 내리면 장바구니 뜨게하고
        	$("body > div.sidenav").fadeIn();
        	$("body > div.sidenav").css("display", "block");
        }else{ //화면을 내리면 장바구니 나가게합니다.
            $("body > div.sidenav").css("display", "none");
            $("body > div.sidenav").fadeOut();
        }
    })
	$("body > div.sidenav").css("display", "none");
	
	initTmap();
	
	$('#myModal').modal();
	
	 $("#modalButton").on("click", function(){
		 $('#myModal').modal();
	 });
	 	 
	 $(document).on('click','#cartbutton', function(){ 
		$("#cartModal").modal();
	 });
			
		// append로 생성한 경우에는 이렇게 정확하게 이름을 지정해줘야지 동작한다!!
		$(document).on('click','#navigation', function(){
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
				swal("등록에 성공하셨습니다!", "마이페이지에서 확인해주세요~", "success");
			});
	  
		$('#timepicker').wickedpicker(options);
		
		$("#modalinsert").on("click", function(){
			// 모달에서 적은 제목의 value을 가져옵니다.
			var modalscheduleTitle = $("#modalscheduleTitle").val();
			// 일정 제목값에 넣습니다.
			$("#scheduleTitle").val(modalscheduleTitle);
			$("#scheduleTitle2").text(modalscheduleTitle);
			// 모달에서 적은 상세정보 value을 가져옵니다.
			var modalscheduleDetail = $("#modalscheduleDetail").val();
			// 일정 상세정보 넣습니다.
			$("#scheduleDetail").val(modalscheduleDetail);
			$("#scheduleDetail2").text(modalscheduleDetail);
			// 모달에서 적은 날짜 value을 가져옵니다.
			var datepicker = $("#datepicker").val();
			// 일정 날짜 넣습니다.
			$("#scheduleDate").val(datepicker);
			// 모달에서 적은 img을 가져옵니다.
			var modalscheduleImg = $("#modalscheduleImg").val();
			// 일정 img 넣습니다.
			$("#scheduleImg").val(modalscheduleImg);
			// 모달을 닫습니다.
			$("#myModal").modal('hide');
		});
		
		$(document).on("click", "#modal", function(){
			$('#myModal').modal();
		});
		
		$(document).on("click", "#uploadButton", function(){
			$('#file').click();
		});
		
		// 배경화면 눌러서 업로드
		$('#img-cover').click(function (e) {
			e.preventDefault();
			$('#file').click();
		});
			
	});

//이미지 미리보기 위한 버튼입니다!!
function readURL(input){
	if (input.files && input.files[0]) { 
		var reader = new FileReader(); 
		reader.onload = function (e) { 
			$("#img").empty();
			$("#img").css('background-image','url('+e.target.result+')');
			var c = '';
			c += '<div class="content">'; 
			c += '  <div id="scheduleTitle2">'+$("#modalscheduleTitle").val()+'</div>';
			c += ' <div id="scheduleDetail2">'+$("#modalscheduleDetail").val()+'</div>';
			c += '<button type="button" class="btn btn-success" id="modal">나들이추가</button>';
			c += ' <button type="button" class="btn btn-success" id="uploadButton">섬네일변경</button>';
			c += ' <input  style="display:none;" type="file" id="files" name="files" onchange="readURL(this)">'; 
			c += '</div>';
			c += ' <div id="img-cover"></div>';
		    $("#img").append(c);
			} 
		reader.readAsDataURL(input.files[0]); 
		}
}	

//드래그앤 드랍 파일 업로드 부분
$(function () {
    var obj = $("#img");
    var upload = $("#files");
    
    obj.on('dragenter', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });

    obj.on('dragleave', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });

    obj.on('dragover', function (e) {
         e.stopPropagation();
         e.preventDefault();
    });
    
	////2. 드래그앤 드롭 업로드 /////
    obj.on('drop', function (e) {
    	console.log(obj.text())
    	obj.text("");
         e.preventDefault();

         var file = e.originalEvent.dataTransfer.files[0];
         var reader = new FileReader();
         
		reader.onload = function (event) {
			var img = new Image();
			img.src = event.target.result;
			
			$("#img").css('background-image','url('+img.src+')');
			var c = '';
			c += '<div class="content">'; 
			c += '  <div id="scheduleTitle2">환영합니다 일정등록입니다!</div>';
			c += ' <div id="scheduleDetail2"></div>';
			c += '<button type="button" class="btn btn-success" id="modalButton">나들이추가</button>';
			c += ' <button type="button" class="btn btn-success" id="uploadButton">섬네일변경</button>';
			c += ' <input  style="display:block;" type="file" id="files" name="files" onchange="readURL(this)">'; 
			c += '</div>';
			c += ' <div id="img-cover"></div>';
		    $("#img").append(c);
		}
         //})
		reader.readAsDataURL(file);// File에서 읽어 오는 역할
		
		alert(JSON.stringify(file));
		
		return false;
         
         if(file.length < 1)
              return;

    });

});

// cart부분 클릭했을때 색깔 바뀌는 부분
function openPage(pageName, elmnt, color) {
    // Hide all elements with class="tabcontent" by default */
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Remove the background color of all tablinks/buttons
    tablinks = document.getElementsByClassName("tablink");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].style.backgroundColor = "";
    }

    // Show the specific tab content
    document.getElementById(pageName).style.display = "block";

    // Add the specific color to the button used to open the tab content
    elmnt.style.backgroundColor = color;
}

// 일정계획으로 옮겨주는 메서드입니다.
function addToSchedule(i, j){
	
		// 주소값
		wayPointAddress = $("#cartAddress"+i+"").text();
		$("#wayPointAddress"+j+"").val(wayPointAddress);
		
		// 이미지값
		wayPointImg=$("#cartImg"+i+"").attr('src');
		$("#wayPointImg"+j+"").val(wayPointImg);
		
		//제목값
		wayPointTitle = $("#cartTitle"+i+"").text();
		$("#wayPointTitle"+j+"").val(wayPointTitle);

		// 상세내용값
		wayPointDetail=$("#cartDetail"+i+"").text();
		$("#wayPointDetail"+j+"").val(wayPointDetail);
		
		// X값
		wayPointDetail=$("#cartX"+i+"").val();
		$("#wayPointX"+j+"").val(wayPointDetail);
		
		// Y값
		wayPointDetail=$("#cartY"+i+"").val();
		$("#wayPointY"+j+"").val(wayPointDetail);
		
}

function addWayPoint(){
	var lasttd = $("#wayPoint > tr").length-1;
	if(lasttd < 6 ){
	var waypoint = '';
		waypoint += '<tr>';
		waypoint += '	<td align="center"><input type="text" name="wayPoints['+w+'].wayPointTitle" id="wayPointTitle'+w+'"/></td>' ;
		waypoint += '	<td align="center"><input type="text" name="wayPoints['+w+'].wayPointAddress" id="wayPointAddress'+w+'"></td>' ;
		waypoint += '	<td align="center"><input type="text" name="wayPoints['+w+'].wayPointDetail"   id="wayPointDetail'+w+'" /></td>' ;
		waypoint += '	<td align="center"><input type="number" name="wayPoints['+w+'].moveTime" id="wayPointMoveTime'+w+'" readonly/></td>' ;
		waypoint += "	<td align='center'><input class='waves-effect waves-light btn col s5' type='button' id='navigation' style='background-color: rgba(250, 170, 50, 0.5);' value='길찾기!' onclick=search('#wayPointAddress"+w+"')></td> " ; 
		waypoint += '	<input type="hidden" name="wayPoints['+w+'].wayPointImg" id="wayPointImg'+w+'"/>' ;
		waypoint += '	<input type="hidden" name="wayPoints['+w+'].wayPointNav" id="wayPointNav'+w+'" />' ;
		waypoint += '	<input type="hidden" name="wayPoints['+w+'].wayPointX"  id="wayPointX'+w+'" >' ;
		waypoint += '	<input type="hidden" name="wayPoints['+w+'].wayPointY"  id="wayPointY'+w+'" >   ' ;
		waypoint += '	</tr>';
	$('#wayPoint').append(waypoint);
	w++;
	} else {
		swal("경유지는 최고 6개까지 가능합니다!");
	}
}

function deleteWayPoint(){
	var lasttd = $("#wayPoint > tr").length-1;
	if(lasttd > 1){ 
	$("#wayPoint > tr:nth("+lasttd+")").remove();
	w--;
	} else {
		swal("최소 2개의 장소는 필요합니다!");
	}
}

//바구니 수정, 삭제 감지 스크립트
$(function(){
	$("button[id^='updateCart']").on("click", function(){
		var cartNo = $(this).closest("table").attr("class");
		var cartTitle = $("."+cartNo).find("th[id^='cartTitle']").text();
		var cartDetail = $("."+cartNo).find("td[id^='cartDetail']").text();

		swal({
			  title: cartTitle+' 장소 설명 수정',
			  text: '변경을 원하시는 설명문구를 입력해주시길 바랍니다.',
			  content: {
			    element: 'input',
			    attributes: {
			      defaultValue: cartDetail,
			    }
			  }
			})
			.then(function (inputData){
				$.ajax({
					url : "/restcart/updateCart/"+cartNo+"/"+escape(encodeURIComponent(inputData)),
					method : "POST",
					contentType: "application/x-www-form-urlencoded; charset=EUC-KR",
					success : function(){
						swal({
							  title: "수정 완료!",
							  text: inputData+"로 정상 수정되었습니다!",
							  icon: "success"
							});
					}
				}) //e.o.ajax
				
				$("."+cartNo).find("td[id^='cartDetail']").text(inputData);
			})
			
	})
	
	$("button[id^='deleteCart']").on("click", function(){
		var cartNo = $(this).closest("table").attr("class");
		
		swal({
			   title: "장소를 정말 삭제하시겠습니까?",
			   text: "삭제하시면 복구가 불가합니다.",
			   icon: "warning",
			   buttons: ["취소", "삭제"],
			   dangerMode: true,
			 })
			 .then((willDelete) => {
			   if (willDelete) {
				   $.ajax({
						url : "/restcart/deleteCart/"+cartNo,
						method : "POST",
						success : function(){
							swal("삭제되었습니다.");
							$("."+cartNo).remove();
						}
					}) //e.o.ajax
			   } else {
			     swal("취소하였습니다.");
			   }
		   });
	})
	
	var updateCartImgNo = "";
	$("img[id^='cartImg']").on("click", function(){
		updateCartImgNo = $(this).closest("table").attr("class");
		$("#file").click();
	})
	
	$("#file").on("change", function(){
		imgPreview(this);
	})
	
	function imgPreview(input) {
    	if (input.files && input.files[0]) {
	        var reader = new FileReader();
	
	        reader.onload = function (e) {
	        	$("."+updateCartImgNo).find("img").attr('src', e.target.result);
	        	
	        	$.ajax({
	    			url : "/restcart/updateCartImg/"+updateCartImgNo,
	    			method : "POST",
					   dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						data : JSON.stringify({
							cartImg : e.target.result
						}),
					   success : function(){
					   }
	    		}) //e.o.ajax
	        	
	        }
	        reader.readAsDataURL(input.files[0]);
        }
    }

})
</script>
</head>
<body>

<!-- 이장소는 장소바구니입니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
<div class="sidenav">
    <button class="tablink" onclick="openPage('Home', this, 'red')" id="defaultOpen">장소바구니</button>
	<button class="tablink" onclick="openPage('News', this, 'green')" >추천장소</button>
	
	<div id="Home" class="tabcontent">
	<br/>
		<c:set var="i" value="0" />
				<c:forEach var="cart" items="${cart}">
					<c:set var="i" value="${i+1}" />
					<table class="${cart.cartNo}" style="margin-buttom:15px">
  					<tr class="ct_list_pop">
						<tr>
							<td rowspan="3"><i class="material-icons">place</i></td>
						    <td rowspan="3" >
						    	<img src="${cart.cartImg}" class="img-rounded" width="50" height="50"  id="cartImg${i}">
								<input class="form-control" type="file" id="file" name="file" style="display:none">
						    </td>
						    <th id="cartTitle${i}">${cart.cartTitle}</th>
                            <td rowspan="3"><div class="dropdown">
							    <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"> 경유지선택
							    <span class="caret"></span></button>
							    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
							      <li ><a tabindex="-1" onclick="addToSchedule('${i}',0)">첫번째</a></li>
							      <li ><a tabindex="-1" onclick="addToSchedule('${i}',1)">두번째</a></li>
							      <li ><a tabindex="-1"onclick="addToSchedule('${i}',2)">세번째</a></li>
							      <li><a tabindex="-1" onclick="addToSchedule('${i}',3)">네번째</a></li>
							      <li ><a tabindex="-1" onclick="addToSchedule('${i}',4)">다섯번째</a></li>
							      <li ><a tabindex="-1" onclick="addToSchedule('${i}',5)">여섯번째</a></li>
							       <li ><a tabindex="-1" onclick="addToSchedule('${i}',6)">일곱번째</a></li>
							    </ul>
							 </div>
							 
							 <!-- 하지수테스트 -->
							 <button class="btn btn-xs" type="button" id="updateCart">수정</button>
							 <button class="btn btn-xs" type="button" id="deleteCart">삭제</button>
                            </td>
						</tr>
						<span id="cartContents">
							<tr>    
							    <td width="200px" id="cartAddress${i}">${cart.cartAddress}</td>
							</tr>
							<tr>
							    <td width="200px" id="cartDetail${i}">${cart.cartDetail}</td>
							</tr>
								<input type="hidden" id="cartX${i}" value="${cart.cartX}">
							    <input type="hidden" id="cartY${i}" value="${cart.cartY}">
						</span>
					</table>
				</c:forEach>
				<button class="btn success">장바구니..</button>
				<div class="custom-select" style="width:200px;">
			 
</div>
	</div>
		
	<div id="Contact" class="tabcontent">
	  <h3>Contact</h3>
	  <p>Get in touch, or swing by for a cup of coffee.</p>
	</div>

</div>
	<form enctype="multipart/form-data" >
      <%@ include file="/layout/toolbar.jsp"%>
     <div id="img" style='background-image: url(/images/spot/riverdefault.jpg); background-position-y :-100px '>  
        <div class="content">  
           <div id="scheduleTitle2">환영합니다 일정등록입니다!</div>
           <div id="scheduleDetail2"></div>
            <button type="button" class="btn btn-success" id="modalButton">나들이추가</button>
            <button type="button" class="btn btn-success" id="uploadButton">섬네일변경</button>
        </div> 
        <div id="img-cover"></div>
      </div> 
      <!-- input파일 숨겨서 처리하기 -->
  <input  type="file" id="file" name="file" onchange="readURL(this)" style="display:none;" > 
  
  
  
  
  
  
			<!-- 처음 입장시 여러가지 정보를 적는 modal 창 start --> 
            <div class="modal" id="myModal" role="dialog"> 
                <div class="modal-dialog modal-sm"> 
                    <div class="modal-content"> 
                        <div class="modal-header"> 
                            <button type="button" class="close" data-dismiss="modal">&times;</button> 
                            <h4 class="modal-title">어느 피크닉 장소를 가세요?</h4> 
                        </div>
					<div class="modal-body">
						<div class="form-group">
							<label for="scheduleTitle">나들이에 이름을 붙여주세요</label> 
							<input type="text" class="form-control" id="modalscheduleTitle" placeholder="제목">
						</div>
						<div class="form-group">
							<label for="scheduleDetail">장소를 간단히 설명해주세요</label> 
							<input type="text" class="form-control" id="modalscheduleDetail" placeholder="장소를 간단히 설명해주세요!!">
						</div>
						<div class="form-group">
							<label for="scheduleDate">나들이가는 날짜</label> 
							<input type="text"  class="form-control"id="datepicker" placeholder="나들이가는 날짜를 입력해주세요!!">
						</div>
					</div>
						<div class="modal-footer"> 
                            <button type="button" class="btn btn-danger modalModBtn" id="modalinsert">입력!</button> 
                        </div> 
                    </div> 
                </div> 
            </div>
            

            
     <div class="container">
     	<hr/>
     		
     		<h1 align="center">'너, 나들이' 스케쥴러 </h1>
     			
     	<hr/>	
		
		<div id="map"></div>
		<a onClick="zoomIn()">zoom in</a>
		<a onClick="zoomOut()">zoom out</a>
		
			<hr/> 
				
			<div class="form-group row">
				<div class="col-xs-4">
					<label for="input_starttime">출발시간은 언제인가요?</label> 
					<input type="text" class="form-control" id="timepicker" name="startHour" />
				</div>
				<div class="col-xs-4">
					<label for="sel1">어떤교통수단을 이용하시겠어요? </label> 
						<select class="form-control" name="transportationCode" id="transportationCode">
							<option value="0">자동차</option>
							<option value="1">도보</option>
							<option value="2">대중교통</option>
						</select>
				</div>
				<div class="col-xs-4">
	  				<label for="sel1">공개범위 :</label>
				      <select class="form-control" name="openRange">
				        <option value="0">모두공개</option>
				        <option value="1">친구만공개</option>
				        <option value="2">비공개</option>
			      	</select>
				</div>	
			</div>
			
			<hr/>
			
			
			<div class="panel panel-info">
					<label>일정계획표</label>
			</div>	
			
			<input type="hidden" name="userId" value="${sessionScope.user.userId}">
			<input type="hidden" id="scheduleTitle" name="scheduleTitle" >
			<input type="hidden" id="scheduleDetail" name="scheduleDetail">
			<input type="hidden" id="scheduleDate" name="scheduleDate">
			<input type="hidden" id="scheduleImg" name="scheduleImg">
			
			<div>
			<table class="table">
				<thead>
					<tr>
						<th class="text-center">제목</th>
						<th class="text-center">주소</th>
						<th class="text-center">상세설명</th>
						<th class="text-center">이동시간(분)</th>
						<th class="text-center">길찾기</th>
					</tr>
				</thead>
				<tbody id="wayPoint">	
					<tr id="wayPoint0">
						<td align="center"><input type="text" name="wayPoints[0].wayPointTitle" id="wayPointTitle0"/></td>
						<td align="center"><input type="text" name="wayPoints[0].wayPointAddress" id="wayPointAddress0"></td>
						<td align="center"><input type="text" name="wayPoints[0].wayPointDetail"   id="wayPointDetail0" value="시작지점!"/></td>
						<td align="center"><input type="number" name="wayPoints[0].moveTime" id="wayPointMoveTime0" readonly/></td>
						<td align="center"><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" id="navigation'" value="출발지등록!" onclick="search('#wayPointAddress0')"></td>  
						<input type="hidden" name="wayPoints[0].wayPointImg" id="wayPointImg0"/>
						<input type="hidden" name="wayPoints[0].wayPointNav" id="wayPointNav0" />
						<input type="hidden" name="wayPoints[0].wayPointX" id="wayPointX0"/>
						<input type="hidden" name="wayPoints[0].wayPointY" id="wayPointY0"/>   
					</tr>
				 	<tr>
						<td align="center"><input type="text" name="wayPoints[1].wayPointTitle" id="wayPointTitle1" /></td>
						<td align="center"><input type="text" name="wayPoints[1].wayPointAddress" id="wayPointAddress1" ></td>
						<td align="center"><input type="text" name="wayPoints[1].wayPointDetail" id="wayPointDetail1" /></td>
					 	<td align="center"><input type="number"  name="wayPoints[1].moveTime"  id="wayPointMoveTime1" readonly/></td>
					 	<td align="center"><input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);"  id="navigation" value="길찾기" onclick="search('#wayPointAddress1')"></td>
						<input type="hidden" name="wayPoints[1].wayPointImg"  id="wayPointImg1"/>				 	
					 	<input type="hidden" name="wayPoints[1].wayPointNav" id="wayPointNav1" />
					 	<input type="hidden" name="wayPoints[1].wayPointX" id="wayPointX1"/>
						<input type="hidden" name="wayPoints[1].wayPointY" id="wayPointY1"/>
					</tr>
				</tbody>
				<hr/>
					<span class="waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="경유지추가" onclick="addWayPoint()">+ 경유지 추가하기</span> 
					<span class="waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="경유지추가" onclick="deleteWayPoint()">- 경유지 줄이기</span>
						<label>몇개의 장소를 들르시나요? </label>
					</div>
				
				<hr />
			</table>

			<br/>
			<button type="button" class="btn btn-warning" id="hi" style="float: right;">등록!!!</button>
			
			</div>
			<br/>
		</div><!-- end of container -->
	</form>
	
</body>
</html>