<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>게시물 상세보기</title>

<meta property="og:site_name" content="너나들이"/>
<meta property="og:title" content="제목"/>    
<meta property="og:description" content="내용" />
<meta property="article:author" content="작성자" />
<meta property="og:url" content="http://localhost:8080/board/getBoard?boardNo=1" />
<meta property="og:image" content="http://www.bagooninara.co.kr/data/file/09/096407ec484ac26ac4a55f9e4c903111.jpg" />

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

<!-- flexslider CDN (슬라이드쇼) -->
<link rel="stylesheet" href="/css/flexslider.css" type="text/css">
<script src="/javascript/flexslider.js"></script>

<!-- sweet alert CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- 카카오 공유 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- 페이스북 공유 -->
<script>(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.0&appId=141283403397328";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));</script>

<style>
	.getBody{
	  margin-top : 10px;
	  border-radius: 3px;
	  border: 1px solid #e6e6e6;
	}
	#boardTitle{
      height : auto;
   }
   #boardImg{
      width : 500px;
      height : auto;
   }
   #boardContent{
      height : auto;
   }
   .icon{
      cursor : pointer;
      width : 30px;
      height : 30px;
   }
   .iconHash{
      width : 20px;
      height : 20px;
   }
   span[id^='hashTag']{
     padding: 5px;
     background-color: #E6F5FA;
     border: 0.5px solid #ccc;
   	 border-radius: 5px;
   }
   div[id^='hashTagLine']{
   	 padding-top: 10px;
   	 padding-bottom: 10px;
   	 padding-left: 10px;
   }
   .iconDetail{
      display : none;
      cursor : pointer;
      width : 30px;
      height : 30px;
      border-radius: 1px;
   }
   .iconOpen{
   	 width : 15px;
   	 height : 15px;
   }
   .userList{
      display: flex;
      flex-direction: row;
   }
   .userInfoAndBoardDate{
      display: flex;
      flex-direction: column;
      justify-content: center;
      margin-left : 10px;
   }
   #more{
      position : relative;
       margin-left: auto;
   }
   #moreContent{
      position : absolute;
      border-radius: 10%;
      background-color : #E6F5FA;
      z-index : 10;
      text-align : center;
   }
   .moreDetail{
      cursor : pointer;
      display : none;
   }
   /* 화면이 작아졌을 때 유저정보가 위로 가게끔 설정 */
   @media only screen and (max-width: 600px) {
      .container{
         display: flex;
         flex-direction: column;
      }
      .b1Section{
      	order: 1;
      }
      .aSection{
      	order: 2;
      	padding-top : 10px;
      	padding-bottom : 10px;
      }
      .b2Section{
      	order: 3;
      }
   }
   #userProfile .img-circle{	
      cursor : pointer;
      height : 64px;
      width : 64px;
   }
   .modalUserProfile .img-circle{
      width: 100px;
      height: auto;
   }
   #commListUser .img-circle{
      cursor : pointer;
      height : 25px;
      width : 25px;
   }
   #commListUser{
   	  cursor: pointer;
   	  font-weight: 600;
   	  margin-right: .3em;
   }
   #commLastTime{
   	  font-size: 10px;
   	  letter-spacing: .2px;
   	  color: #999;
   }
	.userModal{
  		padding-top : 10%; /*모달창 상하좌우 여백줘서 정가운데 뜨게끔 정렬*/
	}
	.userModalContent{
		text-align: center; /*안에 내용물(사진,버튼) 가운데정렬*/
		padding : 5% /*안에 내용물 여백*/
	}
   .myFormControl{
   		background-color: #eee;
    	opacity: 1;
   	    border: 1px solid #ccc;
	    border-radius: 4px;
	    display: inline-block;
	    width: auto;
	    height: 34px;
	    padding: 6px 12px;
	    font-size: 14px;
	    line-height: 1.42857143;
	    color: #555;
	    margin-left: 5px;
   }
   .aSection,
   .b1Section{
   	  padding: 16px;
   }
   .cSection{
   	 padding-right: 16px;
   	 padding-left: 16px;
   }
   #commContent{
     width: 100%;
     height: 18px;
     max-height: 80px;
     border: 0;
     outline: 0;
     padding: 0;
     justify-content: center;
     resize: none;
   }
   .commProm{
     border-top: 1px solid #efefef;
     margin-top: 4px;
     font-size: 14px;
     line-height: 18px;
     min-height: 56px;
     padding: 16px 0;
   }
   
   /*  신고기능을 위한 admin css  */
   .inquireTitle {
      margin-bottom: 10px;
      width: 100%;
   }
   .reportUser {
      display: inline;
      float: right;
      visibility: hidden;
      position : absolute;
      right:1vw;
   }
   .reportLink{
      display: inline;
      float: right;
      visibility: hidden;
      position : absolute;
      right:1vw;   
   }
   .inquireWrite {
      width: 100%;
   }
   body.waiting * {
      cursor: progress;
   }
   .count1 div {
      display: none;
      float: right;
   }
   .count2 div {
      display: none;
      float: right;
   }
   .fonted{
      float: left;
      margin-bottom: 10px;
   }
