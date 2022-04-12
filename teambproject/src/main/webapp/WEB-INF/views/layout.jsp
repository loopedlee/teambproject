<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TeamB Project</title>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style type="text/css">
html, body {
  height: 100vh;
}
.warp {
	min-height:100vh;
	position: relative;
}

footer {
	/*position: absolute;*/
	bottom: 0;
	left: 0;
	right: 0;
}
</style>
</head>
<body>
<div class="container warp">
	<header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
		<tiles:insertAttribute name="header"/>
	</header>
	<div class="row">
		<div class="col">
		<tiles:insertAttribute name="content"/>
		</div>
	</div>
	<footer class="py-3 my-4">
		<tiles:insertAttribute name="footer"/>
	</footer>
</div>
</body>
</html>