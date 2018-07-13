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
	
<title>나들이 백과 추가</title>

</head>
<style type="text/css">
html, body {
	margin: 0px;
	width: 100%;
	height: 100%;
	font-size: 65px;
}

.navbar {
	font-size: 0.2em;
}

.spotAddTitle {
	font-weight: 800;
	font-size: 0.7em;
	margin-bottom: 5%;
}

.normal {
	font-size: 0.3em;
	margin: auto;
}

.description {
	font-size: 0.3em;
	margin-top: 0.5vh;
}

option,select{
	font-size:0.2em;
	width:100%;
	border:1px solid #ccc;
}
</style>
<script type="text/javascript">
	$(function() {
		
		/* index page animation start */
		
		$('.adminmenus > div').on('click',function(){
			var way = $(this).attr('class');
			if(way=="inquire"){
				self.location='/admin/listInquire';
			}else if(way=="spot"){
				self.location='/admin/listSpot';
			}else if(way=="graph"){
				self.location='/admin/listGraph';
			}else if(way=="userList"){
				self.location = '/admin/listUser';
			}else if(way=="userLog"){
				self.location = '/admin/listLog';
			}
		})
		
		/* index page animation end */
		
		$('.confirm').on('click',function(){
			window.location.href = "/admin/listSpot";
		})
		
	})
</script>
<body>

	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="adminmenus">
				<div class="userList">회원목록</div>
				<div class="userLog">회원활동</div>
				<div class="graph">통계내역</div>
				<div class="spot">백과관리</div>
				<div class="inquire">문의관리</div>
			</div>
		</div>
	</nav>

	<div class="container">
		<form class="addForm" enctype="multipart/form-data">
			<div class="spotAddTitle">나들이 백과추가 확인</div>
			<div class="form-group">
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label normal">장 소 명</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="spotTitle"
							value="${spot.spotTitle}" disabled>
					</div>
					<label class="col-sm-2 control-label normal">장 소 코 드</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="spotCode"
							value="${spot.spotCode}" disabled>
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label description">장 소 번 호</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="spotPhone"
							value="${spot.spotPhone}" disabled>
					</div>
				</div>

				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label description">장 소 설 명</label>
					<div class="col-sm-10">
						<textarea class="form-control" rows="4" name="spotDetail" disabled>${spot.spotDetail}</textarea>
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label normal">주 소</label>
					<div class="col-sm-2" style="display:inline-flex;">
						<select name="spotProvince" disabled>
							<option>${spot.spotProvince}</option>
						</select>
					</div>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="spotAddress"
							value="${spot.spotAddress}" disabled>
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label normal">X 좌 표</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="spotX"
							value="${spot.spotX}" disabled>
					</div>
					<label class="col-sm-2 control-label normal">Y 좌 표</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="spotY"
							value="${spot.spotY}" disabled>
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label description">장 소 링 크</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="spotDetailURL"
							value="${spot.spotDetailURL}" disabled>
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label normal">이 미 지</label>
					<div class="col-sm-10">
						<img src="/images/spot/${spot.spotImg}">
					</div>
				</div>
				<div class="col-sm-12" style="display:flex; justify-content: center; margin-top:3%;">
					<button class="btn btn-primary confirm" style="margin-right:2%;" onclick="javascript:window.location.href='/admin/listSpot';return false;">확 인</button>
					<button class="btn btn-defalut" style="margin-left:2%;" onclick="javascript:window.location.href='/admin/addSpot.jsp';return false;">추 가 등 록</button>
				</div>
			</div>
		</form>
	</div>



</body>
</html>