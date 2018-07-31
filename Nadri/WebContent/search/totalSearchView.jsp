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
<script src="/javascript/total_search_view.js"></script>

</head>
<body>

		<nav class="head-section">
		<div class="fix-box">
			<div class="container header-box">
				<span class="glyphicon glyphicon-apple maincon"></span>
				<div class="title-section">
					<div class="title-text">너,나들이</div>
					<span class="glyphicon glyphicon-ice-lolly" style="color: #9E9E9E;"
						id="jolly-icon"></span>
				</div>

				<div class="middle-section">
					<div class="searcher">
						<span class="glyphicon glyphicon-search searcher-icon"></span> <input
							type="text" name="searchKeyword" value=""
							placeholder="검색어를 입력해주세요." autocomplete=off>
					</div>
				</div>

				<div class="side-section">
					<span class="glyphicon glyphicon-bell top-icons"
						id="noticeRoomList"></span> <span
						class="glyphicon glyphicon-comment top-icons" id="chatRoomList"></span>
					<span class="glyphicon glyphicon-list-alt top-icons" id="chat-open"></span>
					<c:if test="${!empty user}">
						<span class="glyphicon glyphicon-pencil top-icons" id="pencil"></span>
						<span class="glyphicon glyphicon-user top-icons" id="join-open"></span>
						<c:if test="${user.role == 1}">
							<span class="glyphicon glyphicon-cog top-icons" id="admin-page"></span>
						</c:if>
						<span class="glyphicon glyphicon-log-out top-icons" id="log-out"></span>
					</c:if>
					<c:if test="${empty user}">
						<span class="glyphicon glyphicon-log-in top-icons" id="login-open"></span>
					</c:if>
					<div class="notificationContainer"
						style="display: none; top: 170%; left: 35%;"
						id="chatRoomContainer">
						<div id="notificationTitle">채팅방</div>
						<div class="col-md-15 bg-white">
							<ul class="friend-list" id="chatFriendList">
								<!--             여기에 채팅방 리스트가 출력됨. -->
							</ul>
						</div>
					</div>

					<div class="notificationContainer"
						style="display: none; top: 170%; left: -15%;" id="noticeContainer">
						<div id="notificationTitle">알림</div>
						<div class="col-md-15 bg-white">
							<ul class="friend-list" id="noticeFriendList">
								<!--             여기에 채팅방 리스트가 출력됨. -->
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</nav>
	
	<div class="container search-log-container">
		<div class="search-logs">
			<div class="row log-detail">
				<div class="col-md-6 col-xs-12 search-history">
					최근 검색 기록
					<c:if test="${searchLog.size()==0}">
					<%-- <c:forEach var="board" items="${boardList}"> --%>
					<div>최근 검색 기록이 없습니다.</div>
					</c:if>
					<c:if test="${searchLog.size()>0}">
						<c:set var="i" value="0" />		
						<c:forEach var="keyword" items="${searchLog}">
						<c:set var="i" value="${ i+1 }" />
							<div class="logs keyword${i}" name="${keyword}">${keyword}</div>
						</c:forEach>
					</c:if>
				</div>
				<div class="col-md-6 col-xs-12 search-recommand">
					추천검색어
					
					<div>검색어2</div>
				</div>`
			</div>
		</div>
	</div>


	<nav class="head-section-small">
		<div class="fix-box-small">
			<div class="container header-box">
				<span class="glyphicon glyphicon-apple maincon-small"></span>
				
				<div class="title-section-small">
					<div class="title-text-small"></div>
					<span class="glyphicon glyphicon-ice-lolly" style="color: #9E9E9E;"
						id="jolly-icon-small"></span>
				</div>

				<div class="middle-section-small">
					<div class="searcher-small">
						<span class="glyphicon glyphicon-search searcher-icon-small"></span> 
						<input type="text" name="searchKeyword" value="" placeholder="검색어를 입력해주세요." autocomplete=off>
					</div>
				</div>

				<div class="side-section-small">
					<span class="glyphicon glyphicon-chevron-left expand-out"></span>
					<div class="side-section-icons">
						<span class="glyphicon glyphicon-chevron-right expand-in"></span>
						<span class="glyphicon glyphicon-bell top-icons-small" id="noticeRoomList"></span> 
						<span class="glyphicon glyphicon-comment top-icons-small" id="chatRoomList"></span>
						<span class="glyphicon glyphicon-list-alt top-icons-small" id="chat-open"></span>
						<c:if test="${!empty user}">
							<span class="glyphicon glyphicon-pencil top-icons-small" id="pencil"></span>
							<span class="glyphicon glyphicon-user top-icons-small" id="join-open"></span>
							<c:if test="${user.role == 1}">
								<span class="glyphicon glyphicon-cog top-icons-small" id="admin-page"></span>
							</c:if>
							<span class="glyphicon glyphicon-log-out top-icons-small" id="log-out"></span>
						</c:if>
						<c:if test="${empty user}">
							<span class="glyphicon glyphicon-log-in top-icons-small" id="login-open"></span>
						</c:if>
					</div>
					<div class="notificationContainer"
						style="display: none; top: 170%; left: 35%;"
						id="chatRoomContainer">
						<div id="notificationTitle">채팅방</div>
						<div class="col-md-15 bg-white">
							<ul class="friend-list" id="chatFriendList">
								<!--             여기에 채팅방 리스트가 출력됨. -->
							</ul>
						</div>
					</div>

					<div class="notificationContainer"
						style="display: none; top: 170%; left: -15%;" id="noticeContainer">
						<div id="notificationTitle">알림</div>
						<div class="col-md-15 bg-white">
							<ul class="friend-list" id="noticeFriendList">
								<!--             여기에 채팅방 리스트가 출력됨. -->
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		</nav>
	</nav>

	<div class="container search-result-container">
		<div class="content-box">
			<div class="search-title-wrapper">
				<h2>
					' <span style="font-weight: 700">${searchKeyword}</span> '의
					검색결과입니다.
				</h2>
				<div class="option-on-off on">검색옵션켜기</div>
				<div class="option-on-off off">검색옵션끄기</div>
				<div class="open-searcher">
					<label class="switch"> <input type="checkbox"> <span
						class="slider round"></span>
					</label>
				</div>
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
						<img
							src="https://ih0.redbubble.net/image.133161613.9621/flat,1000x1000,075,f.jpg"
							class="placeImg"
							style="background-color: black; width: 100%; height: 300px;">
					</div>
				</div>
			</div>
		</div>
		<div class="search-results">
			<div class="">
				<div class="col-md-12 col-xs-12 section-title"
					style="display: flex; justify-content: space-between; align-items: center;">
					<h3 style="display: inline-block; font-weight: 700;">게시글</h3>
					<div>더보기 >></div>
				</div>
				<hr />
				<c:if test="${!empty list_board}">
					<c:set var="i" value="0" />
					<c:forEach var="board" items="${list_board}" end="2">
						<c:set var="i" value="${i+1}" />
						<div class="col-md-4 col-xs-6 board-box">
							<img src="/images/board/posts/${board.boardImg}"
								class="boardImg" style="width: 100%; height: 200px;">
							<div class="boardBox">
								<h3>${board.boardTitle}</h3>
								${board.boardContent}
							</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${empty list_board}">
					<div class="col-md-12 col-xs-12 board-box">
						<img
							src="https://ih0.redbubble.net/image.133161613.9621/flat,1000x1000,075,f.jpg"
							class="boardImg"
							style="width: 100%; height: 200px; opacity: 0.5;">
					</div>
				</c:if>
			</div>

			<div>
				<div class="col-md-12 col-xs-12 section-title"
					style="display: flex; justify-content: space-between; align-items: center;">
					<h3 style="display: inline-block; font-weight: 700;">일정</h3>
					<div>더보기 >></div>
				</div>
				<hr />

				<c:if test="${!empty list_schedule}">
					<c:set var="i" value="0" />
					<c:forEach var="schedule" items="${list_schedule}" end="3">
						<c:set var="i" value="${i+1}" />
						<div class="col-md-6 col-xs-12 board-box">
							<img src="/images/schedule/${schedule.img}" class="boardImg"
								style="width: 100%; height: 200px;">
							<div class="boardBox">
								<h3>${schedule.title}</h3>
								${schedule.content}
							</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${empty list_schedule}">
					<div class="col-md-12 col-xs-12 board-box">
						<img
							src="https://ih0.redbubble.net/image.133161613.9621/flat,1000x1000,075,f.jpg"
							class="boardImg"
							style="width: 100%; height: 200px; opacity: 0.5;">
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
						<a href="https://www.instagram.com/p/${insta.shortLink}"
							target="_blank"><img src="${insta.img}" class="boardImg"
							style="width: 100%;"></a>
					</div>
				</c:forEach>
			</div>

		</div>
	</div>

	<script>
		// Initialize and add the map
		function initMap() {
			var locations;
			var size = ${spot_location.size()}
			;
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
				$('.placeTitle').text("검색결과가 없습니다 ㅠㅠ");
				$('.placeContent').text("미아내오 준비하께오ㅜㅜㅜㅜㅠㅠㅠㅠㅠ");
				$('.placeImg')
						.attr("src",
								"https://ih0.redbubble.net/image.133161613.9621/flat,1000x1000,075,f.jpg");
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
							$('.placeImg').attr("src",
									"/images/spot/" + locations[i][5]);
							$('.placeTitle').attr('name', locations[i][6]);
						}
					})(marker, i));
				}

				$('.placeTitle').text(locations[0][1]);
				$('.placeTitle').attr('name', locations[0][6]);
				$('.placeContent').text("information of selected place");
				$('.placeImg').attr("src", "/images/spot/" + locations[0][5]);
			}

		}
	</script>
	<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAq2HYLHx3q-LM3MusYKsjXVZUik30YqUI&callback=initMap">
		
	</script>
</body>
</html>