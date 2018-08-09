<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<title>너, 나들이</title>
<meta charset="EUC-KR">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

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
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>

<!-- sweet alert CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- 카카오 공유 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- full calendar CDN -->
<script src="/javascript/moment.min.js"></script>
<script src="/javascript/fullcalendar.js"></script>
<script src="/javascript/fullcalendar_ko.js" charset="EUC-KR"></script>
<link rel="stylesheet" href="/css/fullcalendar.css">

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script>

function fncGetList(currentPage) {
   $("#currentPage").val(currentPage)
   $("#detailForm").attr("method", "POST").attr("action", "/schedule/getMyScheduleList").submit();
}

$(function(){
   console.log( ${events_array} );
   
   //* 풀캘린더
   $('#calendar').fullCalendar({
      height: 600, //캘린더 높이 설정
      firstDay: 1, //월요일부터 시작
      customButtons: { //일정생성 바로가기 버튼 커스텀 추가
         gotoAddSchedule: {
            text: '일정 생성하기',
            click: function() {
            	//HJA addschedule
            	$("#transportationModal").modal();
            	//HJA addschedule
            }
          }
      },
      header: { //상단 바 설정
         left: 'prev, next today',
         center: 'title',
            right: 'gotoAddSchedule' //'month,listMonth'
      },
      views: { //가운데 타이틀 커스텀 설정
         month: {
            titleFormat: 'YYYY년 MM월',
            eventLimit: 3, //하루 최대 3개 일정만 보이게 설정
         }
      },
      weekMode: 'variable', //월마다 주 자동으로 표시1
      fixedWeekCount : false, //월마다 주 자동으로 표시2
      columnHeaderHtml: function(mom) { //토요일은 파란색, 일요일은 빨간색으로 표시
          if (mom.weekday() === 5) {
            return "<font color='blue'>토</font>";
          } else if (mom.weekday() === 6) {
           return "<font color='red'>일</font>";
          } else {
            return mom.format('ddd');
          }
      },
      selectable: true, //하루하루 날짜가 선택되도록 설정
      editable: false, //수정 불가하도록 설정
      dropable: false, //드랍 불가하도록 설정
       timeFormat: 'H:mm', //보여질 시간 포멧 설정 //H:24 h:12
      eventLimit: true, //하루 보여질 최대 일정 제한 설정
      eventLimitText: '더보기', //하루 최대 일정이 넘으면 '더보기' 문구 출력
      eventLimitClick: 'popover',
      
       events: ${events_array},
       eventRender: function(event, element) { //공휴일엔 빨간날로 표시
           if (event.className == 'specialDay') {
               element.css({
                   'background-color': '#FF6E6E', //#333333
                   'border-color': '#FF6E6E'
               })
           }else if (event.className == 'generalDay'){
              element.css({
                   'background-color': '#36A8CF',
                   'border-color': '#36A8CF'
               })
           }
       },
       
      
        dayClick : function(date){
           if( new Date(date.format())< new Date()){ //오늘 날짜 이전은 생성불가 설정
              return;
           }
           
           swal({
                title: "해당 날짜엔 나들이 일정이 없습니다.",
                text: date.format()+" 날짜로 일정을 새로 생성하시겠습니까?",
                buttons: ["취소", "생성하기"],
           }).then((willGo) => {
                if (willGo) {
                   
                   swal("교통수단은 무엇으로 지정하시겠습니까?",{
                      buttons: {
                         0: "자동차",
                         1: "도보",
                         2: "대중교통"
                      },
                   }).then((value)=>{
                      switch(value){
                        case "0" :
                           window.open("/schedule/addSchedule?transportationCode=0&date="+date.format()+'');
                           break;
                        case "1" :
                           window.open("/schedule/addSchedule?transportationCode=1&date="+date.format()+'');
                           break;
                        case "2":
                           window.open("/schedule/addSchedule?transportationCode=2&date="+date.format()+'');
                      }
                   })
                }
           });
      },

      eventClick: function(calEvent, jsEvent, view) {
         if(calEvent.id!=0){ //공휴일이 아닐 때만 반응
            console.log(calEvent.title+" 일정으로 이동");
            window.open("/schedule/getSchedule?scheduleNo="+calEvent.id);
              return false;
         }
      },
      
      
   });
   
   
   $("button.btn.btn-default:contains('검색')").on("click", function() {
      fncGetList(1);
   });
   
   //일정에 마우스 올렸을 때 이미 포스팅 한 일정이면 포스팅 못하도록 버튼 막는 스크립트
   $("article").on("mouseover", function(){
      var scheduleNo = $(this).attr("class");
      $.ajax({
         url : "/board/json/checkBoard/"+scheduleNo,
         method : "POST",
         success : function(data){
            console.log(data);
            if(data==1){ //이미 포스팅 한 일정이라면
               $("#shareBoard"+scheduleNo).css("display","none");
            }
         }
      })
   })
   
   //일정 클릭시 일정 상세보기로 이동하는 스크립트
   $("article").on("click", function(){
      self.location="/schedule/getSchedule?scheduleNo="+$(this).attr("class");
   })
   
   //게시물로 공유
   $("button[id^='shareBoard']").on("click", function(e){
      e.stopPropagation();
      var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
      $.ajax({
         url : "/board/json/addBoard/"+scheduleNo,
         method : "POST",
         success : function(data){
            swal("글쓰기 완료!", "마이페이지 내 작성한 글 보기에서 확인가능합니다!", "success");
            $("#shareBoard"+scheduleNo).css("display","none");
            
            //보상 (게시물)
            if( data==5 ){
               swal({
                  title: "축하합니다!",
                  text: "게시물 5회작성 미션을 클리어 하셨습니다!",
                  button: false,
                  className: "rewardModal"
               });
            }else if( data==10 ){
               swal({
                  title: "축하합니다!",
                  text: "게시물 10회작성 미션을 클리어 하셨습니다!",
                  button: false,
                  className: "rewardModal"
               });
            }else if( data==15 ){
               swal({
                  title: "축하합니다!",
                  text: "게시물 15회작성 미션을 클리어 하셨습니다!",
                  button: false,
                  className: "rewardModal"
               });
            }
         }
      }) //e.o.ajax
   })
   
   //SNS로 공유
   Kakao.init('b3eb26586b770154ea49919a7f59f2d2');
   $("button[id^='shareSNS']").on("click", function(e){
      e.stopPropagation();
      var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
      
      Kakao.Link.sendDefault({
           objectType: 'feed',
           content: {
             title: $("."+scheduleNo+" #scheduleTitle").text(),
             description: $("."+scheduleNo+" #scheduleDetail").text()+'\n'+$("."+scheduleNo+" #scheduleHashTag").text(),
             imageUrl: 'http://www.bagooninara.co.kr/data/file/09/096407ec484ac26ac4a55f9e4c903111.jpg',
             link: {
               mobileWebUrl: 'http://localhost:8080/schedule/getSchedule?scheduleNo='+scheduleNo,
               webUrl: 'http://localhost:8080/schedule/getSchedule?scheduleNo='+scheduleNo
             }
           },
           buttons: [{
               title: '웹으로 보기',
               link: {
                 mobileWebUrl: 'http://localhost:8080/schedule/getSchedule?scheduleNo='+scheduleNo,
                 webUrl: 'http://localhost:8080/schedule/getSchedule?scheduleNo='+scheduleNo
               }},{
               title: '앱으로 보기',
               link: {
                 mobileWebUrl: 'http://localhost:8080/schedule/getSchedule?scheduleNo='+scheduleNo,
                 webUrl: 'http://localhost:8080/schedule/getSchedule?scheduleNo='+scheduleNo
               }}]
      });
   })
   
   //일정 삭제
   $("img[id^='deleteSchedule']").on("click", function(e){
      e.stopPropagation();
      var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
      swal({
            title: "일정을 정말 삭제하시겠습니까?",
            text: "일정에 포함된 경유지와 게시물이 함께 삭제됩니다.",
            icon: "warning",
            buttons: ["취소", "삭제"],
            dangerMode: true,
          })
          .then((willDelete) => {
            if (willDelete) {
             $.ajax({
                url : "/restschedule/deleteSchedule/"+scheduleNo,
                method : "POST",
                success : function(){
                   swal("일정이 정상적으로 삭제되었습니다.", { icon: "success" });
                   $("."+scheduleNo).remove();
                }
             }) //e.o.ajax
            } else {
              swal("취소하였습니다.",{ icon: "error" });
            }
      });
   })
   
   //일정 수정
   $("button[id^='updateSchedule']").on("click", function(e){
      e.stopPropagation();
      var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
      self.location="/schedule/updateSchedule?scheduleNo="+scheduleNo;
      //alert(scheduleNo+"번 일정을 수정합니다..");
   })
   
   //URL 복사
   $("button[id^='shortURL']").on("click", function(e){
      e.stopPropagation();

      var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
      $.ajax({
         url : "/restschedule/shortURL/"+scheduleNo,
         method : "POST",
         success : function(){
            swal("클립보드에 복사되었습니다!", "Ctrl+V 를 이용해 친구들에게 공유해보세요!", "success");
         }
      })
   })
    
});

