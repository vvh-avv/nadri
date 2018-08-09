<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>너, 나들이</title>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<!-- layout css -->
<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
<link rel="stylesheet" type="text/css" media="(max-width: 600px)"
	href="/css/indexRealSmall.css" />
<script src="/javascript/indexReal_nonIndex.js"></script>
<!-- google map API -->
<script async defer
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAq2HYLHx3q-LM3MusYKsjXVZUik30YqUI&callback=initMap"></script>
<!-- juanMap.js CDN -->
<script src="/javascript/juanMap.js"></script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script>
	//이 부분은 지도 관련 맵 입니다! 
	//중앙 위치값을 세팅해 줍니다. 
	var center = {
		lat : 37.57593689999999,
		lng : 126.97681569999997
	};
	var map, geocoder, infowindow;
	var locations = [];
	var infowindows = [];
	var contents = [];
	//마커 저장소
	var markers = [];

	//마커 담는 곳
	var spot = $
	{
		cart
	};
	for (var i = 0; i < spot.length; i++) {
		obj = {
			lat : parseFloat(spot[i].spotY),
			lng : parseFloat(spot[i].spotX),
			addr : spot[i].spotAddress,
			detail : spot[i].spotDetail,
			title : spot[i].spotTitle,
			img : spot[i].spotImg,
			no : spot[i].spotNo,
			createtime : spot[i].spotCreateTime
		};
		locations.push(obj);
	};

	function initMap() {

		// 맵 스타일 속성에 필요한 배열 생성 
		var styles = [];

		//새로운 styleMapType를 생성하며 커스터마이징한 스타일을 적용 시킨 객체를 만든다. 
		var styledMap = new google.maps.StyledMapType(styles, {
			name : "Styled Map"
		});

		// 맵에 세팅될 각종 옵션을 적용 시킨다. 
		var mapOptions = {
			//최초 맵 로딩 시 위치 값 셋팅 
			center : center,
			// 줌 레벨 셋팅 
			zoom : 11,
			//스크롤 휠 페이지 검색
			scrollwheel : false,
			// 스타일 맵 적용 
			mapTypeControlOptions : {
				mapTypeIds : [ google.maps.MapTypeId.ROADMAP, 'map_style' ]
			}
		};

		// 맵 객체 생성 
		map = new google.maps.Map(document.getElementById('map'), mapOptions);
		// 시군구를 표현할 수 있도록 경계를 칠해주는 코딩입니다!
		map.data
				.loadGeoJson('https://raw.githubusercontent.com/southkorea/seoul-maps/master/kostat/2013/json/seoul_municipalities_geo.json');
		// Set the stroke width, and fill color for each polygon
		map.data.setStyle(function(feature) {
			var color = '#F1F8E0';
			if (feature.getProperty('isColorful')) {
				color = '';
			}
			return ({
				fillColor : color,
				strokeWeight : 0.2
			});
		});

		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(nowposition, message) {
			// 마커를 생성합니다
			var marker = new google.maps.Marker({
				map : map,
				position : nowposition,
				icon : icons['myplace'].icon
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

		geocoder = new google.maps.Geocoder;

		// When the user clicks, set 'isColorful', changing the color of the letters.
		map.data.addListener('click', function(event) {
			event.feature.setProperty('isColorful', true);
		});

		map.data.addListener('mouseover', function(event) {
			map.data.revertStyle();
			map.data.overrideStyle(event.feature, {
				fillColor : '#F2F79B'
			});
		});

		map.data.addListener('mouseout', function(event) {
			map.data.revertStyle();
		});

		for (var i = 0; i < locations.length; i++) {
			markers[i] = new google.maps.Marker({
				position : locations[i],
				map : map,
				icon : icons['store'].icon
			});
			//인덱스를 꺼내오기.. 중요!!
			markers[i].index = i

			contents[i] = '<div class="grid">'
					+ '<div class="box box-primary" style="font-family : seoul">'
					+ '<h4 class="profile-username text-center">'
					+ locations[i].title
					+ '</h4>'
					+ '<img src="/images/spot/'+locations[i].img+'" height="100" width="100" style="margin-left: auto; margin-right: auto; display: block;">'
					+ '<li class="list-group-item">'
					+ '<i class="glyphicon glyphicon-tree-deciduous"></i><b>위치  </b>'
					+ locations[i].addr
					+ '</li>'
					+ '<li class="list-group-item">'
					+ '<i class="glyphicon glyphicon-book"></i><b>상세내용  </b>'
					+ locations[i].detail
					+ '</li>'
					+ '<li class="list-group-item"><i class="glyphicon glyphicon-ok-circle"></i>'
					+ '<b>Tag&nbsp</b></i> <span class="label label-success"> 장소바구니</span></li>'
					+ '</div>' + '</div>';

			// 이벤트 정보 넣기
			infowindows[i] = new google.maps.InfoWindow({
				content : contents[i],
				removeable : true
			});

			// 마커를 클릭했을때 이벤트 발생 시키기
			google.maps.event.addListener(markers[i], 'click', function() {
				map.setZoom(12);
				// 일단 마커를 모두 닫고
				for (var i = 0; i < markers.length; i++) {
					infowindows[i].close();
				}
				infowindows[this.index].open(map, markers[this.index]);
				map.panTo(markers[this.index].getPosition());
			});
		}
	}//end of initmap();
</script>

<style>
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

.container-cart {
	padding-top: 10px;
}

article {
	display: inline-block;
	position: relative;
	cursor: pointer;
}

article:hover .thumbImg img {
	opacity: 0.3;
}

article:hover .links {
	opacity: 1;
}

.thumbImg img {
	width: 250px;
	height: 250px;
	opacity: 1;
	transition: .5s ease;
	margin: 5px;
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

.linksIcon img {
	position: absolute;
	top: -5%;
	left: -5%;
	width: 70px;
	height: 70px;
}

.map-row {
	padding: 20px;
	border-radius: 5px;
}

#map {
	height: 500px; /* The height is 400 pixels */
	width: 100%; /* The width is the width of the web page */
	border: 1px solid lightgrey;
	border-radius:5px;
}
</style>

</head>

<body>

	<!-- 메인툴바 -->
	<nav class="head-section">
		<div class="fix-box">
			<div class="container header-box">
				<span class="glyphicon glyphicon-apple maincon"></span>
				<div class="title-section">
					<div class="title-text">너, 나들이</div>
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
		<div class="log-wrapper">
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
					</div>
					`
				</div>
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
						<input type="text" name="searchKeyword" value=""
							placeholder="검색어를 입력해주세요." autocomplete=off>
					</div>
				</div>

				<div class="side-section-small">
					<span class="glyphicon glyphicon-chevron-left expand-out"></span>
					<div class="side-section-icons">
						<span class="glyphicon glyphicon-chevron-right expand-in"></span>
						<span class="glyphicon glyphicon-bell top-icons-small"
							id="noticeRoomList"></span> <span
							class="glyphicon glyphicon-comment top-icons-small"
							id="chatRoomList"></span> <span
							class="glyphicon glyphicon-list-alt top-icons-small"
							id="chat-open"></span>
						<c:if test="${!empty user}">
							<span class="glyphicon glyphicon-pencil top-icons-small"
								id="pencil"></span>
							<span class="glyphicon glyphicon-user top-icons-small"
								id="join-open"></span>
							<c:if test="${user.role == 1}">
								<span class="glyphicon glyphicon-cog top-icons-small"
									id="admin-page"></span>
							</c:if>
							<span class="glyphicon glyphicon-log-out top-icons-small"
								id="log-out"></span>
						</c:if>
						<c:if test="${empty user}">
							<span class="glyphicon glyphicon-log-in top-icons-small"
								id="login-open"></span>
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

	<!-- ToolBar End /////////////////////////////////////-->

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
			
					<br /> <a href="/user/getUser">내 정보 보기</a><br /> <br /> <a
						href="/user/updateUser">내 정보 수정</a><br /> <br /> <a
						href="/friend/listFriend2">친구 목록</a><br /> <br /> <a
						href="/board/getMyBoardList">작성한 글</a><br /> <br /> <a
						href="/schedule/getMyScheduleList">내 일정</a><br /> <br /> <a
						href="/cart/getMyCartList">장소 바구니</a><br /> <br /> <br /> <br />
					<br /> <br /> <br /> <br /> <br /> <br /> <a
						href="/user/logout">로그아웃</a><br /> <br />
				</div>
			</div>

			<div class="col-xs-12 col-md-9">

				<div class="col-md-12 user-detail-section">

					<!-- 맵 뜨는 부분 -->
					<div class="row map-row">
						<div id="map"></div>
					</div>
					<br>
					<!-- 바구니에 담은 장소리스트 보여주는 부분 -->
					<div class="row contents">
						<c:set var="i" value="0" />
						<c:forEach var="cart" items="${list}">
							<article class="${cart.cartNo}">
								<!-- 썸네일 형식의 장소 이미지 -->
								<div class="thumbImg" style="width: auto; height: 250px;">
									<c:if test="${cart.cartImg==null}">
										<img src="/images/board/posts/no_image.jpg"
											class="img-thumbnail">
									</c:if>
									<c:if test="${cart.cartImg!=null}">
										<img src="${cart.cartImg}" class="img-thumbnail">
									</c:if>
								</div>
								<!-- 방문도장 이미지 -->
								<c:if test="${cart.stampCode==1}">
									<div class="linksIcon">
										<img id="stamp${schedule.scheduleNo}"
											src="/images/cart/common/stamp.png">
									</div>
								</c:if>
								<!-- 마우스 오버시 보여지는 부분 -->
								<div class="links" style="text-align: center;">
									<span id="cartTitle"><b>${cart.cartTitle}</b><br></span> <span
										id="cartAddress">${cart.cartAddress}<br> <br></span>
									<span id="cartDetail">${cart.cartDetail}</span>
								</div>
							</article>
						</c:forEach>

						<c:if test="${empty list}">
							<span id="defaultText" style="margin-left: 40%;">바구니가
								비었습니다. ㅠㅠ</span>
						</c:if>

					</div>
					<!-- 여기가 detail section 끝나는부분지우면안됨 -->

				</div>

			</div>
		</div>
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
						<button type="button" class="waves-effect waves-light btn"
							id="modalinsert">입력!</button>
					</div>
				</div>
			</div>
		</div>
</body>
</html>