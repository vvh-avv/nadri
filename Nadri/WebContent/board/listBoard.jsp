<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>게시물 목록</title>

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
<script src="/javascript/toolbar.js"></script>

<!-- flexslider CDN (슬라이드쇼) -->
<link rel="stylesheet" href="/css/flexslider.css" type="text/css">
<script src="/javascript/flexslider.js"></script>

<style>
	/*.ListBody{
	  position : relative;
	}*/
	.gotoBoard {
	  position: absolute;
	  bottom: 10%;
	  right: 10%;
	  width: 50px;
	  height: 50px;
	  z-index:999;
	}
</style>

<script>
$(function(){
	
})
</script>
</head>

<body>
	
	<img class="gotoBoard" src="/images/board/gotoBoard.png">
	
	<div class="container ListBody">
		<h2>게시물 목록화면입니다..</h2>
		<pre>
		1
		2
		3
		4
		2
		5
		5
		3
		66
		6
		46
		5
		4563
		45
		2
		42
		42
		42
		4
		2
		6
		46
		5
		4563
		45
		2
		42
		42
		42
		4
		2
		6
		46
		5
		4563
		45
		2
		42
		42
		42
		4
		2
		6
		46
		5
		4563
		45
		2
		42
		42
		42
		4
		2
		</pre>
	</div>
</body>
</html>