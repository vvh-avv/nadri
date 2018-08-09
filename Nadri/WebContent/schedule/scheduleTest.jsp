<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
<!-- ��Ʈ �ִ� css  -->
<link rel="stylesheet" href="/css/commonfont.css">
<!-- DatePicker CDN -->
<script src="/javascript/wickedpicker.min.js?ver=1"></script>
<link rel="stylesheet" href="/css/wickedpicker.min.css">
<!-- sweet alert�� �������� CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- T-map ������ �������� ���� -->
<script
	src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=cadda216-ac54-435a-a8ea-a32ba3bb3356"></script>
<script src="/javascript/juangeolocationPedestrian.js?ver=1"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<!-- <link rel="stylesheet" href="/css/materialize.css"> -->
<!-- juanMap.js CDN -->
<script src="/javascript/juanMap.js"></script>
<!--  clock picker  -->
<script src="/javascript/clockpicker.js"></script>
<link rel="stylesheet" href="/css/clockpicker.css">

<html>
<head>
<title>Insert title here</title>
<style>
.maincon {
	z-index: 15;
}

.title-section>div {
	top: -15px;
}

#map {
	height: 45%;
	width: 100%;
}

.container-add-schedule {
	padding: 10px;
	background: white;
	box-shadow: 1px 1px 10px 0px #8080804d;
}

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
		
		* {
		font-family : 'seoul';
		} */
#scheduleTitle2 {
	font-size: 60px;
}

#scheduleDetail2 {
	font-size: 35px;
}

#img {
	position: relative;
	height: 30vh;
	background-size: cover;
}

#img-cover {
	background: url('/images/common/picnicback.jpg');
	background-size: 350px;
	opacity: .1;
	position: absolute;
	height: 100%;
	width: 100%;
	z-index: 1;
}

#img-cover:hover {
	opacity: .3;
}

#img .content {
	position: absolute;
	top: 55%;
	left: 50%;
	transform: translate(-50%, -50%);
	font-size: 5rem;
	color: white;
	z-index: 2;
	text-align: center;
}

/*���� �ٸ� ������ִ� css*/
.sidenav {
	width: 15%;
	position: absolute;
	z-index: -1;
	top: 400px;
 	left: 350px; 
	background: #eee;
	overflow-x: hidden;
	/*max-height : 60%;*/
/* 	border: 0.3px solid black; */
	transition : all 1s;
}

.sidenav-sliders{
	position : absolute;
	top : 400px;
	width : 56px;
	height : 56px;
	background : #aee485;
	left : 300px;
	transition : all 1s;
}

.sidenav-sliders:hover{
	cursor : pointer;
	left : 294px;
}


/*���� �� ž�϶� css*/
.sidenav1 {
	width: 15%;
	position: fixed;
	z-index: 1;
	top: 180px;
	left: 10px;
	background: #eee;
	overflow-x: hidden;
	/* max-height : 60%;*/
	border: 0.3px solid black;
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
	margin-left: 140px;
	/* Same width as the sidebar + left position in px */
	font-size: 28px; /* Increased text to enable scrolling */
	padding: 0px 10px;
}

@media screen and (max-height: 450px) {
	.sidenav {
		padding-top: 15px;
	}
	.sidenav a {
		font-size: 18px;
	}
}

/*��ũ�����̻ڰ� �����ֱ�(��ٱ���)*/
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
	/*   padding: 1px; */
}

.tabcontent {
	display: none;
	padding: 10px;
	height: 80%;
}

#Tmap_Control_ZoomBar_46 {
	z-index: 998;
}

#Tmap_Control_ScaleLine_47 {
	z-index: 998;
}

#News {
	background-color: #f5f5f5;
}

#Contact {
	background-color: #f5f5f5;
}