$(function(){
	
	// 버튼이면서 updateScheduleReview로 시작하는거 클릭했을때!!
	$("button[id^='updateReview']").on("click", function(e){
		e.stopPropagation();
	
		var scheduleNo =  $(this).attr("id").replace(/[^0-9]/g,"");
		$("#modalscheduleNo").val(scheduleNo);
		$("#review").modal();
	});
	
	// modal전송 버튼을 눌렀을때
	$("#reviewmodalinsert").on("click", function(){
 		$.ajax({
			method : "POST",
			url : "/restschedule/updateReview",
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			data : JSON.stringify({ // 서버로 보낼 데이터 명시 
				scheduleNo : $("#modalscheduleNo").val(),
				scheduleReview : $("#modalscheduleReview").val()
			}),
			success : function(){
			}
		});
		swal("리뷰가 등록되었어요!");
		// 모달을 닫습니다.
		$("#review").modal('hide');
	});
	   
});

</script>

<style>

.fc {
	padding : 20px;
}

.user-profile-section {
	padding-top: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	margin-top: 15px;
	margin-bottom: 15px;
	background: white;
	border-radius: 10px;
	box-shadow: 1px 2px 10px 0px #c7c7c7;
}

.user-detail-section {
	background: white;
	margin: 15px 0px 15px 0px;
	border-radius: 10px;
	box-shadow: 1px 2px 10px 0px #c7c7c7;
}

