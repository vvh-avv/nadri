var iconBase = '/images/spot/icon/';
var icons = {
	baby : {
		icon : iconBase + 'baby.png'
	},
	bike : {
		icon : iconBase + 'bike.png'
	},
	delivery : {
		icon : iconBase + 'delivery.png'
	},
	festival : {
		icon : iconBase + 'festival.png'
	},
	food : {
		icon : iconBase + 'food.png'
	},
	info : {
		icon : iconBase + 'info.png'
	},
	myplace : {
		icon : iconBase + 'myplace.png'
	},
	park : {
		icon : iconBase + 'park.png'
	},
	parking : {
		icon : iconBase + 'parking.png'
	},
	river : {
		icon : iconBase + 'river.png'
	},
	samdae : {
		icon : iconBase + 'samdae.png'
	},
	search : {
		icon : iconBase + 'search.png'
	},
	car : {
		icon : iconBase + 'car.png'
	},
	store : {
		icon : iconBase + 'store.png'
	},
	suyo : {
		icon : iconBase + 'suyo.png'
	},
	picnic : {
		icon : iconBase + 'picnic.png'
	}
};

$(function(){
	$("#park").on("click", function(){
		location.href = "/spot/getSpotList?spotCode=0";
	})

	$("#festival").on("click", function(){
		location.href = "/spot/getFestivalList";
	})

	$("#restaurant").on("click", function(){
		location.href = "/spot/getSpotList?spotCode=1";
	})

	$("#river").on("click", function(){
		location.href = "/spot/getSpotList?spotCode=4";
	})

	$("#search").on("click", function(){
		location.href = "/spot/getSearchSpot";
	})
	
	$("#cartNavi").on("click", function(){
		location.href = "/cart/getMyCartList";
	})
	
	$("#spot").on("click", function(){
		location.href = "/spot/getSearchSpot";
	})
		
 $("#addSchedule").on("click", function() {
	 
		var scheduleTitle =$("#scheduleTitle").val();
		var scheduleDate=$("#scheduleDate").val();
		var scheduleDetail=$("#scheduleDetail").val();
		
		if(scheduleTitle == null || scheduleTitle.length <1){
			swal("나들이 제목을 붙여주세요.");
			return;
		}
		if(scheduleDate == null || scheduleDate.length <1){
			swal("나들이 가시는 날짜를 정해주세요");
			return;
		}
		if(scheduleDetail == null || scheduleDetail.length <1){
			swal("나들이의 간단한 설명을 분여주세요!");
			return;
		}
	 
		$("form").attr("method", "POST").attr("action","/schedule/addSchedule").submit();
		swal("등록에 성공했습니다!", "마이페이지에서 확인해주세요", "success");
	});

 $("#updateSchedule").on("click", function() {
	 
		var scheduleTitle =$("#scheduleTitle").val();
		var scheduleDate=$("#scheduleDate").val();
		var scheduleDetail=$("#scheduleDetail").val();
		
		if(scheduleTitle == null || scheduleTitle.length <1){
			swal("나들이 제목을 붙여주세요.");
			return;
		}
		if(scheduleDate == null || scheduleDate.length <1){
			swal("나들이 가시는 날짜를 정해주세요");
			return;
		}
		if(scheduleDetail == null || scheduleDetail.length <1){
			swal("나들이의 간단한 설명을 분여주세요!");
			return;
		}
	 
		$("form").attr("method", "POST").attr("action","/schedule/updateSchedule").submit();
		swal("수정에 성공했습니다!", "마이페이지에서 확인해주세요", "success");
	});
 
});

// Sets the map on all markers in the array.
function setMapOnAll(map) {
 for (var i = 0; i < markers.length; i++) {
   markers[i].setMap(map);
 }
}

// Removes the markers from the map, but keeps them in the array.
function clearMarkers() {
 setMapOnAll(null);
}

// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
 clearMarkers();
 markers = [];
 locations =[];
}

