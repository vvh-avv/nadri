<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="UTF-8">

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<style type="text/css">

</style>
    
<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
	
	

	
	
//ajax이용해서 아이디 알려주기
$(function(){
	
	$(".btn:contains('아이디 찾기')").on("click",function(){
		
		var userName=$("input[name='userName']").val();
		var email=$("input[name='email']").val();
		
		$.ajax({		
			type:"POST",
			url:"json/findUserId",
			headers : {
				"Accept" : "application/json;charset=EUC-KR",
				"Content-Type" : "application/json"
			}, 
			data : JSON.stringify({										//보낼 정보
				userName : userName, 
				email: email
			}),																								
			dataType:"json",												//서버에서 받는 데이터형식은 제이슨
		    success: function(JSONData, status){
		    	console.log(JSON.stringify(JSONData)); 	//json string 형식으로 변환

		    	//JSONData에서 유저 아이디 추출 
		    	if(JSONData.userId == null) {
		    		$("span.col-id-check").html("해당하는 아이디가 존재하지 않습니다").css("color","red");
		    	} else {
		    		$("span.col-id-check").html("회원님의 아이디는"+JSONData.userId+"입니다").css("color","blue");
		    	}  	
		   	 }		
		});							
	});			
});	

</script>		
</head>

<body>

   <!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" /> 
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<div class="row">
			<div class="col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info">비밀번호 찾기</h3>
				</div>
			</div>
		</div>
		  
		  	
	  	<form class="form-horizontal" id="findPassword" name="findPassword" >
		   <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="userName" name="userName" placeholder="이름을 입력해주세요">
			    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아이디</label>
			    <div class="col-sm-4">
			    	<input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 입력해주세요"> 
				</div>
		  </div>
		  		  	  	   
		  <div class="form-group">
		    <label for="email" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="email" name="email" placeholder="가입시 입력한 이메일을 입력해주세요	">
			    </div>
		  </div>	  
		  <br/>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  id=findPassword>비밀번호 찾기</button>
		  	</div>
		  </div>
		  
		  <span class="col-password-check"></span>
		</form>
		<!-- form End /////////////////////////////////////-->
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>
</html>