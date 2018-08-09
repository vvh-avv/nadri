<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<input type="hidden" name="session" id="session-checker"
	value="${empty user.userId ? 'no_user' : user.userId}" />

<!-- toolbar starts here -->
<nav class="head-section">
	<div class="fix-box">
		<div class="container header-box">
			<span class="glyphicon glyphicon-sunglasses maincon"></span>
			<div class="title-section">
				<div class="title-text">너,나들이</div>
				<span class="glyphicon glyphicon-ice-lolly" style="color: white;"
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
				<span class="glyphicon glyphicon-book top-icons" id="spot-lists"></span>
				<span class="glyphicon glyphicon-list-alt top-icons" id="chat-open"></span>
				<c:if test="${!empty user}">
					<span class="glyphicon glyphicon-bell top-icons"
						id="noticeRoomList"></span>
					<span class="glyphicon glyphicon-comment top-icons" id="chatRoomList"></span>

					<span class="glyphicon glyphicon-pencil top-icons" id="pencil"></span>
					<span class="glyphicon glyphicon-user top-icons" id="join-open"></span>
					<c:if test="${user.role == 1}">
						<span class="glyphicon glyphicon-cog top-icons" id="admin-page"></span>
					</c:if>
					<span class="glyphicon glyphicon-log-out top-icons" id="log-out"></span>
				</c:if>
				<c:if test="${empty user}">
					<span class="glyphicon glyphicon-edit top-icons" id="sign-up"></span>
					<span class="glyphicon glyphicon-log-in top-icons" id="login-open"></span>
				</c:if>
				<div class="notificationContainer"
					style="display: none; top: 170%; left: 35%;" id="chatRoomContainer">
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
				<div class="col-md-6 col-xs-12 search-history"></div>
				<div class="col-md-6 col-xs-12 search-recommand">
					추천검색어

					<div>검색어2</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 로그인 창 -->
<div class="container" style="position: relative;">
	<div class="login-box">
		<div>
			<div class="login-sub-box">
				<form name="login-form" class="login-form">
					<input type="text" name="userId" id="userId" placeholder="아이디를 입력해주세요."> 
					<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요.">
				</form>
				<div class="login-button-box">
					<div class="login-submit">로 그 인</div>
					<div class="join-submit">회 원 가 입</div>
				</div>
				<div class="social-button-box">
					<div class="kakao" id="kakao-login-btn"></div>
					<div class="google"></div>
					<div class="naver" id="naverIdLogin_loginButton"></div>
				</div>
				<div class="user-access-box">
					<div class="id-look-submit">ID 찾기</div>
					<div class="pw-look-submit">비밀번호 찾기</div>
				</div>
			</div>
		</div>
	</div>
</div>

<nav class="head-section-small">
	<div class="fix-box-small">
		<div class="container header-box">
			<span class="glyphicon glyphicon-sunglasses maincon-small"></span>

			<div class="title-section-small">
				<div class="title-text-small"></div>
				<span class="glyphicon glyphicon-ice-lolly" style="color: white;"
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
					<span class="glyphicon glyphicon-chevron-right expand-in"></span> <span
						class="glyphicon glyphicon-bell top-icons-small"
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
					style="display: none; top: 170%; left: 35%;" id="chatRoomContainer">
					<div id="notificationTitle">채팅방</div>
					<div class="col-md-15 bg-white">
						<ul class="friend-list" id="chatFriendList">
							<!--- 여기에 채팅방 리스트가 출력됨. --->
						</ul>
					</div>
				</div>

				<div class="notificationContainer"
					style="display: none; top: 170%; left: -15%;" id="noticeContainer">
					<div id="notificationTitle">알림</div>
					<div class="col-md-15 bg-white">
						<ul class="friend-list" id="noticeFriendList">
							<!--- 여기에 채팅방 리스트가 출력됨.--->
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</nav>
<!--- Toolbar end --->

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

<div class="loader-background">
	<div class="loader">
		<img src="/images/common/loader.gif" alt="suppose to be loader">
	</div>
</div>