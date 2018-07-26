// ���� �׳� �� �÷��ֱ����� �÷���
var a = 0;

var map, markerW0, markerW1, markerW2, markerW3, markerW4, markerW5, markerW6, marker;
var markerLayer_w0 = new Tmap.Layer.Markers("waypoint0");// ���� ��Ŀ ���̾� ����
var markerLayer_w1 = new Tmap.Layer.Markers("waypoint1");// ������ ��Ŀ ���̾� ����
var markerLayer_w2 = new Tmap.Layer.Markers("waypoint2");// ������ ��Ŀ ���̾� ����
var markerLayer_w3 = new Tmap.Layer.Markers("waypoint3");// ������ ��Ŀ ���̾� ����
var markerLayer_w4 = new Tmap.Layer.Markers("waypoint4");// ������ ��Ŀ ���̾� ����
var markerLayer_w5 = new Tmap.Layer.Markers("waypoint5");// ������ ��Ŀ ���̾� ����
var markerLayer_w6 = new Tmap.Layer.Markers("waypoint6");// ������ ��Ŀ ���̾� ����
var markerLayer = new Tmap.Layer.Markers(); //��Ŀ���� ��Ŀ���̾ �ֽ��ϴ�.
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
var lonlat = new Tmap.LonLat(127.02758300000005,37.494541).transform("EPSG:4326", "EPSG:3857");// �⺻ ��ġ�� �����ϴ� �� �Դϴ�!
var geolocation = navigator.geolocation;

var icon_s = icon("s");
var icon_1 = icon("1");
var icon_2 = icon("2");
var icon_3 = icon("3");
var icon_4 = icon("4");
var icon_5 = icon("5");
var icon_6 = icon("6");


// �̺κ��� �ʿ� �� ���������Դϴ�! 
var start_x;
var start_y;
var end_x;
var end_y;

var input_s = false;
var input_e = false;

// Ȩ������ �ε��� ���ÿ� ���� ȣ���� �Լ�
function initTmap(){
    map = new Tmap.Map({
        div:'map',
        width : "100%",
        height : "60%",
    });
    
    map.ctrl_nav.disableZoomWheel(); //���� Ȯ����� ����� �����ϴ�

    //map.events.register("click", map, onClick);
    
    map.addLayer(markerLayer_w0); // �ʿ� ���� ��Ŀ���̾� �߰�
    map.addLayer(markerLayer_w1); // �ʿ� �� ��Ŀ ���̾� �߰�
    map.addLayer(markerLayer_w2); // �ʿ� ������ ��Ŀ ���̾� �߰�
    map.addLayer(markerLayer_w3); // �ʿ� ������ ��Ŀ ���̾� �߰�
    map.addLayer(markerLayer_w4); // �ʿ� ������ ��Ŀ ���̾� �߰�
    map.addLayer(markerLayer_w5); // �ʿ� ������ ��Ŀ ���̾� �߰�
    map.addLayer(markerLayer_w6); // �ʿ� ������ ��Ŀ ���̾� �߰�
    map.addLayer(markerLayer);

    // HTML5�� geolocation���� ����� �� �ִ��� Ȯ���մϴ�.
    // ���� ��ġ ������ ������ �޼����̴�. ����ڰ� ����� �� ��� ����ȴ�.
        // GeoLocation�� �̿��ؼ� ���� ��ġ�� ���ɴϴ�.
        if (geolocation)    geoLocation("w0");
}

// ���� ��ġ������ ��Ÿ�� �޼���

//�� �޼���� �������ڸ��� �ڽ��� ��ġ ���� ���Խ����ִ� �޼��� �Դϴ�.
function geoLocation(location) {
    navigator.geolocation.getCurrentPosition(function(position){
        // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ�� �����մϴ�
        lat = position.coords.latitude; // ����
        lon = position.coords.longitude; // �浵

        moveCoordinate(location, lon, lat);
    });
}

//������ �ܷ����� �Ѵܰ� �ø��� �Լ��Դϴ�.
function zoomIn(){
	map.zoomIn(); //������ 1���� �ø��ϴ�.
}
// ������ �ܷ����� �Ѵܰ� ������ �Լ��Դϴ�.
function zoomOut(){
	map.zoomOut(); //������ 1���� �����ϴ�.
}

//setXY , setMarker , map.setCenter... ������ �޼��带 �ѹ���!!
function moveCoordinate (value, x, y) {
	//alert("moveCoordinate ���̴� value : "+value);
    var PR_3857 = new Tmap.Projection("EPSG:3857");  // Google Mercator ��ǥ����
														// EPSG:3857
    var PR_4326 = new Tmap.Projection("EPSG:4326");  // WGS84 GEO ��ǥ����
														// EPSG:4326

    lonlat = new Tmap.LonLat(x, y).transform(PR_4326, PR_3857);

    setXY(value, x, y);
    
    setMarker(value,lonlat); //��Ŀ ������ֱ�

    map.setCenter(lonlat,13); // geolocation���� ���� ��ǥ�� ������ �߽��� �����մϴ�.
}

