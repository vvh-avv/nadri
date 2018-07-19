var map, markerA, markerB, marker
var markerLayer_s = new Tmap.Layer.Markers("waypoint0");// 시작 마커 레이어 생성
var markerLayer_e = new Tmap.Layer.Markers("waypoint6");// 경유지 마커 레이어 생성
var markerLayer_p = new Tmap.Layer.Markers("waypoint");// 경유지 마커 레이어 생성
var markerLayer = new Tmap.Layer.Markers(); //마커들을 마커레이어에 넣습니다.
var routeLayer = new Tmap.Layer.Vector("route");
routeLayer.style ={
    fillColor:"#FF0000",
    fillOpacity:0.2,
    strokeColor: "#FF0000",
    strokeWidth: 3,
    strokeDashstyle: "solid",
    pointRadius: 2,
    title: "this is a red line"	
};
var lonlat = new Tmap.LonLat(127.02758300000005,37.494541).transform("EPSG:4326", "EPSG:3857");// 기본 위치를 설정하는 곳 입니다!
var geolocation = navigator.geolocation;

var icon_s = icon("s");
var icon_e = icon("e");
var icon_p = icon("p");

var start_x;
var start_y;
var end_x;
var end_y;

var input_s = false;
var input_e = false;

// 홈페이지 로딩과 동시에 맵을 호출할 함수
function initTmap(){
    map = new Tmap.Map({
        div:'map_div',
        width : "100%",
        height : "60%",
    });

    map.events.register("click", map, onClick);
    
    map.addLayer(markerLayer_s); // 맵에 시작 마커레이어 추가
    map.addLayer(markerLayer_e); // 맵에 끝 마커 레이어 추가
    map.addLayer(markerLayer_p); // 맵에 경유지 마커 레이어 추가
    map.addLayer(markerLayer);

    // HTML5의 geolocation으로 사용할 수 있는지 확인합니다.
    // 현재 위치 정보를 얻어오는 메서드이다. 사용자가 허용을 할 경우 실행된다.
        // GeoLocation을 이용해서 접속 위치를 얻어옵니다.
        if (geolocation)    geoLocation("s");
}
// 나의 위치정보를 나타낼 메서드
function geoLocation(location) {
    navigator.geolocation.getCurrentPosition(function(position){
        // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
        lat = position.coords.latitude; // 위도
        lon = position.coords.longitude; // 경도

        moveCoordinate(location, lon, lat);
    });
}

function moveCoordinate (value, x, y) {
    var PR_3857 = new Tmap.Projection("EPSG:3857");  // Google Mercator 좌표계인
														// EPSG:3857
    var PR_4326 = new Tmap.Projection("EPSG:4326");  // WGS84 GEO 좌표계인
														// EPSG:4326

    lonlat = new Tmap.LonLat(x, y).transform(PR_4326, PR_3857);

    setXY(value, x, y);
    
    setMarker(value,lonlat);

    map.setCenter(lonlat); // geolocation으로 얻어온 좌표로 지도의 중심을 설정합니다.
}

// 맵 클릭할 경우 마커 표시 메서드
function onClick(e){
    lonlat = map.getLonLatFromViewPortPx(e.xy).transform("EPSG:3857", "EPSG:4326");// 클릭
																					// 부분의
																					// ViewPortPx를
																					// LonLat
																					// 좌표로
																					// 변환합니다.
    x = lonlat.lon;
    y = lonlat.lat;

    if(input_s == 0) {
        if(input_e == 0) {
            removeMarker("e");
            resetResult();
        }
        removeMarker("s");
        setLocation("#waypoint0", x, y, lonlat);
    } else if(input_e == 0) {
        removeMarker("e");
        setLocation("#waypoint6", x, y, lonlat);
    } else {
        removeMarker("s");
        removeMarker("e");
        reset();
    }
}

/*function resetResult() { // 출력 정보 리셋
    $("#result").text("");
    $("#result1").text("");
    $("#result2").text("");
    $("#result3").text("");
}*/

