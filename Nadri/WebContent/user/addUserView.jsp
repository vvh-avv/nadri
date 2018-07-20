<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
	<title>너, 나들이 test</title>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script src="/javascript/toolbar.js"></script>
	<link rel="stylesheet" href="/css/toolbar.css">

	<style>

	</style>
	
	<script type="text/javascript">		
		function fncAddUser() {
			// Form 유효성 검증
			var id=$('#userId').val();
			var pw=$('#password').val();
			var pw_confirm=$('#passwordChk').val();
			var name=$('#userName').val();
			
			if(id == null || id.length <1){
				alert("아이디는 반드시 입력해야 합니다.");
				return;
			}
			if(pw == null || pw.length <1){
				alert("패스워드는 반드시 입력해야 합니다.");
				return;
			}
			if(pw_confirm == null || pw_confirm.length <1){
				alert("패스워드 확인 입력창이 비어있습니다.");
				return;
			}
			if(name == null || name.length <1){
				alert("이름은 반드시 입력해야 합니다.");
				return;
			}
			
			if(pw != pw_confirm) {
				alert("비밀번호가 일치하지 않습니다.");
				$('#passwordChk').focus();
				return;
			}
				
			var value="";
			if( $('#inputPhone2').val() != "" && $('#inputPhone3').val() != "" ){
				var value = $('option:selected').val() + "-"
									+ $('#inputPhone2').val() + "-"
									+ $('#inputPhone3').val();
			}
			$('input:hidden[name="phone"]').val(value);
			
			//이메일 입력해야 가입 진행
			if( $("#userEmailResult").val() == "" && $("#userEmailResult").val() != "0") {
				alert("이메일 창을 확인해주세요") ;
				return ;		
			} 
			
			//회원가입 클릭시 진행
			$('form').attr('method', 'POST').attr('action', 'addUser').submit();
			}
		
		//회원가입 버튼 클릭시 행위 발생
		$(function(){
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			$('.col-sm-9 button:contains("회원가입")').on('click', function(){
				/* console.log('??'); */
				fncAddUser();
			});
		});
		
		//이메일 형식 확인
		 /* $(function(){
			$('#email').on('change', function(){
				var email=$('input[name="email"]').val();
				if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)){
					alert("이메일 형식이 올바르지 않습니다.");
					returm false;
				}
				$("#email").val(email) ;
			    return true;
			});
		});  */
		
		//이메일 창에 쓰여진 메일 형식 확인
		function check_email(email) {
			var email= email ; 
			alert(email);
		    if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1)){
		    	alert("이메일 형식이 아닙니다.");
				return false;
		    }
			$("#email").val(email) ;
		    return true;
		} 
		
		//이메일 팝업창
		function checkEmail() {
			window.open("/user/emailCheck2.jsp","popWin", 
			"left=500,top=500,width=500,height=500, marginwidth=0,marginheight=0,scrollbars=no, scrolling=no,menubar=no,resizable=no");
		}
	
		
		<%-- 아이디 중복 확인: ajax 이용 --%>
		$(function(){
			$('#userId').on('keyup', function(){
				var userId = $(this).val().trim();
				
				$.ajax({
					url : 'json/checkDuplication/'+userId,
					method : 'get',
					dataType : 'json',
					headers : {
						'Accept' : 'application/json',
						'Content-Type' : 'application/json'
					},
					success : function(JSONData , status){
						if(JSONData){
							$('span.help-block').html('사용할 수 있는 아이디입니다.').css('color','green');
							check = true;
						}else{
							$('span.help-block').html('이미 존재하는 아이디입니다.').css('color','red');
							check = false;
						}
					}
				});
				if(userId == ''){
					$('span.help-block').html('');
				}
			});
		}); 
		
		<%-- 비밀번호 중복 확인: ajax 이용 --%>
		$(function(){
			$('#passwordChk').on('keyup',function(){
				if( $('#password').val() != $(this).val()){
					$('#helpBlock2').text("비밀번호 불일치").css('color','red');
				}else{
					$('#helpBlock2').text("비밀번호 일치").css('color','green');
				}
			});
		});
		
	</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<%-- <jsp:include page="/layout/toolbar.jsp"> 
		<jsp:param name="uri" value="../"/>
	</jsp:include> --%>
	<%@ include file="/layout/toolbar.jsp"%>

