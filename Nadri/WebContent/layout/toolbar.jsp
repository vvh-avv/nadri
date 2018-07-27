<%@ page language="java" pageEncoding="EUC-KR"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/css/chatRoom.css">
<link rel="stylesheet" href="/css/chatRoomInner.css">

<script>
var chatCount = 0;
$(function() {
	var chatRoomList = '' ;
	var noticeList = '' ;
	var flag = 0 ;
	var chatRoomCountFlag = 0 ;
	const chatRoomCount = 5 ;
	
	$('#noticeList').on('click' , function() {
		if (flag == 0) {
			$.ajax({
				url: "/notice/json/getNoticeList" ,
				type : "POST",
				async : false ,
				success : function(data) {
					for(var i = 0 ; i < data.noticeList.length ; i++ ) {
						noticeList += '<li class="active bounceInDown">' +
    	            	'<a href="#" class="clearfix">' +
        				'<img style="float: left;" src="https://bootdey.com/img/Content/user_1.jpg" alt="" class="img-circle">' + 		
        			    '<div class="friend-name">' +
						'<strong>' + data.noticeList[i].senderId + '</strong>' +
        		    	'</div>' +
        		    	'<div class="last-message text-muted">' + data.noticeList[i].content + '</div>' +
	        			'<input type="hidden" value="' + data.noticeList[i].notice+ '"/>' ;	
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
		} // End of if
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
				var receiverId = $(this).children('').text().trim() ;
				
				var json = {
					"senderId" :  senderId  ,
					"receiverId" : receiverId ,
					
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
					$('body')	.append (
						'<iframe allowTransparency="true" style="border: 1px solid transparent; position:fixed; bottom:0 ; width: 95%; height: 100%; background:none transparent; " '
						+ 'src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + '&receiverId=' + receiverId + '"/>' ) ;
					chatRoomCountFlag++;
				} //End of if
				else if (chatRoomCountFlag == 1) {
					$('body')	.append (
							'<iframe allowTransparency="true" style="border: 1px solid transparent; position:fixed; bottom:0 ; width: 65%; height: 100%; background:none transparent; " '
							+ 'src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + '&receiverId=' + receiverId + '"/>' ) ;
					chatRoomCountFlag++;
				} //End of else if
				else if (chatRoomCountFlag == 2) {
					$('body')	.append (
							'<iframe allowTransparency="true" style="border: 1px solid transparent; position:fixed; bottom:0 ; width: 35%; height: 100%; background:none transparent; " '
							+ 'src="http://localhost:3000/?chatRoomNo=' + chatRoomNo + '&senderId=' + senderId + '&receiverId=' + receiverId + '"/>' ) ;
						chatRoomCountFlag++;
				}
				else {
					alert('채팅창은 최대 3개 까지만 가능합니다.') ;
				}
				
				$("#chatFriendList").html('') ;
				$("#chatRoomContainer").css("display", "none") ;
	}) ; //End of on click 
	
	//*창 떠있을 때, 다른 화면 누르면 닫히는 기능.
	$('body').click(function(e) {
		
		if ($("#noticeContainer").css('display') == 'block') {
			if (!($("#noticeContainer").has(e.target).length) && !($("#noticeList").has(e.target).length)) {
				$("#noticeFriendList").html('') ;
				$("#noticeContainer").css("display", "none") ;
				flag = 0 ;
				noticeList = '' ;
			}
		}
		
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
		                	'<a href="#" class="clearfix">' +
                			'<img style="float: left;" src="https://bootdey.com/img/Content/user_1.jpg" alt="" class="img-circle">' + 		
                		    '<div class="friend-name">' +
							'<strong>' + data[i].chatRoom.userId + '</strong>' +
                		    '</div>' +
                		    '<div class="last-message text-muted">' + data[i].message + '</div>' +
                			'<small class="time text-muted">' + data[i].sending_date + '</small>' +
                			'<input type="hidden" value="' + data[i].chatRoom.chatRoomNo + '"/>' ;
                			// 읽음 유무 판단
                			if( data[i].chatRoom.flag > 0) {
	                			chatRoomList += '<small class="chat-alert label label-danger" align="middle">'+ data[i].chatRoom.flag + '</small></a></li>' ; 	
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
		var aa = {
				'"senderId"' : '"user02"' ,
				'"receiverId"' : '"user01"' ,  
				'"noticeCode"' : '"0"' 
		} ;
		
		$.ajax({
			url : "/notice/json/addNotice" ,
			type : "POST",
			datatype : 'json' ,
			async : false ,
			data : aa ,
			contentType : "application/json; charset=UTF-8",
			success : function() {
				noticeSendingWs("user01") ;
				alert('성공') ;
			} ,
			error : function( error ) {
				alert('에러 : ' + error ) ;
			}
		}) ;
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
		alert('알림도착!') ;
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
			//채팅 프로토콜
			var protocol = 2 ;
			webSocket.send(event.data ) ;
		} else {
			alert('다른사이트에서 접근') ;
		}
	}) ;

}//End of websocket if

</script>
<div class="topbar">

   <a href="/"> 
   <img src="/images/common/title_colored.png" class="title">
   </a>
   
   

   <div class="collapse navbar-collapse">
      <input type="text" class="searcher" placeholder="검색어를 입력해주세요."
         name="searchKeyword">
      <div class="sidemenu">
         <c:if test="${!empty user}">
            <c:if test="${user.role==0}">
               <img src="/images/common/chat_white.png" class="icons chat">
               <a href="/user/listUser"> <img
                  src="/images/profile/${user.profileImg}"
                  class="profile" title="let's go to my page">
               </a>
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
   
</div>
<div style="display:flex; flex-direction: col; justify-content: flex-start;">
   <ul class="toggleMenuMob">
      <li class="userMenus"> 닫 기 X </li>
      <li class="userMenus"> 마 이 페 이 지 </li>
      <li class="userMenus"> 나 들 이 백 과 </li>
      <li class="userMenus"> 게 시 판 </li>
      <li class="userMenus"> 일 정 작 성 </li>
   </ul>
</div>
<div>

<input type="text" class="mobSearcher" placeholder="검색어를 입력해주세요."></div>

<div style="display:none" id="loadStatus">
   <img src="/images/common/load.gif" style="width:40%; margin:5% 30% 20% 30%;">
</div>