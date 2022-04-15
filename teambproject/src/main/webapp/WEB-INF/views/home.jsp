<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<html>
<head>
	<title>Home</title>
</head>
<body>

<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-light">
    <div class="col-md-5 p-lg-5 mx-auto my-5">
      <h1 class="display-4 fw-normal">Flower Farm</h1>
      <p class="lead fw-normal">Welcome</p>
    </div>
    <div class="product-device shadow-sm d-none d-md-block"></div>
    <div class="product-device product-device-2 shadow-sm d-none d-md-block"></div>
  </div>
<div class="container">
	<div class="row">		
		<div class="col">
			<h2>추천순</h2>
			<br>
		<div class="card-group">
			<c:forEach var="rate" items="${rate}">
			<div class="card" style="width: 18rem; margin-right: 1rem;">
				<a href="${ctxpath}/goods/content.do?id=${rate.id}">
  				<img src="${ctxpath}/resources/flowerimgs/${rate.img}" class="card-img-top" alt="..." style="max-height: 250px;">
  				</a>
  			<div class="card-body">
  			 <p class="card-text"><c:choose>
                <c:when test="${rate.type==1}">[꽃다발]</c:when>
                <c:when test="${rate.type==2}">[꽃바구니]</c:when>
                <c:when test="${rate.type==3}">[축하화환]</c:when>
                <c:when test="${rate.type==4}">[근조화환]</c:when>
                <c:otherwise>
                  undefined
                </c:otherwise>
              </c:choose></p>
  				<p class="card-text">${rate.name}</p>	
  			</div>
			</div>
			</c:forEach>
		</div>
		</div>
	</div>
	<div class="row" style="margin-top: 3rem;">
		<div class="col">
			<h2>조회순</h2><br>
			<div class="card-group">
			<c:forEach var="read" items="${read}">
			<div class="card" style="width: 18rem; margin-right: 1rem;">
				<a href="${ctxpath}/goods/content.do?id=${read.id}">
  				<img src="${ctxpath}/resources/flowerimgs/${read.img}" class="card-img-top" alt="..." style="max-height: 250px;">
  				</a>
  			<div class="card-body">
  				 <p class="card-text"><c:choose>
                <c:when test="${read.type==1}">[꽃다발]</c:when>
                <c:when test="${read.type==2}">[꽃바구니]</c:when>
                <c:when test="${read.type==3}">[축하화환]</c:when>
                <c:when test="${read.type==4}">[근조화환]</c:when>
                <c:otherwise>
                  undefined
                </c:otherwise>
              </c:choose></p>
  				<p class="card-text">${read.name}</p>
  			</div>
			</div>
			</c:forEach>
		</div>
		</div>
	</div>
	<div class="row" style="margin-top: 3rem;">
		<div class="col">
			<h2>판매량순</h2><br>
			<div class="card-group">
			<c:forEach var="sales" items="${sales}">
			<div class="card" style="width: 18rem; margin-right: 1rem;">
				<a href="${ctxpath}/goods/content.do?id=${sales.id}">
  				<img src="${ctxpath}/resources/flowerimgs/${sales.img}" class="card-img-top" alt="..." style="max-height: 250px;">
  				</a>
  			<div class="card-body">
  				<p class="card-text"><c:choose>
                <c:when test="${sales.type==1}">[꽃다발]</c:when>
                <c:when test="${sales.type==2}">[꽃바구니]</c:when>
                <c:when test="${sales.type==3}">[축하화환]</c:when>
                <c:when test="${sales.type==4}">[근조화환]</c:when>
                <c:otherwise>
                  undefined
                </c:otherwise>
              </c:choose></p>
  				<p class="card-text">${sales.name}</p>
  			</div>
			</div>
			</c:forEach>
		</div>
		</div>
	</div>
</div>
</body>
</html>
