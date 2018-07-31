<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
<!-- DatePicker CDN -->
<script src="/javascript/wickedpicker.min.js?ver=1"></script>
<link rel="stylesheet" href="/css/wickedpicker.min.css">
<!-- 툴바 넣는 CDN 입니다 -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
<!-- sweet alert를 쓰기위한 CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- T-map 지도를 쓰기위한 선언 -->
<script src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=cadda216-ac54-435a-a8ea-a32ba3bb3356"></script>
<script src="/javascript/juangeolocation.js?ver=1"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="/css/materialize.css">
<!-- juanMap.js CDN --> 
<script src="/javascript/juanMap.js"></script> 

<html>
<head>
<title>Insert title here</title>
<style>
#map { 
        height: 45%;
        width:100%; 
      } 

	.container {
    margin-right: 5%;
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
    width: 25%;
    position: fixed;
    z-index: 1;
    top: 120px;
    left: 10px;
    background: #eee;
    overflow-x: hidden;
    /*max-height : 60%;*/
    border : 0.3px solid black;
}

/*고정 바 탑일때 css*/
.sidenav1 {
    width: 25%;
    position: fixed;
    z-index: 1;
    top: 180px;
    left: 10px;
    background: #eee;
    overflow-x: hidden;
   /* max-height : 60%;*/
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
  background-color: #a1d878;
  color: white;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  font-size: 20px;
  width: 50%;
}

.tablink:hover {
  background-color: #45ba31;
}

/* Style the tab content (and add height:100% for full page content) */
body, html {
  height: 100%;
  margin: 0;
  padding: 1px;
}

.tabcontent {
  display: none;
  padding:10px;
  height: 80%;
}

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
    font-size: 10px;
     min-width: 40%;
     }
     
     .open>.dropdown-menu {
    display: block;
    min-width: 40%;
	}
	
	.dropdown, .dropup {
    position: relative;
    display: flex;
	}
    
    p {
    /* margin: 0 0 10px; */
    font-weight: bold;
	}
</style>

<script>
//오늘 날짜 구하기
var today = new Date();
var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0!
var yyyy = today.getFullYear();

if(dd<10) {
    dd='0'+dd
} 

if(mm<10) {
    mm='0'+mm
} 

today = mm+'-'+dd+'-'+yyyy;

//네비게이션 해주는 곳 입니다!
$(function(){
	
	$("#cart").on("click", function(){
		location.href = "/cart/getMyCartList";
	})
	
	$("#spot").on("click", function(){
		location.href = "/spot/getSearchSpot";
	})
	
	
	initTmap();

});


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
	        
	        if(scrollLocation > 110){ //화면을 내리면 장바구니 뜨게하고
	        	$("body > div.sidenav").fadeIn();
	        	$("body > div.sidenav").css("display", "block");
	        }else{ //화면을 내리면 장바구니 나가게합니다.
	            $("body > div.sidenav").css("display", "none");
	            $("body > div.sidenav").fadeOut();
	        }
	    })
		$("body > div.sidenav").css("display", "none");
				
		$('#myModal').modal();
		
		// append로 생성한 경우에는 이렇게 정확하게 이름을 지정해줘야지 동작한다!!
		$(document).on('click','#navigation', function(){
		    setTimeout(function(){
		    	distance();
		    }, 200);
		}); //end of click
		
		 $("#modalButton").on("click", function(){
			 $('#myModal').modal();
		 });
		
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
			    yearSuffix: yyyy+'년',
			    minDate: new Date(today)
			  }); //end of datepicker
	  
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
        $(".tabcontent["+i+"]").slideDown();
    }

    // Remove the background color of all tablinks/buttons
    tablinks = document.getElementsByClassName("tablink");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].style.backgroundColor = "";
        $(".tabcontent["+i+"]").slideUp();
    }

    // Show the specific tab content
    document.getElementById(pageName).style.display = "block";

    // Add the specific color to the button used to open the tab content
    elmnt.style.backgroundColor = color;
}

//일정계획으로 옮겨주는 메서드입니다.
function addToSchedule(i, j){
	var lasttd = $("#wayPoint > tr").length-1;
	if( j <= lasttd ) {
		// 주소값
		wayPointAddress = $("#cartAddress"+i+"").text();
		$("#wayPointAddress"+j+"").val(wayPointAddress);
		
      // 이미지값
      console.log( $("#cartImg"+i+"").attr("class")+"번 카트 이미지 가져오는 중..." );
      $.ajax({
         url : "/restcart/getCart/"+$("#cartImg"+i+"").attr("class"),
         method : "POST",
         success : function(data){
            $("#cartImg"+i+"").attr('src',data.cartImg);
            
            wayPointImg=$("#cartImg"+i+"").attr('src');
            console.log("**"+wayPointImg);
            $("#wayPointImg"+j+"").val(wayPointImg);
         }
      })
      
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
	} else {
		swal("경유지를 먼저 추가해주세요!");
	}
		
}

