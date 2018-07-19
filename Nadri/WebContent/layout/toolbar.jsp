<%@ page language="java" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<div class="topbar">
   
   <a href="/index.jsp">
      <img src="/images/common/title.png" class="title">
   </a> 
   <input type="text" class="searcher" placeholder="검색을 원하시면 클릭해주세요!">
   
   <div class="dropdown">
      <div class="sidemenu">
         <c:if test="${!empty user}">
            <img src="/images/test/bell.png" class="icons"> 
            <img src="/images/test/conversation.png" class="icons"> 
            <c:if test="${empty user}">
               <a href="/user/loginView.jsp"><img src="/images/test/multiple-users-silhouette.png" class="icons"></a>
            </c:if>
            <c:if test="${!empty user}">
               <a href="/user/listUser.jsp"><img src="/images/test/multiple-users-silhouette.png" class="icons"></a>
            </c:if>
            <c:if test="${user.role=='admin'}">
               <a href="/admin/adminIndex.jsp">
               <img src="/images/test/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg" class="profile" title="let's go to Admin page">
               </a>
            </c:if>
            <c:if test="${user.role=='user'}">
               <a href="">
               <img src="/images/test/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg" class="profile" title="let's go to Admin page">
               </a>
            </c:if>
         </c:if>
         <c:if test="${empty user}">
            <div class="right-box">
            <img src="/images/user/join_black.png" class="join">
            <img src="/images/user/login_black.png" class="login">
            </div>
         </c:if>
      </div>
   </div>
   <div class="topmenus">
      <span class="topele">나들이백과</span> <span class="topele">게시판</span> <span class="topele">일정작성</span>
   </div>
</div>   