/*cartcontents�� �۾� �۰��ؼ� �̻ڰ� �ϴ� �κ�*/
td {
	font-size: 12px;
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

.openrange-box {
	margin-top: 5px;
	display: flex;
	justify-content: space-evenly;
}

.schedule-headers-box {
	display: flex;
	margin: 0px;
}

.header-side-lines {
	border-left: 1px solid #dcdcdca1;
	border-right: 1px solid #dcdcdca1;
}

.first-side-line {
	border-right: 1px solid #dcdcdca1;
}

.schedule-headers {
	flex: 1;
}
</style>

<script>

//���� ��¥ ���ϱ�
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


//�׺���̼� ���ִ� �� �Դϴ�!
$(function(){
	
	$('.clockpicker').clockpicker({
		donetext : '�Է�!'
	});
	
	$("#cart").on("click", function(){
		location.href = "/cart/getMyCartList";
	})
	
	$("#spot").on("click", function(){
		location.href = "/spot/getSearchSpot";
	})
	
	$("#reset").on("click", function(){
		reset();
	})
	
	initTmap();

});

// ���������� �������༭ ���� cart���� schedule�� �Ű� �ݴϴ�!!
// �ּҰ�
var wayPointAddress='';
// �̹�����
var wayPointImg='';
// �󼼳��밪
var wayPointDetail='';
// ����
var wayPointTitle='';

// ������Ű�� ���� flag
var w=2;

var options = {
		now: "00:00", //hh:mm 24 hour format only, defaults to current time
        twentyFour: true,  //Display 24 hour format, defaults to false
        upArrow: 'wickedpicker__controls__control-up',  //The up arrow class selector to use, for custom CSS
        downArrow: 'wickedpicker__controls__control-down', //The down arrow class selector to use, for custom CSS
        close: 'wickedpicker__close', //The close class selector to use, for custom CSS
        hoverState: 'hover-state', //The hover state class to use, for custom CSS
        title: '�ð��� �����ϼ���!', //The Wickedpicker's title,
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
		
		$(document).on("click", "#modalinsert",function(){
			// ��޿��� ���� ������ value�� �����ɴϴ�.
			var modalscheduleTitle = $("#modalscheduleTitle").val();
			// ���� ���񰪿� �ֽ��ϴ�.
			$("#scheduleTitle").val(modalscheduleTitle);
			$("#scheduleTitle2").text(modalscheduleTitle);
			// ��޿��� ���� ������ value�� �����ɴϴ�.
			var modalscheduleDetail = $("#modalscheduleDetail").val();
			// ���� ������ �ֽ��ϴ�.
			$("#scheduleDetail").val(modalscheduleDetail);
			$("#scheduleDetail2").text(modalscheduleDetail);
			// ��޿��� ���� ��¥ value�� �����ɴϴ�.
			var datepicker = $("#datepicker").val();
			// ���� ��¥ �ֽ��ϴ�.
			$("#scheduleDate").val(datepicker);
			// ��޿��� ���� img�� �����ɴϴ�.
			var modalscheduleImg = $("#modalscheduleImg").val();
			// ���� img �ֽ��ϴ�.
			$("#scheduleImg").val(modalscheduleImg);
			// ����� �ݽ��ϴ�.
			$("#myModal").modal('hide');
		});
			
 		$(window).scroll(function(){
	        var scrollLocation = $(window).scrollTop(); //�������� ��ũ�� ��
	        
	        if(scrollLocation > 200){ //ȭ���� ������ ��ٱ��� �߰��ϰ�
	        	$("body > div.sidenav").css("position", "fixed");
	        	$("body > div.sidenav").css("top", "120px");
	        	$("body > div.sidenav-sliders").css("position", "fixed");
	        	$("body > div.sidenav-sliders").css("top", "120px");
	        }else{ //ȭ���� ������ ��ٱ��� �������մϴ�.
	        	$("body > div.sidenav").css("position", "absolute");
	        	$("body > div.sidenav").css("top", "400px");
	        	$("body > div.sidenav-sliders").css("position", "absolute");
	        	$("body > div.sidenav-sliders").css("top", "400px");
	        }
	    }) 
	    
/* 	     $('body > div.sidenav-sliders').on('mouseover',function(){
	    	$('.sidenav').css('left','330px');
	    })
	    
	    $('body > div.sidenav-sliders').on('mouseleave',function(){
	    	$('.sidenav').css('left','350px');
	    })  */
			
	    var cartchk = true;
 		
 		$('.sidenav-sliders').on('click',function(){
 			
 			if(cartchk){
 				$(this).css('left','0px');
 				$('body > div.sidenav').css('left','56px');
 				cartchk = false;
 			}else{
 				$(this).css('left','300px');
 				$('body > div.sidenav').css('left','350px');
 				cartchk = true;
 			}
 			
 		})
	    
		$('#myModal').modal();
		
		 $("#modalButton").on("click", function(){
			 $('#myModal').modal();
		 });
		 
		// append�� ������ ��쿡�� �̷��� ��Ȯ�ϰ� �̸��� ����������� �����Ѵ�!!
		$(document).on('click','#navigation', function(){
		    setTimeout(function(){
		    	distance();
		    }, 200);
		}); //end of click
		
		  $( "#datepicker" ).datepicker({
		    dateFormat: 'yy-mm-dd',
		    prevText: '���� ��',
		    nextText: '���� ��',
		    monthNames: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
		    monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'],
		    dayNames: ['��','��','ȭ','��','��','��','��'],
		    dayNamesShort: ['��','��','ȭ','��','��','��','��'],
		    dayNamesMin: ['��','��','ȭ','��','��','��','��'],
		    showMonthAfterYear: true,
		    changeMonth: true,
		    changeYear: true,
		    yearSuffix: yyyy+'��',
		    minDate: new Date(today)
		  }); //end of datepicker
		  
		$('#timepicker').wickedpicker(options);
		
		$(document).on("click", "#modal", function(){
			$('#myModal').modal();
		});
		
		$(document).on("click", "#uploadButton", function(){
			$('#file').click();
		});
		
		// ���ȭ�� ������ ���ε�
		$('#img-cover').click(function (e) {
			e.preventDefault();
			$('#file').click();
		});
		
	});

