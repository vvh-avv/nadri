<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>너,나들이</title>

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- 카카오 로그인 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script src="/javascript/toolbar.js"></script>
<link rel="stylesheet" href="/css/toolbar.css">

<!--  slick  -->
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	$(function() {
		$("img[src='/images/user/kakao_login_btn_small.png']").on("click",
				function() {
					loginWithKakao();
				});
	});

	Kakao.init('7368fcab4bac4f1c102ca1316601d03f');
	function loginWithKakao() {
		// 로그인 창을 띄웁니다.
		Kakao.Auth.login({
			success : function(authObj) {
				// 로그인 성공시, API를 호출합니다.
				Kakao.API.request({
					url : '/v1/user/me',
					success : function(res) {
						//alert(JSON.stringify(res));
						checkUser(res);
					},
					fail : function(error) {
						alert(JSON.stringify(error));
					}
				});
			},
			fail : function(err) {
				alert(JSON.stringify(err));
			}
		});
	};
</script>
<style>
.middle-bar {
	width: 100%;
	height: 120vh;
	box-shadow: 0px -2px 36px -2px rgba(112, 112, 112, 0.5);
	padding-top: 10vh;
	text-align: center;
}

.container-fluid {
	padding: 0px 0px;
}

.popular-contents {
	position: relative;
	margin-top: 5vh;
	display: flex;
	justify-content: space-around;
	text-align: center;
	width: 100%;
}

.popular-contents>div>div {
	border: 1px solid grey;
	height: 20vh;
}
</style>
</head>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />


<body>
	<div class="container-fluid indexHead">
		<%@ include file="layout/toolbar.jsp"%>
		<div
			style="width: 30%; height: 50%; margin: 10% auto; text-align: center;">
			<h1 style="font-weight: 800; color: white;">우리 나들이 갈래?</h1>
		</div>
	</div>
	<div class="container-fluid">
		<div class="middle-bar">
			<h2 style="font-weight: 700;">지금 인기 게시글</h2>
			<div class="container">
				<div class="popular-contents container">
					<div class="col-md-3 col-xs-6" style="line-height: 20vh;">
						<div>PLACE BOX</div>
					</div>
					<div class="col-md-3 col-xs-6" style="line-height: 20vh;">
						<div>PLACE BOX</div>
					</div>
					<div class="col-md-3 col-xs-6" style="line-height: 20vh;">
						<div>PLACE BOX</div>
					</div>
					<div class="col-md-3 col-xs-6" style="line-height: 20vh;">
						<div>PLACE BOX</div>
					</div>
				</div>
			</div>

			<h2 style="font-weight: 700; margin-top: 10%;">지금 인기 일정</h2>
			<div class="container">
				<div class="popular-contents container">
					<div class="col-md-6 col-xs-12" style="line-height: 20vh;">
						<div>PLACE BOX</div>
					</div>
					<div class="col-md-6 col-xs-12" style="line-height: 20vh;">
						<div>PLACE BOX</div>
					</div>
				</div>
				<div class="popular-contents container">
					<div class="col-md-12 col-xs-12" style="line-height: 20vh;">
						<div>PLACE BOX</div>
					</div>
				</div>
			</div>
		</div>
		<div
			style="height: 200px; width: 100%; background-color: #7caafb; padding-top: 10vh; text-align: center;">
			<h3 style="margin-top: 0px; font-weight: 800;">middle area</h3>
		</div>
		<div style="width:100%; height:500px;">
		
		</div>
	</div>

</body>

</html>