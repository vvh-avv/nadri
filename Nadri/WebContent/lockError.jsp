<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Bootstrap CDN -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<!-- common.js / common.css CDN -->
<script src="/javascript/common.js"></script>
<link rel="stylesheet" href="/css/common.css">
<!-- toolbar.js CDN -->
<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">

</head>
<style>
	.errorText{
		text-align: center;
		padding-top: 10%;
	}
	body{ 
		background-color: #whitesmoke;
	}
</style>
<script>
$(function(){
	$("#gotoMain").on("click", function(){
		self.location="/";
	})
	$("#gotoBack").on("click", function(){
		history.go(-1);
	})
})
</script>
<body>
	<!-- 메인 툴바 -->
   <%@ include file="/layout/toolbar.jsp"%>
   
	<div class="container errorText">
		<img src="/images/common/lock.png"><br><br><br>
		<font color="#51A4FC" size=+2>현재 요청하신 페이지는 비공개 페이지 입니다.</font><br><br>
		<font size=+0.5>다른 사람의 프라이버시를 존중해주세요!</font><br><br>
		<button type="button" class="btn btn-primary" id="gotoMain">메인으로</button>
		<button type="button" class="btn btn-default" id="gotoBack">이전 페이지</button>
	</div>
</body>
</html>