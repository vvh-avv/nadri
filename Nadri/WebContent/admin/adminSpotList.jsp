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
<link rel="stylesheet" href="/css/adminIndexSmall.css">
<script src="/javascript/adminIndex.js"></script>

<title>너나들이 나들이백과목록</title>

</head>
<style type="text/css">
html, body {
	margin: 0px;
	width: 100%;
	height: 70vh;
	font-size: 65px;
}

.text-center{
	font-size : 12px;
}

.tableset {
	margin: 5% 5%;
	width: 90%;
	text-align: right;
	font-size: 0.2em;
}

.table{
	margin-top:5%;
}

th {
	font-size: 12px;
	text-align: center;
}

.texts:hover {
	background: #ccc;
}

td {
	font-size: 11px;
	text-align: center;
}

.firstLine {
	background: #60a0b37a;
}

.inquireTransaction {
	display: flex;
	align-items: center;
	font-size: 0.2em;
}

.inquireTransaction>span {
	margin: 0px 5px;
}

.inquireBody {
	display: flex;
	align-items: flex-start;
	flex-direction: column;
	text-align: left;
}

.inquire-detail-title {
	display: block;
	position: relative;
	left: 0px;
	font-size: 2em;
	font-weight: 800;
	margin-left: 10vw;
}

ul {
	margin: 10px 10vw;
	padding: 10px;
}

li {
	margin: 5px 0px;
	font-size: 1.3em;
}

img {
	display: inline;
	float: right;
	margin: auto auto 1% auto;
}

.logbutton {
	margin-left: 15px;
}

.inquirebutton {
	margin-left: 70%;
	width: 15%;
	min-width: 80px;
	margin-right: 15%;
}

.modal-content {
	width: 60%;
	margin: 20% auto;
	align-items: center;
}

h5 {
	text-align: center;
}

.tableset-top {
	display: flex;
	align-items: center;
	margin-bottom: 1%;
	justify-content: flex-end;
}
</style>
<script type="text/javascript">
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/admin/listSpot")
				.submit();
	}

	$(function() {

		/* index page animation start */

		$('.admin-sub-navbar > div').on('click', function() {
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

		$('td[colspan=5]').hide();

		$('.texts').on('click', function() {
			var id = $(this).attr('id');
			if (id.length == 4) {
				var lastindex = id.charAt(id.length - 1);
				$('.' + lastindex).toggle();

			} else {
				console.log(id);
				var sublast = id.charAt(id.length - 1);
				console.log(sublast);
				var lastindex = id.lastIndexOf(sublast);
				console.log(lastindex);
				var realcount = id.substring(3, lastindex + 1);
				console.log(realcount);
				$('.' + realcount).toggle();
			}
		})

		$('.delete-spot').on('click', function() {
			var titleNo = $(this).parent().attr('class');
			console.log(titleNo);
			var title = $('#inq' + titleNo + " > td:nth-child(2)").text();
			var code = $('#inq' + titleNo + " > td:nth-child(1)").text();
			console.log(title);
			console.log(code);
			$('h5 > span').text(title);
			$('.hiddenNo').val(code);
		})

		$('.delete-fine').on('click', function() {
			var code = $('.hiddenNo').val();
			self.location = "/admin/deleteSpot?spotNo=" + code;
		})

		$('#addSpot').on('mouseover', function() {
			$(this).addClass('btn-primary');
		})

		$('#addSpot').on('mouseleave', function() {
			$(this).removeClass('btn-primary');
		})

		$('#addSpot').on('click', function() {
			self.location = "/admin/addSpot";
		})

		$('.modify-spot').on('click', function() {
			var no = $(this).attr('name');
			self.location = "/admin/updateSpot?spotNo=" + no;
		})
		
		$("button.btn.btn-default:contains('검색')").on("click", function() {
			fncGetList(1);
		});
	})
</script>
<body>

	<nav class="admin-navbar">
		<a href="/admin/adminIndex"><h2 class="title">너나들이 Admin</h2></a>
		<div class="navbar-side">
			<a href="/"><div class="glyphicon glyphicon-home"></div></a>
			<div class="profile-photo" style="background:url(/images/profile/${user.profileImg}); background-size:contain;">
			</div>
		</div>
	</nav>
	<nav class="admin-sub-navbar">
		<div class="userList">회원목록</div>
		<div class="graph">통계보기</div>
		<div class="spot">백과관리</div>
		<div class="inquire">문의관리</div>
	</nav>

	<c:if test="${list.size()==0}">
		<div class="container">
			<div>나들이 목록이 하나도 없어요.</div>
		</div>
	</c:if>

	<c:if test="${list.size() > 0}">

		<div class="tableset">
			<div class="tableset-top">
				<div class="col-md-6 text-left">
					<p class="text-primary">전체 ${resultPage.totalCount } 건수, 현재
						${resultPage.currentPage == 0 ? 1 : resultPage.currentPage} 페이지</p>
				</div>

				<div class="col-md-6 text-right">
					<form class="form-inline" name="detailForm">

						<div class="form-group">
							<select class="form-control" name="searchCondition">
								<option value="0"
									${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>장소명</option>
								<option value="1"
									${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>장소번호</option>
							</select>

							<label class="sr-only" for="searchKeyword">검색어</label> <input
								type="text" class="form-control" id="searchKeyword"
								name="searchKeyword" placeholder="검색어"
								value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
						</div>

						<button type="button" class="btn btn-default">검색</button>

						<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						<input type="hidden" id="currentPage" name="currentPage" value="" />

					</form>
				</div>
				<button id="addSpot" class="btn btn-default">추가하기</button>
			</div>
			<table class="table">
				<tr class="firstLine">
					<th>장소번호</th>
					<th>장소이름</th>
					<th>장소주소</th>
					<th>장소등록일</th>
					<th>최종수정일</th>
				</tr>
				<c:set var="i" value="0" />
				<c:forEach var="spot" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr id="inq${i}" class="texts">
						<td>${spot.spotNo}</td>
						<td>${spot.spotTitle}</td>
						<td>${spot.spotAddress}</td>
						<td>${spot.spotCreateTime}</td>
						<td>${spot.spotModifyTime}</td>
					</tr>
					<tr>
						<td colspan="5" class="${i}">
							<div class="inquireBody">
								<div class="inquire-detail-title">
									<span>${spot.spotTitle}</span> 상세보기
								</div>
								<ul>
									<li>주소지 : ${spot.spotAddress}</li>
									<li>설 &nbsp;&nbsp;&nbsp;명 : ${spot.spotDetail}</li>
									<li>장소 이미지</li>
								</ul>
								<img src="/images/spot/${spot.spotImg}">
							</div>
							<button class="btn btn-danger delete-spot" data-toggle="modal"
								data-target="#modal2">삭제하기</button>
							<button class="btn btn-defalut modify-spot" name="${spot.spotNo}">수정하기</button>
						</td>
					<tr>
				</c:forEach>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</div>
		<!-- PageNavigation Start... -->
		<jsp:include page="../common/pageNavigator.jsp" />
		<!-- PageNavigation End... -->
	</c:if>

	<!-- 삭제확인 Modal content-->
	<div class="modal fade" id="modal2" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h5>
					<span></span>의 정보를 정말로 삭제하시겠습니까? <input type="hidden" name="spotNo"
						value="" class="hiddenNo">
				</h5>
				<div
					style="justify-content: space-evenly; display: flex; padding: 5%;">
					<button type="button" class="btn btn-danger delete-fine">삭제확인</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소하기</button>
				</div>
			</div>

		</div>
	</div>



</body>
</html>