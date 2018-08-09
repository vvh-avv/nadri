<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<!-- <link href="../css/facebookLogin.css" rel="stylesheet"> -->
<script>
	$(document).ready(function(){
		$("#verifiedEmail").click(function(){
			var userEmail = {userEmail : $("#userEmail2").val()} ;
				if(check_email(userEmail.userEmail) == true ){
					$.ajax({
						type:"POST",
						url: "/user/json/emailCheck",
						async: false,
						data: userEmail,
    	        		success: function(data){
	            		checkEmail(userEmail.userEmail) ;
            		},
            		error:function(error){
                    	alert("이메일 인증이 실패했습니다");
            		}
				}) ;
			}
		}) ;
	}) ;

</script>

</head>
<body>
	<div class="form-group">
		  <label class="col-sm-3 control-label">이메일</label>
			  <div class="col-sm-3">
			  	<input type="text" class="form-control" placeholder="이메일" id="userEmail2" name="userEmail2">
			  </div>
			  
			  <div class="col-sm-3">
			  	<button name="verifiedEmail" id="verifiedEmail" type="button" class="btn btn-success">인증하기</button>
			  </div>
	  </div>
	
</body>
</html>