// �� Ŭ���� ��� ��Ŀ ǥ�� �޼���
/*function onClick(e){
	alert(e.xy);
    lonlat = map.getLonLatFromViewPortPx(e.xy).transform("EPSG:3857", "EPSG:4326");// Ŭ���ϸ� �׺κ��� ��ǥ���� �����µ� �װ��� ��ȯ�մϴ�. ex)x=929,y=340
    x = lonlat.lon; 
    //alert(x); ��ȯ�� x��
    y = lonlat.lat;
    //alert(y); ��ȯ�� y��

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

function resetResult() { // ��� ���� ����
    $("#result").text("");
    $("#result1").text("");
    $("#result2").text("");
    $("#result3").text("");
}

function setLocation(value, x, y, lonlat) {
    if (value == "#wayPointAddress1"){
    	setXY("w0", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // �˸´� ������ lonlat���� ��ȯ�Ѵ�. lon=14142351.201816,lat=4508358.524059502
        setMarker("w0");
    } else if(value == "#waypoint1") {
        setXY("w1", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // �˸´� ������ lonlat���� ��ȯ�Ѵ�. lon=14142351.201816,lat=4508358.524059502
        setMarker("w1"); // ��Ŀ ����� �κ�
    } else if(value == "#waypoint2") {
        setXY("w2", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // �˸´� ������ lonlat���� ��ȯ�Ѵ�. lon=14142351.201816,lat=4508358.524059502
        setMarker("w2"); // ��Ŀ ����� �κ�
    } else if(value == "#waypoint3") {
        setXY("w3", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // �˸´� ������ lonlat���� ��ȯ�Ѵ�. lon=14142351.201816,lat=4508358.524059502
        setMarker("w3"); // ��Ŀ ����� �κ�
    } else if(value == "#waypoint4") {
        setXY("w4", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // �˸´� ������ lonlat���� ��ȯ�Ѵ�. lon=14142351.201816,lat=4508358.524059502
        setMarker("w4"); // ��Ŀ ����� �κ�
    } else if(value == "#waypoint5") {
        setXY("w5", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // �˸´� ������ lonlat���� ��ȯ�Ѵ�. lon=14142351.201816,lat=4508358.524059502
        setMarker("w5"); // ��Ŀ ����� �κ�
    } else if(value == "#waypoint6") {
        setXY("w6", x, y);
        lonlat = lonlat.transform("EPSG:4326", "EPSG:3857"); // �˸´� ������ lonlat���� ��ȯ�Ѵ�. lon=14142351.201816,lat=4508358.524059502
        setMarker("w6"); // ��Ŀ ����� �κ�
    }
}

// ��Ŀ�� �������ִ� ���Դϴ�.
function setMarker(value) {
    if(value == "w0") {
        markerLayer_w0.removeMarker(markerW0); // ��Ŀ ��ü�� ���̾�� �����մϴ�.
        markerW0 = new Tmap.Marker(lonlat, icon_s); // ��Ŀ ���� ���
        markerLayer_w0.addMarker(markerW0);// ��Ŀ��ü�� ���̾ ǥ���մϴ�.
    } else if(value == "w1") {
    	//markerLayer_e.removeMarker(markerB); // ��Ŀ ��ü�� ���̾�� �����մϴ�.
        markerW1 = new Tmap.Marker(lonlat, icon_1); // ��Ŀ ���� ���
        markerLayer_w1.addMarker(markerW1);// ��Ŀ��ü�� ���̾ ǥ���մϴ�.
    } else if(value == "w2"){
        markerW2 = new Tmap.Marker(lonlat, icon_2); // ��Ŀ ���� ���
        markerLayer_w2.addMarker(markerW2);// ��Ŀ��ü�� ���̾ ǥ���մϴ�.
    } else if(value == "w3"){
        markerW3 = new Tmap.Marker(lonlat, icon_3); // ��Ŀ ���� ���
        markerLayer_w3.addMarker(markerW3);// ��Ŀ��ü�� ���̾ ǥ���մϴ�.
    } else if(value == "w4"){
        markerW4 = new Tmap.Marker(lonlat, icon_4); // ��Ŀ ���� ���
        markerLayer_w4.addMarker(markerW4);// ��Ŀ��ü�� ���̾ ǥ���մϴ�.
    } else if(value == "w5"){
        markerW5 = new Tmap.Marker(lonlat, icon_5); // ��Ŀ ���� ���
        markerLayer_w5.addMarker(markerW5);// ��Ŀ��ü�� ���̾ ǥ���մϴ�.
    } else if(value == "w6"){
        markerW6 = new Tmap.Marker(lonlat, icon_6); // ��Ŀ ���� ���
        markerLayer_w6.addMarker(markerW6);// ��Ŀ��ü�� ���̾ ǥ���մϴ�.
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

//��Ŀ�� ���ִ� ����Դϴ�.
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

// ���ã�⿡ �� xy���� ���ٺκ��� �����ϴ� �κ�!!
function setXY(value, x, y) {
    if(value == "w0") {
    	start_x = x;
    	start_y = y;
        searchAdress("#wayPointAddress0", y, x);
    } else if(value == "w1") {
    	end_x = x;
        end_y = y;
        searchAdress("#wayPointAddress1", y, x);
    } else if(value == "w2") {
    	end_x = x;
        end_y = y;
        searchAdress("#wayPointAddress2", y, x);
    } else if(value == "w3") {
    	end_x = x;
        end_y = y;
        searchAdress("#wayPointAddress3", y, x);
    } else if(value == "w4") {
    	end_x = x;
        end_y = y;
        searchAdress("#wayPointAddress4", y, x);
    } else if(value == "w5") {
    	end_x = x;
        end_y = y;
        searchAdress("#wayPointAddress5", y, x);
    } else if(value == "w6") {
    	end_x = x;
        end_y = y;
        searchAdress("#wayPointAddress6", y, x);
    } else {
        console.log("value Error");
    }
}

//���ݱ��� ®�� ��� ��ã�⸦ ���۴ϴ�.
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

//���� �ֳ� ���� valudation check �κ��ϻ�!!
function search(input) {
	//���⼭ input ���� #waypoint(i) ���Դϴ�!!!
    if($(input).val()=="") {
        alert("주소를 입력해주세요!");
    } else {
     // �� ���� �ִٸ�
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
                    // �������̼� üũ! �� ������ �ִٸ�...
                    if(obj.coordinateInfo != undefined) {
                    	//coordinate�ȿ��� ���������� ��� ����ִ�!
                       var coordinate = obj.coordinateInfo.coordinate[0];
                       //lon�� �ɷ����� ��� ���� �ɷ����� �ֱ⶧���� �̷��� ���� �� �ϴ�!
                       if(coordinate.lon != "") {
                    	   //coordinate�� lon���� lat���� �����س��� sOrE�� ������. ���⼭ input�� #waypoint(i)
                            sOrE(input, coordinate.lon, coordinate.lat);
                       } else if(coordinate.newLon != "") {
                    	   //�����𸣰����� ���ּ��ΰŰ���!!
                            sOrE(input, coordinate.newLon, coordinate.newLat);
                       }
                    } else {
                        if (input == "#waypoint0") {
                            alert("����� �ּҰ� �߸��Ǿ����ϴ�.");
                        } else {
                        	 alert("������ �ּҰ� �߸��Ǿ����ϴ�.");
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

//��� Ž�� ����ϴ� �κ�!! onclick �޼���ν� �ҷ����´�.
function go() {
    if (input_s == 1 && input_e == 1) {
        distance();
    }  else if(input_e == 1) {
    	distance();
    } else if(input_s == 0){
        alert("������� ����ϼ���!");
    } else {
        alert("�������� ����ϼ���!");
    }
}

var headers = {}; 
//headers["appKey"]="cadda216-ac54-435a-a8ea-a32ba3bb3356";// ������ ���� Ű �Դϴ�.
headers["appKey"]="81d71b60-e7b0-4a49-8eff-e265fd5a44d1";// ������ ���� Ű �Դϴ�. ����

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
              //����� ��Ī�Դϴ�.
        		startName : "�����",
        		//������ ��Ī�Դϴ�.
        		endName : "������"
            },
            success:function(data) {
                var obj = JSON.stringify(data);
                obj = JSON.parse(obj);
                
                var total = obj.features[0].properties;
                var time = "";
                /*if(total.totalTime > 3600) {
                    time = Math.floor(total.totalTime/3600) + "�ð� " + Math.floor(total.totalTime%3600/60) + "��";
                } else {
                    time = Math.floor(total.totalTime%3600/60) + "�� ";
                }*/

                map.addLayer(routeLayer);
                //routeLayer.removeAllFeatures();
                
                var vector_format = new Tmap.Format.GeoJSON().read(data); 
                
                routeLayer.addFeatures(vector_format);

                //$("#b"+a+"").val(time);
                $("#wayPointMoveTime"+a+"").val(Math.floor(total.totalTime%3600/60));
                //$("#result3").append("�ýú�: " + total.taxiFare);
                
                // �÷��װ��� �ø��ϴ�.
                a++;
                
                try{
                //Ȧ������������ �׿� �մ��� ���� �̾Ƴ� �� �ִ�!
                for (var i =0 ; obj.features.length ; i+=2){
                	var nav;
                	nav += "#"+obj.features[i].properties.description;
                	$("#wayPointNav"+a+"").val(nav);
                }
                } catch(exception ) {
                	
                }
                        
                //������ ��ã�⸦ ���ؼ� �簪�� �ٲپ��ݴϴ�.
                start_x =end_x;
                start_y =end_y;
            },
            //�߸��� �������� �������� ���!!
            error:function(request,status,error){
                alert("����� Ȥ�� �������� �߸� �����Ͽ����ϴ�.");
                reset();
                console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });//end of ajax
    }
}

