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
		
		$('.update-button').on('click',function(){
			$('.addForm').attr('action','/admin/updateSpot').attr('method','POST').submit();
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
			<div class="spotAddTitle">나들이 백과추가</div>
			<div class="form-group">
				<input type="hidden" name="spotNo" value="${spotNo}">
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label normal">장 소 명</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="spotTitle"
							placeholder="장소명을 입력하세요." value="${spot.spotTitle}">
					</div>
					<label class="col-sm-2 control-label normal">장 소 코 드</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="spotCode"
							placeholder="장소코드를 입력하세요." value="${spot.spotCode}">
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label description">장 소 번 호</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="spotPhone"
							placeholder="전화번호를 입력하세요." value="${spot.spotPhone}">
					</div>
				</div>

				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label description">장 소 설 명</label>
					<div class="col-sm-10">
						<textarea class="form-control" rows="4" name="spotDetail" placeholder="장소 설명을 입력해 주세요.">${spot.spotDetail}</textarea>
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label normal">주 소</label>
					<div class="col-sm-2" style="display:inline-flex;">
						<select name="spotProvince">
							<option value="1" ${spot.spotProvince == '1' ? 'selected' : ''} >강남구</option>
							<option value="2" ${spot.spotProvince == '2' ? 'selected' : ''}>강동구</option>
							<option value="3" ${spot.spotProvince == '3' ? 'selected' : ''}>강북구</option>
							<option value="4" ${spot.spotProvince == '4' ? 'selected' : ''}>강서구</option>
							<option value="5" ${spot.spotProvince == '5' ? 'selected' : ''}>관악구</option>
							<option value="6" ${spot.spotProvince == '6' ? 'selected' : ''}>광진구</option>
							<option value="7" ${spot.spotProvince == '7' ? 'selected' : ''}>구로구</option>
							<option value="8" ${spot.spotProvince == '8' ? 'selected' : ''}>금천구</option>
							<option value="9" ${spot.spotProvince == '9' ? 'selected' : ''}>노원구</option>
							<option value="10" ${spot.spotProvince == '10' ? 'selected' : ''}>도봉구</option>
							<option value="11" ${spot.spotProvince == '11' ? 'selected' : ''}>동대문구</option>
							<option value="12" ${spot.spotProvince == '12' ? 'selected' : ''}>동작구</option>
							<option value="13" ${spot.spotProvince == '13' ? 'selected' : ''}>마포구</option>
							<option value="14" ${spot.spotProvince == '14' ? 'selected' : ''}>서대문구</option>
							<option value="15" ${spot.spotProvince == '15' ? 'selected' : ''}>서초구</option>
							<option value="16" ${spot.spotProvince == '16' ? 'selected' : ''}>성동구</option>
							<option value="17" ${spot.spotProvince == '17' ? 'selected' : ''}>성북구</option>
							<option value="18" ${spot.spotProvince == '18' ? 'selected' : ''}>송파구</option>
							<option value="19" ${spot.spotProvince == '19' ? 'selected' : ''}>양천구</option>
							<option value="20" ${spot.spotProvince == '20' ? 'selected' : ''}>영등포구</option>
							<option value="21" ${spot.spotProvince == '21' ? 'selected' : ''}>용산구</option>
							<option value="22" ${spot.spotProvince == '22' ? 'selected' : ''}>은평구</option>
							<option value="23" ${spot.spotProvince == '23' ? 'selected' : ''}>종로구</option>
							<option value="24" ${spot.spotProvince == '24' ? 'selected' : ''}>종구</option>
							<option value="25" ${spot.spotProvince == '25' ? 'selected' : ''}>중랑구</option>
						</select>
					</div>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="spotAddress"
							placeholder="주소를 입력하세요." value="${spot.spotAddress}">
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label normal">X 좌 표</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="spotX"
							placeholder="X좌표를 입력하세요." value="${spot.spotX}">
					</div>
					<label class="col-sm-2 control-label normal">Y 좌 표</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" name="spotY"
							placeholder="Y좌표를 입력하세요." value="${spot.spotY}">
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label description">장 소 링 크</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" name="spotDetailURL"
							placeholder="장소의 설명이 담긴 링크를 입력하세요." value="${spot.spotDetailURL}">
					</div>
				</div>
				
				<div style="display: flex; margin-bottom:1vh;">
					<label class="col-sm-2 control-label normal">이 미 지</label>
					<div class="col-sm-10">
						<input type="file" name="file" style="font-size: 0.2em;">
					</div>
				</div>
				<div class="col-sm-12" style="display:flex; justify-content: center; margin-top:3%;">
					<button class="btn btn-primary update-button" style="margin-right:2%;">수정하기</button>
					<button class="btn btn-default toList" style="margin-left:2%;" onclick="javascript:window.location.href='/admin/listSpot';return false;">목록으로</button>
				</div>
			</div>
		</form>
	</div>



</body>
</html>