@media only screen and (max-width : 600px) {
	.user-profile-section {
		margin: 0px;
	}
}

.container-mypage {
	padding-top: 10px;
}

.row-mypage {
	margin-bottom: 15px;
}

@media only screen and (min-width: 900px) { /* PC일때 */
	.contentRow {
		display: flex;
		flex-wrap: wrap;
		justify-content: space-around;
	}
	.form-inline.formTagCss {
		float: right;
	}
	.text-primary.pTagCss {
		margin: 0px;
		text-align: right;
		padding-top: 7px;
	}
	.thumbImg img {
		width: 250px;
		height: 250px;
		opacity: 1;
		transition: .5s ease;
	}
}

@media only screen and (max-width: 600px) { /* 모바일일때 */
	.text-primary.pTagCss {
		text-align: center;
	}
	.thumbImg img {
		width: 200px;
		height: 200px;
		opacity: 1;
		transition: .5s ease;
	}
}

article {
	display: inline-block;
	position: relative;
	cursor: pointer;
}

article:hover .thumbImg img {
	opacity: 0.3;
}

article:hover .links, article:hover .linksIcon {
	opacity: 1;
}

.links {
	opacity: 0;
	position: absolute;
	text-align: center;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	transition: .5s ease;
	width: 80%
}

.linksIcon {
	opacity: 0;
	position: absolute;
	top: 10%;
	left: 90%;
	transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	transition: .5s ease;
}

