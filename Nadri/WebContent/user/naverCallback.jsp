<%@ page language="java" contentType="text/html; charset=EUC-KR"   pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>

<head>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>

<body>
	<!-- <!-- 네이버 로그인 자바스크립트 sdk 
	<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
	
	네이버 로그인 자바스크립트 설정 정보 및 초기화
	<script>
	 var naverLogin = new naver.LoginWithNaverId({
		clientId : "{HOBzhSrHnwuHLQpiDnzI}",
		callbackUrl : "{YOUR_CALLBACK_URL}",
		isPopup : false,
		callbackHandle : true
	 });
	 
	 //네이버 아이디로 로그인 정보 초기화를 위해 init 호출
	 naverLogin.init();
	 
	 //콜백 처리, 정상적으로 콜백 처리가 완료될 경우 메인 페이지로 리다이렉트
	 window.addEventListener('load', function(){
		 naverLogin.getLoginStatus(function(status){
			 if(status){
				 //필수로 받아야하는 프로필 정보가 있다면 콜백 시점에 체크
				 var email = naverLogin.user.getEmail();
				 if(email == undefined || email == null){
					 alert("이메일은 필수정보입니다. 정보제공을 위해 동의해주세요");
					 
					//사용자 정보 재동의를 위해 네이버 아이디로 로그인 페이지로 이동
					naverLogin.reprompt();
					return;
				 }
				 window.location.replace("http://" + window.location.hostname + ( (location.port==""||location.port==undefined)?"":":" + location.port) + "/index.jsp");	 
			 }else{
				 console.log("콜백 처리에 실패했습니다");
			 }
		 });
	 });
	</script> -->
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("HOBzhSrHnwuHLQpiDnzI", "YOUR_CALLBACK_URL");
		  // 접근 토큰 값 출력
		  //alert(naver_id_login.oauthParams.access_token);
		  
		  // 네이버 사용자 프로필 조회
		  naver_id_login.get_naver_userprofile("naverSignInCallback()");
		  
		  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		  function naverSignInCallback() {
			var id = naver_id_login.getProfileData('id')+"@naver";
			var nickname = naver_id_login.getProfileData('name');
		    //var email = naver_id_login.getProfileData('email');
			
			$.ajax({
				 url : "/user/json/checkDuplication/"+id,
           	 	 headers : {
 					"Accept" : "application/json",
 					"Content-Type" : "application/json"
 				 },
 				 success : function(idChk){
 					 
 					if(idChk==true){ 
						  console.log("회원가입중...");
						  $.ajax({
							  url : "/user/json/addUser",
							  method : "POST",
							  headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							  },
							  data : JSON.stringify({
  								userId : id,
								userName : nickname,
  								password : "naver",
							  }),
							  success : function(JSONData){
								 alert("회원가입이 정상적으로 되었습니다.");
								 window.close();
								 top.opener.location="/user/snsLogin/"+id;
							  }
						  })
					  }
					  if(idChk==false){ 
						  console.log("로그인 중...");
						  window.close();
						  top.opener.location="/user/snsLogin/"+id;
					  }
 				 }
			})
		  }
	</script> 

</body>
</html>