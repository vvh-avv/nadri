<%@ page language="java" pageEncoding="EUC-KR"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/css/chatRoom.css">
<link rel="stylesheet" href="/css/chatRoomInner.css">

<script>
function deleteIframe(chatRoomNo) {
	alert( chatRoomNo.substring( chatRoomNo.indexOf('m') + 1 , chatRoomNo.length ) ) ;
	$('#iframe' + chatRoomNo.substring( chatRoomNo.indexOf('m') + 1 , chatRoomNo.length )).html('') ;
}


function makeChat(chatRoom) {
	var counter = 0 ;
	senderId = "<c:out value="${user.userId}" />" ;
	chatRoomCountFlag = 0 ;
		if (chatRoomCountFlag == 0) {
			$('body').append (
					'<iframe id="iframe' + chatRoomNo + '" allowTransparency="true" style="border: 0px' + 
					' solid transparent; position:fixed; bottom:0 ; left: 70%; width: 24%; height: 417px; background:none transparent; "' +
					' src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + 
					'&receiverId=' + receiverId + '"/>' ) ;
				chatRoomCountFlag++;
		} //End of if
		else if (chatRoomCountFlag == 1) {
			$('body').append (
					'<iframe id="iframe' + chatRoomNo + '"  allowTransparency="true" style="border: 0px' + 
					' solid transparent; position:fixed; bottom:0 ; left: 40%; width: 24%; height: 417px; background:none transparent; "' +
					' src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + 
					'&receiverId=' + receiverId + '"/>' );
			chatRoomCountFlag++;
		} //End of else if
		else if (chatRoomCountFlag == 2) {
			$('body').append (
					'<iframe id="iframe' + chatRoomNo + '"  allowTransparency="true" style="border: 0px' + 
					' solid transparent; position:fixed; bottom:0 ; left: 10%; width: 24%; height: 417px; background:none transparent; "' +
					' src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + 
					'&receiverId=' + receiverId + '"/>' );
				chatRoomCountFlag++;
		} else {
			alert('채팅창은 최대 3개 까지만 가능합니다.') ;
		}
}

//새로고침해도 채팅방 유지
// $(window).bind({
//     beforeunload: function(ev) {
//         ev.preventDefault();
//     } ,
//     unload: function(ev) {
//         ev.preventDefault();
//     }
// }) ;

