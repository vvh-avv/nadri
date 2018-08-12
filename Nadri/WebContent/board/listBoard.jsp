<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>게시물 목록</title>

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
<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)" href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>
<!-- board.js -->
<script src="/javascript/board.js"></script>

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
  
<!-- 친구리스트 오토컴플릿에 필요한 Caret.js -->
<script src="/javascript/caret.js"></script>
<!-- 친구리스트 오토컴플릿에 필요한 atwho.js -->
<script src="/javascript/atwho.js"></script>
<!--친구리스트 오토컴플릿에 필요한 atwho.css -->
<link href="/css/atwho.css" rel="stylesheet">

<style>	
	.flexslider{
		background : transparent;
		border-radius : 0px;
		
	}
	.ListBody{
		padding-top: 10px;
		overflow: hidden;
	}
	.gotoBoard {
	  cursor : pointer;
	  position: fixed; /*absolute;*/
	  bottom: 10%;
	  right: 10%;
	  width: 50px;
	  height: 50px;
	  z-index:999;
	}
	p{
		float:left;
		margin-bottom:10px;
	}
	.gotoTop {
	  display : none;
	  cursor : pointer;
	  position: fixed;
	  bottom: 10%;
	  right: 5%;
	  width: 50px;
	  height: 50px;
	  z-index:999;
	}
	article{
	  border-radius: 5px;
	  border: 1px solid #e6e6e6;
	  background : white;
	  padding : 10px;
	  box-shadow : 1px 2px 10px 0px #80808040;
	}
   /* 화면이 작아졌을 때 gotoTop이 gotoBoard 위로 가게끔 설정 */
   @media only screen and (max-width: 600px) {
   		.gotoBoard{
   		  bottom : 5%;
   		}
   		.gotoTop{
		  bottom: 12%;
		  right: 10%;
   		}
	}
   #boardTitle,
   #boardContent{
      height : auto;
   }
   #boardImg{
      width : 500px;
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
   img[class^='iconDetail']{
      display : none;
      cursor : pointer;
      width : 30px;
      height : 30px;
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
   span[id^='moreContent']{
   	  display : none;
      position : absolute;
      border-radius: 10%;
      background-color : white;
      z-index : 10;
      text-align : center;
      padding : 10px;
      box-shadow : 0px 0px 15px 0px #dadada;
   }
   span[class^='moreDetail']{
      cursor : pointer;
      display : none;
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
   #commList{
   	padding : 5px;
   }
   #commList:hover{
   	background : #eaeaeac7;
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
   div[id^='commLastTime']{
   	  font-size: 10px;
   	  letter-spacing: .2px;
   	  color: #999;
   }
   #commListDelete img{
      cursor: pointer;
      width: 10px;
      height: 10px;
      float: right;
      margin : 0.5em 0.5em 0em 0.5em;
    }
   #commListInquire img{
      cursor: pointer;
      width: 15px;
      height: 15px;
      float: right;
      margin-right: .3em;
      margin-top: .3em;
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
   span[id^='boardDetail']{
     cursor: pointer;
   }
   .bSection{
   	background : #f3f3f399;
   }
   .aSection,
   .bSection #boardTitle,
   .bSection #boardContent{
   	  padding : 16px;
   }
   .cSection{
   	 padding-right: 16px;
   	 padding-left: 16px;
   }
   #commContent{
     width: 100%;
     height: 28px; /* 100% */
     max-height: 80px;
     border: 0;
     outline: 0;
     padding: 5px;
     justify-content: center;
     resize: none;
     border-radius : 5px;
   }
   #commContent:focus{
   	background : #eaeaeac7;
   }
   .commProm{
     border-top: 1px solid #efefef;
     margin-top: 4px;
     font-size: 14px;
     line-height: 18px;
     min-height: 56px;
     padding: 16px 0;
   }
   .commTag{
   	 cursor: pointer;
   	 background-color: #dce6f8;
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
   
   .swal-text{
   	  text-align: center;
   }
   .rewardModal
   /*,.swal-overlay*/{
   	  background-image: url("/images/board/reward.gif");
   	}
   	
   	/* placeholder 공통에 빠져있는건 흰색이라 검은색으로 바꾸고 싶어서 */
   	::placeholder { color: #333; }
</style>

<script>
//마지막으로 작성된 댓글시간 출력을 함수로 만들고
function refreshDate(){
	var that = $("div[id^='commLastTime']");
	for( i=0; i<that.length; i++ ){
		var boardNo = that.eq(i).closest('article').attr("class");
		$("#commLastTime"+boardNo).text( transferTime(that.eq(i).attr("class").replace(/[^0-9]/g,""))  );
	}
}

$(function(){
	//보상 (게시물)
	if( ${myBoardCnt}==5 ){
		swal({
			title: "축하합니다!",
			text: "게시물 5회작성 미션을 클리어 하셨습니다!",
			button: false,
			className: "rewardModal"
		});
	}else if( ${myBoardCnt}==10 ){
		swal({
			title: "축하합니다!",
			text: "게시물 10회작성 미션을 클리어 하셨습니다!",
			button: false,
			className: "rewardModal"
		});
	}else if( ${myBoardCnt}==15 ){
		swal({
			title: "축하합니다!",
			text: "게시물 15회작성 미션을 클리어 하셨습니다!",
			button: false,
			className: "rewardModal"
		});
	}
	
	//마지막으로 작성된 댓글시간 출력을 함수 바로 실행
	refreshDate();
	//그리고 10초 뒤 또 실행하도록 설정
	setInterval(function(){refreshDate()}, 10000);
	
	//*툴팁사용
	$(document.body).tooltip({ selector: "[data-toggle='tooltip']" });
	
	//*스크롤감지
	$(window).on("scroll", function(){
		var scrollLocation = $(window).scrollTop(); //브라우저의 스크롤 값
		var maxHeight = $(document).height(); //현재페이지의 높이
		var currentScroll = scrollLocation + $(window).height(); //브라우저의 스크롤 값 + 윈도우의 크기
		
		//*1.gotoTop
		if(scrollLocation>50){ //화면을 내리면 gotoTop 뜨게하고
			$(".gotoTop").fadeIn();
			$("span[class^='moreDetail']").hide();
		}else{					//화면을 올리면 gotoTop 사라지게하기
			$(".gotoTop").fadeOut();
		}
		
		//*2.무한스크롤
		if (maxHeight <= currentScroll) { //+10을 한 이유는 사용자가 반드시 최하단이 아니라 하단보다 조금 위에 위치했더라도 데이터를 불러올 수 있도록 하기 위함
			console.log("무한스크롤~");
			$('#boardLoading').css('display','block');
			
			$.ajax({
				url : "/board/json/getBoardList/"+$("#currentPage").val(),
	            method : "POST",
	            headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
	            success : function(data, status){
	            	if(data==""){
	    				$('#boardLoading').remove();
	            		swal ( "확인" ,  "더 불러올 데이터가 존재하지 않습니다." ,  "error" );
	            	}else{
	    				$('#boardLoading').css('display','none');
		            	$("#currentPage").val( Number($("#currentPage").val())+1 ); //현재페이지 증가 +1
		            	
		            	var tag = "";
		            	var sliderTag = "";
		            	$(data).each(function(){
		            		var boardNo = this.boardNo;
		            		tag += "<span id='moreContent"+boardNo+"'>"
		            			+"<span class='moreDetail"+boardNo+"' id='inquireBoard' name="+boardNo+" data-toggle='modal' data-target='#inquireModal'>게시물신고</span><br>";
		            			if(this.boardCode!=0 && this.user.userId!='${sessionScope.user.userId}'){
		            				tag += "<span class='moreDetail"+boardNo+"' id='copySchedule'>일정 복사하기</span>";
		            			}
			            			tag += "</span>"
			            			+"<article class='"+boardNo+"'>"
			            			+"<div class='aSection'> <div class='userList'> <div id='userProfile'>"
			            			+"<img src='/images/profile/"+this.user.profileImg+"' class='img-circle' data-toggle='modal' data-target='.userModal' data-whatever='"+this.user.profileImg+","+this.user.userName+","+this.user.userId+","+this.user.introduce+"'>"                        
			            			+"</div> <div class='userInfoAndBoardDate'> <div id='userInfo'> <b>"+this.user.userName+"</b> ("+this.user.userId+") </div>"
			            			+"<div id='boardDate' style='width:auto;'> <span id='boardDetail'>";
		            			if(this.boardDate){
		            				var date = new Date(this.boardDate);
		            				tag += formatDate(date);
		            			}
		            				tag += "</span> · ";
		            			if(this.openRange=='0'){
		            				tag += "<img class='iconOpen' src='/images/board/open_all.png' data-toggle='tooltip' data-placement='bottom' title='전체공개'>";
		            			}else if(this.openRange=='1'){
		            				tag += "<img class='iconOpen' src='/images/board/open_friends.png' data-toggle='tooltip' data-placement='bottom' title='친구공개'>";
		            			}else{
		            				tag += "<img class='iconOpen' src='/images/board/open_self.png' data-toggle='tooltip' data-placement='bottom' title='비공개'>";
		            			}
		            			if(this.boardCode!=0){
		            				tag += " · <img class='iconOpen' src='/images/board/schedule.png'>";
		            			}
			            			tag += "</div></div>";
			            		if( ${!empty sessionScope.user} ){
			            			tag += "<div id='more'><img class='moreImg' src='/images/board/more.png' style='cursor:pointer;width:20px;height:20px;margin-top:10px'></div>";
			            		}
			            			tag += "</div> </div>";
			            			tag += "<div class='bSection'> <input type='hidden' id='boardNo' name='boardNo' value='"+boardNo+"'> <div id='boardTitle'>"+this.boardTitle+"</div>"
			            					+ "<div class='flexslider'> <ul class='slides'>";
			            		if(this.boardImg!=null){ //이미지가 존재할 경우
			            			if((this.boardImg).indexOf(',')==-1){ //하나일 경우
			            				tag += "<li><img src='/images/board/posts/"+this.boardImg+"'/></li>";
			            				sliderTag += "<li><img src='/images/board/posts/"+this.boardImg+"'/></li>";
			            			}else{ //여러개일 경우
			            				var imgArray = this.boardImg.split(',');
			            				for( i=0; i<imgArray.length; i++ ){
				            				tag += "<li><img src='/images/board/posts/"+imgArray[i]+"'/></li>";	
				            				sliderTag += "<li><img src='/images/board/posts/"+imgArray[i]+"'/></li>";
			            				}
			            			}
			            		}
			            			tag += "</div>";
		            			if(this.hashTag!=null){ //해시태그가 존재할 경우
		            				tag += "<div id='hashTagLine' class="+this.hashTag+">";
		            				var tagArray = this.hashTag.split("#");
		            				for( i=1; i<tagArray.length; i++ ){
				            			tag += "<span id='hashTag'><img class='iconHash' src='/images/board/hashtag.png'>&nbsp;"+tagArray[i]+"</span>";
			            			}
			            			tag += "</div>";
		            			}
			            			tag += "<div id='boardContent'>"+this.boardContent+"</div></div><br>"
			            			+"<div class='cSection'> <div id='iconList'> <span id='likeIcon'>";
			            		if(this.likeFlag==0){
			            			tag += "<img class='icon' src='/images/board/like_empty.png'>";
			            		}else{
			            			tag += "<img class='icon' src='/images/board/like_full.png'>";
			            		}	
			            			tag += "</span> &nbsp; &nbsp;"
			            			+"<span id='commIcon'> <img class='icon' src='/images/board/comment.png'> </span> &nbsp; &nbsp;"
			            			+"<span id='shareIcon'> <img class='icon' src='/images/board/share.png'> &nbsp;&nbsp; <img class='iconDetail"+boardNo+"' id='kakaoShare' src='/images/board/share/kakao.png'> "
			            			+"<img class='iconDetail"+boardNo+"' id='facebookShare' src='/images/board/share/facebook.png'> <img class='iconDetail"+boardNo+"' id='naverShare' src='/images/board/share/naver.png'> </span> </div> <br>"
			            			+"<div id='viewList'> <span id='likePrint"+boardNo+"'>좋아요 "+this.likeCnt+"개</span> &nbsp;&nbsp; <span id='commPrint"+boardNo+"'>댓글 "+this.commCnt+"개</span></div><br>"
			            			+"<div id='commListAll'>";
			            		if(this.comment!=null){
			            			for( i=0; i<this.comment.length; i++ ){
			            				tag += "<div id='commList'> <span id='commListUser' data-toggle='modal' data-target='.userModal' data-whatever='"+this.comment[i].user.profileImg+","+this.comment[i].user.userName+","+this.comment[i].user.userId+","+this.comment[i].user.introduce+"'> "
			            				+ "<img src='/images/profile/"+this.comment[i].user.profileImg+"' class='img-circle'/> "+this.comment[i].user.userId+"</span>"
			            				+ "<span id='commListContent'>"+ccTag(this.comment[i].commentContent)+"</span><span id='commListDelete' class='"+this.comment[i].commentNo+"' style='display:none;'><img src='/images/board/delete2.png'></span>"
			            				+ "<span id='commListInquire' id='inquireUser' name='"+this.comment[i].commentNo+"' style='display:none;' data-toggle='modal' data-target='#inquireModal'><img src='/images/board/inquire.png'></span></div>"	
			            			}
			            			tag += "<div id='commLastTime"+boardNo+"' class='"+this.commLastTime+"'></div>";
			            		}
			            			tag += "<section class='commProm'> <form> <textarea id='commContent' name='commContent' placeholder='댓글을 입력해주세요..'";
			            		if( ${empty sessionScope.user} ){
			            			tag += "readonly";
			            		}
			            		tag += "></textarea></form></section></div></article><br>";
		            	})
		            	$(".ListBody").append(tag);
		            	$("div[class^='flexslider']").data('flexslider').addSlide($(sliderTag));
		            	refreshDate();
	            	}
	            }
			})
		}
	})
	//*상단에 둥둥 떠있는 아이콘 (게시물작성으로 이동)
	$(".gotoBoard").on("click", function(){
		self.location="/board/addBoard";
	})
	//*상단에 둥둥 떠있는 아이콘 (상단으로 이동)
	$(".gotoTop").on("click", function(){
		$(window).scrollTop(0);
	})
	//*날짜 클릭시 상세보기로 이동
   $(document).on("click", "span[id^='boardDetail']", function(){
		//alert( $(this).closest('article').attr("class") );
		self.location="/board/getBoard?boardNo="+$(this).closest('article').attr("class");
	})

	//*슬라이드쇼 시작
   //$(document).on("flexslider", "div[class^='flexslider']", function(){
	$("div[class^='flexslider']").flexslider({
	   animation: "slide"
	});

	//*페이지 로드 시 댓글 태그로 보여주기
	var array = $("div[id^='commList']").length;
	for(var i=0; i<array; i++){
		$("#commListContent"+i).html( ccTag( $("#commListContent"+i).text() ) );
	}
	   
   //*더보기 클릭
   $(document).on("click", "img[class^='moreImg']", function(){
	   var top =  $(this).offset().top+$(this).outerHeight(true); //떠야하는 상단 위치
       var right = ($(window).width() - ($(this).offset().left+$(this).outerWidth())); //떠야하는 우측위치
       var num = $(this).closest('article').attr("class");
       
       $("#moreContent"+num).css("top",top).css("right",right);
   
      if( $(".moreDetail"+num).is(":visible")){
          $(".moreDetail"+num).slideUp();
          $('#moreContent'+num).slideUp();
      }else{
          $(".moreDetail"+num).slideDown();
          $("#moreContent"+num).slideDown();
      }
      
   })
   //*더보기 메뉴
   $(document).on("click", "span[id^='modifyBoard']", function(){
      self.location="/board/updateBoard?BoardNo="+$(this).parent().next().attr("class");
   })
   $(document).on("click", "span[id^='deleteBoard']", function(){
	   var boardNo = $(this).attr("class").replace(/[^0-9]/g,"");
	   swal({
		   title: "게시물을 정말 삭제하시겠습니까?",
		   text: "게시물에 포함된 좋아요, 댓글, 이미지가 모두 삭제됩니다.",
		   icon: "warning",
		   buttons: ["취소", "삭제"],
		   dangerMode: true,
		 })
		 .then((willDelete) => {
		   if (willDelete) {
				$.ajax({
					url : "/board/json/deleteBoard/"+boardNo,
					method : "POST",
					success : function(){
					   swal("게시물이 정상적으로 삭제되었습니다.", { icon: "success", });
					   $("article[class='"+boardNo+"']").remove();
					}
				 }) //e.o.ajax
		   } else {
		     swal("취소하였습니다.",{
		    	 icon: "error",
		     });
		   }
	   });
   })
   $(document).on("click", "span[id^='copySchedule']", function(){
	  var scheduleNo = $(this).attr("id").replace(/[^0-9]/g,"");
   
	  $.ajax({
		  url : "/restschedule/checkSchedule/"+scheduleNo,
		  method : "POST",
		  success : function(data){
			  if(data==1){ //이미 일정 복사를 한 경우
				  swal ( "일정복사 실패!" ,  "이미 일정을 복사하셨습니다.\n마이페이지 내 '내 일정'에서 확인해주시길 바랍니다." ,  "error" )
			  }else{ //일정복사를 해야하는 경우
				  $.ajax({
					  url : "/restschedule/addSchedule/"+scheduleNo,
					  method : "POST",
					  success : function(){
						  swal("일정복사 성공!", "마이페이지 내 '내 일정'에서 확인 가능합니다.", "success");
					  }
				  }) //e.o.ajax
			  }
		  }
	  }) //e.o.ajax
   })
   //*더보기 영역 외 클릭시 fadeOut();
   $(document).mouseup(function(e){
      if( !$("span[class^='moreDetail']").is(e.target) ){
    	  $("span[class^='moreDetail']").fadeOut();
      }
   })
   
   //*하트 클릭
   $(document).on("click", "span[id^='likeIcon']>.icon", function() {
		if( ${empty sessionScope.user} ) {
			swal ( "좋아요 실패" ,  "회원가입 후 이용해주시길 바랍니다." ,  "error" );
			return;
		}
		
	  //alert( $(this).closest('article').attr("class") );
	  var num = $(this).closest('article').attr("class"); 
	  
      if( $(this).attr("src")=="/images/board/like_empty.png" ){ //좋아요+1
         $.ajax({
            url : "/board/json/addLike/"+num,
            method : "POST",
            success : function(map, status){
            	//보상 (좋아요)
            	if( map.myLikeCnt==5 ){
            		swal({
            			title: "축하합니다!",
            			text: "좋아요 5회작성 미션을 클리어 하셨습니다!",
            			button: false,
            			className: "rewardModal"
            		});
            	}else if( map.myLikeCnt==10 ){
            		swal({
            			title: "축하합니다!",
            			text: "좋아요 10회작성 미션을 클리어 하셨습니다!",
            			button: false,
            			className: "rewardModal"
            		});
            	}else if( map.myLikeCnt==15 ){
            		swal({
            			title: "축하합니다!",
            			text: "좋아요 15회작성 미션을 클리어 하셨습니다!",
            			button: false,
            			className: "rewardModal"
            		});
            	}
            	
               $("#likePrint"+num).text("좋아요 "+map.likeCnt+"개");
            }
         })
         
         //알림 전송
         $.ajax({
            url : "/notice/json/addNotice?receiverId="+ $(this).attr("id") + '&otherPk=' + num + '&noticeCode=1' ,
            method : "GET" ,
            success : function( data ) {
               
            	//alert( "noticeSendingWs함수 호출" ) ;
            	//alert( data.noticeCode ) ;
            	noticeSendingWs( data.receiverId + data.noticeCode ) ;
             } ,
             error : function( error ) {
            	 //alert( "에러 : " + error ) ;
             }
         })
         
         $(this).attr("src","/images/board/like_full.png"); //이미지 변경
      }else{ //좋아요-1
         $.ajax({
            url : "/board/json/deleteLike/"+num,
            method : "POST",
            success : function(data, status){
               $("#likePrint"+num).text("좋아요 "+data+"개");
            }
         })
         $(this).attr("src","/images/board/like_empty.png"); //이미지 변경
      }
   })
   
   //*댓글 클릭
   $(document).on("click", "span[id^='commIcon']", function(){
	  if( ${empty sessionScope.user} ) {
			  swal ( "댓글입력 불가" ,  "회원가입 후 이용해주시길 바랍니다." ,  "error" );
			  return;
	  }
	  $(this).closest('article').find('textarea').focus();
   })
   //*댓글 입력
   $(document).on("keyup", "textarea[id^='commContent']", function(){
	 //autocomplete data get
	   $(this).atwho({
	        at: "@",
	        data: null,
	        limit: 10,
	        callbacks: {
	          remoteFilter: function(query, callback){
	            $.getJSON('/friend/json/listFriendFromBoard/${sessionScope.user.userId}', function(data){
	              console.log("서버에서 가져온 데이터 : "+data);
	              callback(data);
	            });
	          }
	        }
	    });
	   //enter event
	   if (event.which==13) {
		   if ( $(this).val().trim()==null || $(this).val().trim()=="" ){
			   alert("댓글을 입력해주세요.");
			   $(this).val("");
			   $(this).focus();
		   }else{
			   if( ${empty sessionScope.user} ){
					swal ( "댓글달기 불가" ,  "회원가입 후 이용해주시길 바랍니다." ,  "error" );
					$(this).val("");
					return;
				}
			   
			   if($(this).val().indexOf('\n')!=-1){ //줄바꿈 감지 => autocomplete 과 submit 구별
				 
				 var content = $(this).val();
				 if(content.length>50){
					 swal ( "댓글 입력 실패!" ,  "50자 이상 입력이 불가합니다." ,  "error" );
					 $(this).val("");
					 return;
				 }
				 
			   //comment submit
			   
			   //댓글길이 유효성체크
			   var content = $(this).val();
	             if(content.length>50){
	                swal ( "댓글 입력 실패!" ,  "50자 이상 입력이 불가합니다." ,  "error" );
	                $(this).val("");
	                return;
	             }
			   //실제 submit 되는 부분
			   var num = $(this).closest('article').attr("class");
			   $.ajax({
				   url : "/board/json/addComment/${sessionScope.user.userId}", //세션
				   method : "POST",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						boardNo : num,
						commentContent : $(this).val()
					}),
				   success : function(map){
					 	//보상 (댓글)
						if( map.myCommCnt==5 ){
							swal({
								title: "축하합니다!",
								text: "댓글 5회작성 미션을 클리어 하셨습니다!",
								button: false,
								className: "rewardModal"
							});
						}else if( map.myCommCnt==10 ){
							swal({
								title: "축하합니다!",
								text: "댓글 10회작성 미션을 클리어 하셨습니다!",
								button: false,
								className: "rewardModal"
							});
						}else if( map.myCommCnt==15 ){
							swal({
								title: "축하합니다!",
								text: "댓글 15회작성 미션을 클리어 하셨습니다!",
								button: false,
								className: "rewardModal"
							});
						}
					 
					   console.log(map.returnFriend); //태그한 친구 확인
					   
					   var addTag = ccTag(map.comment.commentContent);
					   //댓글 개수 변경
					   var cnt = $("#commPrint"+num).text().replace(/[^0-9]/g,"");
					   $("#commPrint"+num).text("댓글 "+(Number(cnt)+1)+"개");
					   //댓글 리스트 추가
					   var str = "<div id='commList'>	<span id='commListUser' data-toggle='modal' data-target='.userModal' data-whatever='"+map.comment.user.profileImg+","+map.comment.user.userName+","+map.comment.user.userId+","+map.comment.user.introduce+"'> <img src='/images/profile/"+map.comment.user.profileImg+"' class='img-circle'/> "+map.comment.user.userId+" </span>";
							 str += "<span id='commListContent'>"+addTag+"</span><span id='commListDelete' class='"+map.comment.commentNo+"' style='display:none;'><img src='/images/board/delete2.png'></span>"
							 	+"<span id='commListInquire' id='inquireUser' name='"+map.comment.commentNo+"' style='display:none;' data-toggle='modal' data-target='#inquireModal'><img src='/images/board/inquire.png'></span></div>";
					   $("#commLastTime"+num).prev().append(str);
						//댓글마지막 시간도 실행
						var timeStampType = map.comment.commentTime;
						var dateType = new Date(timeStampType);
						var lastTime = formatDate2(dateType);
						$("#commLastTime"+num).attr("class", lastTime);
						refreshDate();
				   }
			   }) //e.o.ajax 
			   $(this).val("");
			   }else{
				   //autocomplete
			   }
		   }
	   }
	})
	//*댓글에 태그된 유저아이디 클릭
   $(document).on("click", "span[class^='commTag']", function(){
		//swal($(this).text()+" 님과 친구가 되어보세요~"); 
	})
	
	//*댓글 마우스 오버시 삭제버튼 노출 => 회원만 가능 => 본인만 가능
   $(document).on("mouseover", "div[id^='commList']", function(){
	   if( ${!empty sessionScope.user} ){
	   		$(this).children('span:eq(3)').removeAttr("style");

			if( $(this).children("span:first").text().trim()=='${sessionScope.user.userId}' ){ //=>본인일 때
		   		$(this).children('span:eq(2)').removeAttr("style");
			}
	   }
	})
	//*댓글 마우스가 떠나면 삭제버튼 다시 노출감추기 => 회원만 가능 => 본인만 가능
   $(document).on("mouseleave", "div[id^='commList']", function(){
	   if( ${!empty sessionScope.user} ){
			$(this).children("span:eq(3)").attr("style","display:none;");
			
			if( $(this).children("span:first").text().trim()=='${sessionScope.user.userId}' ){ //=>본인일 때
		   		$(this).children('span:eq(2)').attr("style","display:none;");
			}
	   }
	})
	
	//*댓글삭제
   $(document).on("click", "span[id^='commListDelete']", function(){
		//alert( $(this).attr("class") );
		var commNo = $(this).attr("class");
		$.ajax({
			url : "/board/json/deleteComment/"+$("#boardNo").val()+"/"+commNo,
			method : "POST",
			success : function(data, status){
				$("#commPrint").text("댓글 "+data+"개");
				$("."+commNo).parent().remove();
			}
		}) //e.o.ajax
	 })
	 //*댓글신고
	 $(document).on("click","span[id^='commListInquire']", function(){
		 var counter = $(this).attr('name');
		   $('.inquireLink').val(counter);
		   $('.inquireLink').attr('disabled', 'disabled');
		   $('.inquireCode').val('2').prop("selected", true);
		   $('.inquireCode').attr('disabled', 'disabled');
		   $('.reportUser').css('visibility', 'hidden');
		   $('.reportLink').css('visibility', 'visible');
	 })
   
   //*공유 클릭시 SNS 아이콘 노출
   $(document).on("click", "span[id^='shareIcon']>.icon", function(){
	   var num = $(this).closest('article').attr("class");
      if( $(".iconDetail"+num).css("display")=="none" ){
         $(".iconDetail"+num).show("scale");
      }else{
         $(".iconDetail"+num).hide("scale");
      }
   })
   //* SNS공유
   Kakao.init('b3eb26586b770154ea49919a7f59f2d2');
   $(document).on("click", "img[id^='kakaoShare']", function(){
	   Kakao.Link.sendDefault({
		     objectType: 'feed',
		     content: {
		       title: $(this).closest('article').find('div[id^=boardTitle]').text(),
		       description: $(this).closest('article').find('div[id^=hashTagLine]').attr("class")+"\n"+$(this).closest('article').find('div[id^=boardContent]').text(),
		       imageUrl: 'https://66.media.tumblr.com/9d5b1291f9f83302d8699cab8bfbd472/tumblr_pcguypaDJw1v6rnvho1_540.png',
		       link: {
		         mobileWebUrl: 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class"),
		         webUrl: 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class")
		       }
		     },
		     social: {
		       likeCount: Number($(this).closest('article').find("span[id^=likePrint]").text().replace(/[^0-9]/g,"")),
		       commentCount: Number($(this).closest('article').find("span[id^=commPrint]").text().replace(/[^0-9]/g,""))
		       },
		     buttons: [
		       {
		         title: '웹으로 보기',
		         link: {
		           mobileWebUrl: 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class"),
		           webUrl: 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class")
		         }
		       },
		       {
		         title: '앱으로 보기',
		         link: {
		           mobileWebUrl: 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class"),
		           webUrl: 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class")
		         }
		       }
		     ]
		});
   })
   $(document).on("click", "img[id^='facebookShare']", function(){
      FB.ui({
			method		: 'share_open_graph',
			action_type: 'og.shares',
		    action_properties: JSON.stringify({
		        object: {
		            'og:url': 'http://localhost:8080/board/getBoard?boardNo='+$(this).closest('article').attr("class"),
		            'og:title': $(this).closest('article').find('div[id^=boardTitle]').text(),
		            'og:description': $(this).closest('article').find('div[id^=boardContent]').text(),
		            'og:image': 'https://66.media.tumblr.com/9d5b1291f9f83302d8699cab8bfbd472/tumblr_pcguypaDJw1v6rnvho1_540.png',
		        }
		    })
	  });
   })
   $(document).on("click", "img[id^='naverShare']", function(){
	  var url = encodeURI( "http://localhost:8080/board/getBoard?boardNo="+$(this).closest('article').attr("class") );
	  var title = encodeURI( $(this).closest('article').find('div[id^=boardTitle]').text() );
	  
      var shareURL = "https://share.naver.com/web/shareView.nhn?url="+url+"&title="+title;
      document.location = shareURL;
   })
   
   //*유저프로필 모달창
   var modalFriendId; //모달창 내에서 상대방 ID를 가져오기 위함
   var modalMyself = false; //본인이 본인프로필을 열었는지 체크하기 위함 //본인은 신고하지 못하도록
   $('.userModal').on('show.bs.modal', function (event) {
		var button = $(event.relatedTarget);
  		var modal = $(this);
  		
  		var recipient = button.data('whatever').split(',');
  		modal.find('.modalUserProfile').children().attr("src","/images/profile/"+recipient[0]);
  		modal.find('.myFormControl:first').val(recipient[1]);
  		modal.find('.myFormControl:odd').val(recipient[2]);
  		modal.find('.myFormControl:last').val(recipient[3]);
  		modal.find('button:last').attr("name",recipient[2]);
  		modalFriendId = recipient[2];

  		//클릭한 사람이 친구인지 아닌지 확인
  		if( ${!empty sessionScope.user} ){ //회원만 확인 가능
  			if( '${sessionScope.user.userId}' == modalFriendId ){  //본인일 경우
				$("#addFriend").remove();
				$("#chatFriend").remove();
				modalMyself = true;
  			}else{ //본인이 아니면 실제 로직 수행
  				modalMyself = false;
  	  			$.ajax({
  	  	  			url : "/friend/json/chkFriend/"+recipient[2]+"/1",
  	  	  			success : function(data){
  	  	  				if(data==1){ //친구임
  	  	  					$("#addFriend").remove();
  	  	  					$("#chatFriend").remove();
  	  	  					$(".modalUserButton").prepend("<button type='button' class='btn btn-primary' id='chatFriend'>대화하기</button>");
  	  	  				}else{ //친구가 아님
  	  	  					$("#addFriend").remove();
  	  	  					$("#chatFriend").remove();
  	  	  					$(".modalUserButton").prepend("<button type='button' class='btn btn-primary' id='addFriend'>친구추가</button>");
  	  	  				}
  	  	  			}
  	  	  		}) //e.o.ajax  				
  			}
  		}
	})
   //*유저프로필 모달창 내 친구추가
   $(document).on("click", "button[id^='addFriend']", function(){
	   $.ajax({
		   url : "/friend/json/chkFriend/"+modalFriendId+"/0",
		   success : function(data){
			   if(data==1){ //친구요청이 이미 된 경우
				   swal ( "친구추가 실패!" ,  "이미 우리는 친구예요!" ,  "error" );
			   }else{ //친구요청이 안 된 경우
				   $.ajax({
					   url : "/friend/json/addFriend/"+modalFriendId,
					   success : function(){
						   swal("친구추가 완료!", "상대방을 친구로 추가했습니다!", "success");
					   }
				   }) //e.o.ajax
			   }
		   }
	   }) //e.o.ajax
   })
   //*유저프로필 모달창 내 대화하기
   $(document).on("click", "button[id^='chatFriend']", function(){
	   //대화하기
	   var receiverId = {
		   "receiverId" :  modalFriendId
	   } ;
    	$.ajax({
  	  			url : "/chatRoom/json/getChatRoom2" ,
  	  			data : receiverId,
  	  			type : "GET",
  	  			dataType : "json",
  	  			contentType : "application/json; charset=UTF-8",
  	  			success : function(data) {
  	  				makeChat(data) ;
  	  			} ,
  	  			error : function( error ) {
  	  					alert("에러 : " + error ) ;
  	  			}
    	}) ; //End of ajax
  })
   //*유저프로필 모달창 내 신고하기
   $("button[id^='inquireUser']").on("click", function(){
	   if(!modalMyself){
	         var counter = $(this).attr('name');
	         $('.reportedUserId').val(counter);
	         $('.reportedUserId').attr('disabled', 'disabled');
	         $('.inquireCode').val('0').prop("selected", true);
	         $('.inquireCode').attr('disabled', 'disabled');
	         $('.reportUser').css('visibility', 'visible');
	         $('.reportLink').css('visibility', 'hidden');
	      }else{
	         alert("본인은 신고할 수 없습니다.");
	         $(this).attr("data-toggle","");
	      }

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
               var inquireFile = $('.inquire_file').val();
             
             if(inquireFile==""){
                console.log("파일없음");
                var formData = $(".inquire_form");
                var requestMapping = 'addInquireNoFile';
             }else{
                console.log("파일있음");
                $('.inquire_form').attr('enctype','multipart/form-data');
                var requestMapping = 'addInquire';
                var form = $(".inquire_form");
                // you can't pass Jquery form it has to be javascript form object
                var formData = new FormData(form[0]);
             }

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
                
                var inquireLink = $('.inquireLink').val();
                
                if(inquireLink == ''){
                   
                   console.log("링크가 없어요~");
                   inquireLink = "null";
                   
                }
                
                $.ajax({
                   type : "POST",
                   url : "/restAdmin/"+requestMapping+"/"+reportUser+"/"+inquireCode+"/"+write_enc+"/"+title_enc+"/"+inquireLink,
                   //dataType: 'json', //not sure but works for me without this
                   data : formData,
                   contentType: false,//this is requireded please see answers above
                   processData : false, //this is requireded please see answers above
                   //cache: false, //not sure but works for me without this
                   success : function(data, status) {
                      if (status == "success") {
                         $('body').removeClass('waiting');
                         $('.inquire_form')[0].reset();
                         $('#inquireModal').modal('hide');
                         console.log(data);
                         swal("신고가 완료 되었습니다.");
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
         $('.textCounter2').text(currentLength);
      });

      $('.inquireTitle').on("input", function() {
    	  if($(this).val() == ''){
    		  console.log('no value');
    	  }
    	  var maxlength = $(this).attr("maxlength");
          var currentLength = $(this).val().length;
          $('.textCounter1').text(currentLength);
       });        
               
      $('span[id^="inquireBoard"]').on('click', function() {
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
	<!-- 상단에 둥둥 떠있는 아이콘 (게시물작성으로 이동) -->
	<c:if test="${!empty sessionScope.user}">
		<img class="gotoBoard" src="/images/board/gotoBoard.png">
	</c:if>
	<!-- 상단에 둥둥 떠있는 아이콘 (상단으로 이동) -->
	<img class="gotoTop" src="/images/common/gotoTop.png">
	
	<%@include file="/layout/new_toolbar.jsp"%>
	
	<!-- 페이징처리를 위함 -->
	<input type="hidden" id="currentPage" name="currentPage" value="${search.currentPage}">
	
	<!-- commList 마다 고유 k값 부여 -->
	<c:set var="k" value="0"/>
	
	<div class="container ListBody">
		<c:set var="i" value="0"/>
		<c:forEach var="board" items="${list}">
			
		<!-- 더보기 버튼 클릭시 노출될 항목 --> 
	    <span id="moreContent${board.boardNo}">
	   	  <!-- 현재 로그인 한 유저가 게시물 작성자와 같아야지만 수정/삭제 메뉴를 보여줌 -->
	   	  <c:if test="${board.user.userId==sessionScope.user.userId}">
	      	<span class="moreDetail${board.boardNo}" id="modifyBoard">게시물수정</span><br>
	      	<span class="moreDetail${board.boardNo}" id="deleteBoard">게시물삭제</span><br>
	   	  </c:if>
	      <span class="moreDetail${board.boardNo}" id="inquireBoard" name="${board.boardNo}" data-toggle="modal" data-target="#inquireModal">게시물신고</span><br>
	      <c:if test="${board.boardCode!=0 && sessionScope.user.userId!=board.user.userId}">
	      	<span class="moreDetail${board.boardNo}" id="copySchedule${board.boardCode}">일정 복사하기</span>
	      </c:if>
	    </span>
		
	  <article class="${board.boardNo}">
		<div class="aSection"> <!-- 유저정보 -->
            <div class="userList">
               <div id="userProfile"><img src="/images/profile/${board.user.profileImg}" class="img-circle" data-toggle="modal" data-target=".userModal"  data-whatever="${board.user.profileImg},${board.user.userName},${board.user.userId},${board.user.introduce}"></div>
               <div class="userInfoAndBoardDate">
                  <div id="userInfo"><b>${board.user.userName}</b> (${board.user.userId})</div>
                  <div id="boardDate" style="width:auto;">
                  	<span id="boardDetail"><fmt:formatDate value="${board.boardDate}" pattern="MM월 dd일   a hh:mm"/></span> · 
                  	<c:if test="${board.openRange=='0'}"><img class="iconOpen" src="/images/board/open_all.png" data-toggle="tooltip" data-placement="bottom" title="전체공개"></c:if> <!-- 전체공개 아이콘 -->
                  	<c:if test="${board.openRange=='1'}"><img class="iconOpen" src="/images/board/open_friends.png" data-toggle="tooltip" data-placement="bottom" title="친구공개"></c:if> <!-- 친구공개 아이콘 -->
                  	<c:if test="${board.openRange=='2'}"><img class="iconOpen" src="/images/board/open_self.png" data-toggle="tooltip" data-placement="bottom" title="비공개"></c:if> <!-- 비공개 아이콘 -->
                  	<c:if test="${board.boardCode!=0}"> · <img class="iconOpen" src="/images/board/schedule.png"></c:if>
                  </div>
               </div>
               <c:if test="${!empty sessionScope.user}">
               		<div id="more"><img class="moreImg" src="/images/board/more.png" style="cursor:pointer;width:20px;height:20px;margin-top:10px"></div>
               </c:if>
            </div>
		</div>
		
		<div class="bSection"> <!-- 제목+이미지+내용 -->
      		<input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}">
            <!-- 제목 -->
            <div id="boardTitle">${board.boardTitle}</div>
            <!-- 이미지 -->
            <div class="flexslider">
               <ul class="slides">
                  <c:forTokens var="images" items="${board.boardImg}" delims=",">
                  	  <c:if test="${board.boardCode==0}">
                  	  	<li><img src="/images/board/posts/${images}"/></li>
                  	  </c:if>
                  	  <c:if test="${board.boardCode!=0}">
                  	  	<li><img src="/images/schedule/${images}"/></li>
                  	  </c:if>
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
            <div id="boardContent">${board.boardContent}</div>
		</div><br>
		
		<div class="cSection"> <!--아이콘+좋아요+댓글 -->
            <div id="iconList"><!-- 아이콘(좋아요+댓글+공유) -->
               <span id="likeIcon">
                  <c:if test="${board.likeFlag==0}"><img class="icon" src="/images/board/like_empty.png" id="${board.user.userId}"></c:if>
                  <c:if test="${board.likeFlag!=0}"><img class="icon" src="/images/board/like_full.png"></c:if>
               </span>&nbsp;&nbsp;
               <span id="commIcon"><img class="icon" src="/images/board/comment.png"></span>&nbsp;&nbsp;
               <span id="shareIcon"><!-- 공유하기 버튼 클릭시 노출될 항목 -->
                  <img class="icon" src="/images/board/share.png">&nbsp;&nbsp;
                  <img class="iconDetail${board.boardNo}" id="kakaoShare" src="/images/board/share/kakao.png">
                  <img class="iconDetail${board.boardNo}" id="facebookShare" src="/images/board/share/facebook.png">
                  <img class="iconDetail${board.boardNo}" id="naverShare" src="/images/board/share/naver.png">
               </span>
            </div>
            <br>
            
            <!-- 좋아요@개+댓글@개 -->
            <div id="viewList">
               <span id="likePrint${board.boardNo}">좋아요 ${board.likeCnt}개</span>&nbsp;&nbsp;
               <span id="commPrint${board.boardNo}">댓글 ${board.commCnt}개</span>
            </div>
            <br>
            
            <!-- 댓글리스트 -->
            <div id="commListAll">
	            <c:set var="j" value="0"/>
				<c:forEach var="comment" items="${board.comment}">
				<c:set var="j" value="${j+1}"/>
				<c:set var="k" value="${k+1}"/>
					<div id="commList">
						<span id="commListUser" data-toggle="modal" data-target=".userModal" data-whatever="${comment.user.profileImg},${comment.user.userName},${comment.user.userId},${comment.user.introduce}"> <img src="/images/profile/${comment.user.profileImg}" class="img-circle"/> ${comment.user.userId} </span>
						<span id="commListContent${k}">${comment.commentContent}</span>
						<span id="commListDelete" class="${comment.commentNo}" style="display:none;"><img src="/images/board/delete2.png"></span> 
						<span id="commListInquire" id="inquireUser" name="${comment.commentNo}" style="display:none;" data-toggle="modal" data-target="#inquireModal"><img src="/images/board/inquire.png"></span>
					</div>
	            </c:forEach>
	        </div>
            
            <!-- 마지막 댓글달린 시간 -->
            <div id="commLastTime${board.boardNo}" class="${board.commLastTime}"></div>
            
            <!-- 댓글입력폼 -->
            <section class="commProm">
            	<form><textarea id="commContent" name="commContent" placeholder="댓글을 입력해주세요. (50자 이하)" ${empty user.userId ? "readonly" : ""}></textarea></form>
            </section>
      </div>
   </article><br>
   </c:forEach>      
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
				<c:if test="${!empty sessionScope.user}">
					<div class="modalUserButton">
						<button type="button" class="btn btn-primary" id="addFriend">친구추가</button>
						<button type="button" class="btn btn-danger" id="inquireUser" name="" data-toggle="modal" data-target="#inquireModal">유저신고</button>
					</div>
				</c:if>
			</div>
		</div>
	</div>
	<!-- 프로필 클릭시 유저정보 모달창으로 띄움 끝 -->

	<!-- 신고 Modal content 시작 -->
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
	               <form class="inquire_form">
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
	   <!-- 신고 Modal content 끝 -->   
	   
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
	   
	<div style="display:none" id="boardLoading">
		<img src="/images/board/loading3.gif" style="margin-left:40%;">
	</div>

</body>

</html>