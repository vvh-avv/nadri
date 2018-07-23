<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>

<body>
	<div class="panel-body" >
	<a id="custom-login-btn" href="javascript:loginWithKakao()">
	<img src="//k.kakaocdn.net/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
	</a>
	</div>
	
	<script type='text/javascript'>
	 
	    Kakao.init('e9d991357b2138d7d0b11301a4cc5115');
	    function loginWithKakao() {
	      // 로그인 창을 띄웁니다.
	      Kakao.Auth.login({
	        success: function(authObj) {

	          var authorize_code = authObj.access_token;
	        	          
	          self.location="/user/kakaoLogin?authorize_code="+authorize_code;
	          },
	          
	        fail: function(err) {
	          alert(JSON.stringify(err));
	        }
	      })
	    };

	   
	    $(function(){
	    	$("a:contains('kakaoLogout')").on("click", function() {
	    		
	    		Kakao.Auth.logout(function(data) {
	    			if(data) {
	    				alert("로그아웃되었습니다.");
	    			 }		
	    	       })
	    		})
	     });
	    
	</script>
	
     <div class="form-group">
	    <a id="kakao-logout-btn">kakaoLogout</a>
	</div> 

	</body>
</html>