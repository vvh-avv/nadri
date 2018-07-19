<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="/images/common/favicon.ico">

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Bootstrap CDN -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<!-- common.js / common.css CDN -->
<script src="/javascript/common.js"></script>
<link rel="stylesheet" href="/css/common.css">
<!-- toolbar.js CDN -->
<script src="/javascript/toolbar.js"></script>
<!-- Import materialize.min.js -->
<script type="text/javascript" src="/javascript/materialize.min.js"></script>
<link rel="stylesheet" href="/css/materialize.min.css">
<!-- TimeLine에 관한 라인입니다. -->
<script type="text/javascript" src="/javascript/timelinemain.js"></script>
<link rel="stylesheet" href="/css/timelinestyle.css">
<!-- D-day를 넣기위한 라인입니다. -->
<script type="text/javascript" src="/javascript/downCount.js"></script>
<style>
@font-face {
	font-family: 'seoul';
	src: url('/css/fonts/seoulhangangjangm.eot');
	src: url('/css/fonts/seoulhangangjangm.eot?#iefix')
		format('embedded-opentype'), url('/css/fonts/seoulhangangjangm.woff2')
		format('woff2'), url('/css/fonts/seoulhangangjangm.woff')
		format('woff'), url('/css/fonts/seoulhangangjangm.ttf')
		format('truetype'),
		url('/css/fonts/seoulhangangjangm.svg#seoul-hangang-jang-m')
		format('svg');
	font-weight: normal;
	font-style: normal;
}

ul.countdown {
	list-style: none;
	margin: 75px 0;
	padding: 0;
	display: block;
	text-align: center;
}

ul.countdown li {
	display: inline-block;
}

ul.countdown li span {
	font-size: 80px;
	font-weight: 300;
	line-height: 80px;
}

ul.countdown li.seperator {
	font-size: 80px;
	line-height: 70px;
	vertical-align: top;
}

ul.countdown li p {
	color: #a7abb1;
	font-size: 14px;
}
</style>
<script>
	$(function() {
		$('.countdown').downCount({
			date : '${schedule.scheduleDate} ${schedule.startHour}',
			offset : +10
		});
	});
</script>
${schedule} ${waypoint}
</head>
<body>
	<header>
		<div class="cd-nugget-info">
			<span>
				<style type="text/css">
.cd-nugget-info-arrow {
	fill: #383838;
}
</style> <polygon class="cd-nugget-info-arrow"
					points="15,7 4.4,7 8.4,3 7,1.6 0.6,8 0.6,8 0.6,8 7,14.4 8.4,13 4.4,9 15,9 " />
				</svg>
			</span>
			<p id="scheduleTitle">${schedule.scheduleTitle}</p>
		</div>
		<!-- cd-nugget-info -->
	</header>
	<ul class="countdown">
		<li><span class="days">00</span>
			<p class="days_ref">days</p></li>
		<li class="seperator">:</li>
		<li><span class="hours">00</span>
			<p class="hours_ref">hours</p></li>
		<li class="seperator">:</li>
		<li><span class="minutes">00</span>
			<p class="minutes_ref">minutes</p></li>
		<li class="seperator">:</li>
		<li><span class="seconds">00</span>
			<p class="seconds_ref">seconds</p></li>
	</ul>

	<section class="cd-timeline js-cd-timeline">
		<div class="cd-timeline__container">
		${schedule.scheduleTitle}
			<c:set var="i" value="0" />
			<c:forEach var="waypoint" items="${waypoint}">
				<c:set var="i" value="${i+1}" />
				<!-- cd-timeline__block -->
				<div class="cd-timeline__block js-cd-block">
					<div class="cd-timeline__img cd-timeline__img--movie js-cd-img">
						<img src="/images/spot/icon/cd-icon-movie.svg" alt="Movie">
					</div>
					<!-- cd-timeline__img -->

					<div class="cd-timeline__content js-cd-content">
						<h2>Title of section 2</h2>
						<p>
							<!-- 이부분에 경유지가 올 자리입니다 -->
							<c:forTokens items="${waypoint.wayPointNav}" delims="#" var="sel">
						       * : ${sel}<br>
						   </c:forTokens>
						   </p>
						<a href="#0" class="cd-timeline__read-more">Read more</a> <span
							class="cd-timeline__date">Jan 18</span>
					</div>
					<!-- cd-timeline__content -->
				</div>
				<!-- cd-timeline__block -->
				
				<div class="cd-timeline__block js-cd-block">
					<div class="cd-timeline__img cd-timeline__img--picture js-cd-img">
						<img src="/images/spot/icon/start.png" alt="Picture">
					</div>
					<!-- cd-timeline__img -->
					<div class="cd-timeline__content js-cd-content">
						<h2>Title of section 1</h2>
						<p>
						 </p>
						<a href="#0" class="cd-timeline__read-more">Read more</a> <span
							class="cd-timeline__date">Jan 14</span>
					</div>
					<!-- cd-timeline__content -->
				</div>
				<!-- cd-timeline__block -->
				
				
		</c:forEach>

		</div>
		<!-- 여기안에다가 집어넣으면 몇개더 들어갑니다! -->



	</section>
	<!-- cd-timeline -->

	<script type="text/javascript" src="/javascript/timelinemain.js"></script>
</body>
</html>