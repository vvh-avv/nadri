/**
 *    Jquery 내에서 돌리기 위한 inquire 소스
 */


		
		var inquireType = $('.inquireCode option:selected').val();

		$('.inquireCode').on('change', function() {
			inquireType = this.value;
			if (inquireType == '0') {
				$('.reportUser').css('visibility', 'visible');
			} else {
				$('.reportUser').css('visibility', 'hidden');
			}
		})

		$(".btn-primary").on("click",function(e) {
			
			var inquireFile = $('.file').val();
			
			if(inquireFile==""){
				console.log("첨부파일없음");
				var formData = $("form");
				var requestMapping = 'addInquireNoFile';
			}else{
				console.log("첨부파일있음");
				$('form').attr('enctype','multipart/form-data');
				var requestMapping = 'addInquire';
				var form = $("form");
				// you can't pass Jquery form it has to be javascript form object
				var formData = new FormData(form[0]);
			}

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
					reportUser = "null";
				}
				
				var inquireCode = $('.inquireCode').val();
				
				var title = $('.inquireTitle').val();
				var title_enc = encodeURI(encodeURIComponent(title));
				
				var write = $('.inquireWrite').val();
				var write_enc = encodeURI(encodeURIComponent(write));
										
				$.ajax({
					type : "POST",
					url : "/restAdmin/"+requestMapping+"/"+reportUser+"/"+inquireCode+"/"+write_enc+"/"+title_enc+"/1",
					//dataType: 'json', //not sure but works for me without this
					data : formData,
					contentType: false,//this is requireded please see answers above
					processData : false, //this is requireded please see answers above
					//cache: false, //not sure but works for me without this
					success : function(data, status) {
						if (status == "success") {
							$('body').removeClass('waiting');
							$('form')[0].reset();
							$('#inquireModal').modal('hide');
							console.log(data);
						}
					}
				});
			}

		});


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
			$('.inquireCode').val('0').prop("selected", true);
			$('.inquireCode').attr('disabled', 'disabled');
			$('.reportUser').css('visibility', 'visible');
			$('.reportLink').css('visibility', 'hidden');
		})
		
		$('.inquireComment').on('click', function() {
			var counter = $(this).attr('name');
			$('.inquireLink').val(counter);
			$('.inquireLink').attr('disabled', 'disabled');
			$('.inquireCode').val('2').prop("selected", true);
			$('.inquireCode').attr('disabled', 'disabled');
			$('.reportUser').css('visibility', 'visible');
			$('.reportLink').css('visibility', 'hidden');
		})
		
		$('.inquireBoard').on('click', function() {
			var counter = $(this).attr('name');
			$('.inquireLink').val(counter);
			$('.inquireLink').attr('disabled', 'disabled');
			$('.inquireCode').val('1').prop("selected", true);
			$('.inquireCode').attr('disabled', 'disabled');
			$('.reportUser').css('visibility', 'hidden');
			$('.reportLink').css('visibility', 'visible');
		})
		
		$('.inquireUnblock').on('click', function() {
			var counter = $(this).attr('name');
			$('.inquireCode').val('4').prop("selected", true);
			$('.inquireCode').attr('disabled', 'disabled');
			$('.reportUser').css('visibility', 'hidden');
			$('.reportLink').css('visibility', 'hidden');
		})
		
		$('.inquireCorrect').on('click', function() {
			var counter = $(this).attr('name');
			$('.inquireLink').val(counter);
			$('.inquireLink').attr('disabled', 'disabled');
			$('.inquireCode').val('3').prop("selected", true);
			$('.inquireCode').attr('disabled', 'disabled');
			$('.reportUser').css('visibility', 'hidden');
			$('.reportLink').css('visibility', 'visible');
		})