//�̹��� �̸����� ���� ��ư�Դϴ�!!
function readURL(input){
	if (input.files && input.files[0]) { 
		var reader = new FileReader(); 
		reader.onload = function (e) { 
			$("#img").empty();
			$("#img").css('background-image','url('+e.target.result+')');
			$('#img-cover').css('background','none');
			var c = '';
			c += '<div class="content">'; 
			c += '  <div id="scheduleTitle2">'+$("#modalscheduleTitle").val()+'</div>';
			c += ' <div id="scheduleDetail2">'+$("#modalscheduleDetail").val()+'</div>';
/* 			c += '<button type="button" class="btn btn-success" id="modal">�������߰�</button>';
			c += ' <button type="button" class="btn btn-success" id="uploadButton">�����Ϻ���</button>'; */
			c += ' <input  style="display:none;" type="file" id="files" name="files" onchange="readURL(this)">'; 
			c += '</div>';
			c += ' <div id="img-cover"></div>';
		    $("#img").append(c);
			} 
		reader.readAsDataURL(input.files[0]); 
		}
}	

//�巡�׾� ��� ���� ���ε� �κ�
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
    
	////2. �巡�׾� ��� ���ε� /////
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
			c += '  <div id="scheduleTitle2">ȯ���մϴ� ��������Դϴ�!</div>';
			c += ' <div id="scheduleDetail2"></div>';
			/* c += '<button type="button" class="btn btn-success" id="modalButton">�������߰�</button>';
			c += ' <button type="button" class="btn btn-success" id="uploadButton">�����Ϻ���</button>'; */
			c += ' <input  style="display:block;" type="file" id="files" name="files" onchange="readURL(this)">'; 
			c += '</div>';
			c += ' <div id="img-cover"></div>';
		    $("#img").append(c);
		}
         //})
		reader.readAsDataURL(file);// File���� �о� ���� ����
		
		return false;
         
         if(file.length < 1)
              return;

    });

});

// cart�κ� Ŭ�������� ���� �ٲ�� �κ�
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

