<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- Bootstrap CDN -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<title>너나들이 통합검색결과</title>
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>

<!--  slick  -->
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="/css/fonts/kirang/fonts.css" />
<link rel="stylesheet" type="text/css" href="/css/fonts/JuA/fonts.css" />
<link rel="stylesheet" type="text/css"
	href="/css/fonts/HanNa11/fonts.css" />

<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<link rel="stylesheet" type="text/css" href="/css/totalSearchView.css" />
<!-- <script src="/javascript/indexReal.js"></script> -->
<script src="/javascript/indexReal_nonIndex.js"></script>
<script src="/javascript/total_search_view.js"></script>

</head>
<body>

<%@include file="/layout/new_toolbar.jsp"%>

	<div class="container search-result-container">
		<div class="content-box">
			<div class="search-title-wrapper">
				<h2>
					' <span style="font-weight: 700">${searchKeyword}</span> '의
					검색결과입니다.
				</h2>
				<!-- <div class="option-on-off on">검색옵션켜기</div>
				<div class="option-on-off off">검색옵션끄기</div>
				<div class="open-searcher">
					<label class="switch"> <input type="checkbox"> <span
						class="slider round"></span>
					</label>
				</div> -->
			</div>
			<div class="map-wrapper">
				<div class="row search-results">
					<div class="col-md-12">
						<div id="map"></div>
						<div class="map-button"></div>
					</div>
				</div>
				<div class="row place-info search-results">
					<div class="col-md-6 col-xs-12">
						<div class="map-detail-wrapper">
							<h3 class="placeTitle"></h3>
							<div class="placeContent"></div>
						</div>
					</div>
					<div class="col-md-6 col-xs-12">
						<img src="/images/common/no_image.jpg" class="placeImg" style="background-color: black; width: 100%; height: 300px;">
					</div>
				</div>
			</div>
		</div>
		<div class="search-results">
			<div class="">
				<div class="col-md-12 col-xs-12 section-title board-section"
					style="display: flex; justify-content: space-between; align-items: center;">
					<div class="title-flex-box">
						<h3 class="menu-title" style="display: inline-block; font-weight: 700;">게시글</h3>
						<div class="mini-title">너나들이 유저들이 직접 작성한 게시물들입니다.</div>
					</div>
					<div class="board-more">더보기 >></div>
				</div>
				<hr />
				<c:if test="${!empty list_board}">
					<c:set var="i" value="0" />
					<c:forEach var="board" items="${list_board}" end="5">
						<c:set var="i" value="${i+1}" />
						<div class="col-md-4 col-xs-6 board-box">
							<img src="/images/board/posts/${board.boardImg}"
								class="boardImg" style="width: 100%; height: 200px;">
							<div class="boardBox">
								<h3 class="board-link" id="${board.boardNo}">${board.boardTitle}</h3>
								<div class="board-contents">${board.boardContent}</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${empty list_board}">
					<div class="col-md-12 col-xs-12 board-box no-boards">
						<div>검색된 게시물이 없습니다.</div>
					</div>
				</c:if>
			</div>

			<div>
				<div class="col-md-12 col-xs-12 section-title schedule-section"
					style="display: flex; justify-content: space-between; align-items: center;">
					<div class="title-flex-box">
						<h3 class="menu-title" style="display: inline-block; font-weight: 700;">일정</h3>
						<div class="mini-title">너나들이 유저들이 직접 생성한 일정들입니다.</div>
					</div>
					<div class="see-more">더보기 >></div>
				</div>
				<hr />
				<c:if test="${!empty list_schedule}">
					<c:set var="i" value="0" />
					<c:forEach var="schedule" items="${list_schedule}" end="3">
						<c:set var="i" value="${i+1}" />
						<div class="col-md-6 col-xs-12 board-box">
							<img src="/images/spot/uploadFiles/${schedule.schedule_img}" class="boardImg"
								style="width: 100%; height: 200px;">
							<div class="boardBox">
								<h3 class="schedule-link" id="${schedule.schedule_no}">${schedule.schedule_title}</h3>
								<div class="board-contents">${schedule.schedule_detail}</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${empty list_schedule}">
					<div class="col-md-12 col-xs-12 board-box no-boards">
						<div>검색된 게시물이 없습니다.</div>
					</div>
				</c:if>
			</div>

			<div>
				<div class="col-md-12 col-xs-12 section-title"
					style="display: flex; justify-content: space-between; align-items: center;">
					<h3 style="display: inline-block; font-weight: 700;">인스타그램</h3>
					<div>더보기 >></div>
				</div>
				<hr />

				<c:set var="i" value="0" />
				<c:forEach var="insta" items="${insta_list}">
					<c:set var="i" value="${i+1}" />
					<div class="col-md-3 col-xs-4 insta-box">
						<a href="https://www.instagram.com/p/${insta.shortLink}" target="_blank"><img src="${insta.img}" class="boardImg" style="width: 100%;"></a>
					</div>
				</c:forEach>
			</div>

		</div>
	</div>

	<script>
	
		
		// Initialize and add the map
		function initMap() {
			var locations;
			var size = ${spot_location.size()};
			
			console.log(size);
			
			if (size == 0) {
				locations = [ '검색결과가 없습니다.', 37.581095, 126.977156 ];
				var map = new google.maps.Map(document.getElementById('map'), {
					zoom : 15,
					center : new google.maps.LatLng(37.581095, 126.977156),
					mapTypeId : google.maps.MapTypeId.ROADMAP

				});
			} else {
				locations = ${spot_location};
				var map = new google.maps.Map(document.getElementById('map'), {
					zoom : 15,
					center : new google.maps.LatLng(locations[0][2],
							locations[0][3]),
					mapTypeId : google.maps.MapTypeId.ROADMAP

				});
			}

			var infowindow = new google.maps.InfoWindow();

			var marker, i;

			if (size == 0) {
				console.log('검색결과가 없습니다.');
				$('.placeTitle').text("검색결과가 없습니다.");
				$('.placeContent').text("검색된 결과의 내용이 없습니다.");
				$('.placeImg').attr("src","/images/common/no_image.jpg");
			} else {
				for (i = 0; i < locations.length; i++) {
					marker = new google.maps.Marker({
						position : new google.maps.LatLng(locations[i][2],
								locations[i][3]),
						icon : locations[i][0],
						map : map
					});

					google.maps.event.addListener(marker, 'click', (function(
							marker, i) {
						return function() {
							infowindow.setContent(locations[i][1]);
							infowindow.open(map, marker);
							$('.placeTitle').text(locations[i][1]);
							$('.placeContent').text(locations[i][4]);
							////////////////////////////HJA 수정... 공원도 이미지를 보일 수 있도록!!////////////
							if(locations[i][5].length <= 15){
							$('.placeImg').attr("src",
									"/images/spot/" + locations[i][5]);
							} else {
								$('.placeImg').attr("src", locations[i][5]);
							}
							//////////////////////////////////////////////////////////////////////////
							$('.placeTitle').attr('name', locations[i][6]);
						}
					})(marker, i));
				}

				$('.placeTitle').text(locations[0][1]);
				$('.placeTitle').attr('name', locations[0][6]);
				$('.placeContent').text(locations[0][4]);
				//alert( locations[0][5]);
				////////////////////////////HJA 수정... 공원도 이미지를 보일 수 있도록!!////////////
				if(locations[0][5].length <= 15){
					$('.placeImg').attr("src", "/images/spot/" + locations[0][5]);
				} else {
			        $('.placeImg').attr("src", locations[0][5]);
				}
				//////////////////////////////////////////////////////////////////////////
				//$('.placeImg').attr("src", locations[0][5]);
			}

		}
		
		$(document).ready(function(){
			// 맵을 시작하는 메서드입니다.
			initMap();
		}); // 처음 시작될때 클릭버튼 세팅
	</script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAq2HYLHx3q-LM3MusYKsjXVZUik30YqUI&callback=initMap">
	</script>
</body>
</html>