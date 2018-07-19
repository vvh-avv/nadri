// 지금 그냥 값 늘려주기위한 플래그
var a = 0;

var map, markerW0, markerW1, markerW2, markerW3, markerW4, markerW5, markerW6, marker;
var markerLayer_w0 = new Tmap.Layer.Markers("waypoint0");// 시작 마커 레이어 생성
var markerLayer_w1 = new Tmap.Layer.Markers("waypoint1");// 경유지 마커 레이어 생성
var markerLayer_w2 = new Tmap.Layer.Markers("waypoint2");// 경유지 마커 레이어 생성
var markerLayer_w3 = new Tmap.Layer.Markers("waypoint3");// 경유지 마커 레이어 생성
var markerLayer_w4 = new Tmap.Layer.Markers("waypoint4");// 경유지 마커 레이어 생성
var markerLayer_w5 = new Tmap.Layer.Markers("waypoint5");// 경유지 마커 레이어 생성
var markerLayer_w6 = new Tmap.Layer.Markers("waypoint6");// 경유지 마커 레이어 생성
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
var icon_1 = icon("1");
var icon_2 = icon("2");
var icon_3 = icon("3");
var icon_4 = icon("4");
var icon_5 = icon("5");
var icon_6 = icon("6");


// 이부분은 맵에 들어갈 전역변수입니다! 
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

    //map.events.register("click", map, onClick);
    
    map.addLayer(markerLayer_w0); // 맵에 시작 마커레이어 추가
    map.addLayer(markerLayer_w1); // 맵에 끝 마커 레이어 추가
    map.addLayer(markerLayer_w2); // 맵에 경유지 마커 레이어 추가
    map.addLayer(markerLayer_w3); // 맵에 경유지 마커 레이어 추가
    map.addLayer(markerLayer_w4); // 맵에 경유지 마커 레이어 추가
    map.addLayer(markerLayer_w5); // 맵에 경유지 마커 레이어 추가
    map.addLayer(markerLayer_w6); // 맵에 경유지 마커 레이어 추가
    map.addLayer(markerLayer);

    // HTML5의 geolocation으로 사용할 수 있는지 확인합니다.
    // 현재 위치 정보를 얻어오는 메서드이다. 사용자가 허용을 할 경우 실행된다.
        // GeoLocation을 이용해서 접속 위치를 얻어옵니다.
        if (geolocation)    geoLocation("w0");
}
// 나의 위치정보를 나타낼 메서드

//이 메서드는 입장하자마자 자신의 위치 값을 삽입시켜주는 메서드 입니다.
function geoLocation(location) {
    navigator.geolocation.getCurrentPosition(function(position){
        // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
        lat = position.coords.latitude; // 위도
        lon = position.coords.longitude; // 경도

        moveCoordinate(location, lon, lat);
    });
}

//setXY , setMarker , map.setCenter... 세가지 메서드를 한번에!!
function moveCoordinate (value, x, y) {
    var PR_3857 = new Tmap.Projection("EPSG:3857");  // Google Mercator 좌표계인
														// EPSG:3857
    var PR_4326 = new Tmap.Projection("EPSG:4326");  // WGS84 GEO 좌표계인
														// EPSG:4326

    lonlat = new Tmap.LonLat(x, y).transform(PR_4326, PR_3857);

    setXY(value, x, y);
    
    setMarker(value,lonlat); //마커 만들어주기

    map.setCenter(lonlat); // geolocation으로 얻어온 좌표로 지도의 중심을 설정합니다.
}

// 맵 클릭할 경우 마커 표시 메서드
/*function onClick(e){
	alert(e.xy);
    lonlat = map.getLonLatFromViewPortPx(e.xy).transform("EPSG:3857", "EPSG:4326");// 클릭하면 그부분의 좌표값이 나오는데 그것을 변환합니다. ex)x=929,y=340
    x = lonlat.lon; 
    //alert(x); 변환된 x값
    y = lonlat.lat;
    //alert(y); 변환된 y값

    if(input_s == 0) {
        if(input_e == 0) {
        	alert("111111111111111111")
            removeMarker("e");
            resetResult();
        }
        removeMarker("s");
        setLocation("#waypoint0", x, y, lonlat);
    } else if(input_e == 0) {
    	alert("22222222222222222")
        removeMarker("e");
        setLocation("#waypoint1", x, y, lonlat);
    } else if(input){
    	alert("3333333333333333")
        removeMarker("s");
        removeMarker("e");
        reset();
    }
}*/

