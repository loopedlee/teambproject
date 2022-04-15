<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
 .aoption:link { color: black; text-decoration: none;}
 .aoption:visited { color: black; text-decoration: none;}
 .aoption:hover { color: blue; text-decoration: underline;}
</style>
</head>
<body>
<c:if test="${sessionScope.grade eq 1}">
<a href="${ctxpath}/goods/writeForm.do">글쓰기</a>
</c:if>
  <form name="searchForm" method="get" action="${ctxpath}/goods/goodsList.do">
    <table style="margin-left: 875px;">
      <tr>
        <td align="right">
          <select name="keyField">
            <option value="1">꽃다발</option>
            <option value="2">꽃바구니</option>
            <option value="3">축하화환</option>
            <option value="4">근조화환</option>
          </select>
          
          <input type="text" name="keyWord">
          <input type="submit" value="검색">
        </td>
      </tr>
    </table>
  </form>
  
  <h2>상품 목록 표 [등록된 상품 수 : ${count}]</h2>
<div class="row row-cols-1 row-cols-md-3 g-4">
  <c:forEach var="goodsDto" items="${list}" varStatus="status">
  <div class="col">
  <div class="card">
  <a href="${ctxpath}/goods/content.do?id=${goodsDto.id}">
  <%-- <a href="${ctxpath}/goods/content.do?id=${goodsDto.id}&pageNum=${currentPage}">--%>
  <img src="${ctxpath}/resources/flowerimgs/${goodsDto.img}" class="card-img-top" alt="..." style="max-height: 420px;">
  </a>
  <div class="card-body">
    <p class="card-text"><c:choose>
                <c:when test="${goodsDto.type==1}">[꽃다발]</c:when>
                <c:when test="${goodsDto.type==2}">[꽃바구니]</c:when>
                <c:when test="${goodsDto.type==3}">[축하화환]</c:when>
                <c:when test="${goodsDto.type==4}">[근조화환]</c:when>
                <c:otherwise>
                  undefined
                </c:otherwise>
              </c:choose></p>
              <p><a class="aoption" href="${ctxpath}/goods/content.do?id=${goodsDto.id}">${goodsDto.name}</a></p>
              <%--<p><a class="aoption" href="${ctxpath}/goods/content.do?id=${goodsDto.id}&pageNum=${currentPage}">${goodsDto.name}</a></p> --%>
  </div>
</div>
</div>
</c:forEach>
</div>
  <%--  <table>
  <c:forEach var="goodsDto" items="${list}" varStatus="status">
    <c:if test="${status.index%4==0}">
      <tr>
      </tr>
    </c:if>
    <td>
      <table border="1" width="320" height="450">
        <tr>
          <td height="30" colspan="2" align="center" style="border:thick double #32a1ce;">
            <h5><a href="${ctxpath}/goods/content.do?id=${goodsDto.id}&pageNum=${currentPage}">${goodsDto.name}</a></h5>
          </td>
        </tr>
            
        <tr>
          <td colspan="2" align="center">
            <c:if test="${goodsDto.stock>0}">
              <a href="${ctxpath}/goods/content.do?id=${goodsDto.id}&pageNum=${currentPage}">
                <img src="${ctxpath}/resources/flowerimgs/${goodsDto.img}" width="150" height="150">
              </a>
              </c:if>
              <c:if test="${goodsDto.stock==0}">
                ${goodsDto.name}은 품절입니다.
              </c:if>
              </td>
            </tr>
            
            <tr>
              <td>타입</td>
              <td>
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
              <td>가격</td>
              <td>${goodsDto.price}원</td>
            </tr>
            
            <tr>
              <td>등록날짜</td>
              <td>${goodsDto.regdate}</td>
            </tr>
            
            <tr>
              <td>판매수</td>
              <td>${goodsDto.sales}개</td>
            </tr>
            
            <tr>
              <td>조회수</td>
              <td>${goodsDto.readcount}</td>
            </tr>
            
            <tr>
              <td>별점</td>
              <td>${goodsDto.rate}</td>
            </tr>
            
            <tr>
              <td>상품재고</td>
              <td>
                <c:if test="${goodsDto.stock>0}">
                  ${goodsDto.stock}
                </c:if>
                <c:if test="${goodsDto.stock==0}">
                                 품절
                </c:if>
              </td>
            </tr>
          </table>
       </c:forEach>
    </table>
-->
  <%--블럭 페이지 처리 --%>
  <table style="margin:auto;">
    <tr>
      <td align="center">
        <!-- 에러방지 -->
        <c:if test="${endPage>pageCount}">
          <c:set var="endPage" value="${pageCount}"/>
        </c:if>
        
        <!-- 이전블럭 -->
        <c:if test="${startPage>10}">
          <a href="${ctxpath}/goods/goodsList.do?pageNum=${startPage-10}">[이전블럭]</a>
        </c:if>
        
        <!-- 페이지처리 -->
        <c:forEach var="i" begin="${startPage}" end="${endPage}">
          <a href="${ctxpath}/goods/goodsList.do?pageNum=${i}"><font size="5">[${i}]</font></a>
        </c:forEach>
        
        <!-- 다음블럭 -->
        <c:if test="${endPage>pageCount}">
          <a href="${ctxpath}/goods/goodsList.do?pageNum=${startPage+10}">[다음블럭]</a>
        </c:if>
      </td>
    </tr>
  </table>
</body>
</html>