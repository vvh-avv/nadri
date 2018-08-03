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
							<div class="col-md-6 option-align">
								<div>최신순</div>
								<div class="glyphicon glyphicon-arrow-up option-icons"></div>
								<div class="glyphicon glyphicon-arrow-down option-icons"></div>
							</div>
							<div class="col-md-6 option-align">
								<div>종류별</div>
								<div class="glyphicon glyphicon-arrow-up option-icons"></div>
								<div class="glyphicon glyphicon-arrow-down option-icons"></div>
							</div>
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
									${resultPage.currentPage == 0 ? 1 : resultPage.currentPage} 페이지</p>
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
													<li class="ele-inquire">링크 : ${inquire.inquireLink}</li>
												</c:if>

												<li class="ele-inquire">신고 내용 : ${inquire.inquireWrite}</li>
												<li class="ele-inquire">첨부 파일</li>

											</ul>

											<div class="inquire-detail-bottom">
												<img src="/images/inquire/${inquire.inquireFile1}"
													style="width: 100px; height: 100px;">

												<c:if test="${inquire.inquireChkCode==0}">
													<button class="btn btn-primary inquirebutton" id="${i}"
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
	<!-- <div class="modal fade" id="inquire-taken" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-body">
        <div class="row">
          <div class="col-lg-5">
            Carousel Wrapper
            <div id="carousel-thumb" class="carousel slide carousel-fade carousel-thumbnails" data-ride="carousel">
                Slides
                <div class="carousel-inner" role="listbox">
                    <div class="carousel-item active">
                        <img class="d-block w-100" src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/img%20(23).jpg" alt="First slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/img%20(24).jpg" alt="Second slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/img%20(25).jpg" alt="Third slide">
                    </div>
                </div>
                /.Slides
                Controls
                <a class="carousel-control-prev" href="#carousel-thumb" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carousel-thumb" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
                /.Controls
                <ol class="carousel-indicators">
                    <li data-target="#carousel-thumb" data-slide-to="0" class="active"> <img class="d-block" src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/img%20(23).jpg" class="img-fluid"></li>
                    <li data-target="#carousel-thumb" data-slide-to="1"><img class="d-block" src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/img%20(24).jpg" class="img-fluid"></li>
                    <li data-target="#carousel-thumb" data-slide-to="2"><img class="d-block" src="https://mdbootstrap.com/img/Photos/Horizontal/E-commerce/Vertical/img%20(25).jpg" class="img-fluid"></li>
                </ol>
            </div>
            /.Carousel Wrapper
          </div>
          <div class="col-lg-7">
            <h2 class="h2-responsive product-name">
              <strong>Product Name</strong>
            </h2>
            <h4 class="h4-responsive">
              <span class="green-text">
                <strong>$49</strong>
              </span>
              <span class="grey-text">
                <small>
                  <s>$89</s>
                </small>
              </span>
            </h4>

            Accordion wrapper
            <div class="accordion" id="accordion" role="tablist" aria-multiselectable="true">

                Accordion card
                <div class="card">

                    Card header
                    <div class="card-header" role="tab" id="headingOne">
                        <a data-toggle="collapse" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            <h5 class="mb-0">
                                Description <i class="fa fa-angle-down rotate-icon"></i>
                            </h5>
                        </a>
                    </div>

                    Card body
                    <div id="collapseOne" class="collapse show" role="tabpanel" aria-labelledby="headingOne" data-parent="#accordion" >
                        <div class="card-body">
                            Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute,
                            non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod.
                        </div>
                    </div>
                </div>
                Accordion card

                Accordion card
                <div class="card">

                    Card header
                    <div class="card-header" role="tab" id="headingTwo">
                        <a class="collapsed" data-toggle="collapse" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                            <h5 class="mb-0">
                                Details <i class="fa fa-angle-down rotate-icon"></i>
                            </h5>
                        </a>
                    </div>

                    Card body
                    <div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo" data-parent="#accordion" >
                        <div class="card-body">
                            Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute,
                            non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod.
                        </div>
                    </div>
                </div>
                Accordion card

                Accordion card
                <div class="card">

                    Card header
                    <div class="card-header" role="tab" id="headingThree">
                        <a class="collapsed" data-toggle="collapse" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                            <h5 class="mb-0">
                                Shipping <i class="fa fa-angle-down rotate-icon"></i>
                            </h5>
                        </a>
                    </div>

                    Card body
                    <div id="collapseThree" class="collapse" role="tabpanel" aria-labelledby="headingThree" data-parent="#accordion">
                        <div class="card-body">
                            Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute,
                            non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod.
                        </div>
                    </div>
                </div>
                Accordion card
            </div>
            /.Accordion wrapper

            Add to Cart
            <div class="card-body">
              <div class="row">
                <div class="col-md-6">
                  <div class="md-form">
                    <select class="mdb-select colorful-select dropdown-primary">
                      <option value="" disabled selected>Choose your option</option>
                      <option value="1">White</option>
                      <option value="2">Black</option>
                      <option value="3">Pink</option>
                    </select>
                    <label>Select color</label>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="md-form">
                    <select class="mdb-select colorful-select dropdown-primary">
                      <option value="" disabled selected>Choose your option</option>
                      <option value="1">XS</option>
                      <option value="2">S</option>
                      <option value="3">L</option>
                    </select>
                    <label>Select size</label>
                  </div>
                </div>
              </div>
              <div class="text-center">

                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button class="btn btn-primary">Add to cart
                  <i class="fa fa-cart-plus ml-2" aria-hidden="true"></i>
                </button>
              </div>
            </div>
            /.Add to Cart
          </div>
        </div>
      </div>
    </div>
  </div>
</div> -->
	<!-- Modal: modalQuickView -->

	</div>

	<script src="/javascript/adminInquire.js"></script>
</body>
</html>