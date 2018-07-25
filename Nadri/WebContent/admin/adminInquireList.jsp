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
			<div class="profile-photo"></div>
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
					<div class="col-md-10 col-xs-12">
						<div class="glyphicon glyphicon-search"></div>
						<input type="text" class="inquireKeyword" name="searchKeyword"
							placeholder="검색어를 입력해주세요"
							value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
						<div class="row check-boxes">

							<div class="col-md-3 col-xs-3">
								<input type="checkbox" name="inclCon" class="conditions"
									value="이름"><label class="cons-label" id="inclCon">
									검색어를 포함한 검색 </label>
							</div>

							<div class="col-md-3 col-xs-3">
								<input type="checkbox" name="beginCon" class="conditions"
									value="이름"><label class="cons-label" id="beginCon">
									검색어로 시작하는 검색 </label>
							</div>

							<div class="col-md-3 col-xs-3">
								<input type="checkbox" name="endCon" class="conditions"
									value="이름"><label class="cons-label" id="endCon">
									검색어로 끝나는 검색 </label>
							</div>
							
							<div class="col-md-3 col-xs-3">
								<input type="checkbox" name="noChecked" class="conditions"
									value="이름"><label class="cons-label" id="noChecked">
									처리완료문의제외 </label>
							</div>
						</div>
						<div class="row order-option">
							<div class="col-md-6">최신순</div>
							<div class="col-md-6">종류별</div>
						</div>
					</div>
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

							<div class="col-md-6 text-left">
								<p class="text-primary">전체 ${resultPage.totalCount } 건수, 현재
									${resultPage.currentPage} 페이지</p>
							</div>

							<div class="col-md-6 text-right">
								<form class="form-inline" name="detailForm">

									<div class="form-group">
										<select class="form-control" name="searchCondition">
											<option value="0"
												${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>문의회원ID</option>
											<option value="1"
												${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>문의명</option>
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
									<input type="hidden" id="currentPage" name="currentPage"
										value="" />

								</form>
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
									<td>${inquire.inquireCode=="0" ? "유저신고" : (inquire.inquireCode=="1" ? "댓글신고" : (inquire.inquireCode=="2" ? "게시글신고" : (inquire.inquireCode=="3" ? "정정신청" : "기타문의" )) )}</td>
									<td>${inquire.inquireTitle}</td>
									<td>${inquire.inquireWrite}</td>
									<td>${inquire.userId}</td>
									<td>${inquire.inquireChkCode=="0" ? "처리대기" : (inquire.inquireChkCode=="2" ? "보류처리" : "정상처리") }</td>
									<td>${inquire.inquireTime}</td>
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
														<button class="logbutton userReportLog"
															data-toggle="modal" data-target="#modal2"
															name="${inquire.reportUserId}">활동보기</button>
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
			</div>
		</div>
	</div>


	<script src="/javascript/adminInquire.js"></script>
</body>
</html>