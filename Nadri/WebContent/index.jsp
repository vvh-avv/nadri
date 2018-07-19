<%@ page contentType="text/html; charset=euc-kr"%>
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
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

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
</head>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />


<body>
	<div class="container-fluid indexHead">
		<%@ include file="layout/toolbar.jsp"%>
	</div>
	<div class="container-fluid">
		<div class="middle-bar">
			<div class="popular-contents container">
				<div class="col-md-3 col-xs-6">content1</div>
				<div class="col-md-3 col-xs-6">content2</div>
				<div class="col-md-3 col-xs-6">content3</div>
				<div class="col-md-3 col-xs-6">content4</div>
				<div class="col-md-3 col-xs-6">content5</div>
				<div class="col-md-3 col-xs-6">content1</div>
				<div class="col-md-3 col-xs-6">content2</div>
				<div class="col-md-3 col-xs-6">content3</div>
				<div class="col-md-3 col-xs-6">content4</div>
				<div class="col-md-3 col-xs-6">content5</div>
			</div>
		</div>
	</div>
	
</body>

</html>