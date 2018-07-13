<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>문의 및 신고 목록</title>
<!-- css cdn -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<!-- js cdn -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript">
	$(function() {
		
		var inquireType = $('.inquireCode option:selected').val();

		$('.inquireCode').on('change', function() {
			inquireType = this.value;
			if (inquireType == '0') {
				$('.reportUser').css('visibility', 'visible');
			} else {
				$('.reportUser').css('visibility', 'hidden');
			}
		})

		$(".btn-primary").on(
				"click",
				function(e) {

					var form = $("form");

					// you can't pass Jquery form it has to be javascript form object
					var formData = new FormData(form[0]);

					//if you only need to upload files then 
					//Grab the File upload control and append each file manually to FormData
					//var files = form.find("#fileupload")[0].files;

					//$.each(files, function() {
					//  var file = $(this);
					//  formData.append(file[0].name, file[0]);
					//});

					if ($('.inquireTitle').val() == '') {
						alert("제목을 입력해주세요!");
						$('.inquireTitle').focusin();
						return;
					} else if ($('.inquireWrite').val() == '') {
						alert("내용을 입력해주세요!");
						$('.inquireTitle').focusin();
					} else {

						$('body').addClass('waiting');
						
						var reportUser = $('.reportedUserId').val();
						
						if(reportUser==''){
							console.log("유저신고가 아닙니다~");
							reportUser = "null";
						}
						
						var inquireCode = $('.inquireCode').val();
						
						var title = $('.inquireTitle').val();
						var title_enc = encodeURI(encodeURIComponent(title));
						
						var write = $('.inquireWrite').val();
						var write_enc = encodeURI(encodeURIComponent(write));
												
						$.ajax({
							type : "POST",
							url : "/restAdmin/addInquire/"+reportUser+"/"+inquireCode+"/"+write_enc+"/"+title_enc+"/1",
							//dataType: 'json', //not sure but works for me without this
							data : formData,
							contentType: false,//this is requireded please see answers above
							processData : false, //this is requireded please see answers above
							//cache: false, //not sure but works for me without this
							success : function(data, status) {
								if (status == "success") {
									$('body').removeClass('waiting');
									$('form')[0].reset();
									$('#myModal').modal('hide');
									console.log(data);
								}
							}
						});
					}

				});

		$('img').on('mouseover', function() {
			$(this).css('cursor', 'pointer');
		})

		$('img').on('click', function() {
			var counter = $(this).attr('name');
			$('.reportedUserId').val(counter);
			$('.reportedUserId').attr('disabled', 'disabled');
			$('.inquireCode').val('0').prop("selected", true);
			$('.inquireCode').attr('disabled', 'disabled');
			$('.reportLink').css('visibility', 'hidden');
			$('.reportUser').css('visibility', 'visible');
		})

		$('.inquireTitle').on('click', function() {
			$('.count1 div').css('display', 'inline-block');
		})

		$('.inquireTitle').on('focusout', function() {
			$('.count1 div').css('display', 'none');
		})

		$('.inquireWrite').on('click', function() {
			$('.count2 div').css('display', 'inline-block');
		})

		$('.inquireWrite').on('focusout', function() {
			$('.count2 div').css('display', 'none');
		})

		$('textarea').on("input", function() {
			var maxlength = $(this).attr("maxlength");
			var currentLength = $(this).val().length;
			$('.textCounter2').text(currentLength - 1);
		});

		$('.inquireTitle').on("input", function() {
			var maxlength = $(this).attr("maxlength");
			var currentLength = $(this).val().length;
			$('.textCounter1').text(currentLength - 1);
		});
		
		$('.boardReport').on('mouseover', function() {
			$(this).css('cursor', 'pointer');
		})
		
		$('.inquireUser').on('click', function() {
			var counter = $(this).attr('name');
			$('.inquireLink').val(counter);
			$('.inquireLink').attr('disabled', 'disabled');
			$('.inquireCode').val('1').prop("selected", true);
			$('.inquireCode').attr('disabled', 'disabled');
			$('.reportUser').css('visibility', 'hidden');
			$('.reportLink').css('visibility', 'visible');
		})

	})
