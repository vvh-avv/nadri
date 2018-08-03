<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Bootstrap CDN -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<!-- juanMap.js CDN --> 
<script src="/javascript/juanMap.js"></script> 
<!-- sweetAlert CDN -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)" href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>
<!-- materialize 넣는 css -->
<!-- <script src="/javascript/materialize.js"></script>
<link rel="stylesheet" href="/css/materialize.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> -->

<html>
<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

.detail-box{
	background : white;
	padding : 20px;
	padding-bottom : 50px;
}

.box-footer{
	display : flex;
	justify-content: center;
	padding : 0px 50px 0px 50px;
	width : 100%;
}

.pull-left{
	display : flex;
	width : 100%;
	justify-content: space-evenly;
	margin-top : 20px;
}

.spot-top-box{
	width : 65%;
	margin-left:auto;
	margin-right:auto;
}

@media only screen and (max-width : 600px){
	.spot-top-box{
		width : 100%;
		margin-left:auto;
		margin-right:auto;
	}
}

.nav-wrapper{
	border-radius: 0px 0px 60px 60px;
	background: linear-gradient(#888888,#525252);
	margin: 0px 15px 15px 15px;
	box-shadow : 1px 2px 10px 0px #a7a7a7;
}

#nav-mobile{
	list-style: none;
	display : flex;
	margin : 0px;
	justify-content: space-evenly;
	padding : 15px;
	color : white;
}

#nav-mobile:hover{
	z-index : 99;
}

li > span{
	transition : all 1s;
}

li > span:hover{
	cursor : pointer;
	font-weight : 900;
	font-size:20px;
}

#map {
	height: 30%;
}

/*맨위로가게만들어주는 css */
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
   
   /*모달 위치 비교 css */
.modal {
	top : 20%;
} 

.container {
    text-align: center;
}  	
</style>
<script type="text/javascript">

//맨위로 올라가게 만들어 주는 script
$(function(){
	
	$("#nologininquire").on("click", function(){
	       swal("로그인후 이용해주세요!");
	    });
		
		$("#nologincart").on("click", function(){
			swal("로그인후 이용해주세요!");
	    });
		
    //*스크롤감지
    $(window).scroll(function(){
        var scrollLocation = $(window).scrollTop(); //브라우저의 스크롤 값
        
        if(scrollLocation!=0){ //화면을 내리면 gotoTop 뜨게하고
            $(".gotoTop").fadeIn();
        }else{                    //화면을 올리면 gotoTop 사라지게하기
            $(".gotoTop").fadeOut();
        }
    })
 
    //*상단에 둥둥 떠있는 아이콘 (상단으로 이동)
    $(".gotoTop").on("click", function(){
        $("body").scrollTop(0);
    });
    
    $("#listbutton").on("click", function() {
		history.go(-1);
	});
	
	$("button.btn.btn-secondary.modalModBtn").on("click", function() {
		swal("Good job!", "장소바구니에 추가했습니다!!", "success")
		addCartSpot();
		//$("#cartModal").modal('hide');
		//sweetalert쓰기위한 javascript
	});
});

