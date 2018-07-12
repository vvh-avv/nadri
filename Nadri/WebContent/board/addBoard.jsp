<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>게시물 등록</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="/images/common/favicon.ico">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Bootstrap CDN -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<!-- common.js / common.css CDN -->
<script src="/javascript/common.js"></script>
<link rel="stylesheet" href="/css/common.css">

<style>
	.well > div{
		cursor : pointer;
	}
	#imgUpload{
		 width : 35px;
		 height : 35px;
		 cursor : pointer;
	}
	#imgDelete{
		cursor : pointer;
	}
	.thumb-image{
		width : 180px;
		height : 180px;
		pointer-events: none; /*마우스효과 비활성화 설정, 이 설정을 안하면 본문에 drag를 할 수 있게 된다*/
	}
	.imgPreview{
		display:none;
		height:200px;
		white-space:nowrap; /*가로스크롤 사용 설정*/
		overflow-x:scroll; /*가로스크롤 활성화 설정*/
		/*overflow:auto; /*영역 초과시 스크롤 보이고, 초과안하면 스크롤 감추는 auto 설정 */
	}
</style>

<script>

//본문에 내용넣는 자바스크립트
function addContent(data){
	if(data==null){
		return;
	} else{
		$("#boardContent").val(data);
	}
}

$(function(){
	//*임시저장 버튼클릭
	$("button[name='tempSave']").on("click", function(){
		var tsData = $("#boardContent").val(); //임시저장 데이터
		
		//임시저장 횟수 제한(6개) //실제 뿌려질 수 있는 리스트가 몇개인지 체크
		var realDataCnt = 0;
		for(var i=localStorage.lsCount; i>=1; i--){
			if(localStorage.getItem(i)===null){
				continue;
			}else{
				realDataCnt ++;
			}
		}
		if(realDataCnt==6) {
			alert("임시저장을 더이상 할 수 없습니다.\n등록된 데이터를 삭제해주시길 바랍니다.");
			return;
		}
		
		//실제 임시저장하는 소스
		if (tsData.trim()=="") {
			localStorage.clear(); //테스트용 코드
			alert('임시저장할 내용이 없습니다.');
		}else{
			//1.key(현재시스템날짜)=value(본문내용) 형식으로 localStorage에 저장
			var now = formatDate(new Date);
			localStorage.setItem(now, tsData);
			
			//2.key(임시저장횟수)=value(현재시스템날짜) 형식으로 localStorage에 저장
			if (localStorage.lsCount) { //localStorage에 lsCount가 존재하면 +1
		   		localStorage.lsCount = Number(localStorage.lsCount) + 1;
			} else { //존재하지 않으면 1로 고정
		    	localStorage.lsCount = 1;
			}
			localStorage.setItem(localStorage.lsCount, now);
			
			//목록에 항목 바로 추가
			$("#tempMsg").remove();
			$(".well").prepend("<div id=temp"+localStorage.lsCount+">"+localStorage.getItem(localStorage.lsCount)+
									"<img src='/images/board/delete.png' id=imgDelete"+localStorage.lsCount+" width='20' height='20' align='right'></div>");

			alert("임시저장되었습니다.");
		}
	})
	
	//*임시저장목록 버튼클릭
	$("button[name='tempList']").on("click", function(){
		if ( !localStorage.lsCount || localStorage.lsCount=='0' ) { //한번도 임시저장을 하지 않았다면
			$(".well").html("<div id=tempMsg style='cursor: default'>임시저장한 데이터가 없습니다.</div>");
		}else{ //임시저장을 한 적이 있다면
			var divTag='';
			for(var i=localStorage.lsCount; i>=1; i--){ //저장된 횟수만큼 임시저장목록에서 출력
				if(localStorage.getItem(i)===null){
					continue;
				}else{
					divTag += "<div id=temp"+[i]+">"+localStorage.getItem(i)+
									"<img src='/images/board/delete.png' id=imgDelete"+i+" width='20' height='20' align='right'></div>";
				}
			}
			$(".well").html(divTag);
		}
	})
	
	//*임시저장 개별삭제 버튼클릭
	$(document).on("click", ".well>div>img", function(){
		//-아래에서 removeItem 하면 작성하고있는 내용도 사라져서 객체화시켜둠
		var tsData = $("#boardContent").val();
		
		localStorage.removeItem( $(this).parent().text() );
		localStorage.removeItem( $(this).parent().attr("id").split("temp")[1] );
		//localStorage.lsCount = Number(localStorage.lsCount)-1;
		
		$(this).parent().remove();
		
		//임시저장한 데이터를 모두 삭제한 경우 데이터없다고 출력
		if( $(".well").children('div').length==0 ){
			localStorage.clear();
			$(".well").html("<div id=tempMsg style='cursor: default'>임시저장한 데이터가 없습니다.</div>");
		}

		//-객체화 시켰던 작성내용 다시 올리기! 야매!
		addContent(tsData);
	})
	
	//*임시저장목록의 항목 클릭시 localStorage에서 실제 임시저장된 데이터를 가져와서 본문에 씌우기
	$(document).on("click", ".well>div", function(){
		var tempData = localStorage.getItem($(this).text());
		addContent(tempData);
	})
	
	//*작성하기 버튼클릭
	$("button:contains('작성하기')").on("click", function(){
		if( $("#boardTitle").val()=="" ){ //제목이 비었을 경우 체크
			$(".form-group:first").removeClass().addClass("form-group has-error");
			$("#boardTitle").focus();
		}else if( $("#boardContent").val()=="" ){ //내용이 비었을 경우 체크
			$(".form-group:last").removeClass().addClass("form-group has-error");
			$("#boardContent").focus();
		}else if( $("#file")[0].files.length>6 ){ //첨부한 이미지가 6개가 넘었을 경우
			alert("이미지는 최대 5개까지 업로드가능합니다.");
		}else{
			$("form").attr("method","POST").attr("action", "/board/addBoard").submit();
		}
	})
	//*제목 입력안하고 전송하면 빨간테두리 생기는데, 그거 없애는 코드 
	$("#boardTitle").on("keyup", function(){
		if( $(this).parent().parent().parent().attr("class")=="form-group has-error" ){
			$(this).parent().parent().parent().removeClass().addClass("form-group");	
		}
	})
	//*내용 입력안하고 전송하면 빨간테두리 생기는데, 그거 없애는 코드 
	$("#boardContent").on("keyup", function(){
		if( $(this).parent().attr("class")=="form-group has-error" ){
			$(this).parent().removeClass().addClass("form-group");	
		}
	})
	
	//*다시작성 버튼클릭
	$("button:contains('다시작성')").on("click", function(){
		$("#boardTitle").val("");
		$("#boardContent").val("");
		$("#openRange").val("0");
		$("#file").attr("type","radio");
		$("#file").attr("type","file");
		$(".thumb-image").remove();
		$(".imgPreview").hide();
	})
	
	//*이미지업로드 버튼클릭
	$("#imgUpload").on("click", function(){
		$("#file").click();
	})
	
	//*이미지업로드시 미리보기
	$("#file").on('change', function(){
		imgPreview();
	})
	 
})