function setLocation(value, x, y, lonlat) {
    if (value == "#waypoint0"){
        setXY("s", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // 마커 정보 등록
        setMarker("s");
    } else if(value == "#waypoint6") {
        setXY("e", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // 마커 정보 등록
        setMarker("e");
    }
}

function setMarker(value) {
    if(value == "s") {
        markerLayer_s.removeMarker(markerA);
        markerA = new Tmap.Marker(lonlat, icon_s); // 마커 정보 등록
        markerLayer_s.addMarker(markerA);
    } else if(value == "e") {
        markerLayer_e.removeMarker(markerB);
        markerB = new Tmap.Marker(lonlat, icon_e);
        markerLayer_e.addMarker(markerB);
    }
}

function icon(value) {
    if(value != "s" && value != "e") {
        value == "s";
    }
    var size = new Tmap.Size(24, 38);
    var offset = new Tmap.Pixel(-(size.w / 2), -(size.h));
    var icon = new Tmap.IconHtml('<img src=http://tmapapis.sktelecom.com/upload/tmap/marker/pin_r_m_'+value+'.png />',size, offset);
    return icon;
}

function removeMarker(value) {
    if(value == "s") {
        markerLayer_s.removeMarker(markerA);
        markerA = null;
        start_x = null;
        start_y = null;
        $("#waypoint0").val("");
    } else if(value == "e") {
        markerLayer_e.removeMarker(markerB);
        markerB = null;
        end_x = null;
        end_y = null;
        $("#waypoint6").val("");
    }
}

function setXY(value, x, y) {
    if(value == "s") {
        start_x = x;
        start_y = y;
        searchAdress("#waypoint0", y, x);
    } else if(value == "e") {
        end_x = x;
        end_y = y;
        searchAdress("#waypoint6", y, x);
    } else {
        console.log("value Error");
    }
}

//지금까지 짰던 모든 길찾기를 없앱니다.
function reset () { 
    $("#waypoint0").val(null);
    $("#waypoint6").val(null);
    removeMarker("s");
    removeMarker("e");
    endInputS();
    endInputE();
    resetResult();
    map.removeLayer(routeLayer);
}

//경로 탐색 긔긔하는 부분!! onclick 메서드로써 불러들어온다.
function go() {
    if (input_s == 1 && input_e == 1) {
        distance();
    } else if(input_s == 0){
        alert("출발지를 등록하세요!");
    } else {
        alert("도착지를 등록하세요!");
    }
}

var headers = {}; 
headers["appKey"]="cadda216-ac54-435a-a8ea-a32ba3bb3356";// 실행을 위한 키 입니다.
															// 발급받으신 AppKey를
															// 입력하세요.

function distance() {
    if (start_x != null && end_x != null) {
        $.ajax({
            method:"POST",
            headers:headers,
            url:"https://api2.sktelecom.com/tmap/routes/pedestrian?version=1",
            data:{
                startX:start_x,
                startY:start_y,
                endX:end_x,
                endY:end_y,
                reqCoordType : "WGS84GEO",
                resCoordType : "EPSG3857",
                angle:"172",
              //출발지 명칭입니다.
        		startName : "출발지",
        		//목적지 명칭입니다.
        		endName : "도착지"
            },
            success:function(data) {
                var obj = JSON.stringify(data);
                obj = JSON.parse(obj);
                var total = obj.features[0].properties;
                var waypoint0 = 0;
                var waypoint6;

                var time = "";
                if(total.totalTime > 3600) {
                    time = Math.floor(total.totalTime/3600) + "시간 " + Math.floor(total.totalTime%3600/60) + "분";
                } else {
                    time = Math.floor(total.totalTime%3600/60) + "분 ";
                }

                map.addLayer(routeLayer);
                routeLayer.removeAllFeatures();
                

                var vector_format = new Tmap.Format.GeoJSON().read(data); 
                
                routeLayer.addFeatures(vector_format);

                $("#result").text("소요 시간: " + time);
                $("#result1").text("거리: " + total.totalDistance/1000+ "km ");
                $("#result2").text("통행료: " + total.totalFare);
                $("#result3").text("택시비: " + total.taxiFare);
            },
            //잘못된 도착지를 지정했을 경우!!
            error:function(request,status,error){
                alert("출발지 혹은 도착지를 잘못 지정하였습니다.");
                reset();
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    }
}

function searchAdress(input, lat, lon) {
    $.ajax({
        method: "GET",
        url: "https://api2.sktelecom.com/tmap/geo/reversegeocoding?version=1",
        data: {
          lat: lat,
          lon: lon,
          appKey: headers["appKey"]
        },
        success: function(data) {
            if(data != undefined) {
            var obj = JSON.stringify(data);
            obj = JSON.parse(obj);
            } else {
                alertAdress(input);
            }
            $(input).val(obj.addressInfo.fullAddress);//인풋에다가 value를 삽입합니다. (그곳을 검색했다는 것을 알려주기 위해서!)
        },
        error:function(request,status,error){
        	//제공해주지 않는 주소이니까 이전에 체크한 마커를 없애줍니다.
            alertAdress(input);
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

function alertAdress(input) {
    alert("제공되지 않는 주소 범위입니다.");
        if(input == "#waypoint0") {
            removeMarker("s");
        } else if(input == "#waypoint6"){
        	removeMarker("e");
        } else {
            removeMarker("p");
        }
}

function search(input) {
	//여기서 input 값은 #waypoint(i) 값입니다!!!
	alert(input);
    if($(input).val()=="") {
        alert("입력값이 없습니다.");
    } else {
        textSearch(input, $(input).val());
    }
}

//한글주소명을써서 그것을 토대로 길을 찾는건가보군!
//여기서 add값은 $(input).val()
function textSearch(input, add) {
    if($(input).val() != null) {
        $.ajax({
            method: "GET",
            url: "https://api2.sktelecom.com/tmap/geo/fullAddrGeo?version=1",
            data: {
               fullAddr: add,
               appKey: headers["appKey"]
            },
            success: function(data) {
            	alert(JSON.stringify(data));
                var obj = JSON.stringify(data);
                obj = JSON.parse(obj);

                if(obj.coordinateInfo != undefined) {
                	//coordinate안에는 지리정보가 모두 들어있다!
                   var coordinate = obj.coordinateInfo.coordinate[0];
                   //lon만 걸러내면 모든 것을 걸러낼수 있기때문에 이렇게 정한 듯 하다!
                   if(coordinate.lon != "") {
                	   //coordinate의 lon값과 lat값을 추출해내서 sOrE로 보낸다. 여기서 input은 
                        sOrE(input, coordinate.lon, coordinate.lat);
                   } else if(coordinate.newLon != "") {
                       console.log(coordinate.newLon);
                        sOrE(input, coordinate.newLon, coordinate.newLat);
                   }
                } else {
                    if (input == "#waypoint0") {
                        alert("출발지 주소가 잘못되었습니다.");
                    } else if(input == "#waypoint6" ) {
                        alert("도착지 주소가 잘못되었습니다.");
                    } else {
                    	 alert("경유지 주소가 잘못되었습니다.");
                    }
                }
            },
            error:function(request,status,error){
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                
            }
        });
    }
}

//여기는 뭐하는 부분이지..?
function sOrE (input, x, y) {
    if(input == "#waypoint0") {
        start_x = x;
        start_y = y;
        startInputS();
        moveCoordinate("s", x,y);
    } else if(input == "#waypoint6") {
        end_x = x;
        end_y = y;
        startInputE();
        moveCoordinate("e", x,y);
    } else {
        alert("잘못된 값을 입력하셨습니다.");
    }
}

// 플래그 시작 input
function startInputS() {
    input_s = 1;
}

//플래그 끝 input
function endInputS() {
    input_s = 0;
}

function startInputE() {
    input_e = 1;
}

function endInputE() {
    input_e = 0;
}

