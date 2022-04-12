<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <style type="text/css">
  h2{text-align: center;}
  table{margin: auto; border: 1px solid black; width: 70%;}
  </style>
  
  <script type="text/javascript">
  function rateUp(){
  	location.href="${ctxpath}/goods/rateUp.do?id=${id}&pageNum=${pageNum}";
  }
  </script>
</head>
<body>
  <h2>글내용 보기</h2>
  
  <table border="1">
    <tr>
      <td align="right">
        <a href="${ctxpath}/goods/editForm.do?id=${id}&pageNum=${pageNum}">글수정</a>&nbsp;
        <a href="${ctxpath}/goods/delete.do?id=${id}&pageNum=${pageNum}">글삭제</a>&nbsp;
        <a href="${ctxpath}/goods/writeForm.do">글쓰기</a>&nbsp;
        <a href="${ctxpath}/goods/goodsList.do?pageNum=${pageNum}">글목록</a>&nbsp;
      </td>
    </tr>
  </table>
  
  <table border="1">
    <tr>
      <td>글번호</td>
      <td>${goodsDto.id}
        <input type="hidden" value="${goodsDto.id}" id="id" name="id">
      </td>
    </tr>

    <tr>
      <td colspan="4" align="center">
        <img src="${ctxpath}/resources/flowerimgs/${goodsDto.img}" width="400" height="400">
      </td>
    </tr>

    <tr>
      <td>상품 이름</td>
      <td colspan="3">
        ${goodsDto.name}
      </td>
    </tr>

    <tr>
      <td>상품 설명</td>
      <td colspan="3">
        ${goodsDto.detail}
      </td>
    </tr>
    
    <tr>
      <td>상품 가격</td>
      <td>${goodsDto.price}</td>
    </tr>
    <tr>
      <td>상품 재고</td>
      <td>${goodsDto.stock}</td>
    </tr>
    
    <tr>
      <td>타입</td>
      <td colspan="3">
        <c:choose>
          <c:when test="${goodsDto.type==1}">꽃다발</c:when>
          <c:when test="${goodsDto.type==2}">꽃바구니</c:when>
          <c:when test="${goodsDto.type==3}">축하화환</c:when>
          <c:when test="${goodsDto.type==4}">근조화환</c:when>
          <c:otherwise>
            undefined
          </c:otherwise>
        </c:choose>
       </td>
     </tr>
     
    <tr>
      <td>조회수</td>
      <td>${goodsDto.readcount}</td>
    </tr>
    
    <tr>
      <td>추천수</td>
      <td>${goodsDto.rate}</td>
    </tr>
    
    <tr align="center">
      <td colspan="2"><button type="button" onClick="rateUp()">게시물 추천!</button></td>
    </tr>
    
  </table>
</body>
</html>