//일정계획으로 옮겨주는 메서드입니다.
function addToSchedule2(i, j){
	var lasttd = $("#wayPoint > tr").length-1;
	if( j <= lasttd ) {
		// 주소값
		wayPointAddress = $("#cartAddress"+i+"").text();
		
		if( wayPointAddress.indexOf("대한민국") != -1) {
			wayPointAddress  = wayPointAddress.replace("대한민국","");
		}
		
		$("#wayPointAddress"+j+"").val(wayPointAddress);
		
    	 // 이미지값
		wayPointImg=$("#recommandImg"+i+"").attr('src');
		$("#wayPointImg"+i+"").val(wayPointImg);
      
		//제목값
		wayPointTitle = $("#recommandTitle"+i+"").text();
		$("#wayPointTitle"+j+"").val(wayPointTitle);

		// 상세내용값
		wayPointDetail=$("#recommandDetail"+i+"").text();
		$("#wayPointDetail"+j+"").val(wayPointDetail);
		
		// X값
		wayPointDetail=$("#recommandX"+i+"").val();
		$("#wayPointX"+j+"").val(wayPointDetail);
		
		// Y값
		wayPointDetail=$("#recommandY"+i+"").val();
		$("#wayPointY"+j+"").val(wayPointDetail);
	} else {
		swal("경유지를 먼저 추가해주세요!");
	}
		
}

