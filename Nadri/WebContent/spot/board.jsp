<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!-- Bootstrap CDN -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- Mansory CDN -->
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
    <meta charset="utf-8">
    <title>Masonry</title>
    <style>
    * { margin : 0px; padding : 0px;}
      .item {
        width: 100px;
        height: 100px;
        float: left;
        margin: 5px;
        border-radius :10px;
        background-color: #2195c9;
      }
      .big { width : 210px; height:430px;}
      .normal { width : 210px; height:210px;}
      .small { width : 100px ; height:100px;}
    </style>
  <script>
   $(document).ready(function () {
	   $('#masonry-container').masonry({
		   itemSelector: '.item',
		   columWidth : 110
	   });
   });
    </script>
  </head>
  <body>
    <div id="masonry-container">
    <div class="item small">Dolor</div>
      <div class="item big"></div>
      <div class="item normal">Ipsum</div>
         <div class="item small">Dolor</div>
        <div class="item small">Dolor</div>
         <div class="item small">Dolor</div>
         <div class="item normal">Ipsum</div>
      <div class="item normal">Ipsum</div>
             <div class="item small">Dolor</div>
        <div class="item small">Dolor</div>
         <div class="item small">Dolor</div>
    </div>

  </body>
</html>