//jQuery 시작
$(function() {
	var chatRoomList = '' ;
	var noticeList = '' ;
	var flag = 0 ;
	var chatRoomCountFlag = 0 ;
	const chatRoomCount = 5 ;
	
	$('#noticeRoomList').on('click' , function() {
		if (flag == 0) {
			
			$.ajax({
				url: "/notice/json/getNoticeList" ,
				type : "POST",
				async : false ,
				success : function(data) {
					
					for(var i = 0 ; i < data.noticeList.length ; i++ ) {
						
						noticeList += '<li class="active bounceInDown">' +
	                	'<a href="#" class="clearfix"><img style="float: left;" src="../images/profile/' + 
						data.noticeList[i].userProfileImg + '" alt="" class="img-circle">' +
						'<div class="friend-name">' +
						'<strong>' + data.noticeList[i].senderId + '</strong>' +
            		    '</div>' +
            		    '<div class="last-message text-muted">' + data.noticeList[i].content + '</div>' +
            			'<input type="hidden" id="noticeCode" value="' + data.noticeList[i].noticeCode + '"/>' +
            			'<input type="hidden" id="otherPk" value="' + data.noticeList[i].otherPk + '"/>' +
            			'<input type="hidden" id="noticeNo" value="' + data.noticeList[i].noticeNo + '"/>' +
            			'<input type="hidden" id="noticeMap" value="' + data.noticeMap + '"/></a></li>' ;
					}
				} , //End of success
				error : function(error) {
					alert("실패") ;
				} //End of error
			}) ; //End of ajax
			$("#noticeFriendList").append(noticeList) ;
			$("#noticeContainer").css("display", "block") ;
			flag = 1 ;
			noticeList = '' ;
		} //End of if
		else if(flag == 1) {
			$("#noticeFriendList").html('') ;
			$("#noticeContainer").css("display", "none") ;
			flag = 0 ;
		}
	}) ; //End of click
	
	
	//after click notice
	$('#noticeFriendList').on( 'click', '.clearfix', function() {
				flag = 0 ;

				var senderId = "<c:out value="${ user.userId }"/>"
				var receiverId = $(this).children('.friend-name').text().trim() ;
				var otherPk = $(this).children('#otherPk').val() ;
				var noticeCode = $(this).children('#noticeCode').val() ;
				var noticeNo = $(this).children('#noticeNo').val() ;
				var noticeMap = $(this).children('#noticeMap').val() ;
				
				var json = {
					"senderId" :  senderId  ,
					"receiverId" : receiverId ,
					"otherPk" : otherPk ,
					"noticeCode" : noticeCode } ;
				
				//notice 내용 업데이트 시키기(읽음으로.)
				$.ajax ({
					type : "GET",
					url : "/notice/json/updateNotice?noticeNo=" + noticeNo,
					async : false ,
					success : function(data) {
						alert( data ) ;
						alert( noticeCode ) ;
						switch (noticeCode) {
						//신고
						case '0' :  
									break ;
						//좋아요
						case '1' :
							alert('좋아요 실행') ;
							self.location = "/board/getBoard?boardNo=" + otherPk ;
									break ;
						//친구요청
						case '2' :
									break ;
						//태그									
						case '3' :
							self.location = "/board/getBoard?boardNo=" + otherPk ;
							break ;
						default :
							alert('디폴트실행..') ;
						}
						
						noticeCode = $(this).children('#noticeCode').val() ;
					} ,
					error : function(error) {
						alert( "에러 : " + error ) ; 
					}
				}) ; //End of ajax
				
				$("#noticeFriendList").html('') ;
				$("#noticeContainer").css("display", "none") ;
	}) ;
	
	
	//*채팅방 클릭시
	$('#chatFriendList').on( 'click', '.clearfix', function() {
				flag = 0 ;

				var senderId = "<c:out value="${ user.userId }"/>"
				var receiverId = $(this).children('.friend-name').text().trim() ;
				var chatRoomNo = $(this).children('input').val() ;
				
				var json = {
					"senderId" :  senderId  ,
					"chatRoomNo" :  chatRoomNo
				} ;
				
				//채팅방 내용 업데이트 시키기(읽음으로.)
				$.ajax ({
					type : "GET",
					url : "/chatRoom/json/updateChat",
					datatype : 'json' ,
					async : false ,
					contentType : "application/json; charset=UTF-8" ,
					data : json ,
					success : function(data) {
					} ,
					error : function(error) {
						alert( error ) ; 
					}
				}) ; //End of ajax
				
				if (chatRoomCountFlag == 0) {
					$('body').append (
						'<iframe id="iframe' + chatRoomNo + '"  allowTransparency="true" style="border: 0px' + 
						' solid transparent; position:fixed; bottom:0 ; left: 70%; width: 24%; height: 417px; background:none transparent; "' +
						' src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + 
						'&receiverId=' + receiverId + '"/>' );
					chatRoomCountFlag++;
				} //End of if
				else if (chatRoomCountFlag == 1) {
					$('body').append (
							'<iframe id="iframe' + chatRoomNo + '"  allowTransparency="true" style="border: 0px' + 
							' solid transparent; position:fixed; bottom:0 ; left: 40%; width: 24%; height: 417px; background:none transparent; "' +
							' src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + 
							'&receiverId=' + receiverId + '"/>' );
					chatRoomCountFlag++;
				} //End of else if
				else if (chatRoomCountFlag == 2) {
					$('body').append (
							'<iframe id="iframe' + chatRoomNo + '"  allowTransparency="true" style="border: 0px' + 
							' solid transparent; position:fixed; bottom:0 ; left: 10%; width: 24%; height: 417px; background:none transparent; "' +
							' src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + 
							'&receiverId=' + receiverId + '"/>' );
						chatRoomCountFlag++;
				}
				else {
					alert('채팅창은 최대 3개 까지만 가능합니다.') ;
				}
				//채팅방은 초기화
				$("#chatFriendList").html('') ;
				$("#chatRoomContainer").css("display", "none") ;
	}) ; //End of on click 
	
//*창 떠있을 때, 다른 화면 누르면 닫히는 기능.
	$('body').click(function(e) {
		
// 		if ($("#noticeContainer").css('display') == 'block') {
// 			if (!($("#noticeContainer").has(e.target).length) && !($("#noticeList").has(e.target).length)) {
// 				$(".friendAlert").html('') ;
// 				$("#noticeContainer").css("display", "none") ;
// 				flag = 0 ;
// 				noticeList = '' ;
// 			}
// 		}
		
		if ($("#chatRoomContainer").css('display') == 'block') {
			if (!($("#chatRoomContainer").has(e.target).length) && !($("#chatRoomList").has(e.target).length) ) {
				$("#chatFriendList").html('') ;
				$("#chatRoomContainer").css("display", "none") ;
				flag = 0 ;
				chatRoomList = '' ;
			}
		}
	}) ;

	$("#chatRoomList").on( 'click' , function() {
			//처음 채팅방 눌렀을 때
			if (flag == 0) {
				$.ajax({ type : "POST", 
				url : "/chatRoom/json/getChatRoom",
				async : false,
				success : function(data) {
					today = new Date() ;

					for (var i = 0; i < chatRoomCount; i++) {
						
						if( today.getDate() - data[i].sending_date.substring(8,10) != 0) {
							data[i].sending_date = data[i].sending_date.substring( 0 , 10 ) ;
						}
						chatRoomList += 
							'<li class="active bounceInDown">' +
		                	'<a href="#" class="clearfix">' ; 		
                		    var userImg = data[i].chatRoom.userProfileImg.split(',') ;
                		    
                		    switch ( data[i].chatRoom.userProfileImg.split(',').length ) {
                		    case 1 : 
                		    	chatRoomList +=  '<img style="float: left;" src="../images/profile/' + data[i].chatRoom.userProfileImg + '" alt="" class="img-circle">' ;
                		    	break ;
                		    case 4 : 
                		    	chatRoomList += '<div class="big-box"style="float: left;">' +
                		    	'<div class="small-box1" style="background : url(' + 
                		    	'../images/profile/' + userImg[0] + ') center no-repeat' +
                		    	' background-size : 10%;"></div>' +
                		        '<div class="small-box1" style="background : url(' +
                		        '../images/profile/' + userImg[1] + ') center no-repeat;' +
                		        ' background-size : 300px; left:50%;"></div>' +
                		        '<div class="small-box1" style="background : url(' +
                		        '../images/profile/' + userImg[2] + ') center no-repeat;' +
                		        ' background-size : 300px; top:50%;"></div>' +
                		        '<div class="small-box1" style="background : url(' +
                		        ' ../images/profile/' + userImg[3] +   ' ) center no-repeat;' +
                		        ' background-size : 300px; top:50%; left:50%;"></div></div>'
                		    	break ;
                		    case 3 :
                   		    	chatRoomList += '<div class="big-box"style="float: left;">' +
                		    	'<div class="small-box1" style="background : url(' + 
                		    	'../images/profile/' + userImg[0] + ') center no-repeat' +
                		    	' background-size : 10%;"></div>' +
                		        '<div class="small-box1" style="background : url(' +
                		        '../images/profile/' + userImg[1] + ') center no-repeat;' +
                		        ' background-size : 300px; left:50%;"></div>' +
                		        '<div class="small-box1" style="background : url(' +
                		        '../images/profile/' + userImg[2] + ') center no-repeat;' +
                		        ' background-size : cover; top:50%; width:100%;"></div></div>' ;
                		    	break ;
                		    case 2 : 
                		    	chatRoomList += '<div class="big-box"style="float: left;">' +
                		    	'<div class="small-box1" style="height : 100%; background : url(' + 
                		    	'../images/profile/' + userImg[0] + ') center no-repeat' +
                		    	' background-size : cover;"></div>' +
                		        '<div class="small-box1" style="height : 100%; background : url(' +
                		        '../images/profile/' + userImg[1] + ') center no-repeat;' +
                		        ' background-size : cover; left:50%;"></div></div>'
                		    	break ;
                		    }
                		    chatRoomList +=  '<div class="friend-name">' +
							'<strong>' + data[i].chatRoom.userId + '</strong>' +
                		    '</div>' +
                		    '<div class="last-message text-muted">' + data[i].message + '</div>' +
                			'<small class="time text-muted">' + data[i].sending_date.substring( 11 , 16 ) + '</small>' +
                			'<input type="hidden" value="' + data[i].chatRoom.chatRoomNo + '"/>' ;
                			// 읽음 유무 판단
                			if( data[i].chatRoom.flag > 0) {
	                			chatRoomList += '<small class="chat-alert label label-danger" align="middle">'+ data[i].chatRoom.flag + '</small></a></li>' ; 	
                			} else {
                				chatRoomList += '</a></li>' ;
                			}
	                		    
					} //End of for
				} , //End of success
				error : function(error) {
					alert("실패") ;
				} //End of error
			}) ; //End of ajax
			
			$("#chatFriendList").append(chatRoomList) ;
			$("#chatRoomContainer").css("display", "block") ;
			flag = 1 ;
			chatRoomList = '' ;
		} //End of if
		else if(flag == 1) {
			$("#chatFriendList").html('') ;
			$("#chatRoomContainer").css("display", "none") ;
			flag = 0 ;
		}
	}) ; //End of click
	
	//send notice
	function noticeSending(noticeJson) {
		
		noticeSendingWs(noticeJson) ;
		alert('성공') ;
		
	}
	
}) ; //End of jQuery