<div class="container">

	<div class="page-header col-sm-offset-2 col-sm-10">
		<h1>회원 가입</h1>
	</div>
	
	<form class="form-horizontal" enctype="multipart/form-data">
		<div class="form-group" >
			<div class="row">
				<label for="userName" class="col-sm-3 control-label">이름</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="userName" name="userName" placeholder="이름">
				</div>
				<span class="col-sm-6"></span>
			</div>
			<br/>

			<div class="row">
				<label for="userId" class="col-sm-3 control-label">아이디</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="userId" name="userId" placeholder="ID" aria-describedby="helpBlock">
				</div>
				<span id="helpBlock" class="help-block col-sm-6"></span>
			</div>

			<br/>
			
			<!-- <div class="row">
				<label for="email" class="col-sm-3 control-label">이메일</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" id="email" name="email" placeholder="example@example.com">
				</div>
				<div class="col-sm-3">
					<button type="button" id="verifiedEmail" name="verifiedEmail" class="btn btn-success">인증하기</button>
				</div>
			</div> -->
			<jsp:include page="emailCheck.jsp"/>
			<br/>
			
			<div class="row">
				<label for="password" class="col-sm-3 control-label">비밀번호</label>
				<div class="col-sm-3">
					<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요">
				</div>
				<span class="col-sm-6"></span>
			</div>
			<br/>

			<div class="row">
				<label for="passwordChk" class="col-sm-3 control-label">비밀번호확인</label>
				<div class="col-sm-3">
					<input type="password" class="form-control" id="passwordChk" name="passwordChk" placeholder="비밀번호를 다시 한 번 입력하세요" aria-describedby="helpBlock2">
				</div>
				<span id="helpBlock2" class="help-block2 col-sm-6"></span>
			</div>
			<br/>
			
			<div class="row">
				<label for="profileImg" class="col-sm-3 control-label">프로필 사진</label>
				<div class="col-sm-3">
					<!-- <input type="file" class="form-control" id="profileImg" name="file" > -->
					<input multiple="multiple" type="file" class="form-control" id="profileImg" name="file">
				</div>
				<span class="col-sm-3"></span>
			</div>
			<br/>
			
			<div class="form-group">
		     <label for="sex" class="col-sm-3 control-label">성별</label>
			   <span class="col-sm-2">
		         <label><input type="radio" id="sex" name="sex" value="0">남자</label>
		       </span>
		      <span class="col-sm-2">
		         <label><input type="radio" id="sex" name="sex" value="1">여자</label>
		        </span>
			</div>
			<br/>
			
			<div class="form-group">
		    <label for="age" class="col-sm-3 control-label">나이</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="age" name="age" placeholder="나이">
		    </div>
		    <div class="col-sm-4">
		    	<strong>세</strong> 
		    </div>
		  </div>
		  <br/>
			
			<div class="row">
				<label for="inputPhone1" class="col-sm-3 control-label">전화번호</label>
				<input type="hidden" name="phone">
				<div class="col-sm-2">
					<select class="form-control" id="inputPhone1" name="phone1">
						<option>010</option>
						<option>011</option>
						<option>016</option>
						<option>018</option>
						<option>019</option>
					</select>
				</div>
				<label for="inputPhone2" class="col-sm-1 control-label">-</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="inputPhone2" name="phone2">
				</div>
				<label for="inputPhone3" class="col-sm-1 control-label">-</label>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="inputPhone3" name="phone3">
				</div>
				<span class="col-sm-1"></span>
			</div>
			<br/>
			
			<div class="row">
				<label for="introduce" class="col-sm-3 control-label">자기소개</label>
				<textarea class="col-sm-9" name="introduce" rows="10"></textarea>
			</div>
			<br/>
			
			<div class="row">
				<div class="col-sm-offset-3 col-sm-9">
					<button type="button" class="btn btn-success">회원가입</button>
				</div>
			</div>
			
			<div class="row">
				<!-- <img src="/images/ct_btnbg03.gif" width="14" height="23"/> -->
			 <!-- 	<input type="hidden" id="userId" name="userId" value="">-->
			 	<input type="hidden" id="email" name="email" value="">
			 	<input type="hidden" id="userEmailResult" name="userEmailResult" value="">
			</div>
			
		</div>
	</form>
</div>

</body>
</html>
