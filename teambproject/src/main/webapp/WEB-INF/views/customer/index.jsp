<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/jquery-migrate-3.4.0.js"></script>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<div style="margin-bottom: 3rem;">
<form method="get" action="${ctxpath}/customer/ctsearch.do">
<input type="text" class="form-control" placeholder="검색어를 입력해주세요." style="float: left; width: 30rem;" name="keyword">
<input type="submit" name="search" class="btn btn-outline-secondary" value="검색">
</form>
<c:if test="${sessionScope.grade eq 0 or sessionScope.id eq null}">
<a href="${ctxpath}/customer/insertct.do" style="float: right;">
	<input type="button" class="btn btn-outline-success" value="문의글 작성">
</a>
</c:if>
</div>
<table class="table" style="text-align: center;">
<thead>
<tr>
	<td>게시물번호</td>
	<td>문의글</td>
	<td>작성자</td>
	<td>조회수</td>
	<td>작성일</td>
</tr>
</thead>
<tbody id="list">
<c:forEach var="view" items="${list}">
<tr>
<td>${view.id}</td>
<td><a href="${ctxpath}/customer/cdetail.do/${view.id}">${view.subject}</a><span>(${view.comment})</span></td>
<td>${view.writer}</td>
<td>${view.readcount}</td>
<td>${view.regdate}</td>
</tr>
</c:forEach>
</tbody>
</table>
<c:if test="${count>0}">      
<%--에러 방지 --%>
<c:if test="${endPage>pageCount}">
   <c:set var="endPage" value="${pageCount}"/>
</c:if>
<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
    <li class="page-item">
    <c:if test="${startPage>10}">
      <a class="page-link" href="${ctxpath}/customer/customer.do?pageNum=${startPage-10}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </c:if>
    <c:if test="${startPage>10} && ${keyword ne null}">
      <a class="page-link" href="${ctxpath}/customer/customer.do?pageNum=${startPage-10}?keyword=${keyword}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </c:if>
    </li>
    <c:forEach var="i" begin="${startPage}" end="${endPage}">
    <c:if test="${keyword eq null}">
    <li class="page-item"><a class="page-link" href="${ctxpath}/customer/customer.do?pageNum=${i}">${i}</a></li>
    </c:if>
    <c:if test="${keyword ne null}">
    	<li class="page-item"><a class="page-link" href="${ctxpath}/customer/customer.do?pageNum=${i}?keyword=${keyword}">${i}</a></li>
    </c:if>
    </c:forEach>
    <c:if test="${endPage<pageCount}">
    <li class="page-item">
      <a class="page-link" href="${ctxpath}/customer/customer.do?pageNum=${startPage+10}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
    </c:if>
    <c:if test="${endPage<pageCount} && ${keyword ne null}">
    <li class="page-item">
      <a class="page-link" href="${ctxpath}/customer/customer.do?pageNum=${startPage+10}?keyword=${keyword}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
    </c:if>
  </ul>
</nav>
</c:if>
</body>
</html>