<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- 카카오 로그인 -->
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
    	 body >  div.container{ 
        	border: 3px solid #D6CDB7;
            margin-top: 170px;
        }
    </style>
    
    <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">

		//============= "로그인"  Event 연결 =============
		$( function() {
			
			$("#userId").focus();
			
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("button").on("click" , function() {
				var id=$("input:text").val();
				var pw=$("input:password").val();
				
				/* if(id == null || id.length <1) {
					alert('ID 를 입력하지 않으셨습니다.');
					$("#userId").focus();
					return;
				}
				
				if(pw == null || pw.length <1) {
					alert('패스워드를 입력하지 않으셨습니다.');
					$("#password").focus();
					return;
				} */
				
				$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
			});
		});	
		
		
		//============= 회원원가입화면이동 =============
		$( function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("#addUser").on("click" , function() {
				self.location = "/user/addUser"
			});
		});
		
		//============== 아이디 / 비밀번호 찾기 화면 이동 ===========
		$( function() {	
			$("#findUser").on("click", function() {
				self.location = "/user/findUser.jsp"
			});
		});
		
		//============= 카카오 로그인 =================
		$(function(){
			$("img[src='/images/kakao_login_btn_small.png']").on("mouseover" , function() {
				$(this).attr("src", "/images/kakao_login_btn_small_ov.png");
			});
			
			$("img[src='/images/kakao_login_btn_small.png']").on("mouseout" , function() {
				$(this).attr("src", "/images/kakao_login_btn_small.png");
			});
			
			$("img[src='/images/kakao_login_btn_small.png']").on("click" , function() {
				loginWithKakao();
			});
		});
		
		Kakao.init('1d3fddc61b788ab458254eb1f4ea00ae');
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
	    
	    //function checkUser(userId2, type, nickname){
	    function checkUser(res){
	    	var userId2 = "ka@"+res.id;
	    	var type = "ka";
	    	var nickname = res.properties.nickname;
			var email = res.kaccount_email;
	 
	    	$.ajax( 
					{
						url : "/user/json/checkUser/"+userId2+"/"+type ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							if(JSONData.userId != null){
								login(JSONData.userId, JSONData.password);
							}else{
								self.location = "/user/addUser2?userId2="+userId2+"&type="+type+"&userName="+nickname+"&email="+email;
							}
						}
				});
	    }
	    
	    function login(id, password){
			
			$.ajax( 
					{
						url : "/user/json/login/"+id+"/"+password ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							$(parent.document.location).attr("href","/index.jsp");
							window.close();
						}
				});
		}
	    
	    $(function(){
			$("img[src='http://static.nid.naver.com/oauth/small_g_in.PNG']").on("click" , function() {
				loginWithNaver();
			});
		});
		
		function loginWithNaver(){
			$.ajax( 
					{
						url : "/user/json/loginWithNaver" ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
						
							popWin = window.open(JSONData.apiURL, "popWin", "left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=no, scrolling=no, menubar=no, resizable=no");
						}
				});
		}
		
		window.name = "loginView";
		
	</script>		
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" > 
		<jsp:param name="uri" value="../"/>
	</jsp:include>
   	<!-- ToolBar End /////////////////////////////////////-->	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<!--  row Start /////////////////////////////////////-->
		<div class="row">
		
			<div class="col-md-6">
					<img src="/images/test/logo.jpg" class="img-rounded" width="100%" />
			</div>
	   	 	
	 	 	<div class="col-md-6">
	 	 	
		 	 	<br/><br/>
				
				<div class="jumbotron">	 	 	
		 	 		<h1 class="text-center">로 &nbsp;&nbsp;그 &nbsp;&nbsp;인</h1>

			        <form class="form-horizontal">
		  
					  <div class="form-group">
					    <label for="userId" class="col-sm-4 control-label">아 이 디</label>
					    <div class="col-sm-6">
					      <input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">패 스 워 드</label>
					    <div class="col-sm-6">
					      <input type="password" class="form-control" name="password" id="password" placeholder="패스워드" >
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
					      <button type="button" class="btn btn-primary"  >로 &nbsp;그 &nbsp;인</button>
					      <a class="btn btn-primary btn" href="#" id="addUser" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>
					      <button type="button" id="findUser" class="btn btn-default"  >아이디 / 비밀번호 찾기</button>
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4 col-sm-6 text-center">
							<img src="/images/kakao_login_btn_small.png" />
					  		<img src="http://static.nid.naver.com/oauth/small_g_in.PNG" width="80" height="30" border="0"/>
					    </div>
					  </div>
					  
			
					</form>
			   	 </div>
			
			</div>
			
  	 	</div>
  	 	<!--  row Start /////////////////////////////////////-->
  	 	
 	</div>
 	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>