function resetResult() { // 출력 정보 리셋
    $("#result").text("");
    $("#result1").text("");
    $("#result2").text("");
    $("#result3").text("");
}

function setLocation(value, x, y, lonlat) {
    if (value == "#waypoint0"){
    	alert("in setLocation() xy값을 가지고 이 메소드로 들어왔다! #waypoint0");
    	setXY("w0", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // 알맞는 폼으로 lonlat값을 변환한다. lon=14142351.201816,lat=4508358.524059502
        setMarker("w0");
    } else if(value == "#waypoint1") {
    	alert("in setLocation() xy값을 가지고 이 메소드로 들어왔다! #waypoint1");
        setXY("w1", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // 알맞는 폼으로 lonlat값을 변환한다. lon=14142351.201816,lat=4508358.524059502
        setMarker("w1"); // 마커 만드는 부분
    } else if(value == "#waypoint2") {
    	alert("in setLocation() xy값을 가지고 이 메소드로 들어왔다! #waypoint2");
        setXY("w2", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // 알맞는 폼으로 lonlat값을 변환한다. lon=14142351.201816,lat=4508358.524059502
        setMarker("w2"); // 마커 만드는 부분
    } else if(value == "#waypoint3") {
    	alert("in setLocation() xy값을 가지고 이 메소드로 들어왔다! #waypoint3");
        setXY("w3", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // 알맞는 폼으로 lonlat값을 변환한다. lon=14142351.201816,lat=4508358.524059502
        setMarker("w3"); // 마커 만드는 부분
    } else if(value == "#waypoint4") {
    	alert("in setLocation() xy값을 가지고 이 메소드로 들어왔다! #waypoint4");
        setXY("w4", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // 알맞는 폼으로 lonlat값을 변환한다. lon=14142351.201816,lat=4508358.524059502
        setMarker("w4"); // 마커 만드는 부분
    } else if(value == "#waypoint5") {
    	alert("in setLocation() xy값을 가지고 이 메소드로 들어왔다! #waypoint5");
        setXY("w5", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // 알맞는 폼으로 lonlat값을 변환한다. lon=14142351.201816,lat=4508358.524059502
        setMarker("w5"); // 마커 만드는 부분
    } else if(value == "#waypoint6") {
    	alert("in setLocation() xy값을 가지고 이 메소드로 들어왔다! #waypoint6");
        setXY("w6", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // 알맞는 폼으로 lonlat값을 변환한다. lon=14142351.201816,lat=4508358.524059502
        setMarker("w6"); // 마커 만드는 부분
    }
}

// 마커를 생성해주는 곳입니다.
function setMarker(value) {
    if(value == "w0") {
        markerLayer_w0.removeMarker(markerW0); // 마커 객체를 레이어에서 제거합니다.
        markerW0 = new Tmap.Marker(lonlat, icon_s); // 마커 정보 등록
        markerLayer_w0.addMarker(markerW0);// 마커객체를 레이어에 표출합니다.
    } else if(value == "w1") {
    	//markerLayer_e.removeMarker(markerB); // 마커 객체를 레이어에서 제거합니다.
        markerW1 = new Tmap.Marker(lonlat, icon_1); // 마커 정보 등록
        markerLayer_w1.addMarker(markerW1);// 마커객체를 레이어에 표출합니다.
    } else if(value == "w2"){
        markerW2 = new Tmap.Marker(lonlat, icon_2); // 마커 정보 등록
        markerLayer_w2.addMarker(markerW2);// 마커객체를 레이어에 표출합니다.
    } else if(value == "w3"){
        markerW3 = new Tmap.Marker(lonlat, icon_3); // 마커 정보 등록
        markerLayer_w3.addMarker(markerW3);// 마커객체를 레이어에 표출합니다.
    } else if(value == "w4"){
        markerW4 = new Tmap.Marker(lonlat, icon_4); // 마커 정보 등록
        markerLayer_w4.addMarker(markerW4);// 마커객체를 레이어에 표출합니다.
    } else if(value == "w5"){
        markerW5 = new Tmap.Marker(lonlat, icon_5); // 마커 정보 등록
        markerLayer_w5.addMarker(markerW5);// 마커객체를 레이어에 표출합니다.
    } else if(value == "w6"){
        markerW6 = new Tmap.Marker(lonlat, icon_6); // 마커 정보 등록
        markerLayer_w6.addMarker(markerW6);// 마커객체를 레이어에 표출합니다.
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

//마커를 없애는 장소입니다.
function removeMarker(value) {
    if(value == "s") {
        markerLayer_s.removeMarker(markerA);
        markerA = null;
        way0_x = null;
        way0_y = null;
        $("#waypoint0").val("");
    } else if(value == "e") {
        markerLayer_e.removeMarker(markerB);
        markerB = null;
        way1_x = null;
        way1_y = null;
        $("#waypoint1").val("");
    }
}

// 경로찾기에 들어갈 xy값을 해줄부분을 세팅하는 부분!!
function setXY(value, x, y) {
    if(value == "w0") {
    	start_x = x;
    	start_y = y;
        searchAdress("#waypoint0", y, x);
    } else if(value == "w1") {
    	end_x = x;
        end_y = y;
        searchAdress("#waypoint1", y, x);
    } else if(value == "w2") {
    	end_x = x;
        end_y = y;
        searchAdress("#waypoint2", y, x);
    } else if(value == "w3") {
    	end_x = x;
        end_y = y;
        searchAdress("#waypoint3", y, x);
    } else if(value == "w4") {
    	end_x = x;
        end_y = y;
        searchAdress("#waypoint4", y, x);
    } else if(value == "w5") {
    	end_x = x;
        end_y = y;
        searchAdress("#waypoint5", y, x);
    } else if(value == "w6") {
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
    $("#waypoint1").val(null);
    removeMarker("s");
    removeMarker("e");
    endInputS();
    endInputE();
    //resetResult();
    //map.removeLayer(routeLayer);
}

//값이 있나 없나 valudation check 부분일뿐!!
function search(input) {
	//여기서 input 값은 #waypoint(i) 값입니다!!!
    if($(input).val()=="") {
        alert("입력값이 없습니다.");
    } else {
     // 즉 값이 있다면
        if($(input).val() != null) {
            $.ajax({
                method: "GET",
                url: "https://api2.sktelecom.com/tmap/geo/fullAddrGeo?version=1",
                data: {
                   fullAddr: $(input).val(),
                   appKey: headers["appKey"]
                },
                success: function(data) {
                    var obj = JSON.stringify(data);
                    obj = JSON.parse(obj);
                    // 벨류데이션 체크! 즉 정보가 있다면...
                    if(obj.coordinateInfo != undefined) {
                    	//coordinate안에는 지리정보가 모두 들어있다!
                       var coordinate = obj.coordinateInfo.coordinate[0];
                       //lon만 걸러내면 모든 것을 걸러낼수 있기때문에 이렇게 정한 듯 하다!
                       if(coordinate.lon != "") {
                    	   //coordinate의 lon값과 lat값을 추출해내서 sOrE로 보낸다. 여기서 input은 #waypoint(i)
                            sOrE(input, coordinate.lon, coordinate.lat);
                       } else if(coordinate.newLon != "") {
                    	   //뭔지모르겠지만 신주소인거같다!!
                            sOrE(input, coordinate.newLon, coordinate.newLat);
                       }
                    } else {
                        if (input == "#waypoint0") {
                            alert("출발지 주소가 잘못되었습니다.");
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
}

//경로 탐색 긔긔하는 부분!! onclick 메서드로써 불러들어온다.
function go() {
    if (input_s == 1 && input_e == 1) {
        distance();
    }  else if(input_e == 1) {
    	distance();
    } else if(input_s == 0){
        alert("출발지를 등록하세요!");
    } else {
        alert("경유지를 등록하세요!");
    }
}

var headers = {}; 
//headers["appKey"]="cadda216-ac54-435a-a8ea-a32ba3bb3356";// 실행을 위한 키 입니다.
headers["appKey"]="81d71b60-e7b0-4a49-8eff-e265fd5a44d1";// 실행을 위한 키 입니다. 내꺼

function distance() {
    if (start_x != null && end_x != null) {
        $.ajax({
            method:"POST",
            headers:headers,
            url:"https://api2.sktelecom.com/tmap/routes?version=1",
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
                alert(JSON.stringify(obj));
                
                var total = obj.features[0].properties;
                var time = "";
                /*if(total.totalTime > 3600) {
                    time = Math.floor(total.totalTime/3600) + "시간 " + Math.floor(total.totalTime%3600/60) + "분";
                } else {
                    time = Math.floor(total.totalTime%3600/60) + "분 ";
                }*/

                map.addLayer(routeLayer);
                //routeLayer.removeAllFeatures();
                
                var vector_format = new Tmap.Format.GeoJSON().read(data); 
                
                routeLayer.addFeatures(vector_format);

                //$("#b"+a+"").val(time);
                $("#wayPointMoveTime"+a+"").val(Math.floor(total.totalTime%3600/60));
                //$("#result3").append("택시비: " + total.taxiFare);
                
                // 플래그값을 늘립니다.
                a++;
                
                try{
                //홀수만돌려야지 그에 합당한 값만 뽑아낼 수 있다!
                for (var i =0 ; obj.features.length ; i+=2){
                	var nav;
                	nav += "#"+obj.features[i].properties.description;
                	$("#wayPointNav"+a+"").val(nav);
                }
                } catch(exception ) {
                	
                }
                        
                //다음번 길찾기를 위해서 양값을 바꾸어줍니다.
                start_x =end_x;
                start_y =end_y;
            },
            //잘못된 도착지를 지정했을 경우!!
            error:function(request,status,error){
                alert("출발지 혹은 도착지를 잘못 지정하였습니다.");
                reset();
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });//end of ajax
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
        } else if(input == "#waypoint1"){
        	removeMarker("e");
        } else {
            removeMarker("p");
        }
}

//여기에서는 x,y경로값 셋팅해주고 플래그를 바꿔줍니다! cf) input은 #waypoint(i) , coordinate.newLon, coordinate.newLat
function sOrE (input, x, y) {
    if(input == "#waypoint0") {
    	//waypoint0 즉 출발이라면...
    	start_x = x; //경로값을 셋팅x
    	start_y = y; //경로값을 셋팅y
        startInputS(); //플래그를 1로 바꾼다.
        moveCoordinate("w0", x,y);
    } else if(input == "#waypoint1") {
    	//waypoint0이 아닌 경유지라면?
        end_x = x; //경로값을 셋팅x
        end_y = y; //경로값을 셋팅y
        startInputE(); //플래그를 1로 바꾼다. 이유가 뭐지??
        moveCoordinate("w1", x,y);
    } else if(input == "#waypoint2") {
    	//waypoint0이 아닌 경유지라면?
    	end_x = x; //경로값을 셋팅x
    	end_y = y; //경로값을 셋팅y
        startInputE(); //플래그를 1로 바꾼다. 이유가 뭐지??
        moveCoordinate("w2", x,y);
    } else if(input == "#waypoint3") {
    	//waypoint0이 아닌 경유지라면?
    	end_x = x; //경로값을 셋팅x
    	end_y = y; //경로값을 셋팅y
        startInputE(); //플래그를 1로 바꾼다. 이유가 뭐지??
        moveCoordinate("w3", x,y);
    } else if(input == "#waypoint4") {
    	//waypoint0이 아닌 경유지라면?
    	end_x = x; //경로값을 셋팅x
    	end_y = y; //경로값을 셋팅y
        startInputE(); //플래그를 1로 바꾼다. 이유가 뭐지??
        moveCoordinate("w4", x,y);
    } else if(input == "#waypoint4") {
    	//waypoint0이 아닌 경유지라면?
    	end_x = x; //경로값을 셋팅x
    	end_y = y; //경로값을 셋팅y
        startInputE(); //플래그를 1로 바꾼다. 이유가 뭐지??
        moveCoordinate("w2", x,y);
    } else if(input == "#waypoint5") {
    	//waypoint0이 아닌 경유지라면?
    	end_x = x; //경로값을 셋팅x
    	end_y = y; //경로값을 셋팅y
        startInputE(); //플래그를 1로 바꾼다. 이유가 뭐지??
        moveCoordinate("w5", x,y);
    } else if(input == "#waypoint6") {
    	//waypoint0이 아닌 경유지라면?
    	end_x = x; //경로값을 셋팅x
    	end_y = y; //경로값을 셋팅y
        startInputE(); //플래그를 1로 바꾼다. 이유가 뭐지??
        moveCoordinate("w6", x,y);
    } else  {
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