function addCartSpot(){
	//$("#cart").attr("method","POST").attr("action" , "/restcart/addCartSpot").submit();
	$.ajax({
				type : 'post', // 요청 method 방식 
				url : '/restcart/addCartSpot',// 요청할 서버의 url
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'json', // 서버로부터 되돌려받는 데이터의 타입을 명시하는 것이다.
				data : JSON.stringify({ // 서버로 보낼 데이터 명시 
					spotNo : $("#spotNo").val(),
					userId : $("#userId").val(),
					cartDetail : $("#cartDetail").val(),
					cartTitle : $("#cartTitle").val(),
					cartAddress :$("#cartAddress").val(),
					cartX : $("#cartX").val(),
					cartY : $("#cartY").val(),
					cartImg : $("#cartImg").val()
				}),
				success : function(data) {// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
				}// success
	});// ajax
};

		
	function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 14,
          scrollwheel: false
        });
        
        var nowposition = new google.maps.LatLng(JSON.stringify(${a.response.body.items.item.mapy}), JSON.stringify(${a.response.body.items.item.mapx})),    
        message = '<div style="font-family : seoul"><div>여기예요!</div></div>';
        
    	displayMarker(nowposition, message);
      }
	
	// 지도에 마커와 인포윈도우를 표시하는 함수입니다
	function displayMarker(nowposition, message) {
	    // 마커를 생성합니다
	    var marker = new google.maps.Marker({  
	        map: map, 
	        position: nowposition,
	        icon: icons['picnic'].icon
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
</script>

<head>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<body class="hold-transition skin-blue sidebar-mini layout-boxed">

<!-- 상단에 둥둥 떠있는 아이콘 (상단으로 이동) -->
<img class="gotoTop" src="/images/board/gotoTop.png" alt="맨위로!">

<%@include file="/layout/new_toolbar.jsp"%>

			<div class="container detail-box">
				<%-- Content Header (Page header) --%>
				<div class="jumbotron" id="map">
				</div>
				<%-- Main content --%>
					<div class="col-lg-12">
								<div class="box-header with-border">
									<h5 class="text-align-center" style="text-align: center;">
										선택하신 나들이백과의 <strong class="text-danger">상세정보 </strong>입니다!
									</h5>
								</div>
								<br />

								<div class="box-body-center">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>장소명</strong>
										</div>
										<div class="col-xs-8 col-md-10">${a.response.body.items.item.title}</div>
									</div>
								</div>
								<hr />
								
								<c:if test="${not empty a.response.body.items.item.firstimage}">
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>장소이미지</strong>
										</div>
										<div class="col-xs-8 col-md-10">
												<img class="materialboxed"  src='${a.response.body.items.item.firstimage}' width="300" height="200" />
										</div>
									</div>
								</div>

								<hr />		
								</c:if>
								
								<c:if test="${empty a.response.body.items.item.firstimage}">
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>장소이미지</strong>
										</div>
										<div class="col-xs-8 col-md-10">
												<img class="materialboxed"  src='/images/spot/festivaldefault.jpg' width="30%" height="20%" />
										</div>
									</div>
								</div>

								<hr />
								</c:if>

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2">
											<strong>상세정보</strong>
										</div>
										<div class="col-xs-8 col-md-10">${a.response.body.items.item.overview}</div>
									</div>
								</div>

								<hr />

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>주소</strong>
										</div>
										<div class="col-xs-8 col-md-10">${a.response.body.items.item.addr1}</div>
									</div>
								</div>

								<hr />
								
							<!-- 전화번호는 있는 장소도 있고 없는 장소도 있으므로 널체크를 해줍니다. -->
							<c:if test="${not empty a.response.body.items.item.tel }">
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>연락처</strong>
										</div>
										<div class="col-xs-8 col-md-10">${a.response.body.items.item.tel}</div>
									</div>
								</div>

								<hr />
							</c:if>
							
							<!-- 장소URL은 있는 장소도 있고 없는 장소도 있으므로 널체크를 해줍니다. -->
							<c:if test="${not empty a.response.body.items.item.homepage }">
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>장소URL</strong>
										</div>
										<div class="col-xs-8 col-md-10">${a.response.body.items.item.homepage}</div>
									</div>
								</div>

								<hr />
							</c:if>

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>장소구</strong>
										</div>
										<div class="col-xs-8 col-md-10">
										     ${a.response.body.items.item.telname}
										</div>
									</div>
								</div>

								<hr />
								
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>작성일자</strong> / <strong>수정일자</strong>
										</div>	
											<c:set var="createdtime" value="${a.response.body.items.item.createdtime}"/>
											<c:set var="modifiedtime" value="${a.response.body.items.item.modifiedtime}"/>
										<div class="col-xs-8 col-md-10">
											 ${fn:substring(createdtime,0,8) } / ${fn:substring(modifiedtime,0,8) }
										</div>
									</div>
								</div>
								
								<hr/>
								
							</div>					
							
							<div class="box-footer">
								<div class="pull-left">
									<button type="button" class="btn btn-secondary" id="listbutton"><i class="fa fa-list"></i> 목록으로</button>
									<c:if test="${sessionScope.user.userId != null}">
										<button type="button" class="btn btn-secondary" id="inquirebutton"><i class="fa fa-save"></i> 신고하기</button>
										<button type="button" class="btn btn-secondary" data-toggle='modal' data-target='#cartModal'>장소바구니 추가</button>
									</c:if>
									<c:if test="${sessionScope.user.userId == null}">
										<button type="button" class="btn btn-secondary" id="nologininquire"><i class="fa fa-save"></i> 신고하기</button>
										<button type="button" class="btn btn-secondary" id="nologincart">장소바구니 추가</button>
									</c:if>	
								</div>											
							</div>
							
						</div>
									
				<form id=cart>
					<div class="modal fade" id="cartModal" role="dialog">
						<div class="modal-dialog" id="cartModal">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">장소바구니 추가</h4>
								</div>
								<div class="modal-body">
										<input type="hidden"id="spotNo" name="spotNo" value="${a.response.body.items.item.contentid}" >
									<div class="form-group">
										<label for="cartTitle">어떤 이름으로 추가하시겠어요?</label> 
										<input class="form-control" id="cartTitle" name="cartTitle" value="${a.response.body.items.item.title}" >
									</div>
										<input type="hidden" id="cartX" name="cartX" value="${a.response.body.items.item.mapx}" >
                                        <input type="hidden"  id="cartY" name="cartY" value="${a.response.body.items.item.mapy}" >
										<input type="hidden" id="cartAddress" name="cartAddress" value="${a.response.body.items.item.addr1}">
									<div class="form-group">
										<label for="cartDetail">어떤일로 추가하셨나요?</label> 
										 <input type="text" class="form-control" name="cartDetail" id="cartDetail" value="" />
									</div>
									<input type="hidden" id="userId" name="userId" value="${sessionScope.user.userId}">
									<input type="hidden" id="cartImg" name="cartImg" value="${a.response.body.items.item.firstimage}" >
							</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary pull-left" data-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-secondary modalModBtn" data-dismiss="modal">추가</button>
								</div>
							</div>
						</div>
					</div>
				</form>
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
				
			</div>
				
<!-- 구글맵을 불러쓰기위한 CDN -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>

</body>
</html>

