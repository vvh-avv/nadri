<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html lang="ko">
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
<title>너나들이 통합검색결과</title>
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
<style>
	#map {
		height: 500px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
    }
    .place-info{
    	margin-top:1vh;
    	width:100%;
    	hegiht:200px;
    }
    .contents{
    	margin: 1vh 0vh;
    }
    .insta-box{
    	margin-bottom:1vh;
    }
    
    .section-title{
    	margin-top:5vh;
    }

</style>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				
				<div class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="glyphicon glyphicon-user"></span>
				</div>
				<div class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-2"
					aria-expanded="false">
					<span class="glyphicon glyphicon-search"></span>
				</div>
				<a class="navbar-brand" href="#">너나들이</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			
			<div class="row" style="display:flex; justify-content:flex-end;">
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
					<ul class="nav navbar-nav">
						<li>
							<form class="navbar-form" action="/searchLog/listSearchLog" method="post" style="display:inline-block">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="Search" name="searchKeyword">
								</div>
								<button type="submit" class="btn btn-default">Submit</button>
							</form>
						</li>
					</ul>
				</div>
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#"><span class="glyphicon glyphicon-send"></span></a></li>
						<li><a href="#"><span
								class="glyphicon glyphicon-envelope"></span></a></li>
						<li><a href="#"><span class="glyphicon glyphicon-bell"></span></a></li>
						<li><a href="#"></a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">
							<span class="glyphicon glyphicon-user"></span></a>
							<ul class="dropdown-menu">
								<li><a href="#">Action</a></li>
								<li><a href="#">Another action</a></li>
								<li><a href="#">Something else here</a></li>
								<li role="separator" class="divider"></li>
								<li><a href="#">Separated link</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
		</div>
		<!-- /.container-fluid -->
	</nav>

</body>
</html>