</script>
</head>

<body>
	<div class="container">
		<div class="col-md-2"> <!-- 내 일정 목록 -->
			<div id="cartList">
				1<br>2<br>3<br>  <!-- 일정바구니 불러올 예정 ,,,,, -->
			</div>
		</div>
		
		<form class="form-horizontal" enctype="multipart/form-data">
			<div class="col-md-8">
				<div class="form-group">
					<!-- 제목 + 파일업로드 -->
					<div class="row">
						<!-- 제목 -->
						<div class="col-xs-11 col-md-11">
							<input class="form-control" type="text" id="boardTitle" name="boardTitle" placeholder="제목을 입력해주세요..">
						</div>
						<!-- 파일업로드 -->
						<div class="col-xs-1 col-md-1" align="right">
							<img src="/images/board/imgUpload.png" id="imgUpload" alt="이미지 업로드하기">
							<input multiple="multiple" class="form-control" type="file" id="file" name="file" style="display:none" accept=".gif, .jpg, .png, .jpeg">
						</div>
					</div>
				</div>
				<br>
				
				<!-- 업로드 한 파일 미리보기 -->
				<div class="imgPreview"></div>
				
				<!-- 본문 -->
				<div class="form-group">
					<textarea class="form-control" rows="20" id="boardContent" name="boardContent" placeholder="내용을 입력해주세요.."></textarea>
				</div>
				<br>
			</div>
			
			<div class="col-md-2">
				<!-- 공개범위 -->
				<select class="form-control" id="openRange" name="openRange">
					<option value="0" selected="selected">모두공개</option>
					<option value="1">친구공개</option>
					<option value="2">비공개</option>
				</select>
				<br><br>
				<br><br>
			
				<!-- 임시저장 -->
				<button type="button" class="btn btn-success btn-md btn-block" name="tempSave">임시저장</button>
				<button type="button" class="btn btn-default btn-md btn-block" name="tempList" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">임시저장목록</button><br>
				<div class="collapse" id="collapseExample">
				  <div class="well">
				  	<!-- 임시저장데이터 들어갈 공간 -->
				  </div>
				</div>
				<br><br>
					
				<!-- 작성하기, 다시작성 버튼 -->
				<button type="button" class="btn btn-primary btn-md btn-block">작성하기</button>
				<button type="button" class="btn btn-default btn-md btn-block">다시작성</button>
			</div>
			
		</form>
	</div><!--e.o.container-->
	
</body>
</html>