/**************************************WebSocket******************************************/
var userId = "${sessionScope.user.userId}"; //"<c:out value="${user.userId}"/>";
if (userId != null) {
	var webSocket = new WebSocket("ws://localhost:8080/websocket/" + userId ) ;

	//웹 소켓이 연결되었을 때 호출되는 이벤트
	webSocket.onopen = function() {
//			alert('웹 소켓 연결 성공.') ;
	} ;

	//웹 소켓이 에러가 났을 때 호출되는 이벤트
	webSocket.onerror = function(error) {
//			alert('웹 소켓 연결 에러.'  + error ) ;
	} ;

	webSocket.onclose = function() {
//			alert('웹 소켓 연결 끊김');
	};

	//웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트
	webSocket.onmessage = function(message) {
		alert( message.data ) ;
		$("#msg_count").text(++chatCount) ;
	} ;
	
	function noticeSendingWs(userId) {
		alert('noticeSendingWs') ;
		webSocket.send(userId) ;
	} ;
	
	
	//cross browser 
	window.addEventListener('message', function(event) {
		if ( event.origin.indexOf('http://localhost:3000/') ) {
			// The data has been sent from your site
			if( event.data.indexOf('closeChatRoom') != -1 ) {
				alert( event.data) ;
				deleteIframe(event.data) ;
			} else {
				webSocket.send( event.data ) ;	
			}
			
		} else {
			alert('다른사이트에서 접근') ;
		}
	}) ;

}//End of websocket if