</script>
<style type="text/css">
html, body {
	width: 100%;
	height: 100%;
}

body.waiting * {
	cursor: progress;
}

.postbox {
	align-self: center;
	width: 80%;
	height: 50%;
	margin-left: 10%;
	margin-top: 5%;
	margin-bottom: 10%;
	border: 1px solid #ccc;
}

button {
	margin: 20px;
}

.inquireWrite {
	width: 100%;
}

p {
	float: left;
	margin-bottom: 10px;
}

.inquireTitle {
	margin-bottom: 10px;
	width: 100%;
}

.reportUser {
	display: inline;
	float: right;
	visibility: hidden;
	position : absolute;
	right:1vw;
}

.reportLink{
	display: inline;
	float: right;
	visibility: hidden;
	position : absolute;
	right:1vw;	
}

.profile {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	margin: 1%;
	padding: 3px;
	border: 3px solid #d4a4b6;
}

.topbox {
	display: flex;
	align-items: center;
}

.topbox h6 {
	margin-left: 15px;
}

.glyphicon-option-horizontal {
	margin-left: 65%;
	width: 20px;
	height: auto;
}

select {
	background: #ccc;
}

.count1 div {
	display: none;
	float: right;
}

.count2 div {
	display: none;
	float: right;
}
</style>
</head>
<body>
	<div class="postbox">
		<div class="topbox">
			<img
				src="../images/test/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg"
				alt="x" class="profile" data-toggle="modal" data-target="#myModal"
				name="user01">
			<h6>user01 (김고양이)</h6>
			<span name="user02" class="glyphicon glyphicon-option-horizontal boardReport" data-toggle="modal" data-target="#myModal"></span>
		</div>
	</div>
	<br />
	<br />
	<div class="postbox">
		<div class="topbox" id="12345">
			<img
				src="../images/test/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg"
				alt="x" class="profile" data-toggle="modal" data-target="#myModal">
			<h6>user02 (김야옹이)</h6>
			<span class="glyphicon glyphicon-option-horizontal boardReport" data-toggle="modal" data-target="#myModal"></span>
		</div>
	</div>
<!-- 신고 Modal content -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						신고하기<br>
						<h6 style="color: lightgrey;">신고내용은 창을 닫아도 유지됩니다</h6>
					</h4>
				</div>
				<div class="modal-body">
					<form enctype="multipart/form-data">
						신 고 종 류 <select class="inquireCode" name="inquireCode"
							style="height: 30px;">
							<option value="9">선택하세요</option>
							<option value="0">유저신고</option>
							<option value="1">게시글신고</option>
							<option value="2">댓글신고</option>
							<option value="3">정정신청</option>
							<option value="4">기타문의</option>
						</select>
						<span class="reportUser">
							신고유저아이디 <input type="text" name="reportUserId"
								class="reportedUserId" value="">
						</span>
						<span class="reportLink">
							신 고 링 크 <input type="text" name="inquireLink"
								class="inquireLink" value="">
						</span>
						<hr />
						<div class="count1">
							<p>제목</p>
							<div>/30</div>
							<div class="textCounter1">0</div>
						</div>
						<input type="text" class="inquireTitle" name="inquireTitle"
							value="" placeholder="제목을 입력해주세요." maxlength="30"></br>
						<div class="count2">
							<p>신 고 내 용</p>
							<div>/100</div>
							<div class="textCounter2">0</div>
						</div>
						<textarea class="inquireWrite" name="inquireWrite" value=""
							placeholder="내용을 입력해 주세요." maxlength="100"></textarea>
						</br/>
						<p>
							<input type="file" name="file" multiple="multiple">
						</p>
						</br/>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">보내기</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫
						기</button>
				</div>
			</div>

		</div>
	</div>
</body>
</html>