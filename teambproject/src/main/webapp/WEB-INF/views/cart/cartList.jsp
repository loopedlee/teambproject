<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>내 장바구니 목록</h2>
<table class="table table-hover" style="background-color:skyblue; table-layout:fixed;">
  <tr>
    <td>상품 ID</td>
    <td>추가한 날짜</td>
    <td>상품 이름</td>
    <td>상품 이미지</td>
    <td>상품 가격</td>
    <td>구매할 수량</td>
    <td></td>
  </tr>
</table>
<c:forEach var="cartDto" items="${list}" varStatus="status">
<form action="${ctxpath}/cart/cartUpdate.do" method="post">
  <table class="table table-hover" style="table-layout:fixed;" >
    <tr>
      <td>${cartDto.id}
        <input type="hidden" name="gid" id="gid" value="${cartDto.id}">
        <input type="hidden" name="uid" id="uid" value="${sessionScope.id}">
      </td>
      <td>${cartDto.date}</td>
      <td><a href="${ctxpath}/goods/content.do?id=${cartDto.id}">${cartDto.name}</a></td>
      <td><a href="${ctxpath}/goods/content.do?id=${cartDto.id}"><img src="${ctxpath}/resources/flowerimgs/${cartDto.img}" width="100" height="100"></a></td>
      <td>${cartDto.price}</td>
      <td><input type="text" name="stock" id="stock" value="${cartDto.stock}" size="2">개</td>
      <td>
        <input type="submit" value="수정">  
        <input type="button" value="삭제" onClick="location.href='${ctxpath}/cart/cartDelete.do?uid=${cartDto.uid}&gid=${cartDto.gid}'">
        <input type="button" value="구매" onClick="location.href='${ctxpath}/cart/orderListInsertForm.do?gid=${cartDto.gid}'">
      </td>
    </tr>
  </table>
</form>
<c:set var="allprice" value="${allprice + (cartDto.price * cartDto.stock)}"/>
</c:forEach>
<table class="table table-hover" style="table-layout:fixed;" >
  <tr align="right">
    <td>전체 가격 합계 : ${allprice}원</td>
  </tr>
</table>
</body>
</html>