.linksIcon img {
	width: 15px;
	height: 15px;
}

.rewardModal /*,.swal-overlay*/ {
	background-image: url("/images/board/reward.gif");
}

}
</style>

</head>

<body>

	<%@include file="/layout/new_toolbar.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-3">
				<div class="col-md-12 user-profile-section">
					<c:if test="${!empty user.profileImg && user.profileImg!=' '}">
						<img src="/images/profile/${user.profileImg}" width="133"
							height="133" class="img-circle">
						<br />
						<br />
					</c:if>
					<c:if test="${ empty user.profileImg} ">
						<img src="/images/profile/default.png" width="133" height="133"
							class="img-circle">
					</c:if>
		
					<br /> <a href="/user/getUser">내 정보 보기</a><br /> <br /> 
						<a href="/user/updateUser">내 정보 수정</a><br /> <br /> 
						<a href="/friend/listFriend2">친구 목록</a><br /> <br /> 
						<a href="/board/getMyBoardList">작성한 글</a><br /> <br /> 
						<a href="/schedule/getMyScheduleList">내 일정</a><br /> <br /> 
						<a href="/cart/getMyCartList">장소 바구니</a><br /> <br /> <br /> <br />
					<br /> <br /> <br /> <br /> <br /> <br /> 
						<a href="/user/logout">로그아웃</a><br /> <br />
				</div>
			</div>

			<div class="col-xs-12 col-md-9">

				<div class="col-md-12 user-detail-section">

					<!-- 캘린더 -->
					<div class="row row-mypage">
						<div id="calendar" class="fc fc-ltr fc-bootstrap4"></div>
					</div>

					<!-- 검색어 -->
					<div class="row row-mypage">
						<div class="col-md-6">
							<p class="text-primary pTagCss">
								총 <b>${resultPage.totalCount}</b>개의 일정이 있습니다!
							</p>
						</div>
						<div class="col-md-6">
							<form id="detailForm" class="form-inline formTagCss"
								name="detailForm">
								<div class="form-group">
									<select class="form-control" name="searchCondition">
										<option value="0"
											${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>제목</option>
										<option value="1"
											${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>해쉬태그</option>
									</select>
								</div>
								<div class="form-group">
									<label class="sr-only" for="searchKeyword">검색어</label> <input
										type="text" class="form-control" id="searchKeyword"
										name="searchKeyword" placeholder="검색어"
										value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
								</div>
								<button type="button" class="btn btn-default">검색</button>
								<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
								<input type="hidden" id="currentPage" name="currentPage" value="1" />
							</form>
						</div>
					</div>

					<!-- 작성한 글 리스트 뜨는 부분 -->
					<div class="row row-mypage">
						<c:set var="i" value="0" />
						<c:forEach var="schedule" items="${list}">

							<c:if test="${i%3==0}">
								<div class="row row-mypage contentRow">
							</c:if>

							<c:set var="i" value="${i+1}" />

							<article class="${schedule.scheduleNo}">
								<!-- 썸네일 형식의 작성한 글 이미지 -->
								<div class="thumbImg" style="width: auto; height: 250px;">
									<c:if test="${fn:length(schedule.scheduleImg) <= 1}">
										<img src="/images/spot/421.jpg" class="img-thumbnail">
									</c:if>
									<c:if test="${fn:length(schedule.scheduleImg) > 1}">
										<c:if test="${(schedule.scheduleImg).contains(',')}">
											<img
												src="/images/spot/uploadFiles/${schedule.scheduleImg.split(',')[0]}"
												class="img-thumbnail">
										</c:if>
										<c:if test="${!(schedule.scheduleImg).contains(',')}">
											<img src="/images/spot/uploadFiles/${schedule.scheduleImg}"
												class="img-thumbnail">
										</c:if>
									</c:if>
								</div>
								<!-- 마우스 오버시 보여지는 부분 -->
								<div class="links" style="text-align: center;">
									<span id="scheduleTitle"><b>${schedule.scheduleTitle}</b><br></span>
									<span id="scheduleDetail">${schedule.scheduleDetail}<br>
										<br></span> <span id="scheduleHashTag">${schedule.hashTag}<br>
										<br></span>	
									<button type="button" class="btn btn-primary btn-xs"
										id="shortURL${schedule.scheduleNo}">URL 복사하기</button>
									<button type="button" class="btn btn-primary btn-xs"
										id="updateReview${schedule.scheduleNo}">일정 리뷰등록</button>
									<br>
									<button type="button" class="btn btn-warning btn-xs"
										id="shareSNS${schedule.scheduleNo}">카카오로 공유하기</button>
									<button type="button" class="btn btn-warning btn-xs"
										id="shareBoard${schedule.scheduleNo}">게시물로 공유하기</button>
									<br>
									<button type="button" class="btn btn-default btn-xs"
										id="updateSchedule${schedule.scheduleNo}">일정 수정하기</button>
								</div>
								<div class="linksIcon">
									<img id="deleteSchedule${schedule.scheduleNo}"
										src="/images/board/delete2.png">
								</div>
							</article>

							<c:if test="${i%3==0}">
					</div>
					</c:if>

					</c:forEach>

					<c:if test="${empty list}">
						<span id="defaultText" style="margin-left: 40%;">생성하신 일정이
							없습니다. ㅠㅠ</span>
					</c:if>

				</div>

			</div>

		</div>
	</div>
	<!-- HJA 일정등록 transportation navigation -->
<!-- 처음 입장시 여러가지 정보를 적는 modal 창 start -->
<div class="modal" id="transportationModal" role="dialog">
	<div class="modal-dialog modal-sm dialogue-schedule" data-dismiss="modal">
		<div class="modal-content modal-schedule">
			<div class="modal-header schedule-header">
				<h4 class="modal-title schedule-title"> 이동수단을 선택해주세요. </h4>
				<button type="button" class="close closer-schedule" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body schedules-icons">
				<div class="walk"><img src="/images/common/walk.png" class="schedule-trans"></div>
				<div class="car"><img src="/images/common/car.png" class="schedule-trans"></div>
				<div class="public"><img src="/images/common/public.png" class="schedule-trans"></div>
			</div>
		</div>
	</div>
</div>
	
	
	
	<!-- 리뷰를 등록하는 모달창! --> 
	<form id="reviewform">
            <div class="modal" id="review" role="dialog"> 
                <div class="modal-dialog modal-sm"> 
                    <div class="modal-content"> 
                        <div class="modal-header"> 
                            <button type="button" class="close" data-dismiss="modal">&times;</button> 
                            <h4 class="modal-title">나들이 어떠셨어요??</h4> 
                        </div>
					<div class="modal-body">
						<div class="form-group">
							<label for="scheduleTitle">후기작성</label> 
							<input type="text" class="form-control" id="modalscheduleReview" name="scheduleReview" placeholder="나들이 후기를 작성해주세요!">
							<input type="hidden" id="modalscheduleNo" name="scheduleNo">
					</div>
						<div class="modal-footer"> 
                            <button type="button" class="btn btn-danger modalModBtn" id="reviewmodalinsert">입력!</button> 
                        </div> 
                    </div> 
                </div> 
            </div>
       </form>
       
       
</body>
</html>