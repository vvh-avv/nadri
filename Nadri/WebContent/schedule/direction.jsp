<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 

<meta name="viewport" content="width=device-width, initial-scale=1.0" /> 
<link rel="shortcut icon" href="/images/common/favicon.ico"> 

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
<!-- toolbar.js CDN --> 
<script src="/javascript/toolbar.js"></script> > 
<!-- Mansory CDN 블럭처럼 게시물을 쌓을 수 있도록 만들어주는 CDN입니다! --> 
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>
<!--Import Google Icon Font-->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!-- T-map 지도를 쓰기위한 선언 -->
<script src="https://api2.sktelecom.com/tmap/js?version=1&format=javascript&appKey=cadda216-ac54-435a-a8ea-a32ba3bb3356"></script>
<!-- Import materialize.min.js -->
<script type="text/javascript" src="/javascript/materialize.min.js"></script>
<link rel="stylesheet" href="/css/materialize.min.css">
<script src="/javascript/juangeolocation.js?ver=1"></script>
<html>
<head>
<title>Insert title here</title>

<script>

$(document).ready(function(){
	 initTmap();

	// 0.2초의 시간을 줘야지 자바스크립트가 먼저 실행되지 않습니다!!
	$(".waves-effect").click(function(){
		    setTimeout(function(){
		    	go();
		    }, 200);
		}); //end of click
});

function addWayPoint() {
	$("body > div.row > form > div:nth-child(3) > div").append(
		      "<div class='row'>"+
               "<div class='(input-field col s12'>"+
                   "<input type='text' id='waypoint1' />"+
                   "<div class='row'>"+
                       "<input class='waves-effect waves-light btn col s5' style='background-color: rgba(250, 170, 50, 0.5);'"+
                      " type='button' value='도착지 등록' onclick='search('#waypoint1')'>"+
                       "<button class='waves-effect waves-light btn offset-s1 col s5' type='button' onclick='geoLocation('e')'>"+
                          " <i class='material-icons left'>center_focus_weak</i>  내 위치"+
                       "</button>"+
                  " </div>"+
              " </div>"+
         " </div>	"
	);
}
</script>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        
    </head>
    <body>
        <nav style="background-image: url('/images/spot/parkdefault.png');">
            <div class="nav-wrapper">
                <a href="#" class="brand-logo center">navigation</a>
            </div>
        </nav>
        <div class="row">
        <!-- T-Map 지도 화면 -->
            <div id="map_div"></div>
        
            <form class="offset-s6 col s3" style="margin-top: 6%;" id="navigation">
                <div class="row">
               
                    <div class="input-field col s12">
                        <input type="text" id="waypoint0" />
                        <div class="row">
                            <input class="waves-effect waves-light btn col s5" type="button" style="background-color: rgba(250, 170, 50, 0.5);" value="출발지 등록" onclick="search('#waypoint0')">
                            <button class="waves-effect waves-light btn offset-s1 col s5" type="button" onclick="geoLocation('s')">
                                <i class="material-icons left">center_focus_weak</i>  내 위치
                            </button>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="input-field col s12">
                        <input type="text" id="waypoint1" />
                        <div class="row">
                            <input class="waves-effect waves-light btn col s5" style="background-color: rgba(250, 170, 50, 0.5);" type="button" value="경유지 등록" onclick="search('#waypoint1')">
                        </div>
                    </div>
                </div>
                
                    <div class="row">
                    <div class="input-field col s12">
                        <input type="text" id="waypoint2" />
                        <div class="row">
                            <input class="waves-effect waves-light btn col s5" style="background-color: rgba(250, 170, 50, 0.5);" type="button" value="경유지 등록" onclick="search('#waypoint2')">
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="input-field col s12">
                        <input type="text" id="waypoint3" />
                        <div class="row">
                            <input class="waves-effect waves-light btn col s5" style="background-color: rgba(250, 170, 50, 0.5);" type="button" value="경유지 등록" onclick="search('#waypoint3')">
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="input-field col s12">
                        <input type="text" id="waypoint4" />
                        <div class="row">
                            <input class="waves-effect waves-light btn col s5" style="background-color: rgba(250, 170, 50, 0.5);" type="button" value="경유지 등록" onclick="search('#waypoint4')">
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="input-field col s12">
                        <input type="text" id="waypoint5" />
                        <div class="row">
                            <input class="waves-effect waves-light btn col s5" style="background-color: rgba(250, 170, 50, 0.5);" type="button" value="경유지 등록" onclick="search('#waypoint5')">
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="input-field col s12">
                        <input type="text" id="waypoint6" />
                        <div class="row">
                            <input class="waves-effect waves-light btn col s5" style="background-color: rgba(250, 170, 50, 0.5);" type="button" value="경유지 등록" onclick="search('#waypoint6')">
                        </div>
                    </div>
                </div>
                          
                <div class="row">
                	<button class="waves-effect waves-light btn offset-s1 col s5" type="button" onclick="addWayPoint()">경유지 추가 </button>
                <div>
                
            </form>
            <div class="result col s3">
                <p id="result" class="center-align"></p>
                <p id="result1" class="center-align"></p>
                <p id="result2" class="center-align"></p>
                <p id="result3" class="center-align"></p>
            </div>
        </div>
    </body>
</html>