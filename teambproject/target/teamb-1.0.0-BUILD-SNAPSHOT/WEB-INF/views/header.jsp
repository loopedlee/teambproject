<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<a href="/teamb" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
	<span class="fs-4">제목 가제</span>
</a>
<ul class="nav nav-pills">
	<c:if test="${empty sessionScope.id}">
	<li class="nav-item"><a href="#" class="nav-link">로그인</a></li>
	</c:if>
	<c:if test="${not empty sessionScope.id}">
	<li class="nav-item"><span style="display: block; padding: 0.5rem 1rem;">${sessionScope.id}님 안녕하세요.</span></li>
	<li class="nav-item"><a href="#" class="nav-link">로그아웃</a></li>
	<li class="nav-item"><a href="#" class="nav-link">내정보수정</a></li>
	</c:if>
	<li class="nav-item"><a href="${ctxpath}/goods/goodsList.do" class="nav-link">상품목록</a></li>
	<li class="nav-item"><a href="${ctxpath}/notice/list.do" class="nav-link">공지사항</a></li>
	<li class="nav-item"><a href="${ctxpath}/customer.do" class="nav-link">고객센터</a></li>
	<li class="nav-item"><a href="#" class="nav-link">FAQ</a></li>
</ul>