function addWayPoint(){
	var lasttd = $("#wayPoint > tr").length-1;
	if(lasttd < 6 ){
		swal("경유지가 추가되었어요");
		var waypoint = '';
		waypoint += '<tr>';
		waypoint += '	<td align="center"><input class="form-control" type="text" name="wayPoints['+w+'].wayPointTitle" id="wayPointTitle'+w+'"/></td>' ;
		waypoint += '	<td align="center"><input class="form-control" type="text" name="wayPoints['+w+'].wayPointAddress" id="wayPointAddress'+w+'"></td>' ;
		waypoint += '	<td align="center"><input class="form-control" type="text" name="wayPoints['+w+'].wayPointDetail"   id="wayPointDetail'+w+'" /></td>' ;
		waypoint += '	<td align="center"><input class="form-control" type="text" name="wayPoints['+w+'].moveTime" id="wayPointMoveTime'+w+'" readonly/></td>' ;
		waypoint += "	<td align='center'><input class='waves-effect waves-light btn col s5' type='button' style='background-color: rgba(250, 170, 50, 0.5);'  id='navigation' value='길찾기' onclick=search('#wayPointAddress"+w+"')></td> " ; 
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
	swal("경유지가 삭제되었어요");
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
   $("img[id^='fakeCartImg']").on("click", function(){
      updateCartImgNo = $(this).closest("table").attr("class");
      $("#fileImg").click();
   })
   
   $("#fileImg").on("change", function(){
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
                success : function(data){
                   alert(data);
                   //$("."+updateCartImgNo).find("img").attr('src',data);
                   //$("#cartImg"+i+"").attr('src');
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
<div class="sidenav">
    <button class="tablink" onclick="openPage('Home', this, '#45ba31')" id="defaultOpen">장소바구니</button>
	<button class="tablink" onclick="openPage('Contact', this, '#45ba31')">추천바구니</button>
	
	<input class="form-control" type="file" id="fileImg" name="fileImg" style="display:none">

	<div id="Home" class="tabcontent">
	<br/>
		<c:set var="i" value="0" />
				<c:forEach var="cart" items="${cart}">
					<c:set var="i" value="${i+1}" />
				<div>
					<table class="${cart.cartNo}" style="margin-buttom:15px">
  					<tr class="ct_list_pop">
						<tr>
							<td rowspan="3"><i class="material-icons">place</i></td>
						    <td rowspan="3" >
						    <!-- 이미지 미리보기를 위한 img 태그 -->
                         <c:if test="${cart.cartImg.contains('http://')}">
                            <img src="${cart.cartImg}" class="${cart.cartNo}" width="50" height="50"  id="fakeCartImg${i}">
                         </c:if>
                         <c:if test="${!cart.cartImg.contains('http://')}">
                            <img src="/images/spot/${cart.cartImg}" class="${cart.cartNo}" width="50" height="50"  id="fakeCartImg${i}">
                         </c:if>
                         <!-- 실제 데이터가 넘어가는 img 태그 -->
                         <img style="display:none;" src="/images/spot/${cart.cartImg}" width="50" height="50"  id="cartImg${i}" class="${cart.cartNo}">
						    </td>
						    <th id="cartTitle${i}">${cart.cartTitle}</th>
                            <td rowspan="3"><div class="dropdown">
							    <button class="dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"> 경유지선택
							    <span class="caret"></span></button>
							    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
							      <li ><a onclick="addToSchedule('${i}',0)">첫번째</a></li>
							      <li ><a onclick="addToSchedule('${i}',1)">두번째</a></li>
							      <li ><a onclick="addToSchedule('${i}',2)">세번째</a></li>
							      <li><a  onclick="addToSchedule('${i}',3)">네번째</a></li>
							      <li ><a onclick="addToSchedule('${i}',4)">다섯번째</a></li>
							      <li ><a onclick="addToSchedule('${i}',5)">여섯번째</a></li>
							       <li ><a onclick="addToSchedule('${i}',6)">일곱번째</a></li>
							    </ul>
							 </div>
							 
							 <!-- 하지수테스트 -->
 							 <button class="btn" type="button" id="updateCart">수정</button>
							 <button class="btn" type="button" id="deleteCart">삭제</button>
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
				</div>
				</c:forEach>
				<button class="btn success" id="cartNavi">장바구니..</button>
	</div>

	<div id="Contact" class="tabcontent">
	  <br/>
		 <c:set var="i" value="0" />
				<c:forEach var="recommand" items="${recommand}">
					<c:set var="i" value="${i+1}" />
				<div>
					<table class="${recommand.spotNo}" style="margin-buttom:15px">
  					<tr class="ct_list_pop">
						<tr>
							<td rowspan="3"><i class="material-icons">place</i></td>
						    <td rowspan="3" >
						    <c:if test="${fn:length(recommand.spotImg) >= 30 }">
						    	<img src="${recommand.spotImg}" class="img-rounded" width="50" height="50"  id="cartImg${i}">
						    </c:if>
						     <c:if test="${fn:length(recommand.spotImg) < 30 }">
						    	<img src="/images/spot/${recommand.spotImg}" class="img-rounded" width="50" height="50"  id="recommandImg${i}">
						    </c:if>		
						    </td>
						    <th id="recommandTitle${i}">${recommand.spotTitle}</th>
                            <td rowspan="3"><div class="dropdown">
							    <button class="dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"> 경유지선택
							    <span class="caret"></span></button>
							    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
							      <li ><a onclick="addToSchedule2('${i}',0)">첫번째</a></li>
							      <li ><a onclick="addToSchedule2('${i}',1)">두번째</a></li>
							      <li ><a onclick="addToSchedule2('${i}',2)">세번째</a></li>
							      <li><a onclick="addToSchedule2('${i}',3)">네번째</a></li>
							      <li ><a onclick="addToSchedule2('${i}',4)">다섯번째</a></li>
							      <li ><a onclick="addToSchedule2('${i}',5)">여섯번째</a></li>
							       <li ><a onclick="addToSchedule2('${i}',6)">일곱번째</a></li>
							    </ul>
							 </div>
                            </td>
						</tr>
						<span id="cartContents">
							<tr>    
							    <td width="200px" id="recommandAddress${i}">${recommand.spotAddress}</td>
							</tr>
							<tr>
							    <td width="200px" id="recommandDetail${i}">${recommand.spotDetail}</td>
							</tr>
								<input type="hidden" id="recommandX${i}" value="${recommand.spotX}">
							    <input type="hidden" id="recommandY${i}" value="${recommand.spotY}">
						</span>
					</table>
				</div>
				</c:forEach>
				<button class="btn success" id ="spot">장소검색..</button>
	</div>

</div>
	<form enctype="multipart/form-data" >
      <%@ include file="/layout/toolbar.jsp"%>
     <div id="img" style='background-image: url(/images/spot/421.jpg); background-position-y :-100px '>  
        <div class="content">  
           <div id="scheduleTitle2">일정수정페이지 입니다!</div>
           <div id="scheduleDetail2"></div>
            <button type="button" class="waves-effect waves-light btn" id="modalButton">나들이추가</button>
            <button type="button" class="waves-effect waves-light btn" id="uploadButton">섬네일변경</button>
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
                            <h4 class="modal-title">나들이 가세요?</h4> 
                        </div>
					<div class="modal-body">
						<div class="form-group">
							<label for="scheduleTitle">나들이에 제목을 지어주세요</label> 
							<input type="text" class="form-control" id="modalscheduleTitle" placeholder="제목" value="${schedule.scheduleTitle}">
						</div>
						<div class="form-group">
							<label for="scheduleDetail">주제를 간단히 설명해주세요</label> 
							<input type="text" class="form-control" id="modalscheduleDetail" placeholder="장소를 간단히 설명해주세요!!" value="${schedule.scheduleDetail}">
						</div>
						<div class="form-group">
							<label for="scheduleDate">언제 나들이 가세요?</label> 
							<input type="text"  class="form-control"id="datepicker" placeholder="나들이가는 날짜를 입력해주세요!!" value="${schedule.scheduleDate}" readOnly>
						</div>
					</div>
						<div class="modal-footer"> 
                            <button type="button" class="waves-effect waves-light btn" id="modalinsert">입력!</button> 
                        </div> 
                    </div> 
                </div> 
            </div>
            
     <div class="container">
     	<hr/>	
		
		<div id="map"></div>
		
			<hr/> 
				
			<div class="form-group row">
				<div class="col-xs-3">
					<p>출발시간은 언제인가요?</p> 
					<input type="text" class="form-control" id="timepicker" name="startHour" readOnly />
				</div>
				<div class="col-xs-3">
				<p>공개범위를 설정해주세요! </p>
				      <select class="form-control" name="openRange" >
				        <option value="0">모두공개</option>
				        <option value="1">친구만공개</option>
				        <option value="2">비공개</option>
						</select>
				</div>
				<div class="col-xs-4">
				<p>경유지를 추가할까요?</p>
				    <span class="waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" onclick="addWayPoint()">+ 경유지 추가</span> 
					<span class="waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" onclick="deleteWayPoint()">- 경유지 제거</span>
				</div>	
			</div>
			
			<hr/>
			
			<input type="hidden" name="userId" value="${sessionScope.user.userId}">
			<input type="hidden" id="scheduleTitle" name="scheduleTitle" value="${schedule.scheduleTitle}">
			<input type="hidden" id="scheduleDetail" name="scheduleDetail" value="${schedule.scheduleDetail}">
			<input type="hidden" id="scheduleDate" name="scheduleDate" value="${schedule.scheduleDate}">
			<input type="hidden" id="scheduleImg" name="scheduleImg" value="${schedule.scheduleImg}">
			<input type="hidden" id="scheduleNo" name="scheduleNo" value="${schedule.scheduleNo}">
			<input type="hidden" id="transportationCode" name="transportationCode" value="0">
			
			<table class="table">
				<thead>
					<tr>
						<th width="15%">제목</th>
						<th width="20%">주소</th>
						<th width="20%">상세설명</th>
						<th width="7%">이동시간(분)</th>
						<th width="10%">길찾기</th>
					</tr>
				</thead>
				<tbody id="wayPoint">	
					<c:set var="i" value="-1" />
						<c:forEach var="waypoint" items="${waypoint}">
							<c:set var="i" value="${i+1}" />
							<tr>
								<td align="center"><input class="form-control" type="text" name="wayPoints[${i}].wayPointTitle" id="wayPointTitle${i}" value="${waypoint.wayPointTitle}"/></td>
								<td align="center"><input class="form-control" type="text" name="wayPoints[${i}].wayPointAddress" id="wayPointAddress${i}"value="${waypoint.wayPointAddress}"></td>
								<td align="center"><input class="form-control" type="text" name="wayPoints[${i}].wayPointDetail"   id="wayPointDetail${i}"value="${waypoint.wayPointDetail}" /></td>
								<td align="center"><input class="form-control" type="text" name="wayPoints[${i}].moveTime" id="wayPointMoveTime${i}" readonly/></td>
								<td align='center'><input class='waves-effect waves-light btn col s5' type='button' style='background-color: rgba(250, 170, 50, 0.5);'  id='navigation' value='길찾기' onclick="search('#wayPointAddress${i}')"></td>
								<input type="hidden" name="wayPoints[${i}].wayPointImg" id="wayPointImg'+${i}+'" value="${waypoint.wayPointImg}"/>
								<input type="hidden" name="wayPoints[${i}].wayPointNav" id="wayPointNav'+${i}+'" value="${waypoint.wayPointNav}"/>
								<input type="hidden" name="wayPoints[${i}].wayPointX"  id="wayPointX${i}" value="${waypoint.wayPointX}" >
								<input type="hidden" name="wayPoints[${i}].wayPointY"  id="wayPointY${i}" value="${waypoint.wayPointY}">
							</tr>
					</c:forEach>
				</tbody>
			</table>
			
				<hr />
			<button class="waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5); float: right;" id="updateSchedule" >수정</button>
	</form>
	
</body>
</html>