// 일정생성에서 쓸 메서드!
//일정계획으로 옮겨주는 메서드입니다.
function addToSchedule(i, j){
	var lasttd = $("#wayPoint > tr").length-1;
	if( j <= lasttd ) {
		// 주소값
		wayPointAddress = $("#cartAddress"+i+"").text();
		$("#wayPointAddress"+j+"").val(wayPointAddress);
		
    // 이미지값
    console.log( $("#cartImg"+i+"").attr("class")+"번 카트 이미지 가져오는 중..." );
    $.ajax({
       url : "/restcart/getCart/"+$("#cartImg"+i+"").attr("class"),
       method : "POST",
       success : function(data){
          $("#cartImg"+i+"").attr('src',data.cartImg);
          
          wayPointImg=$("#cartImg"+i+"").attr('src');
          console.log("**"+wayPointImg);
          $("#wayPointImg"+j+"").val(wayPointImg);
       }
    })
    
		//제목값
		wayPointTitle = $("#cartTitle"+i+"").text();
		$("#wayPointTitle"+j+"").val(wayPointTitle);

		// 상세내용값
		wayPointDetail=$("#cartDetail"+i+"").text();
		$("#wayPointDetail"+j+"").val(wayPointDetail);
		
		// X값
		wayPointDetail=$("#cartX"+i+"").val();
		$("#wayPointX"+j+"").val(wayPointDetail);
		
		// Y값
		wayPointDetail=$("#cartY"+i+"").val();
		$("#wayPointY"+j+"").val(wayPointDetail);
	} else {
		swal("경유지를 먼저 추가해주세요!");
	}
		
}

//일정계획으로 옮겨주는 메서드입니다.
function addToSchedule2(i, j){
	var lasttd = $("#wayPoint > tr").length-1;
	if( j <= lasttd ) {
		// 주소값
		wayPointAddress = $("#recommandAddress"+i+"").text();
		
		if( wayPointAddress.indexOf("대한민국") != -1) {
			wayPointAddress  = wayPointAddress.replace("대한민국","");
		}
		
		$("#wayPointAddress"+j+"").val(wayPointAddress);
		
		// 이미지값
		wayPointImg=$("#recommandImg"+i+"").attr('src');
		$("#wayPointImg"+j+"").val(wayPointImg);
    
		//제목값
		wayPointTitle = $("#recommandTitle"+i+"").text();
		$("#wayPointTitle"+j+"").val(wayPointTitle);

		// 상세내용값
		wayPointDetail=$("#recommandDetail"+i+"").text();
		$("#wayPointDetail"+j+"").val(wayPointDetail);
		
		// X값
		wayPointDetail=$("#recommandX"+i+"").val();
		$("#wayPointX"+j+"").val(wayPointDetail);
		
		// Y값
		wayPointDetail=$("#recommandY"+i+"").val();
		$("#wayPointY"+j+"").val(wayPointDetail);
	} else {
		swal("경유지를 먼저 추가해주세요!");
	}
		
}

function addWayPoint(){
	var lasttd = $("#wayPoint > tr").length-1;
	if(lasttd < 6 ){
		swal("경유지가 추가되었어요");
		var waypoint = '';
		waypoint += '<tr>';
		waypoint += '	<td align="center"><input class="form-control" type="text" name="wayPoints['+w+'].wayPointTitle" id="wayPointTitle'+w+'"/></td>' ;
		waypoint += '	<td align="center"><input class="form-control" type="text" name="wayPoints['+w+'].wayPointAddress" id="wayPointAddress'+w+'"></td>' ;
		waypoint += '	<td align="center"><input class="form-control" type="text" name="wayPoints['+w+'].wayPointDetail"   id="wayPointDetail'+w+'" /></td>' ;
		waypoint += '	<td align="center"><input class="form-control" type="text" name="wayPoints['+w+'].moveTime" id="wayPointMoveTime'+w+'" readonly/></td>' ;
		waypoint += "	<td align='center'><input class='waves-effect waves-light btn col s5' type='button' style='background-color: rgba(250, 170, 50, 0.5);'  id='navigation' value='길찾기' onclick=search('#wayPointAddress"+w+"')></td> " ; 
		waypoint += '	<input type="hidden" name="wayPoints['+w+'].wayPointImg" id="wayPointImg'+w+'"/>' ;
		waypoint += '	<input type="hidden" name="wayPoints['+w+'].wayPointNav" id="wayPointNav'+w+'" />' ;
		waypoint += '	<input type="hidden" name="wayPoints['+w+'].wayPointX"  id="wayPointX'+w+'" >' ;
		waypoint += '	<input type="hidden" name="wayPoints['+w+'].wayPointY"  id="wayPointY'+w+'" >   ' ;
		waypoint += '	</tr>';
	$('#wayPoint').append(waypoint);
	w++;
	} else {
		swal("경유지는 최고 6개까지 가능합니다!");
	}
}

function deleteWayPoint(){
	var lasttd = $("#wayPoint > tr").length-1;
	if(lasttd > 1){ 
	swal("경유지가 삭제되었어요");
	$("#wayPoint > tr:nth("+lasttd+")").remove();
	w--;
	} else {
		swal("최소 2개의 장소는 필요합니다!");
	}
}

function deleteImg(i){
	$("#wayPointImg"+i+"").val("");
}