</style>

<script>
//* 마지막으로 작성된 댓글시간 출력을 함수로 만들고
function refreshDate(){
	///if(refresh == false){ //load 시 
		$("#commLastTime").text(transferTime( $("#commLastTime").attr("class") ) );
	///}else{
	//	if( time == null ){ //ajax 이후 + 10초마다
	///		$("#commLastTime").text(transferTime( formatDate2( $("#commLastTime").attr("class") ) ));
	//	}else{ //ajax 이후
	//		var date = new Date(time);
	//		$("#commLastTime").text( transferTime( formatDate2(date) ));
	///		refresh = true;
	//	}	
	///}
}

$(function(){
	var refresh = false;
	//var refreshData = ;
	//우선 바로 실행
	refreshDate();
	//그리고 10초 뒤 또 실행하도록 설정
	setInterval(function(){refreshDate()}, 10000);
	
	//* 툴팁
	$('[data-toggle="tooltip"]').tooltip();
	
   //*슬라이드쇼 시작
   $('.flexslider').flexslider({
      animation: "slide"
   });
   
   //*더보기 클릭
   $(".moreImg").on("click", function(){
       var top =  $(this).offset().top+$(this).outerHeight(true); //떠야하는 상단 위치
       var right = ($(window).width() - ($(this).offset().left+$(this).outerWidth())); //떠야하는 우측위치
       
       $("#moreContent").css("top",top).css("right",right);
   
      if( $(".moreDetail").is(":visible")){
          $(".moreDetail").slideUp();
      }else{
          $(".moreDetail").slideDown();
      }
   })
   //*더보기 메뉴
   $("#modifyBoard").on("click", function(){
      $("#firstForm").attr("method","GET").attr("action", "/board/updateBoard").submit();
   })
   $("#deleteBoard").on("click", function(){
	   swal({
		   title: "게시물을 정말 삭제하시겠습니까?",
		   text: "게시물을 삭제하면 게시물에 포함된\n좋아요, 댓글, 이미지가 모두 삭제됩니다.",
		   icon: "warning",
		   buttons: ["취소", "삭제"],
		   dangerMode: true,
		 })
		 .then((willDelete) => {
		   if (willDelete) {
		     swal("게시물이 정상적으로 삭제되었습니다.", {
		       icon: "success",
		     });
		   } else {
		     swal("취소하였습니다.",{
		    	 icon: "error",
		     });
		   }
	   });
   })
   //*더보기 영역 외 클릭시 fadeOut();
   $(document).mouseup(function(e){
      if( !$(".moreDetail").is(e.target) ){
         $(".moreDetail").fadeOut();
      }
   })
   
   $("#addCart").on("click", function(){
      alert("일정바구니추가하자..")
   })
   
   //*하트 클릭
   $("#likeIcon>.icon").on("click", function(){
      if( $(this).attr("src")=="/images/board/like_empty.png" ){ //좋아요+1
         $.ajax({
            url : "/board/json/addLike/"+$("#boardNo").val().trim(),
            method : "POST",
            success : function(data, status){
               $("#likePrint").text("좋아요 "+data+"개");
            }
         })
         $(this).attr("src","/images/board/like_full.png"); //이미지 변경
      }else{ //좋아요-1
         $.ajax({
            url : "/board/json/deleteLike/"+$("#boardNo").val().trim(),
            method : "POST",
            success : function(data, status){
               $("#likePrint").text("좋아요 "+data+"개");
            }
         })
         $(this).attr("src","/images/board/like_empty.png"); //이미지 변경
      }
   })
   
   //*댓글 클릭
   $("#commIcon").on("click", function(){
      $("#commContent").focus();
   })
   //*댓글 입력
   $("textarea").on("keyup", function(event){
	   if (event.which==13) {
		   if ( $(this).val().trim()==null || $(this).val().trim()=="" ){
			   alert("댓글을 입력해주세요.");
			   $(this).val("");
			   $(this).focus();
		   }else{
			   $.ajax({
				   url : "/board/json/addComment/"+"user06", //세션
				   method : "POST",
				   dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						boardNo : $("#boardNo").val().trim(),
						commentContent : $(this).val()
					}),
				   success : function(comment){
					   //댓글 개수 변경
					   var cnt = $("#commPrint").text().replace(/[^0-9]/g,"");
					   $("#commPrint").text("댓글 "+(Number(cnt)+1)+"개");
					   //댓글 리스트 추가
					   var str = "<div id='commList'>	<span id='commListUser' data-toggle='modal' data-target='.userModal' data-whatever='"+comment.user.profileImg+","+comment.user.userId+","+comment.user.userName+","+comment.user.introduce+"'> <img src='/images/profile/"+comment.user.profileImg+"' class='img-circle'/> "+comment.user.userId+"</span>";
							 str += "<span id='commListContent'>"+comment.commentContent+"</span></div>";
					   $("#commListAll").append(str);
						//댓글마지막 시간도 실행
						$("#commLastTime").attr("class","comment.commentTime");
						refreshDate();
				   }
			   }) //e.o.ajax
		   }
		   $(this).val("");
	   }
   })
   
   //*공유 클릭시 SNS 아이콘 노출
   $("#shareIcon>.icon").on("click", function(){
      if( $(".iconDetail").css("display")=="none" ){
         $(".iconDetail").show("scale");
      }else{
         $(".iconDetail").hide("scale");
      }
   })
   //* SNS공유
   Kakao.init('b3eb26586b770154ea49919a7f59f2d2');
   $("#kakaoShare").on("click", function(){
	   Kakao.Link.sendDefault({
	     objectType: 'feed',
	     content: {
	       title: $("#boardTitle").text(),
	       description: $("#hashTag").text()+'\n'+$("#boardContent").text(),
	       imageUrl: 'http://www.bagooninara.co.kr/data/file/09/096407ec484ac26ac4a55f9e4c903111.jpg',
	       link: {
	         mobileWebUrl: 'http://localhost:8080/board/getBoard?boardNo='+$("#boardNo").val(),
	         webUrl: 'http://localhost:8080/board/getBoard?boardNo='+$("#boardNo").val()
	       }
	     },
	     social: {
	       likeCount: Number($("#likePrint").text().replace(/[^0-9]/g,"")),
	       commentCount: Number($("#commPrint").text().replace(/[^0-9]/g,""))
	       },
	     buttons: [
	       {
	         title: '웹으로 보기',
	         link: {
	           mobileWebUrl: 'http://localhost:8080/board/getBoard?boardNo='+$('#boardNo').val(),
	           webUrl: 'http://localhost:8080/board/getBoard?boardNo='+$('#boardNo').val()
	         }
	       },
	       {
	         title: '앱으로 보기',
	         link: {
	           mobileWebUrl: 'http://localhost:8080/board/getBoard?boardNo='+$('#boardNo').val(),
	           webUrl: 'http://localhost:8080/board/getBoard?boardNo='+$('#boardNo').val()
	         }
	       }
	     ]
	   });
   })
   $("#facebookShare").on("click", function(){
	   FB.ui({
			method		: 'share_open_graph',
			action_type: 'og.shares',
		    action_properties: JSON.stringify({
		        object: {
		            'og:url': 'http://localhost:8080/board/getBoard?boardNo='+$("#boardNo").val(),
		            'og:title': $("#boardTitle").text(),
		            'og:description': $("#boardContent").text(),
		            'og:image': 'http://www.bagooninara.co.kr/data/file/09/096407ec484ac26ac4a55f9e4c903111.jpg',
		        }
		    })
		});
	/* FB.ui({
   	    method: 'share',
   	    //href: 'http://192.168.0.44:8080/board/getBoard?boardNo='+$("#boardNo").val(),
   	    display: 'popup',
   	    name: 'title',
   	    caption: 'hashtag',
   	    description: 'content',
   	    link: 'http://192.168.0.44:8080/board/getBoard?boardNo='+$("#boardNo").val(),
   	    //href: 'http://localhost:8080/board/getBoard?boardNo='+$("#boardNo").val()
   	    //href : 'https://www.facebook.com/dialog/share?app_id=141283403397328&display=popup&href=https%3A%2F%2Flocalhost:8080/board/getBoard?boardNo='+$('#boardNo').val()+'&redirect_uri=localhost:8080/board/getBoard?boardNo='+$('#boardNo').val()
   	  }, function(response){
   		  console.log(response);
   	  });*/
   })   
   $("#naverShare").on("click", function(){
	  var url = encodeURI( "http://localhost:8080/board/getBoard?boardNo="+$("#boardNo").val() );
	  var title = encodeURI( $("#boardTitle").text() );
	  
      var shareURL = "https://share.naver.com/web/shareView.nhn?url="+url+"&title="+title;
      document.location = shareURL;
   })
   
   //*유저프로필 모달창
   $('.userModal').on('show.bs.modal', function (event) {
		var button = $(event.relatedTarget);
  		var modal = $(this);
  		
  		var recipient = button.data('whatever').split(',');
  		modal.find('.modalUserProfile').children().attr("src","/images/profile/"+recipient[0]);
  		modal.find('.myFormControl:first').val(recipient[1]);
  		modal.find('.myFormControl:odd').val(recipient[2]);
  		modal.find('.myFormControl:last').val(recipient[3]);
	})
   //*유저프로필 모달창 내 친구추가
   $("#addFriend").on("click", function(){
	   alert("친구추가를 합시다..")
   })
   //*유저프로필 모달창 내 신고하기
   $("#inquireUser").on("click", function(){
	   var counter = $(this).attr('name');
	   $('.reportedUserId').val(counter);
	   $('.reportedUserId').attr('disabled', 'disabled');
	   $('.inquireCode').val('0').prop("selected", true);
	   $('.inquireCode').attr('disabled', 'disabled');
	   $('.reportUser').css('visibility', 'visible');
	   $('.reportLink').css('visibility', 'hidden');
	})
   
   
   //* Admin (신고기능)
   var inquireType = $('.inquireCode option:selected').val();

      $('.inquireCode').on('change', function() {
         inquireType = this.value;
         if (inquireType == '0') {
            $('.reportUser').css('visibility', 'visible');
         } else {
            $('.reportUser').css('visibility', 'hidden');
         }
      })

      $(".inquireSend").on(
            "click",
            function(e) {

               var form = $(".inquire_form");

               // you can't pass Jquery form it has to be javascript form object
               var formData = new FormData(form[0]);

               //if you only need to upload files then 
               //Grab the File upload control and append each file manually to FormData
               //var files = form.find("#fileupload")[0].files;

               //$.each(files, function() {
               //  var file = $(this);
               //  formData.append(file[0].name, file[0]);
               //});

               if ($('.inquireTitle').val() == '') {
                  alert("제목을 입력해주세요!");
                  $('.inquireTitle').focusin();
                  return;
               } else if ($('.inquireWrite').val() == '') {
                  alert("내용을 입력해주세요!");
                  $('.inquireTitle').focusin();
               } else {

                  $('body').addClass('waiting');
                  
                  var reportUser = $('.reportedUserId').val();
                  
                  if(reportUser==''){
                     console.log("유저신고가 아닙니다~");
                     reportUser = "null";
                  }
                  
                  var inquireCode = $('.inquireCode').val();
                  
                  var title = $('.inquireTitle').val();
                  var title_enc = encodeURI(encodeURIComponent(title));
                  
                  var write = $('.inquireWrite').val();
                  var write_enc = encodeURI(encodeURIComponent(write));
                  
                  var link = $('.inquireLink').val();
                                    
                  $.ajax({
                     type : "POST",
                     url : "/restAdmin/addInquire/"+reportUser+"/"+inquireCode+"/"+write_enc+"/"+title_enc+"/"+link,
                     //dataType: 'json', //not sure but works for me without this
                     data : formData,
                     contentType: false,//this is requireded please see answers above
                     processData : false, //this is requireded please see answers above
                     //cache: false, //not sure but works for me without this
                     success : function(data, status) {
                        if (status == "success") {
                           $('body').removeClass('waiting');
                           $('form')[0].reset();
                           $('#myModal').modal('hide');
                           console.log(data);
                        }
                     }
                  });
               }

            });

      $('.inquireTitle').on('click', function() {
         $('.count1 div').css('display', 'inline-block');
      })

      $('.inquireTitle').on('focusout', function() {
         $('.count1 div').css('display', 'none');
      })

      $('.inquireWrite').on('click', function() {
         $('.count2 div').css('display', 'inline-block');
      })

      $('.inquireWrite').on('focusout', function() {
         $('.count2 div').css('display', 'none');
      })

      $('.inquireWrite').on("input", function() {
         var maxlength = $(this).attr("maxlength");
         var currentLength = $(this).val().length;
         $('.textCounter2').text(currentLength - 1);
      });

      $('.inquireTitle').on("input", function() {
         var maxlength = $(this).attr("maxlength");
         var currentLength = $(this).val().length;
         $('.textCounter1').text(currentLength - 1);
      });
      
      $('#inquireBoard').on('click', function() {
         var counter = $(this).attr('name');
         $('.inquireLink').val(counter);
         $('.inquireLink').attr('disabled', 'disabled');
         $('.inquireCode').val('1').prop("selected", true);
         $('.inquireCode').attr('disabled', 'disabled');
         $('.reportUser').css('visibility', 'hidden');
         $('.reportLink').css('visibility', 'visible');
      })
})
</script>
</head>

