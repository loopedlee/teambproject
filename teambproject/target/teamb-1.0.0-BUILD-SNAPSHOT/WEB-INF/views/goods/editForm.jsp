<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
  function check(ff){
	  if(ff.imgFile.value==null){
		  ff.img.value=${img};
	  }else{
		  ff.img.value=ff.imgFile.value;
	  }
	  ff.submit();
  }
</script>
</head>
<body>
<h2>상품 수정 폼</h2>
<%-- name,detail,img,type,price,stock --%>
<form action="${ctxpath}/goods/editPro.do" name="editForm" method="post" enctype="multipart/form-data" onSubmit="return check(this)">
  <table>
    <tr>
      <td>상품 이름</td>
      <td>
        <input type="hidden" id="id" name="id" value="${goodsDto.id}">
        <input type="text" id="name" name="name" size="30" value="${goodsDto.name}">
      </td>
    </tr>
  
    <tr>
      <td>상품 설명</td>
      <td><textarea id="detail" name="detail" cols="50" rows="10">${goodsDto.detail}</textarea></td>
    </tr>
  
    <tr>
      <td>상품 이미지</td>
      <td>
        <table border="1">
          <tr>
            <td>
              <input type="file" name="imgFile" id="imgFile">
              <input type="hidden" name="img" id="img" value="${img}">
            </td>
          </tr>
        </table>
      </td>
    </tr>
    
    <tr>
      <td>상품 타입</td>
      <td>
        <select name="type">
          <option value="${goodsDto.type}">
          <c:choose>
            <c:when test="${goodsDto.type==1}">꽃다발</c:when>
            <c:when test="${goodsDto.type==2}">꽃바구니</c:when>
            <c:when test="${goodsDto.type==3}">축하화환</c:when>
            <c:when test="${goodsDto.type==4}">근조화환</c:when>
            <c:otherwise>
            undefined
            </c:otherwise>
          </c:choose>
          </option>
          <option value="1">꽃다발</option>
          <option value="2">꽃바구니</option>
          <option value="3">축하화환</option>
          <option value="4">근조화환</option>
        </select>
      </td>
    </tr>
    
    <tr>
      <td>상품 가격</td>
      <td><input type="text" id="price" name="price" size="30" value="${goodsDto.price}">원</td>
    </tr>
    
    <tr>
      <td>상품 재고</td>
      <td><input type="text" id="stock" name="stock" size="30" value="${goodsDto.stock}">개</td>
    </tr>
    <tr>
      <td colspan="2" align="center">
        <input type="submit" value="상품수정">
      </td>
    </tr>
  </table>
</form>

</body>
</html>