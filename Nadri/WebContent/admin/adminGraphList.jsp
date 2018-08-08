<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<!-- Bootstrap CDN -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- admin index 전용 css  -->
<link rel="stylesheet" href="/css/adminIndex.css">
<link rel="stylesheet" href="/css/adminIndexSmall.css">
<script src="/javascript/adminIndex.js"></script>

<title>너나들이 관리자 페이지 - 통계관리</title>

</head>
<style type="text/css">

html, body {
	margin: 0px;
	width: 100%;
	height: 70vh;
	font-size: 65px;
}

.container {
	font-size: 0.3em;
	margin-top : 30px;
	margin-bottom: 30px;
}

#chart-div {
	display: flex;
	width: 100%;
	min-height: 450px;
	justify-content: center;
}

.selectbox {
	font-size: 0.8em;
	text-align: right;
}

.graph-top-box {
	margin-top: 3%;
}

.graph-title {
	font-size: 2em;
	font-weight: 750;
}

.duration {
	height: 3.5vh;
	width: 6vw;
	padding-left: 1.8vw;
}

.duration>option {
	text-align: center;
}

.graphbox {
	margin-top: 5%;
}
</style>

<body>

	<nav class="admin-navbar">
		<a href="/admin/adminIndex"><h2 class="title">너나들이 Admin</h2></a>
		<div class="navbar-side">
			<a href="/"><div class="glyphicon glyphicon-home"></div></a>
			<div class="profile-photo" style="background:url(/images/profile/${user.profileImg}); background-size:contain;">
			</div>
		</div>
	</nav>
	<nav class="admin-sub-navbar">
		<div class="userList">회원목록</div>
		<div class="graph">통계보기</div>
		<div class="spot">백과관리</div>
		<div class="inquire">문의관리</div>
	</nav>

	<div class="container">
		<ul class="nav nav-tabs">
			<li role="presentation" class="active"><a href="#">Home</a></li>
			<li role="presentation"><a href="#">Profile</a></li>
			<li role="presentation"><a href="#">Messages</a></li>
		</ul>
		<div class="row graph-top-box">
			<div class="col-md-8 graph-title">
				<span>일간</span> 유저 활동 기록
			</div>
			<div class="col-md-4 selectbox">
				<select name="duration" class="duration" align="left">
					<option value="day">일간</option>
					<option value="week">주간</option>
					<option value="month">월간</option>
				</select>
			</div>
			<div class="col-md-12 graphbox">
				<canvas id="chart-div" width="400" height="250"></canvas>
			</div>
		</div>
	</div>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
	<script type="text/javascript">
		var duration = $('.duration').val();
		var ctx = document.getElementById("chart-div");
		var myChart = new Chart(ctx,
				{
					type : 'line',
						data : {
							labels :["00시","01시","02시","03시","04시","05시",
								"06시","07시","08시","09시","10시","11시","12시",
								"13시","14시","15시","16시","17시","18시","19시",
								"20시","21시","22시","23시"],
							datasets : [ {
								label : '작성된 게시글',
								data : (duration == 'day' ? ${boardDay} : ( duration == 'week' ? ${boardWeek} : ${boardMonth})),		
								fill: false,
								lineTension:0,
								backgroundColor: '#a03131',
								borderColor : [ '#c54444'],
								borderWidth : 1
							},{
								label : '작성된댓글',
								data : (duration == 'day' ? ${commDay} : ( duration == 'week' ? ${commWeek} : ${commMonth})),
								fill: false,
								lineTension:0,
								backgroundColor : 'powderblue',
								borderColor : [ 'rgba(54, 162, 235, 1)' ],
								borderWidth : 1	
							},{
								label : '생성된 일정',
								data : (duration == 'day' ? ${scheduleDay} : ( duration == 'week' ? ${scheduleWeek} : ${scheduleMonth})),
								fill: false,
								lineTension:0,
								backgroundColor : '#6cc05d',
								borderColor : [ '#51a942' ],
								borderWidth : 1	
							},{
								label : '작성된 문의',
								data : (duration == 'day' ? ${inquireDay} : ( duration == 'week' ? ${inquireWeek} : ${inquireMonth})),
								fill: false,
								lineTension:0,
								backgroundColor : '#f1ec50',
								borderColor : [ '#f2be50' ],
								borderWidth : 1	
							} ]
						},
					options : {
						plugins: {
						    datalabels: {
						      listeners: {
						        // called for any labels
						        enter: function(context) {
						        	console.log("get in");
						        },
						        leave: function(context) { },
						        click: function(context) {
						        	context.hovered = true;
						            return true;
						        }
						      }
						    }
						  },
						scales : {
							yAxes : [ {
								ticks : {
									beginAtZero : true
								}
							} ]
						}
					}
				});
		
 		$('.duration').on('change', function() {
 			duration = $('.duration').val();
 			if(duration == 'week'){
 				console.log("주간 데이터 필요");
 				myChart.data.labels = [ "월요일","화요일","수요일","목요일","금요일","토요일","일요일"];
 				myChart.data.datasets[0].data = ${boardWeek};
 				myChart.data.datasets[1].data = ${commWeek};
 				myChart.data.datasets[2].data = ${scheduleWeek};
 				myChart.data.datasets[3].data = ${inquireWeek};
 				console.log(myChart.data);
 			}else if(duration =='month'){
 				console.log("월간 데이터 필요");
 				myChart.data.datasets[0].data = ${boardMonth};
 				myChart.data.datasets[1].data = ${commMonth};
 				myChart.data.datasets[2].data = ${scheduleMonth};
 				myChart.data.datasets[3].data = ${inquireMonth};
 				myChart.data.labels = ${month};
 			}else if(duration =='day'){
 				myChart.data.labels = ["00시","01시","02시","03시","04시","05시",
					"06시","07시","08시","09시","10시","11시","12시",
					"13시","14시","15시","16시","17시","18시","19시",
					"20시","21시","22시","23시"];
 				myChart.data.datasets[0].data = ${boardDay};
 				myChart.data.datasets[1].data = ${commDay};
 				myChart.data.datasets[2].data = ${scheduleDay};
 				myChart.data.datasets[3].data = ${inquireDay};
 			}
 			window.myChart.update();
		});
		
	</script>
</body>
</html>