</script>
<style>
.big-box{
   width:45px ;
   height:45px ;
   border:6px solid #757575;
   position:relative;     /* 중요한 부분 이미지를 묶고있는 가장 큰 엘레먼트가 반드시 이 속성가져야함 */
   overflow:hidden; /* 안에 넣은 이미지가 넘치지않게 하는 중요요소 */
   border-radius : 50%;
   border: 1px solid transparent ;
}

.small-box1{
   position : absolute;
   width:50%;
   height:50%;  
}

</style>
<div class="topbar">

   <a href="/index.jsp"> 
   <img src="/images/common/title_colored.png" class="title">
   </a>
   
   

   <div class="collapse navbar-collapse">
      <input type="text" class="searcher" placeholder="검색어를 입력해주세요." name="searchKeyword">
      <div class="sidemenu">
      
         <c:if test="${!empty user}">
            <c:if test="${user.role==0}">
            	
            	<a href="#" id="noticeRoomList">
               <img src="/images/common/bell_white.png" class="icons bell">
               </a>
               
				<a href="#" id="chatRoomList">
               <img src="/images/common/chat_white.png" class="icons chat" style="top:12%; right:10%;">
               </a>
      		 
              <img src="/images/profile/${user.profileImg}"
                  class="profile" title="let's go to my page" style="">
               
            </c:if>
            
            <c:if test="${user.role==1}">
               
               <img src="/images/common/chat_white.png" class="icons chat">
               <img src="/images/profile/${user.profileImg}" class="profile" title="let's go to Admin page">
            </c:if>
         </c:if>
         
         
         
         
         
         
         
      </div>
      <c:if test="${empty user}">
         <div class="right-box">
            <img src="/images/user/join_white.png" class="join"> 
            <img src="/images/user/login_white.png" class="login">
         </div>
      </c:if>
      <div class="topmenus">
         <span class="topele spots" style="font-family: 'seoul';">나들이백과</span> 
         <span class="topele boards" style="font-family: 'seoul';">게시판</span> 
         <span class="topele schedules" style="font-family: 'seoul';">일정작성</span>
      </div>
   </div>
   <div class="toggleBox">
      <img src="/images/common/more_white.png" class="menuExpand" style="transform:rotate(90deg)"> 
      <img src="/images/common/search_white.png" class="searchExpand">
   </div>
</div>
<div class="floatbackground"></div>
<div class="sidecatalogue">

   <div class="closeAll">X</div>
   
   <div class="profileSection">
      <img src="/images/profile/${user.profileImg}" class="profileImg">
      <div class="row" style="display:flex; justify-content: center; margin-top:20px;">
         <div class="col-md-12" style="text-align:center; font-size:3vw; font-weight:700;">${user.userName}</div>
      </div>
         <div class="col-md-12" style="text-align:center; font-size: 1vw;">${user.userId}</div>
   </div>
   
	<div class="notificationContainer" style="display: none; top : 12% ; right : 3% ;" id="chatRoomContainer">
		<div id="notificationTitle">채팅방</div>
		<div class="col-md-15 bg-white">
			<ul class="friend-list" id="chatFriendList">
				<!--             여기에 채팅방 리스트가 출력됨. -->
			</ul>
		</div>
	</div>
	
	<div class="notificationContainer" style="display: none; top : 12% ; right : 3% ;" id="noticeContainer">
		<div id="notificationTitle">알림</div>
		<div class="col-md-15 bg-white">
			<ul class="friend-list" id="noticeFriendList">
				<!--             여기에 채팅방 리스트가 출력됨. -->
			</ul>
		</div>
	</div>	
	
	
	
</div>
<div>

<input type="text" class="mobSearcher" placeholder="검색어를 입력해주세요."></div>

<div style="display:none" id="loadStatus">
   <img src="/images/common/load.gif" style="width:40%; margin:5% 30% 20% 30%;">
</div>