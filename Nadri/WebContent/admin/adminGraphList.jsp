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

<title>너나들이 관리자 페이지 - 통계관리</title>

</head>
<style type="text/css">
html, body {
	margin: 0px;
	width: 100%;
	height: 100%;
	font-size: 65px;
}

.container {
	font-size: 0.3em;
}

.glyphicon-home {
	font-size: 0.8em;
	align: right;
	margin-left: 95%;
}

.navbar {
	font-size: 0.2em;
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

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

	// 구글차트 onload
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});

	google.charts.setOnLoadCallback(drawChart);
	
	var duration = 'day';
	
	function drawChart() {
		
		var data = new google.visualization.DataTable();
		
		if(duration =='day'){
			data.addColumn('string','시간(hour)');
		}else if(duration =='week'){
			data.addColumn('string','주간(week)');		
		}else if(duration=='month'){
			data.addColumn('string','일(day)');			
		}
		data.addColumn('number','게시글작성횟수');
		data.addColumn('number','댓글작성횟수');
		data.addColumn('number','일정작성횟수');
		data.addColumn('number','문의작성횟수');
		
		if(duration == 'day'){
			data.addRows(${dayGraph});
		}else if(duration == 'week'){
			data.addRows(${weekGraph});
		}else if(duration == 'month'){
			data.addRows(${monthGraph});
		}
		
		var options = {
				width:'100%',
				height:'100%',
				chartArea:{width:'80%',
					height:'90%'},
				vAxis: {minValue: 0},
				animation: { duration: 1000,
			        easing: 'out' }
		};
		var chart = new google.visualization.LineChart(document.getElementById('chart-div'));

		chart.draw(data, options);	
	}
	
	function changeChart(dura){
		if(dura=='week'){
			duration = 'week';
		}else if(dura =='day'){
			duration = 'day';
		}else if(dura == 'month'){
			duration = 'month';
		}
		drawChart();
	}

	$(function() {

		/* index page animation start */

		$('.adminmenus > div').on('click', function() {
			var way = $(this).attr('class');
			if (way == "inquire") {
				self.location = '/admin/listInquire';
			} else if (way == "spot") {
				self.location = '/admin/listSpot';
			} else if (way == "graph") {
				self.location = '/admin/listGraph?duration=day';
			} else if (way == "userList") {
				self.location = '/admin/listUser';
			} else if (way == "userLog") {
				self.location = '/admin/listLog';
			}
		})

		/* index page animation end */
		$('.duration').on('change', function(){
			var du = changeChart($(this).val());
			if(du=='day'){
				$('.graph-title > span').text('일간');
			}else if(du=='week'){
				$('.graph-title > span').text('주간');
			}else if(du=='month'){
				$('.graph-title > span').text('월간');
			}
		})

	});
</script>
<body>

	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<div class="adminmenus">
				<div class="userList">회원목록</div>
				<div class="graph">통계내역</div>
				<div class="spot">백과관리</div>
				<div class="inquire">문의관리</div>
			</div>
		</div>
		<!-- /.container-fluid -->
	</nav>

	<div class="container">
		<div class="row graph-top-box">
			<div class="col-md-8 graph-title"><span>일간</span> 유저 활동 기록</div>
			<div class="col-md-4 selectbox">
				<select name="duration" class="duration" aling="left">
					<option value="day">일간</option>
					<option value="week">주간</option>
					<option value="month">월간</option>
				</select>
			</div>
			<div class="col-md-12 graphbox">
				<div id="chart-div"></div>
			</div>
		</div>
	</div>
</body>
</html>