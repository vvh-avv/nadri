<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
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

<!-- admin index 전용 css  -->
<link rel="stylesheet" href="/css/adminIndex.css">
<title>너나들이 관리자 페이지</title>

</head>
<script type="text/javascript">
	$(function() {

		/* index page animation start */

		$('.adminmenus > div').on('click', function() {
			var way = $(this).attr('class');
			if (way == "inquire") {
				self.location = '/admin/listInquire';
			} else if (way == "spot") {
				self.location = '/admin/listSpot';
			} else if (way == "graph") {
				self.location = '/admin/listGraph?duration=day';
			} else if (way == "userList") {
				self.location = '/admin/listUser';
			} else if (way == "userLog") {
				self.location = '/admin/listLog';
			}
		})

		/* index page animation end */

	})
</script>
<body>

	<nav class="navbar navbar-default navbar-fixed-top"
		style="padding: 0px 20px;">
		<div class="navbar-left" style="padding-right: 16px;">
			<a href="/admin/adminIndex">admin page</a>
		</div>
		<div class="container-fluid">
			<div class="adminmenus">
				<div class="userList">회원목록</div>
				<div class="graph">통계내역</div>
				<div class="spot">백과관리</div>
				<div class="inquire">문의관리</div>
			</div>
		</div>
		<div class="navbar-right" style="padding-right: 16px;">
			<a href="/"><img src="/images/common/home.png"
				style="width: 34px; height: auto;" title="너나들이페이지로 돌아가기"></a>
		</div>
		<!-- /.container-fluid -->
	</nav>

	<div class="container">
		<div class="indexBox">
			
			<div class="row" style="width:100%;">
				<div class="col-md-6 col-xs-12" style="padding:12px 15px 0px 15px;">
				 	최근 가입 회원목록 >>
				 	<c:if test="${userList.size()==0}">
						<div class="container">
							<div>회원 목록이 하나도 없어요.</div>
						</div>
					</c:if>
					<c:if test="${userList.size() > 0}">
					<div class="table-responsive" style="font-size:0.6em;">
						<table class="table table-hover" style="margin-bottom:0px; margin-top:15px;">
							<tr>
								<th> 회원아이디 </th>
								<th> 회원이름 </th>
								<th> 가입일 </th>
							</tr>
							<c:set var="i" value="0" />
							<c:forEach var="user" items="${userList}">
							<c:set var="i" value="${ i+1 }" />
							<tr>
								<td>${user.userId}</td>
								<td>${user.userName}</td>
								<td>${user.regDate}</td>
							</tr>
							</c:forEach>
							<tr>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
					</div>
					</c:if>
				</div>	
				<div class="col-md-6 col-xs-12">
				
				</div>
			</div>
		</div>
	</div>

</body>
</html>