//�ٱ��� ����, ���� ���� ��ũ��Ʈ
$(function(){
	
   $("button[id^='updateCart']").on("click", function(){
      var cartNo = $(this).closest("table").attr("class");
      var cartTitle = $("."+cartNo).find("th[id^='cartTitle']").text();
      var cartDetail = $("."+cartNo).find("td[id^='cartDetail']").text();

      swal({
           title: cartTitle+' ��� ���� ����',
           text: '������ ���Ͻô� ���������� �Է����ֽñ� �ٶ��ϴ�.',
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
                       title: "���� �Ϸ�!",
                       text: inputData+"�� ���� �����Ǿ����ϴ�!",
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
            title: "��Ҹ� ���� �����Ͻðڽ��ϱ�?",
            text: "�����Ͻø� ������ �Ұ��մϴ�.",
            icon: "warning",
            buttons: ["���", "����"],
            dangerMode: true,
          })
          .then((willDelete) => {
            if (willDelete) {
               $.ajax({
                  url : "/restcart/deleteCart/"+cartNo,
                  method : "POST",
                  success : function(){
                     swal("�����Ǿ����ϴ�.");
                     $("."+cartNo).remove();
                  }
               }) //e.o.ajax
            } else {
              swal("����Ͽ����ϴ�.");
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
<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>
</head>
<body>

	<%@include file="/layout/new_toolbar.jsp"%>
	<div class="sidenav-sliders"></div>
	<div class="sidenav">
		<button class="tablink" onclick="openPage('Home', this, '#45ba31')"
			id="defaultOpen">��ҹٱ���</button>
		<button class="tablink" onclick="openPage('Contact', this, '#45ba31')">��õ�ٱ���</button>

		<input class="form-control" type="file" id="fileImg" name="fileImg"
			style="display: none">

		<div id="Home" class="tabcontent">
			<br />
			<c:set var="i" value="0" />
			<c:forEach var="cart" items="${cart}">
				<c:set var="i" value="${i+1}" />
				<div>
					<table class="${cart.cartNo}" style="margin-buttom: 15px">
						<tr class="ct_list_pop">
						<tr>
							<td rowspan="3"><i class="material-icons">place</i></td>
							<td rowspan="3">
								<!-- �̹��� �̸����⸦ ���� img �±� --> <c:if
									test="${cart.cartImg.contains('http://')}">
									<img src="${cart.cartImg}" class="${cart.cartNo}" width="50"
										height="50" id="fakeCartImg${i}">
								</c:if> <c:if test="${!cart.cartImg.contains('http://')}">
									<img src="/images/spot/${cart.cartImg}" class="${cart.cartNo}"
										width="50" height="50" id="fakeCartImg${i}">
								</c:if> <!-- ���� �����Ͱ� �Ѿ�� img �±� --> <img style="display: none;"
								src="/images/spot/${cart.cartImg}" width="50" height="50"
								id="cartImg${i}" class="${cart.cartNo}">
							</td>
							<th id="cartTitle${i}">${cart.cartTitle}</th>
							<td rowspan="3"><div class="dropdown">
									<button class="dropdown-toggle" type="button" id="menu1"
										data-toggle="dropdown">
										���������� <span class="caret"></span>
									</button>
									<ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
										<li><a onclick="addToSchedule('${i}',0)">ù��°</a></li>
										<li><a onclick="addToSchedule('${i}',1)">�ι�°</a></li>
										<li><a onclick="addToSchedule('${i}',2)">����°</a></li>
										<li><a onclick="addToSchedule('${i}',3)">�׹�°</a></li>
										<li><a onclick="addToSchedule('${i}',4)">�ټ���°</a></li>
										<li><a onclick="addToSchedule('${i}',5)">������°</a></li>
										<li><a onclick="addToSchedule('${i}',6)">�ϰ���°</a></li>
									</ul>
								</div> <!-- �������׽�Ʈ -->
								<button class="btn" type="button" id="updateCart">����</button>
								<button class="btn" type="button" id="deleteCart">����</button></td>
						</tr>
						<span id="cartContents">
							<tr>
								<td width="200px" id="cartAddress${i}">${cart.cartAddress}</td>
							</tr>
							<tr>
								<td width="200px" id="cartDetail${i}">${cart.cartDetail}</td>
							</tr> <input type="hidden" id="cartX${i}" value="${cart.cartX}">
							<input type="hidden" id="cartY${i}" value="${cart.cartY}">
						</span>
					</table>
				</div>
			</c:forEach>
			<button class="btn success" id="cartNavi">��ٱ���..</button>
		</div>

		<div id="Contact" class="tabcontent">
			<br />
			<c:set var="i" value="0" />
			<c:forEach var="recommand" items="${recommand}">
				<c:set var="i" value="${i+1}" />
				<div>
					<table class="${recommand.spotNo}" style="margin-buttom: 15px">
						<tr class="ct_list_pop">
						<tr>
							<td rowspan="3"><i class="material-icons">place</i></td>
							<td rowspan="3"><c:if
									test="${fn:length(recommand.spotImg) >= 30 }">
									<img src="${recommand.spotImg}" class="img-rounded" width="50"
										height="50" id="recommandImg${i}">
								</c:if> <c:if test="${fn:length(recommand.spotImg) < 30 }">
									<img src="/images/spot/${recommand.spotImg}"
										class="img-rounded" width="50" height="50"
										id="recommandImg${i}">
								</c:if></td>
							<th id="recommandTitle${i}">${recommand.spotTitle}</th>
							<td rowspan="3"><div class="dropdown">
									<button class="dropdown-toggle" type="button" id="menu1"
										data-toggle="dropdown">
										���������� <span class="caret"></span>
									</button>
									<ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
										<li><a onclick="addToSchedule2('${i}',0)">ù��°</a></li>
										<li><a onclick="addToSchedule2('${i}',1)">�ι�°</a></li>
										<li><a onclick="addToSchedule2('${i}',2)">����°</a></li>
										<li><a onclick="addToSchedule2('${i}',3)">�׹�°</a></li>
										<li><a onclick="addToSchedule2('${i}',4)">�ټ���°</a></li>
										<li><a onclick="addToSchedule2('${i}',5)">������°</a></li>
										<li><a onclick="addToSchedule2('${i}',6)">�ϰ���°</a></li>
									</ul>
								</div></td>
						</tr>
						<span id="cartContents">
							<tr>
								<td width="200px" id="recommandAddress${i}">${recommand.spotAddress}</td>
							</tr>
							<tr>
								<td width="200px" id="recommandDetail${i}">${recommand.spotDetail}</td>
							</tr> <input type="hidden" id="recommandX${i}"
							value="${recommand.spotX}"> <input type="hidden"
							id="recommandY${i}" value="${recommand.spotY}">
						</span>
					</table>
				</div>
			</c:forEach>
			<button class="btn success" id="spot">��Ұ˻�..</button>
		</div>

	</div>
	<form enctype="multipart/form-data">

		<div id="img" style="background: #abb6bb">
			<div class="content">
				<div id="scheduleTitle2">ȯ���մϴ� ��������Դϴ�!</div>
				<div id="scheduleDetail2"></div>
				<!-- <button type="button" class="btn btn-primary" id="modalButton">Ÿ��Ʋ����</button>
				<button type="button" class="btn btn-default" id="uploadButton">�����Ϻ���</button> -->
			</div>
			<div id="img-cover"></div>
		</div>
		<!-- input���� ���ܼ� ó���ϱ� -->
		<input type="file" id="file" name="file" onchange="readURL(this)"
			style="display: none;">

		<!-- ó�� ����� �������� ������ ���� modal â start -->
		<%-- 		<div class="modal" id="myModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">������ ������?</h4>
					</div>
					<div class="modal-body">
						<div class="form-group">
							<label for="scheduleTitle">�������� ������ �����ּ���.</label> <input
								type="text" class="form-control" id="modalscheduleTitle"
								placeholder="������ �Է����ּ���!">
						</div>
						<div class="form-group">
							<label for="scheduleDetail">������������ ������ �������ּ���</label> <input
								type="text" class="form-control" id="modalscheduleDetail"
								placeholder="��Ҹ� ������ �������ּ���!">
						</div>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="waves-effect waves-light btn"
							id="modalinsert">�� ��</button>
					</div>
				</div>
			</div>
		</div> --%>

		<div class="container container-add-schedule">
			<hr />

			<div class="form-group row schedule-headers-box">
				<div class="col-md-3 col-xs-12 schedule-headers first-side-line">
					<label for="scheduleDate">���� ������ ������?</label> <input type="text"
						class="form-control" id="datepicker"
						placeholder="Ŭ���Ͽ� ��¥�� �������ּ���!" value="${date}" readOnly>
				</div>
				<div class="col-md-3 col-xs-12 schedule-headers">
					<p>��߽ð��� �����ΰ���?</p>
					<div class="input-group clockpicker">
						<input type="text" class="form-control" value="09:00" readonly>
						<span class="input-group-addon"> <span
							class="glyphicon glyphicon-time"> </span>
						</span>
					</div>
				</div>
				<div class="col-md-3 col-xs-12 header-side-lines schedule-headers">
					<p>���������� �������ּ���!</p>
					<div class="openrange-box">
						<input type="radio" name="openRange" value="0" checked>��ΰ���
						<input type="radio" name="openRange" value="1">ģ������ <input
							type="radio" name="openRange" value="2">��������
					</div>
				</div>
				<div class="col-md-4 col-xs-12 schedule-headers">
					<p>�������� �߰��ұ��?</p>
					<div class="waypoint-buttons-box">
						<span class="waves-light btn col s5" type="button"
							style="background-color: rgb(59, 128, 187); color: white;"
							onclick="addWayPoint()">+ ������ �߰�</span> <span
							class="waves-light btn col s5" type="button"
							style="background-color: rgba(163, 172, 179, 0.5); color: white;"
							onclick="deleteWayPoint()">- ������ ����</span>
					</div>
				</div>
			</div>

			<hr />

			<div id="map"></div>

			<hr />



			<input type="hidden" name="userId"
				value="${sessionScope.user.userId}"> <input type="hidden"
				id="scheduleTitle" name="scheduleTitle"> <input
				type="hidden" id="scheduleDetail" name="scheduleDetail"> <input
				type="hidden" id="scheduleDate" name="scheduleDate"> <input
				type="hidden" id="scheduleImg" name="scheduleImg"> <input
				type="hidden" id="transportationCode" name="transportationCode"
				value="1">

			<table class="table">
				<thead>
					<tr>
						<th width="15%">����</th>
						<th width="20%">�ּ�</th>
						<th width="20%">�󼼼���</th>
						<th width="5%">�̵��ð�</th>
						<th width="10%">��ã��</th>
					</tr>
				</thead>
				<tbody id="wayPoint">
					<tr id="wayPoint0">
						<td align="center"><input class="form-control" type="text"
							name="wayPoints[0].wayPointTitle" id="wayPointTitle0" /></td>
						<td align="center"><input class="form-control" type="text"
							name="wayPoints[0].wayPointAddress" id="wayPointAddress0"></td>
						<td align="center"><input class="form-control" type="text"
							name="wayPoints[0].wayPointDetail" id="wayPointDetail0"
							value="��������!" /></td>
						<div class="col-xs-4"></div>
						<td align="center"><input
							class="waves-effect waves-light btn col s5" type="button"
							style="background-color: rgba(250, 170, 50, 0.5);"
							id="navigation'" value="�����"
							onclick="search('#wayPointAddress0')"></td>
						<input type="hidden" name="wayPoints[0].wayPointImg"
							id="wayPointImg0" />
						<input type="hidden" name="wayPoints[0].wayPointNav"
							id="wayPointNav0" />
						<input type="hidden" name="wayPoints[0].wayPointX" id="wayPointX0" />
						<input type="hidden" name="wayPoints[0].wayPointY" id="wayPointY0" />
					</tr>
					<tr>
						<td align="center"><input class="form-control" type="text"
							name="wayPoints[1].wayPointTitle" id="wayPointTitle1" /></td>
						<td align="center"><input class="form-control" type="text"
							name="wayPoints[1].wayPointAddress" id="wayPointAddress1"></td>
						<td align="center"><input class="form-control" type="text"
							name="wayPoints[1].wayPointDetail" id="wayPointDetail1" /></td>
						<div class="col-xs-4">
							<td align="center"><input class="form-control" type="text"
								name="wayPoints[1].moveTime" id="wayPointMoveTime1" readonly /></td>
						</div>
						<td align="center"><input
							class="waves-effect waves-light btn col s5" type="button"
							style="background-color: rgba(250, 170, 50, 0.5);"
							id="navigation" value="��ã��" onclick="search('#wayPointAddress1')"></td>
						<input type="hidden" name="wayPoints[1].wayPointImg"
							id="wayPointImg1" />
						<input type="hidden" name="wayPoints[1].wayPointNav"
							id="wayPointNav1" />
						<input type="hidden" name="wayPoints[1].wayPointX" id="wayPointX1" />
						<input type="hidden" name="wayPoints[1].wayPointY" id="wayPointY1" />
					</tr>
				</tbody>
			</table>

			<hr />
			<button class="waves-light btn col s5" type="button"
				style="background-color: rgba(250, 170, 50, 0.5); float: right;"
				id="addSchedule">���</button>
		</div>
	</form>

</body>
</html>