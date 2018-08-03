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

<title>너나들이 유저 목록</title>

</head>
<style type="text/css">
html, body {
	margin: 0px;
	width: 100%;
	height:70vh;
	font-size: 65px;
}

.text-center{
	font-size : 12px;
}

.tableset {
	margin: 5% 5%;
	width: 90%;
	text-align: left;
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
	background: rgba(163, 161, 159, 0.52);
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

.navbar {
	font-size: 0.2em;
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

.logbutton {
	margin-left: 15px;
}

.inquirebutton {
	margin-left: 70%;
	width: 15%;
	min-width: 80px;
	margin-right: 15%;
}

#chart_div {
	display: flex;
	justify-content: center;
}

.userLogList {
	font-size: 0.2em;
}

select, option {
	font-size: 0.2em;
}

.duration-log {
	display: flex;
	justify-content: flex-end;
}

.block-user {
	visibility: hidden;
	margin-right: 2%;
}

.row{
	display:flex;
	justify-content: space-between;
	align-items: center;
}

</style>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	// 구글 챠트의 정보를 불러옵니다.
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	
	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/admin/listUser").submit();
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

		$('.inquirebutton').on(
				'click',
				function() {
					var id = $(this).attr('id');
					console.log(id);

					var code = $('#inq' + id + " td:nth-child(2)").text();
					var no = $('#inq' + id + " td:nth-child(1)").text();
					$('.inquireTransaction > span:nth-child(2)').text(code);
					$('.inquireTransaction > span:nth-child(2)').css(
							'font-weight', '800');
					$('.inquireTransaction > span:nth-child(1)').text(no);
					$('.inquireTransaction > span:nth-child(1)').css(
							'font-weight', '800');

					$('#modal1').modal();
				});

		$('td[colspan=7]').hide();

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

		$('.sended').on(
				'click',
				function() {
					var inqCode = $('.inquiredCode').text();
					var chkCode = $('.inquireChkCode').val();
					console.log('checked code value = ' + chkCode);
					self.location = '/admin/updateInquire?inqCode=' + inqCode
							+ '&chkCode=' + chkCode;
				})

		$('img').on('mouseover', function() {
			$(this).css('cursor', 'pointer');
			$(this).css('opacity', '0.5');
		})

		$('img').on('click', function() {
			window.open($(this).attr('src'), "_blank");
		})

		$('img').on('mouseleave', function() {
			$(this).css('opacity', '1');
		})
		
		$("button.btn.btn-default:contains('검색')").on("click", function() {
			fncGetList(1);
		});

		
		

	});
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
			<div>회원 목록이 하나도 없어요.</div>
		</div>
	</c:if>

	<c:if test="${list.size() > 0}">
		<div class="tableset">
			<div class="row">

				<div class="col-md-6 text-left">
					<p class="text-primary" style="margin:0px;">전체 ${resultPage.totalCount } 건수, 현재
						${resultPage.currentPage == 0 ? 1 : resultPage.currentPage} 페이지</p>
				</div>

				<div class="col-md-6 text-right">
					<form class="form-inline" name="detailForm">

						<div class="form-group">
							<select class="form-control" name="searchCondition">
								<option value="0"
									${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
								<option value="1"
									${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
							</select>
						</div>

						<div class="form-group">
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

			</div>
			<table class="table">
				<tr class="firstLine">
					<th>회원아이디</th>
					<th>회원이름</th>
					<th>검색공개유무</th>
					<th>가입일</th>
					<th>마지막 접속일</th>
					<th>유저상태</th>
					<th>유저 아이피</th>
				</tr>
				<c:set var="i" value="0" />
				<c:forEach var="user" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr id="list${i}" class="texts">
						<td>${user.userId}</td>
						<td>${user.userName}</td>
						<td>${user.infoOption==0 ? "공개" : "비공개"}</td>
						<td>${user.regDate}</td>
						<td>${user.lastLogin}</td>
						<td>${user.status==0 ? "정상" : (user.status == 1 ? "차단" : "탈퇴")}</td>
						<td>${user.ip}</td>
					</tr>
					<tr>
						<td colspan="7" class="${i}">
							<div class="inquireBody">
								<div class="inquire-detail-title">${inquire.inquireNo}번
									문의내용 상세보기</div>

								<ul>

									<li>문의글 작성 유저 아이디 : ${inquire.userId}
										<button class="logbutton userInqLog" data-toggle="modal"
											data-target="#modal2" name="${inquire.userId}">활동보기</button>
									</li>

									<c:if test="${inquire.inquireCode==0}">
										<li>신고된 해당 유저 아이디 : ${inquire.reportUserId}
											<button class="logbutton userReportLog" data-toggle="modal"
												data-target="#modal2" name="${inquire.reportUserId}">활동보기</button>
										</li>
									</c:if>

									<c:if test="${inquire.inquireCode > 0}">
										<li>링크 : ${inquire.inquireLink}</li>
									</c:if>

									<li>신고 내용 : ${inquire.inquireWrite}</li>
									<li>첨부 파일</li>

								</ul>

								<img src="/images/inquire/${inquire.inquireFile1}"
									style="width: 100px; height: 100px;">

								<c:if test="${inquire.inquireChkCode==0}">
									<button class="btn btn-primary inquirebutton" id="${i}"
										data-toggle="modal" data-target="#Modal1">신고처리하기</button>
								</c:if>

							</div>
						</td>
					<tr>
				</c:forEach>
				<tr>
					<td></td>
					<td></td>
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

	

	<!-- 신고처리 Modal content-->
	<div class="modal fade" id="Modal1" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">신고처리</h4>
				</div>
				<div class="modal-body">
					<div class="inquireTransaction">
						회원님의 <span class="inquiredCode"></span>번 <span></span> 문의는 <select
							class="inquireChkCode">
							<option value="1">정상처리</option>
							<option value="2">보류처리</option>
						</select> 되었습니다.
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary sended">보내기</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫
						기</button>
				</div>
			</div>


		</div>
	</div>

	<!-- 회원활동확인 Modal content-->
	<div class="modal fade" id="modal2" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<span class="userIdLog"></span>회원활동
					</h4>
				</div>
				<div class="modal-body">
					<div class="duration-log">
						<select name="duration" class="duration">
							<option value="all">전체</option>
							<option value="week">이번주</option>
							<option value="month">이번달</option>
						</select>
					</div>

					<div id="chart_div"></div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger block-user"
						data-dismiss="modal">유저차단하기</button>
					<button type="button" class="btn btn-default modal-close"
						data-dismiss="modal">닫기</button>
				</div>
			</div>


		</div>
	</div>

</body>
</html>