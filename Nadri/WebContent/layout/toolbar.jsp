<%@ page language="java" pageEncoding="EUC-KR"%>

<div class="topbar">

	<a href="/index.jsp"> 
	<img src="/images/common/title_colored.png" class="title">
	</a>

	<div class="collapse navbar-collapse">
		<input type="text" class="searcher" placeholder="검색어를 입력해주세요."
			name="searchKeyword">
		<div class="sidemenu">
			<c:if test="${!empty user}">
				<img src="/images/common/bell_white.png" class="icons bell">
				<img src="/images/common/chat_white.png" class="icons chat">
				<img src="/images/common/user_white.png" class="icons friend">
				<c:if test="${user.role==0}">
					<a href="/user/listUser"> <img
						src="/images/test/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg"
						class="profile" title="let's go to my page">
					</a>
				</c:if>
				<c:if test="${user.role==1}">
					<a href="/admin/adminIndex"> <img
						src="/images/test/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg"
						class="profile" title="let's go to Admin page">
					</a>
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
			<span class="topele spots" style="font-family: 'seoul';">나들이백과</span> <span class="topele boards" style="font-family: 'seoul';">게시판</span> <span
				class="topele schedules" style="font-family: 'seoul';">일정작성</span>
		</div>
	</div>
	<div class="toggleBox">
		<img src="/images/common/more_white.png" class="menuExpand" style="transform:rotate(90deg)"> 
		<img src="/images/common/search_white.png" class="searchExpand">
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