function searchAdress(input, lat, lon) {
	//alert("searchAdress input! : " +input);
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
            $(input).val(obj.addressInfo.fullAddress);//��ǲ���ٰ� value�� �����մϴ�. (�װ��� �˻��ߴٴ� ���� �˷��ֱ� ���ؼ�!)
        },
        error:function(request,status,error){
        	//���������� �ʴ� �ּ��̴ϱ� ������ üũ�� ��Ŀ�� �����ݴϴ�.
            alertAdress(input);
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

function alertAdress(input) {
    alert("�������� �ʴ� �ּ� �����Դϴ�.");
        if(input == "#waypoint0") {
            removeMarker("s");
        } else if(input == "#waypoint1"){
        	removeMarker("e");
        } else {
            removeMarker("p");
        }
}

//���⿡���� x,y��ΰ� �������ְ� �÷��׸� �ٲ��ݴϴ�! cf) input�� #waypoint(i) , coordinate.newLon, coordinate.newLat
function sOrE (input, x, y) {
    if(input == "#wayPointAddress0") {
    	//waypoint0 �� ����̶��...
    	start_x = x; //��ΰ��� ����x
    	start_y = y; //��ΰ��� ����y
        startInputS(); //�÷��׸� 1�� �ٲ۴�.
        moveCoordinate("w0", x,y);
    } else if(input == "#wayPointAddress1") {
    	//waypoint0�� �ƴ� ���������?
        end_x = x; //��ΰ��� ����x
        end_y = y; //��ΰ��� ����y
        startInputE(); //�÷��׸� 1�� �ٲ۴�. ������ ����??
        moveCoordinate("w1", x,y);
    } else if(input == "#wayPointAddress2") {
    	//waypoint0�� �ƴ� ���������?
    	end_x = x; //��ΰ��� ����x
    	end_y = y; //��ΰ��� ����y
        startInputE(); //�÷��׸� 1�� �ٲ۴�. ������ ����??
        moveCoordinate("w2", x,y);
    } else if(input == "#wayPointAddress3") {
    	//waypoint0�� �ƴ� ���������?
    	end_x = x; //��ΰ��� ����x
    	end_y = y; //��ΰ��� ����y
        startInputE(); //�÷��׸� 1�� �ٲ۴�. ������ ����??
        moveCoordinate("w3", x,y);
    } else if(input == "#wayPointAddress4") {
    	//waypoint0�� �ƴ� ���������?
    	end_x = x; //��ΰ��� ����x
    	end_y = y; //��ΰ��� ����y
        startInputE(); //�÷��׸� 1�� �ٲ۴�. ������ ����??
        moveCoordinate("w4", x,y);
    } else if(input == "#wayPointAddress4") {
    	//waypoint0�� �ƴ� ���������?
    	end_x = x; //��ΰ��� ����x
    	end_y = y; //��ΰ��� ����y
        startInputE(); //�÷��׸� 1�� �ٲ۴�. ������ ����??
        moveCoordinate("w2", x,y);
    } else if(input == "#wayPointAddress5") {
    	//waypoint0�� �ƴ� ���������?
    	end_x = x; //��ΰ��� ����x
    	end_y = y; //��ΰ��� ����y
        startInputE(); //�÷��׸� 1�� �ٲ۴�. ������ ����??
        moveCoordinate("w5", x,y);
    } else if(input == "#wayPointAddress6") {
    	//waypoint0�� �ƴ� ���������?
    	end_x = x; //��ΰ��� ����x
    	end_y = y; //��ΰ��� ����y
        startInputE(); //�÷��׸� 1�� �ٲ۴�. ������ ����??
        moveCoordinate("w6", x,y);
    } else  {
        alert("�߸��� ���� �Է��ϼ̽��ϴ�.");
    }
}

// �÷��� ���� input
function startInputS() {
    input_s = 1;
}

//�÷��� �� input
function endInputS() {
    input_s = 0;
}

function startInputE() {
    input_e = 1;
}

function endInputE() {
    input_e = 0;
}

