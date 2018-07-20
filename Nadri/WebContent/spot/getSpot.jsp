<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Bootstrap CDN -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<!-- 구글맵을 불러쓰기위한 CDN -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDLmpiP9iv7Bf7XzkdB28SsOkNvgzxxvFs&callback=initMap"></script>
<!-- 툴바 넣는 CDN 입니다 -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">
<html>
<style>
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

#map {
	height: 30%;
}
</style>
<script type="text/javascript">

	$(function() {
		$("button.btn.btn-success.modalModBtn").on("click", function() {
			$("#cart").attr("method","POST").attr("action" , "/cart/addCart").submit();
		});
		
		$("button.btn.btn-primary").on("click", function() {
			history.go(-1);
		});
		
		$("button.btn.btn-danger").on("click", function() {
			self.location = "/purchase/addPurchase?prodNo=${product.prodNo}";
		});

	});
	
	function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: ${spot.spotX} , lng: ${spot.spotY}},
          zoom: 14,
          scrollwheel: false
        });
        
        var nowposition = new google.maps.LatLng(${spot.spotY}, ${spot.spotX}),    
        message = '여기에요!'
        
    displayMarker(nowposition, message);
      }
	
	// 지도에 마커와 인포윈도우를 표시하는 함수입니다
	function displayMarker(nowposition, message) {
	    // 마커를 생성합니다
	    var marker = new google.maps.Marker({  
	        map: map, 
	        position: nowposition
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
	<%@ include file="/layout/toolbar.jsp"%>
		<div class="wrapper">
			<%-- Content Wrapper. Contains page content --%>
			<div class="content-wrapper">
				<%-- Content Header (Page header) --%>
				<div class="jumbotron" id="map">
				</div>
				<%-- Main content --%>
				<section class="content container-fluid">
					<div class="col-lg-12">
							<div class="box box-primary">
								<div class="box-header with-border">
									<h5 class="text-muted">
										선택하신 장소백과의 <strong class="text-danger">상세정보 </strong>입니다!
									</h5>
								</div>
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2">
											<strong>장소번호</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotNo}</div>
									</div>
								</div>

								<hr />

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>장소명</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotTitle}</div>
									</div>
								</div>
								<hr />
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>장소이미지</strong>
										</div>
										<div class="col-xs-8 col-md-4">
											<c:if test="${spot.spotCode==0 }">
												<img src="${spot.spotImg}" width="300" height="300" />
											</c:if>
											<c:if test="${spot.spotCode !=0 }">
												<img src="/images/spot/${spot.spotImg}" width="300" height="300" />
											</c:if>
										</div>
									</div>
								</div>

								<hr />

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2">
											<strong>장소상세정보</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotDetail}</div>
									</div>
								</div>

								<hr />

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>장소주소</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotAddress}</div>
									</div>
								</div>

								<hr />
								
							<!-- 전화번호는 있는 장소도 있고 없는 장소도 있으므로 널체크를 해줍니다. -->
							<c:if test="${not empty spot.spotPhone }">
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>연락처</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotPhone}</div>
									</div>
								</div>

								<hr />
							</c:if>
							
							<!-- 장소URL은 있는 장소도 있고 없는 장소도 있으므로 널체크를 해줍니다. -->
							<c:if test="${not empty spot.spotDetailURL }">
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>장소URL</strong>
										</div>
										<a href="${spot.spotDetailURL}"><div class="col-xs-8 col-md-4">${spot.spotDetailURL}</div></a>
									</div>
								</div>

								<hr />
							</c:if>

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>장소시군구</strong>
										</div>
										<div class="col-xs-8 col-md-4">
											<c:if test="${spot.spotProvince == 1}">
										     강남구
										  </c:if>
											<c:if test="${spot.spotProvince == 2}">
										     강동구
										  </c:if>
											<c:if test="${spot.spotProvince == 3}">
										     강북구
										  </c:if>
											<c:if test="${spot.spotProvince == 4}">
										     강서구
										  </c:if>
											<c:if test="${spot.spotProvince == 5}">
										     관악구
										  </c:if>
											<c:if test="${spot.spotProvince == 6}">
										     광진구
										  </c:if>
											<c:if test="${spot.spotProvince == 7}">
										     구로구
										  </c:if>
											<c:if test="${spot.spotProvince == 8}">
										     금천구
										  </c:if>
											<c:if test="${spot.spotProvince == 9}">
										     노원구
										  </c:if>
											<c:if test="${spot.spotProvince == 10}">
										     도봉구
										  </c:if>
											<c:if test="${spot.spotProvince == 11}">
										     동대문구
										  </c:if>
											<c:if test="${spot.spotProvince == 12}">
										     동작구
										  </c:if>
											<c:if test="${spot.spotProvince == 13}">
										     마포구
										  </c:if>
											<c:if test="${spot.spotProvince == 14}">
										     서대문구
										  </c:if>
											<c:if test="${spot.spotProvince == 15}">
										    서초구
										  </c:if>
											<c:if test="${spot.spotProvince == 16}">
										     성동구
										  </c:if>
											<c:if test="${spot.spotProvince == 17}">
										     성북구
										  </c:if>
											<c:if test="${spot.spotProvince == 18}">
										   송파구
										  </c:if>
											<c:if test="${spot.spotProvince == 19}">
										     양천구
										  </c:if>
											<c:if test="${spot.spotProvince == 20}">
										     영등포구
										  </c:if>
											<c:if test="${spot.spotProvince == 21}">
										     용산구
										  </c:if>
											<c:if test="${spot.spotProvince == 22}">
										     은평구
										  </c:if>
											<c:if test="${spot.spotProvince == 23}">
										     종로구
										  </c:if>
											<c:if test="${spot.spotProvince == 24}">
										    중구
										  </c:if>
											<c:if test="${spot.spotProvince == 25}">
										     중랑구
										  </c:if>
										</div>
									</div>
								</div>

								<hr />

								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>장소작성일자</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotCreateTime}</div>
									</div>
								</div>

								<hr />
								<div class="box-body">
									<div class="row">
										<div class="col-xs-4 col-md-2 ">
											<strong>장소수정일자</strong>
										</div>
										<div class="col-xs-8 col-md-4">${spot.spotModifyTime}</div>
									</div>
								</div>

								<hr />

							</div>

							<!-- 이제부터 구매리뷰를 뽑아내는 부분입니다. -->
							<div class="box box-primary">
								<div class="box-header with-border">
									<h5 class="text-muted">
										선택하신 물품의 <strong class="text-danger">리뷰 </strong>입니다!
									</h5>
								</div>
								<div class="box-body">
									<c:set var="i" value="0" />
									<c:forEach var="product" items="${reviewlist}">
										<c:set var="i" value="${i+1 }" />
										<div class="row">
											<div class="col-xs-4 col-md-2">
												<strong>구매아이디</strong>
											</div>
											<div class="col-xs-8 col-md-4">${product.buyerId}</div>
											<br />
											<div class="col-xs-4 col-md-2">
												<strong>구매리뷰</strong>
											</div>
											<div class="col-xs-8 col-md-4">${product.review}</div>
											</tr>
									</c:forEach>
								</div>
							</div>

							<!-- 구매리뷰 뽑아내는 부분 마지막입니다. -->

							<div class="box-footer">
								<button type="button" class="btn btn-primary">
									<i class="fa fa-list"></i> 목록
								</button>
								<div class="pull-right">
									<c:if test="${product.prodQuantity!=0}">
										<button type="button" class="btn btn-danger">
											<i class="fa fa-save"></i> 목록으로
										</button>
										<button type="button" class="btn btn-info" data-toggle='modal' data-target='#modifyModal'>장바구니</button>
									</c:if>
								</div>
						</form>
					</div>
				</section>

				<!-- 장바구니추가 modal 창 start -->
				<form id=cart>
					<input type="hidden" name="price" value="${spot.spotNo}" />
					<div class="modal fade" id="modifyModal" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">장바구니 추가</h4>
								</div>
								<div class="modal-body">
									<div class="form-group">
										<label for="spotNo">장소번호</label> <input class="form-control"
											id="spotNo" name="spotNo" value="${spot.spotNo}" readonly>
									</div>
									<div class="form-group">
										<label for="spotTitle">장소이름</label> <input
											class="form-control" id="spotTitle" name="spotTitle"
											value="${spot.spotTitle}" readonly>
									</div>
									<div class="form-group">
										<label for="cartQuantity">어떤일로 추가하셨나요?</label> <input
											type="hidden" name="productQuantity"
											value="${product.prodQuantity}"> <input type="text"
											class="form-control" name="cartQuantity" id="quantity"
											class="quantity" value="" />
									</div>
									<div class="form-group">
										<label for="buyerId">추가자아이디</label> <input
											class="form-control" id="buyerId" name="buyerId"
											value="${sessionScope.user.userId}" readonly>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-success modalModBtn" id="abc">장소바구니추가</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>

		</div>
</body>

</html>

