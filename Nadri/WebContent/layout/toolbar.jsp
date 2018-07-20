<%@ page language="java" pageEncoding="EUC-KR"%>

<div class="topbar">

	<a href="/index.jsp"> <img src="/images/common/title.png"
		class="title">
	</a>

	<div class="collapse navbar-collapse">
		<input type="text" class="searcher" placeholder="검색어를 입력해주세요."
			name="searchKeyword">
		<div class="sidemenu">
			<c:if test="${!empty user}">
				<img src="/images/common/bell_black.png" class="icons bell">
				<img src="/images/common/chat_black.png" class="icons chat">
				<img src="/images/common/user_black.png" class="icons friend">
				<c:if test="${user.role==1}">
					<a href="/admin/adminIndex.jsp"> <img
						src="/images/test/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg"
						class="profile" title="let's go to Admin page">
					</a>
				</c:if>
				<c:if test="${user.role==0}">
					<a href=""> <img
						src="/images/test/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg"
						class="profile" title="let's go to Admin page">
					</a>
				</c:if>
			</c:if>
		</div>
		<c:if test="${empty user}">
				<div class="right-box">
					<img src="/images/user/join_black.png" class="join"> <img
						src="/images/user/login_black.png" class="login">
				</div>
		</c:if>
		<div class="topmenus">
			<span class="topele spots" style="font-family: 'seoul';">나들이백과</span> <span class="topele boards" style="font-family: 'seoul';">게시판</span> <span
				class="topele schedules" style="font-family: 'seoul';">일정작성</span>
		</div>
	</div>
	<div class="toggleBox">
		<img src="/images/common/more_black.png" class="menuExpand"> 
		<img src="/images/common/search_black.png" class="searchExpand">
	</div>
</div>
<div style="display:flex; flex-direction: col; justify-content: flex-start;">
	<ul class="toggleMenuMob">
		
	</ul>
</div>