<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
html, body {
   margin: 0px;
   width: 100%;
   height: 100%;
   overflow-x: hidden;
}

.topbar {
   position: relative;
   top: 0px;
   width: 100vw;
   min-width: 100vw;
   height: 20vh;
   background: white;
   overflow: hidden;
   transition: all 2s;
   transition-property: height;
   align-items: center;
   border-bottom: 1px solid rgba(212, 212, 212, 0.65);
   transition: all 1s;
}

.topfixed {
   position: fixed;
   top: 0px;
   width: 100vw;
   height: 8vh;
   background: rgba(212, 212, 212, 0.65);
   overflow: hidden;
   transition: all 1s;
   transition-property: height;
   box-shadow: 0 2px 8px 0 rgba(0, 0, 0, 0.15);
   align-items: center;
   overflow: hidden;
}

.topmenus {
   top: 0;
   display: flex;
   justify-content: center;
   width: 30vw;
   min-width: 200px;
   height: 3.5vh;
   min-height: 15px;
   background: white;
   border-bottom-right-radius: 60px;
   border-bottom-left-radius: 60px;
   margin-left: auto;
   margin-right: auto;
   box-shadow: 0 3px 8px 0 rgba(0, 0, 0, 0.12);
   transition: height 1s ease;
}

.title {
   position: absolute;
   display: inline-block;
   font-weight: 800;
   font-size: 72px;
   color: black;
   margin-top: 0.6vh;
   transition: all 1s;
   left: 2vw;
}

.titlefixed {
   position: absolute;
   display: inline-block;
   font-weight: 600;
   font-size: 30px;
   color: black;
   font-weight: 600;
   font-size: 30px;
   color: black;
   top: 0;
   transition: all 1s;
   left: 2vw;
}

.topmenus :nth-child(2) {
   margin-left: 30px;
   margin-right: 30px;
   transition: all 1s;
}

.topele {
   position: relative;
   font-family: fantasy;
   font-size: 12px;
   color: #D4D4D4;
   top: 0.5vh;
   transition: all 1s;
}

.sidemenu {
   position: absolute;
   right: 2vw;
   top: 4vh;
   display: flex;
   transition: all 1s;
   align-items: center;
   flex-direction: row;
   justify-content: space-between;
}

.icons {
   margin: auto 10px;
   top: 0; left : 0; right : 0; bottom : 0; width : 28px;
   height: auto; 
   transition: all 1s;
   width: 35px;
   left: 0;
   right: 0;
   bottom: 0;
}

.sidemenu>.fix {
   width: 28px;
   height: auto;
   position: fixed;
   top: 0;
   transition: all 1s;
}

.searcher {
   width: 20vw;
   min-width: 100px;
   position: absolute;
   margin-left: 40vw;
   top: 7vh;
   border: 0.5px solid rgba(212, 212, 212, 0.65);
   transition: all 1s;
}

.profile {
   width: 45px;
   height: 45px;
   margin: auto;
   top: 0;
   left: 0;
   right: 0;
   bottom: 0;
   transition: all 1s;
   padding: 2px;
   border: 2px solid rgba(212, 212, 212, 0.65);
   border-radius: 50%;
}

#admin {
   display: none;
}
</style>

         <div class="topbar">
            <div class="topmenus">
               <span class="topele">나들이백과</span> <span class="topele">게시판</span> <span class="topele">일정작성</span>
            </div>
            <a href="/index.jsp">
               <div class="title">너, 나들이demo</div>
            </a> <input type="text" class="searcher">
            <div class="dropdown">
               <div class="sidemenu">
                  <img src="/images/test/bell.png" class="icons"> 
                  <img src="/images/test/conversation.png" class="icons"> 
                  <c:if test="${empty user}">
                     <a href="/user/loginView.jsp"><img src="/images/test/multiple-users-silhouette.png" class="icons"></a>
                  </c:if>
                  <c:if test="${!empty user}">
                     <a href="/user/listUser.jsp"><img src="/images/test/multiple-users-silhouette.png" class="icons"></a>
                  </c:if>
                  <a href="/admin/adminIndex.jsp">
                  <img src="/images/test/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg" class="profile" title="let's go to Admin page">
                  </a>
               </div>
            </div>
            </div>   


