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
	
	<!-- layout css -->
	<link rel="stylesheet" type="text/css" href="/css/indexReal.css" />
	<link rel="stylesheet" type="text/css" media="(max-width: 600px)" href="/css/indexRealSmall.css" />
	<script src="/javascript/indexReal_nonIndex.js"></script>
	
	<!-- sweet alert CDN -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style type="text/css"></style>
    
<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

var createA = document.createElement('a');
createA.setAttribute('href', "/user/findPassword");
createA.innerHTML="<span style='color:#516ed6'>비밀번호 찾기로 이동</span>"

//아이디 찾기 유효성 검사
function fncFindUserId(){
	var name = $('#name').val();
	var mail = $('#mail').val();
	
	//alert("name:: "+name);
	//alert("mail:: "+mail);
	
	if(name == ""){
		//alert("이름을 입력해야 아이디를 찾을 수 있습니다");
		swal({
			   title: "확인하세요!",
			   text: "이름을 입력해야 아이디를 찾을 수 있습니다!",
			   icon: "error",
			   buttons: false,
			 });
		return;
	}
	
	if(mail == ""){
		//alert("이메일을 입력해야 아이디를 찾을 수 있습니다");
		swal({
			   title: "확인하세요!",
			   text: "이메일을 입력해야 아이디를 찾을 수 있습니다!",
			   icon: "error",
			   buttons: false,
			 });
		return;
	}
	
}

//아이디 찾기 버튼 클릭 시 행위 발생
$(function(){
	$('#findUserIdChk').on('click', function(){
		fncFindUserId();
	});
});


	
//ajax이용해서 아이디 알려주기
$(function(){
	
	$(".btn:contains('아이디 찾기')").on("click",function(){
		
		var userName=$("input[id='name']").val();
		var email=$("input[id='mail']").val();
		
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
		    		//$("span.col-id-check").html("해당하는 아이디가 존재하지 않습니다").css("color","red");
		    		swal({
		    			title: "실패!",
		    			   text: "해당하는 아이디가 존재하지 않습니다!",
		    			   icon: "error",
		    			   buttons: false,
		    		});
		    	} else {
		    		//$("span.col-id-check").html("회원님의 아이디는"+JSONData.userId+"입니다").css("color","blue");
		    		swal({
		    			title: "성공!",
		    			   text: "회원님의 아이디는 \""+JSONData.userId+"\"입니다!",
		    			   icon: "success",
		    			   buttons: false,
		    			   content: createA,
		    		});
		    	}  	
		   	 }		
		});							
	});			
});	



</script>		
</head>

<body>

   <!-- ToolBar Start /////////////////////////////////////-->
	 <%@include file="/layout/new_toolbar.jsp"%>
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		<div class="row">
			<div class="col-xs-offset-4 col-xs-4 col-md-offset-4 col-md-4">
				<div class="page-header text-center">
					<h3 class="text-info">아이디 찾기</h3>
					<h5><b>이름</b>과 <b>이메일</b>을 입력하세요</h5>
				</div>
			</div>
		</div>

		<form class="form-horizontal">
			<div class="form-group">
				<label for="userName" class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">이름</label>
					<div class="col-xs-4 col-md-4">
						<input type="text" class="form-control" id="name"  placeholder="이름을 입력해주세요">
					</div>
			</div>
		  
		  <div class="form-group">
		    <label for="email" class="col-xs-offset-1 col-xs-3 control-label col-md-offset-1 col-md-3 control-label">이메일</label>
			    <div class="col-xs-4 col-md-4">
			      <input type="text" class="form-control" id="mail"  placeholder="가입시 입력한 이메일을 입력해주세요">
			    </div>
		  </div>
		 	<br/>
		  
		<div class="form-group">
			<div class="col-xs-offset-4  col-xs-4 text-center col-md-offset-4  col-md-4 text-center">
			    <button type="button" id="findUserIdChk" class="btn btn-primary">아이디 찾기</button>
			</div>
		</div>
		  
		 	<span class="col-id-check"></span>
		</form>
	  	<br/><br/><br/>
		
		<!-- form End /////////////////////////////////////-->
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>
</html>