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

<!-- admin index 전용  -->
<link rel="stylesheet" href="/css/adminIndex.css">
<link rel="stylesheet" href="/css/adminIndexSmall.css">
<link rel="stylesheet" href="/css/adminInquire.css">
<link rel="stylesheet" href="/css/adminInquireSmall.css">
<script src="/javascript/adminIndex.js"></script>

<title>너나들이 어드민 문의관리 페이지</title>

</head>

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<body>

	<nav class="admin-navbar">
		<a href="/admin/adminIndex"><h2 class="title">너나들이 Admin</h2></a>
		<div class="navbar-side">
			<a href="/"><div class="glyphicon glyphicon-home"></div></a>
			<div class="profile-photo"
				style="background:url(/images/profile/${user.profileImg}); background-size:contain;">
			</div>
		</div>
	</nav>
	
	<nav class="admin-sub-navbar">
		<div class="userList">회원목록</div>
		<div class="graph">통계보기</div>
		<div class="spot">백과관리</div>
		<div class="inquire">문의관리</div>
	</nav>

	<div class="container">
		<div class="row option-box">
			<div class="col-md-12 col-xs-12">
				<div class="inquire-title">문의목록 조회하기</div>
				<div class="open-searcher">
					<label class="switch"> <input type="checkbox"> <span
						class="slider round"></span>
					</label>
				</div>
				<div class="row options">
					<form name="inquire-search-form" class="inquire-search-form">
						<div class="col-md-10 col-xs-12">
							<div class="glyphicon glyphicon-search"></div>
							<input type="text" class="inquireKeyword" name="searchKeyword"
								placeholder="검색어를 입력해주세요"
								value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
							<input type="hidden" name="listing" class="listing" value="${empty lister ? 'not_listed' : lister }">
							<input style="display: none;">
							<div class="row check-boxes">

								<div class="col-md-3 col-xs-3">
									<input type="radio" name="searchCondition" class="conditions"
										value="0"><label class="cons-label" id="inclCon">
										문의명으로 검색 </label>
								</div>

								<div class="col-md-3 col-xs-3">
									<input type="radio" name="searchCondition" class="conditions"
										value="1"><label class="cons-label" id="beginCon">
										문의내용 검색 </label>
								</div>

								<div class="col-md-3 col-xs-3">
									<input type="radio" name="searchCondition" class="conditions"
										value="2"><label class="cons-label" id="endCon">
										문의유저 검색 </label>
								</div>

								<div class="col-md-3 col-xs-3">
									<input type="checkbox" name="noChecked" class="conditions"
										value="doneNot"><label class="cons-label"
										id="noChecked"> 처리완료문의제외 </label>
								</div>
							</div>
							<div class="row order-option">

								<div class="col-md-4 option-align">
									<div>최신순</div>
									<div class="glyphicon glyphicon-arrow-up option-icons"></div>
									<div class="glyphicon glyphicon-arrow-down option-icons"></div>
								</div>

								<div class="col-md-4 option-align">
									<div>종류별</div>
									<div class="glyphicon glyphicon-arrow-up option-icons"></div>
									<div class="glyphicon glyphicon-arrow-down option-icons"></div>
								</div>

								<div class="col-md-4 option-align">
									<div>처리순</div>
									<div class="glyphicon glyphicon-arrow-up option-icons"></div>
									<div class="glyphicon glyphicon-arrow-down option-icons"></div>
								</div>

							</div>
						</div>
						<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						<input type="hidden" id="currentPage" name="currentPage" value="" />
					</form>
				</div>
			</div>
		</div>
		<div class="row inquire-lists">
			<div class="col-md-12 col-xs-12">
				<c:if test="${list.size()==0}">
					<div class="non-inquire">
						<div>조회된 문의 내역이 없습니다.</div>
					</div>
				</c:if>
				<c:if test="${list.size() > 0}">
					<div class="tableset">
						<div class="row">
							<div class="col-md-6 text-right">
								<p class="text-primary">전체 ${resultPage.totalCount } 건수, 현재
									${resultPage.currentPage == 0 ? 1 : resultPage.currentPage} 페이지</p>
							</div>
						</div>
						<table class="table">
							<tr class="firstLine">
								<th>문의번호</th>
								<th>문의유형</th>
								<th>문의제목</th>
								<th>문의내용</th>
								<th>문의유저</th>
								<th>문의처리</th>
								<th>문의날짜</th>
							</tr>
							<c:set var="i" value="0" />
							<c:forEach var="inquire" items="${list}">
								<c:set var="i" value="${ i+1 }" />
								<tr id="inq${i}" class="texts">
									<td>${inquire.inquireNo}</td>
									<td>${inquire.inquireCode=="0" ? "유저신고" : (inquire.inquireCode=="1" ? "게시글신고" : (inquire.inquireCode=="2" ? "댓글신고" : (inquire.inquireCode=="3" ? "정정신청" : "기타문의" )) )}</td>
									<td>${inquire.inquireTitle}</td>
									<td>${inquire.inquireWrite}</td>
									<td>${inquire.userId}</td>
									<td>${inquire.inquireChkCode=="0" ? "처리대기" : (inquire.inquireChkCode=="2" ? "보류처리" : "정상처리") }</td>
									<td>${inquire.inquireTime}</td>
								</tr>
								<tr>
									<td colspan="7" class="${i} body-box">
										<div class="inquireBody">
											<div class="inquire-detail-title">${inquire.inquireNo}번
												문의내용 상세보기</div>
											<ul>

												<li class="ele-inquire">문의글 작성 유저 아이디 :
													${inquire.userId}
													<button class="logbutton userInqLog" data-toggle="modal"
														data-target="#modal2" name="${inquire.userId}">활동보기</button>
												</li>

												<c:if test="${inquire.inquireCode==0}">
													<li class="ele-inquire">신고된 해당 유저 아이디 :
														${inquire.reportUserId}
														<button class="logbutton userReportLog"
															data-toggle="modal" data-target="#modal2"
															name="${inquire.reportUserId}">활동보기</button>
													</li>
												</c:if>

												<c:if test="${inquire.inquireCode > 0}">
													<li class="ele-inquire">
													링크 : ${inquire.inquireLink}
													<c:if test="${inquire.inquireCode == 1}">
													<button class="logbutton inquire-detail-view"
															data-toggle="modal" data-target="#inquire-detail-modal"
															name="${inquire.inquireLink}" id="${inquire.inquireCode}">내용보기</button>
													</c:if>
													<c:if test="${inquire.inquireCode == 2}">
													<button class="logbutton inquire-detail-view"
															data-toggle="modal" data-target="#inquire-detail-modal"
															name="${inquire.inquireLink}" id="${inquire.inquireCode}">내용보기</button>
													</c:if>
													<c:if test="${inquire.inquireCode == 3}">
													<button class="logbutton inquire-detail-view"
															data-toggle="modal" data-target="#inquire-detail-modal"
															name="${inquire.inquireLink}" id="${inquire.inquireCode}">내용보기</button>
													</c:if>
													</li>
												</c:if>

												<li class="ele-inquire">신고 내용 : ${inquire.inquireWrite}</li>
												<c:if test="${inquire.inquireChkCode > 0}">
													<li class="ele-inquire">처리 사유 : ${inquire.inquireChkReason}</li>
												</c:if>
												<li class="ele-inquire">첨부 파일</li>

											</ul>

											<div class="inquire-detail-bottom">
												<img src="/images/inquire/${empty inquire.inquireFile1 ? 'no_image.jpg' : inquire.inquireFile1}" style="width: 100px; height: 100px;">
												<c:if test="${inquire.inquireChkCode==0}">
													<button class="btn btn-primary inquirebutton" id="${inquire.inquireNo}"
														data-toggle="modal" data-target="#inquire-taken">신고처리하기</button>
												</c:if>
											</div>
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
			</div>
		</div>
	</div>

	<!-- modal start (do not mess with below) -->


	<div class="modal fade" id="modal2" role="dialog">

		<div class="modal-dialog modal-lg">
			<div class="modal-content user-modal">
				<div class="modal-header inquired-user-header">
					<span class="userIdLog"></span> 회원님의 활동 정보입니다.
				</div>
				<div class="modal-body chart-body">
					<div id="chart_div"></div>
					<div class="chart-duration">
						<select name="duration" class="duration">
							<option value="" hidden>기간</option>
							<option value="all">전체</option>
							<option value="week">주간</option>
							<option value="month">월간</option>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<div class="user-log-buttons">
						<button class="btn btn-danger block-user" data-toggle="modal"
							data-target="#modal3">차단하기</button>
						<button class="btn btn-default closer" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>

	</div>
	
	<div class="modal fade" id="inquire-detail-modal" role="dialog">

		<div class="modal-dialog modal-lg">
			<div class="modal-content user-modal">
				<div class="modal-header inquired-user-header">
					신고된 게시글의 내용확인
				</div>
				<div class="modal-body chart-body">
					<div class="reply-detail" style="font-size:15px;"></div>
				</div>
				<div class="modal-footer">
					<div class="user-log-buttons">
						<button class="btn btn-danger block-reported-user" data-toggle="modal"
							data-target="#modal3">차단하기</button>
						<button class="btn btn-default closer" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>

	</div>

	<div class="modal fade" id="modal3" role="dialog">

		<div class="modal-dialog modal-lg">
			<div class="modal-content user-modal">
				<div class="modal-header inquired-user-header">
					<span class="userIdLog-check"></span> 회원을 정말로 차단하시겠습니까?
				</div>
				<div class="modal-body chart-body" style="font-size:15px; letter-spacing:2px;">차단확인 혹은 취소를 눌러주세요.</div>
				<div class="modal-footer">
					<div class="user-log-buttons">
						<button class="btn btn-danger block-fine">차단확인</button>
						<button class="btn btn-default closer" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>

	</div>

	<div class="modal fade" id="inquire-taken" role="dialog">

		<div class="modal-dialog modal-lg">
			<div class="modal-content user-modal">
				<div class="modal-header inquired-user-header">신고 내역 처리하기</div>
				<div class="modal-body chart-body" style=" font-size:12px">
					<div class="chart-duration" style="align-items:center; width : 60%; justify-content:space-evenly">
						<div><span class="inquire-chk-userId"></span>회원님의 신고는</div>
						<div>
						<input type="hidden" name="inquireCode" class="inquireCodeHidden" value="">
							<select name="inquireChkReason" class="inquireChkReason" style="height:30px">
								<option value="" hidden>처리사유선택</option>
								<option value="0">약관위배</option>
								<option value="1">욕설 및 도배</option>
								<option value="2">허위사실게재</option>
								<option value="3">광고글 게시</option>
							</select>
						</div>
						 사유에 의해서 
						<div>
							<select name="inquireChkCode" class="inquireChkCode" style="height:30px">
								<option value="" hidden>처리종류선택</option>
								<option value="1">정상처리</option>
								<option value="2">보류처리</option>
							</select>
						</div>
						<div>되었습니다.</div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="user-log-buttons">
						<button class="btn btn-primary sended">처리하기</button>
						<button class="btn btn-default closer" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>

	</div>

	<script src="/javascript/adminInquire.js"></script>
</body>
</html>