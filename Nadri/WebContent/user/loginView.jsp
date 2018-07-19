<%@ page contentType="text/html; charset=euc-kr"%>

<!DOCTYPE html>
<html>
<head>
<title>너, 나들이 test</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<!-- 카카오 로그인 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<!-- 구글 로그인 -->
<script src="https://apis.google.com/js/client:platform.js?onload=renderButton" async defer></script> 
<!-- <script src="https://apis.google.com/js/platform.js" async defer></script> -->
<!-- <script src="https://apis.google.com/js/api:client.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>	 -->
<meta name="google-signin-client_id" content="318076473976-lvibspiedbi0fmj9iiugfiqpg9v16b47.apps.googleusercontent.com"></meta> 

<!-- 네이버 로그인 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>


<style>
	body > div.comtainer{
		border : 3px solid #D6CDB7;
		margin-top : 133px;
	}
</style>

<script type="text/javascript">
	//로그인 버튼 누르면 밑의 메서드에 의해 동작
	function fncLogin(){
		var id = $("#userId").val();
		var pw = $("#password").val();
		//아이디, 비번 입력해야 : 유효성 검사
		if(id==null || id.length<1){
			alert('아이디를 입력하지 않으셨습니다.');
			$("input:text").focus();
			return;
		}
			
		if(pw==null || pw.length<1){
			alert('패스워드를 입력하지 않으셨습니다.');
			$("input:password").focus();
			return;
		}

		$.ajax({
			url : "/user/json/login",
			method : "POST",
			dataType : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({
				userId : id,
				password : pw
			}),
			success : function(JSONData, status){
				
				if(JSONData.userId != "none"){
					
					if( JSONData.password == $("#password").val() ){
						$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
					}else{
						$("#message").text("비밀번호를 다시 확인하세요").css("color", "red");
						$("#password").val("").focus();
					}
					
				}else{
					$("#userId").val("").focus();
					$("#password").val("");
					$("#message").text("아이디, 패스워드를 다시 확인하세요").css("color", "red");
				}
			}
		});
	}
	//버튼 클릭 시 fnclogin 발동
	$(function(){
		$("#userId").focus();

		$("#logInButton").on("click", function(){
			fncLogin();
		});

		$("a.btn.btn-primary.btn").on("click", function(){
			self.location="/user/addUser";
		});	
	});

	
	//아이디 / 비밀번호 찾기 화면 이동
	$( function() {	
		$("#findUser").on("click", function() {
			self.location = "/user/findUser.jsp"
		});
	});
	
	$( function() {	
		$("#findPassword").on("click", function() {
			self.location = "/user/findPassword.jsp"
		});
	});
	
	//sns 로그인 파트
	//카카오 로그인
	$(function(){
		Kakao.init('7368fcab4bac4f1c102ca1316601d03f');
		
		$("#kakao-login-btn").on("click", function(){
			//로그인 시도
			Kakao.Auth.login({
		        success: function(authObj) {
		       	alert(authObj);
		          //로그인 성공시에 api호출
		          Kakao.API.request({
		            url: '/v1/user/me',
		            success: function(res) {
		              res.id += "@kakao";
		              alert(res.id);
		              alert("넘어온 데이터 확인");
		              $.ajax({
		            	  url : "/user/json/checkDuplication/"+res.id,
		            	  headers : {
		  					"Accept" : "application/json",
		  					"Content-Type" : "application/json"
		  				  },
		  				  success : function(userIdChk){
		  					//DB에 아이디가 없으면 회원가입창으로
		  					  if(userIdChk==true){ 
		  						 alert("회원가입중입니다");
		  						  console.log("회원가입중입니다");
		  						  $.ajax({
		  							  url : "/user/json/addUser",
		  							  method : "POST",
		  							  headers : {
		  								"Accept" : "application/json",
		  								"Content-Type" : "application/json"
		  							  },
		  							  data : JSON.stringify({
  		  								userId : res.id,
		  								userName : res.properties.nickname,
  		  								password : "kakao123",
		  							  }),
		  							  success : function(JSONData){
		  								 alert("회원가입이 완료되었습니다");
		  								console.log("회원가입이 완료되었습니다.");
		  								 $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  							  }
		  						  })
		  					  }
		  					//DB에 아이디 있으면 로그인
		  					  if(userIdChk==false){ 
		  						 alert("로그인중입니다");
		  						  console.log("로그인중입니다");
		  						  $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  					  }
		  				  }
		              })
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
		})
	})
	
	
	//구글 로그인
	$(function(){
 		function googleLogin(googleUser) {
		    var profile = googleUser.getBasicProfile();
		    console.log(profile);
		}
		
		$(".g-signin2").on("click", function(){
		    gapi.client.load('plus', 'v1', function () {
		        gapi.client.plus.people.get({
		            'userId': 'me'
		        }).execute(function (res) {
		        	console.log(JSON.stringify(res));
		        	res.id += "@google";
			        
		            $.ajax({
		            	url : "/user/json/checkDuplication/"+res.id,
		            	headers : {
		  					"Accept" : "application/json",
		  					"Content-Type" : "application/json"
		  				},
		  				success : function(idChk){
		  					  if(idChk==true){ 
		  						  alert("회원가입중입니다");
		  						  console.log("회원가입중입니다");
		  						  $.ajax({
		  							  url : "/user/json/addUser",
		  							  method : "POST",
		  							  headers : {
		  								"Accept" : "application/json",
		  								"Content-Type" : "application/json"
		  							  },
		  							  data : JSON.stringify({
		  								userId : res.id,
		  								userName : res.displayName,
		  								password : "google123",
		  							  }),
		  							  success : function(JSONData){		  								
		  								 alert("회원가입이 완료되었습니다.");
		  								 $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  							  }
		  						  })
		  					  }
		  					  if(idChk==false){ 
		  						  console.log("로그인중입니다");
		  						  $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  					  }
		  				  }
		              })
		        	})
	        })
		})
		function onFailure(error) {
		    console("error : "+error);
		}		
		function signOut() {
		    var auth2 = gapi.auth2.getAuthInstance();
		    auth2.signOut().then(function () {
		    	self.location="/user/logout";
		    });
		}
	})

	/* $(function googleLogin() {
	    gapi.load('auth2', function(){
	    	// GoogleAuth 라이브러리에 대한 싱글 톤을 가져 와서 클라이언트를 설정합니다.
	      auth2 = gapi.auth2.init({
	        client_id: '318076473976-lvibspiedbi0fmj9iiugfiqpg9v16b47.apps.googleusercontent.com',
	        //클라이언트 ID
	        cookiepolicy: 'single_host_origin'
	        // Request scopes in addition to 'profile' and 'email'
			// scope: 'profile email',
			//fetch_basic_profile: 'false',

	    
	      });
	      attachSignin(document.getElementById("google"));
	    });
	  });
	  
	  
	  function attachSignin(element) {
		  
		    console.log(element.id);
		    auth2.attachClickHandler(element, {},
		       function(googleUser) {
		    		$.ajax(
		    			{
		    			url : "/user/json/addUser" ,
						method : "POST" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						data:JSON.stringify({
							userId :  googleUser.getBasicProfile().getId(),
							userName : googleUser.getBasicProfile().getName(),
							email : googleUser.getBasicProfile().getEmail()
						}),
						success : function (JSONData,status) {
							console.log("성공")
							if(JSONData.phone==null || JSONData.addr ==null){
								self.location = "/user/json/addUser?userId="+JSONData.userId
							}else{
								self.location="/user/snsLogin?userId="+JSONData.userId;
							}
						},fail: function (error) {
							alert(JSON.stringfy(error));
						}
		    		})
		        }, 
		        function(error) {
		          alert(JSON.stringify(error, undefined, 2));
		        });
		  } */
		  
		//네이버 로그인
			$(function(){
		   		var naverLogin = new naver.LoginWithNaverId({
					clientId: "HOBzhSrHnwuHLQpiDnzI",
					callbackUrl: "http://localhost:8080/user/naverCallback.jsp",
					isPopup: true,
					loginButton: {color: "green", type: 3, height: 45}
				});
		   		//설정정보를 초기화하고 연동 준비
				naverLogin.init();
			})
	
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp"> 
		<jsp:param name="uri" value="../"/>
	</jsp:include>
	<!-- <div class="navbar navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">너, 나들이 test page</a>
   		</div>
   	</div> -->
   	<!-- ToolBar End /////////////////////////////////////-->	
   	
   	<div class="container">
   		<div class="row">
   			<div class="col-md-6">
				<img src="/images/test/logo.jpg" class="img-rounded" width="100%" />
			</div>
			<div class="col-md-6">
				<br><br>
				<div class="jumbotron">
				
					
					<form class="form-horizontal">
						<div class="form-group">
							<label for="userId" class="col-sm-4 control-label">아 이 디</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="password" class="col-sm-4 control-label">비 밀 번 호</label>
							<div class="col-sm-6">
								<input type="password" class="form-control" name="password" id="password" placeholder="비밀번호" >
							</div>
						</div>
							

						<div id="message" align="center"></div><br>
					
					<div class="form-group">
					    <div class="col-sm-offset-2 col-sm-8 text-center">
					      <button type="button" id="logInButton" class="btn btn-primary"  >로 &nbsp;그 &nbsp;인</button>
					      <a class="btn btn-primary btn" href="#" id="addUser" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a><br/>
					      <button type="button" id="findUser" class="btn btn-default"  >아이디 찾기</button>
					      <button type="button" id="findPassword" class="btn btn-default"  >비밀번호 찾기</button>
					    </div>
					  </div>
					</form>
												
												
					<!-- 카카오 로그인 HTML -->
					<div id="kakaoLogin" align="center">
						<a id="kakao-login-btn" href="#">
							<img src="/images/user/kakao_login_btn_small.png" /> 	
						</a>
						<a href="http://developers.kakao.com/logout"></a>
					</div>
												
					<!-- 구글 로그인 HTML -->
					 <div id="googleLogin" align="center">													
						<div class="g-signin2" data-onsuccess="googleLogin" data-theme="dark"></div>
					</div>
					<!-- <img  id="google" src="/images/user/google_login.png" />
			      	<a id="google" class="g-signin2" data-onsuccess="googleLogin"></a> -->
												
					<!-- 네이버 로그인 HTML --> 
  					 <div id="naverIdLogin" align="center">
						<a id="naver-login-btn" href="#" role="button"></a>
					</div> 

				</div>
			</div>
   		</div>
   	</div>

</body>
</html>