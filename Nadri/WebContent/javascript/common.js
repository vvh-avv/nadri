///////////////////// 해당 파일은 일단 수정불가!
///////////////////// 수정이 필요하면 스크립트 만든 사람에게 꼭 먼저 물어보기 !!


//HJS
//현재 시스템 날짜+시간 가져오고 포맷을 바꾼 자바스크립트
function formatDate(today) {
	var month = (today.getMonth() + 1);
	var day = today.getDate();
	var hours = today.getHours()+''; //''을 안넣으면 문자취급이 안되어 아래 조건문 성립불가
	var min = today.getMinutes()+'';
	var sec = today.getSeconds()+'';

	if (month.length < 2) month = '0' + month;
	if (day.length < 2) day = '0' + day;
	if (hours.length < 2) hours = '0' + hours;
	if (min.length < 2) min = '0' + min;
	if (sec.length < 2) sec = '0' + sec;
	
   	var now = today.getFullYear() + '년' + month + '월' + day + '일  ' +
   					hours + ':' + min+ ':' + sec;
	
	return now;
}

//HJS
//이미지 미리보기 뷰
//준비사항1 : <input multiple="multiple" class="form-control" type="file" id="file" name="file"...>		//파일업로드 할 input file태그
//준비사항2 : <div class="imgPreview"></div> 																		//이미지 미리보기 div태그
function imgPreview(){
	var countFiles = $("#file")[0].files.length;

	//업로드 할 이미지 개수가 6개 초과시 알럿창띄우고 5개만 보여주기
	if(countFiles>6){
		alert("이미지는 최대 5개까지 업로드가능합니다.");
		//IE9 이상 사용하기 위해 type을 다른걸로 잠깐 바꾸기 //참고:http://jindo.dev.naver.com/blog/2014/01/136
		$("#file").attr("type","radio");
		$("#file").attr("type","file");
		return;
	}

	var imgPath = $("#file")[0].value; //이미지경로(fakePath)를 포함한 이미지명
	var extn = imgPath.substring(imgPath.lastIndexOf('.')+1).toLowerCase(); //확장자명
	var imgPreview = $(".imgPreview"); //이미지 보여줄 div 태그
	imgPreview.empty(); //이미지 보여줄 div 태그 안에 내용물 비워두기

	if (extn=="gif" || extn=="png" || extn=="jpg" || extn=="jpeg") {
	    if (typeof (FileReader) != "undefined") { //해당 브라우저가 FileReader를 사용할 수 있는지 체크 
	   	 //첨부한 이미지 개수만큼 반복
	        for (var i = 0; i < countFiles; i++) {
	            var reader = new FileReader();
	            reader.onload = function (e) {
	           	//imgPreview영역에 img태그 append
	               $("<img class=thumb-image src="+e.target.result+">").appendTo(imgPreview); 
	            }

	            imgPreview.show(); //바로 보여주기
	            reader.readAsDataURL($("#file")[0].files[i]); //데이터를 URI로 표현하는 방식
	        }
	    } else { alert("해당 브라우저는 첨부한 파일을 미리볼 수 없습니다."); }
	}else { alert("사진만 선택이 가능합니다."); imgPreview.hide(); return;}

	imgPreview.show();
}
