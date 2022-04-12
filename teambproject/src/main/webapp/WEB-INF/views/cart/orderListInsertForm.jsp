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
  <form name="insertOrder" action="orderListInsertPro.do">
    <h2>상품 상세</h2>
    <table class="table table-hover">
      <tr>
        <td>상품 이름</td>
        <td>${gName}<input type="hidden" value="${gid}" name="gid" id="gid"></td>
      </tr>
      
      <tr>
        <td>상품 이미지</td>
        <td>
          <input type="hidden" value="${img}" name="img" id="img">
          <img src="${ctxpath}/resources/flowerimgs/${img}" width="100" height="100">
        </td>
      </tr>
     </table>
    <h2> 입력 정보 </h2> 
     <table class="table table-hover">
      <tr>
        <td>이름</td>
        <td>
          <input type="text" value="${name}" name="name" id="name" size="15">          
          
          <input type="hidden" value="${uid}" name="uid" id="uid">
        </td>
      </tr>
      
      <tr>
        <td>전화번호</td>
        <td><input type="text" value="${tel}" name="tel" id="tel"></td>
      </tr>
      
      <tr>
        <td>주소</td>
        <td><input type="text" value="${zipcode}" name="zipcode" id="zipcode"></td>
      </tr>
      
      <tr>
        <td>상세주소</td>
        <td><input type="text" value="${address}" name="address" id="address"></td>
      </tr>
      
      <tr>
        <td>주문할 갯수</td>
        <td><input type="text" value="${stock}" name="stock" id="stock" readOnly></td>
      </tr>  
      
      <tr>
        <td>가격</td>
        <td><input type="text" value="${price*stock}" name="price" id="price" readOnly></td>
      </tr>
      
      <tr>
        <td colspan="2" align="center">
          <input type="submit" value="구매">
          <input type="button" value="취소" onClick="history.back(); return false;" >
        </td>
      </tr>
    </table>
  </form>
</body>
</html>