<body>
   <jsp:include page="/layout/toolbar.jsp"/>

   <!-- 더보기 버튼 클릭시 노출될 항목 --> 
   <span id="moreContent">
   	  <!-- 현재 로그인 한 유저가 게시물 작성자와 같아야지만 수정/삭제 메뉴를 보여줌 -->
   	  <c:if test="${board.user.userId=='user01'}">
      	<span class="moreDetail" id="modifyBoard">게시물수정</span><br>
      	<span class="moreDetail" id="deleteBoard">게시물삭제</span><br>
   	  </c:if>
      <span class="moreDetail" id="inquireBoard" name="${board.boardNo}" data-toggle="modal" data-target="#inquireModal">게시물신고</span><br>
      <span class="moreDetail" id="addCart">일정바구니 추가</span>
   </span>
               
   <div class="container getBody">
      <div class="col-md-8 aSection"> <!-- 제목+이미지+내용 -->
         <form id="firstForm" class="form-horizontal">
            <!-- 제목 -->
      		<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}">
            <div id="boardTitle" class="bg-warning">${board.boardTitle}</div>
            
            <!-- 이미지 -->
            <input type="hidden" id="boardImg" name="boardImg" value="${board.boardImg}">
            <div class="flexslider">
               <ul class="slides">
                  <c:forTokens var="images" items="${board.boardImg}" delims=",">
                      <li><img src="/images/board/posts/${images}"/></li>
                  </c:forTokens>
               </ul>
            </div>
            
            <!-- 해시태그 -->
            <c:if test="${board.hashTag!=null}">
            	<div id="hashTagLine" class="${board.hashTag}">
            	<c:forTokens var="hashtags" items="${board.hashTag}" delims="#">
            		<span id="hashTag"><img class="iconHash" src="/images/board/hashtag.png">&nbsp;${hashtags}</span>
            	</c:forTokens>
            	</div>
            </c:if>
            
            <!-- 내용 -->
            <div id="boardContent" class="bg-warning">${board.boardContent}</div>
         </form>
      </div>
      
      <div class="col-md-4 b1Section"> <!-- 유저정보+게시물기능(좋아요+댓글+공유)+댓글 -->
         <form id="lastForm" class="form-horizontal">
            <!-- 유저정보 -->
            <div class="userList">
               <div id="userProfile"><img src="/images/profile/${board.user.profileImg}" class="img-circle" data-toggle="modal" data-target=".userModal" data-whatever="${board.user.profileImg},${board.user.userId},${board.user.userName},${board.user.introduce}"></div>
               <div class="userInfoAndBoardDate">
                  <div id="userInfo"><b>${board.user.userName}</b> (${board.user.userId})</div>
                  <div id="boardDate"><fmt:formatDate value="${board.boardDate}" pattern="MM월 dd일   a hh:mm"/> · 
                  	<c:if test="${board.openRange=='0'}"><img class="iconOpen" src="/images/board/open_all.png" data-toggle="tooltip" data-placement="bottom" title="전체공개"></c:if> <!-- 전체공개 아이콘 -->
                  	<c:if test="${board.openRange=='1'}"><img class="iconOpen" src="/images/board/open_friends.png" data-toggle="tooltip" data-placement="bottom" title="친구공개"></c:if> <!-- 친구공개 아이콘 -->
                  	<c:if test="${board.openRange=='2'}"><img class="iconOpen" src="/images/board/open_self.png" data-toggle="tooltip" data-placement="bottom" title="비공개"></c:if> <!-- 비공개 아이콘 -->
                  </div>
               </div>
               <div id="more"><img class="moreImg" src="/images/board/more.png" style="cursor:pointer;width:20px;height:20px;margin-top:10px"></div>
            </div>
            </form>
      </div>
      
      <div class="col-md-4 b2Section"><br>
            <!-- 아이콘(좋아요+댓글+공유) -->
            <div id="iconList">
               <span id="likeIcon">
                  <c:if test="${likeFlag==0}"><img class="icon" src="/images/board/like_empty.png"></c:if>
                  <c:if test="${likeFlag!=0}"><img class="icon" src="/images/board/like_full.png"></c:if>
               </span>&nbsp;&nbsp;
               <span id="commIcon"><img class="icon" src="/images/board/comment.png"></span>&nbsp;&nbsp;
               <!-- 공유하기 버튼 클릭시 노출될 항목 -->
               <span id="shareIcon">
                  <img class="icon" src="/images/board/share.png">&nbsp;&nbsp;
                  <img class="iconDetail" id="kakaoShare" src="/images/board/share/kakao.png">
                  <img class="iconDetail" id="facebookShare" src="/images/board/share/facebook.png">
                  <img class="iconDetail" id="naverShare" src="/images/board/share/naver.png">
               </span>
            </div>
            <br>
            
            <!-- 좋아요@개+댓글@개 -->
            <div id="viewList">
               <span id="likePrint">좋아요 ${board.likeCnt}개</span>&nbsp;&nbsp;
               <span id="commPrint">댓글 ${board.commCnt}개</span>
            </div>
            <br>
            
            <!-- 댓글리스트 -->
            <div id="commListAll">
	            <c:set var="i" value="0"/>
				<c:forEach var="comment" items="${board.comment}">
				<c:set var="i" value="${i+1}"/>
					<div id="commList">
						<span id="commListUser" data-toggle="modal" data-target=".userModal" data-whatever="${comment.user.profileImg},${comment.user.userId},${comment.user.userName},${comment.user.introduce}"> <img src="/images/profile/${comment.user.profileImg}" class="img-circle"/> ${comment.user.userId} </span>
						<span id="commListContent">${comment.commentContent}</span>
					</div>
	            </c:forEach>
	        </div>
            
            <!-- 마지막 댓글달린 시간 -->
            <div id="commLastTime" class="${board.commLastTime}"></div>
            
            <!-- 댓글입력폼 -->
            <section class="commProm">
            	<form><textarea id="commContent" name="commContent" placeholder="댓글을 입력해주세요.."></textarea></form>
            </section>
      </div>
   </div><!-- e.o.container -->
   
   
   <!-- 프로필 클릭시 유저정보 모달창으로 띄움 시작 -->
	<div class="modal modal-center fade userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm userModalInner">
			<div class="modal-content userModalContent">
				<!-- 실제 들어갈 내용 -->
			    <button type="button" class="close" data-dismiss="modal">&times;</button>
				<div class="modalUserProfile"><img src="" class="img-circle"></div>
				<br>
				<div class="modalUserName"><b>이 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름 </b><input class="myFormControl" type="text" value="" readonly></div>
				<br>
				<div class="modalUserId"><b>아&nbsp;&nbsp;이&nbsp;&nbsp;디 </b><input class="myFormControl" type="text" value="" readonly></div>
				<br>
				<div class="modalUserIntroduce"><b>자기소개 </b><input class="myFormControl" type="text" value="" readonly></div>
				<br><br>
				<div class="modalUserButton">
					<button type="button" class="btn btn-primary" id="addFriend">친구추가</button>
					<button type="button" class="btn btn-danger" id="inquireUser" name="${board.user.userId}" data-toggle="modal" data-target="#inquireModal">유저신고</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 프로필 클릭시 유저정보 모달창으로 띄움 끝 -->
   
   <!-- 신고 Modal content -->
   <div class="modal fade" id="inquireModal" role="dialog">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal">&times;</button>
               <h4 class="modal-title">
                  	신고하기<br>
                  <h6 style="color: lightgrey;">신고내용은 창을 닫아도 유지됩니다</h6>
               </h4>
            </div>
            <div class="modal-body">
               <form class="inquire_form" enctype="multipart/form-data">
	               신 고 종 류
	              <select class="inquireCode" name="inquireCode" style="height: 30px;">
                     <option value="9">선택하세요</option>
                     <option value="0">유저신고</option>
                     <option value="1">게시글신고</option>
                     <option value="2">댓글신고</option>
                     <option value="3">정정신청</option>
                     <option value="4">기타문의</option>
                  </select>
                  <span class="reportUser">신고유저아이디<input type="text" name="reportUserId" class="reportedUserId" value="">
                  </span>
                  <span class="reportLink">신 고 링 크<input type="text" name="inquireLink" class="inquireLink" value="">
                  </span>
                  <hr />
                  <div class="count1">
                     <p class="fonted">제목</p>
                     <div>/30</div>
                     <div class="textCounter1">0</div>
                  </div>
                  <input type="text" class="inquireTitle" name="inquireTitle" value="" placeholder="제목을 입력해주세요." maxlength="30"><br>
                  <div class="count2">
                     <p>신 고 내 용</p>
                     <div>/100</div>
                     <div class="textCounter2">0</div>
                  </div>
                  <textarea class="inquireWrite" name="inquireWrite" value="" placeholder="내용을 입력해 주세요." maxlength="100"></textarea>
                  <br>
                  <p class="fonted">
                     <input type="file" name="inquire_file" multiple="multiple">
                  </p>
                  <br>
               </form>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-primary inquireSend">보내기</button>
               <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
            </div>
         </div>

      </div>
   </div>
   
</body>
</html>