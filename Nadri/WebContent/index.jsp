<%@ page contentType="text/html; charset=euc-kr"%>

<!DOCTYPE html>
<html>
<head>
<title>너,나들이</title>

	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- 카카오 로그인 -->
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
     
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		$(function(){
			$("img[src='/images/user/kakao_login_btn_small.png']").on("click" , function() {
				loginWithKakao();
			});
		});
		
		Kakao.init('7368fcab4bac4f1c102ca1316601d03f');
	    function loginWithKakao() {
	      // 로그인 창을 띄웁니다.
	      Kakao.Auth.login({
	        success: function(authObj) {
	            // 로그인 성공시, API를 호출합니다.
	            Kakao.API.request({
	              url: '/v1/user/me',
	              success: function(res) {
	                //alert(JSON.stringify(res));
	                checkUser(res);
	              },
	              fail: function(error) {
	                alert(JSON.stringify(error));
	              }
	            });
	          },
	          fail: function(err) {
	            alert(JSON.stringify(err));
	          }
	      });
	    };
	
	</script>
</head>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />


<body>
<jsp:include page="layout/toolbar.jsp"/>
   	<br/>
   	메인화면 test
   	<br/>
   	
   	 <div class="form-group">
	    <div class="col-sm-offset-4 col-sm-6 text-center">
			<img src="/images/user/kakao_login_btn_small.png" />
	    </div>
	  </div>
   	
</body>

</html>