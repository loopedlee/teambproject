<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../constants.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h2 {
text-align: center;
}

table {
margin: auto;
border: 1px solid black;
}
</style>
</head>
<body>
<h2>FAQ</h2>
   <c:if test="${sessionScope.grade eq 1}">
    <table border="0" class="table table-hover">
      <tr>
        <td align="right" colspan="4">
          <a href="${ctxpath}/faq/insertForm.do">새글쓰기</a>
        </td>
      </tr>
    </table>
    </c:if>
    
    <table border="1" width="80%" class="table table-hover">
    
    <tr align="center">
      <td>글쓴이</td>
      <td>글제목</td>
      <td>글내용</td>
      <td>날짜</td>
	  
    </tr>
    
    <c:forEach var="FaqDto" items="${list}">
      <tr align="center">
        <td>${FaqDto.writer}</td>
        <%-- 제목을 클릭하면 글내용 보기로 이동하기 content.do?num${} --%>
        <td>
        <a href="${ctxpath}/faq/content.do?num=${FaqDto.id}">
        ${FaqDto.subject}
        </a>
        </td>
        
        <td>${FaqDto.content}</td>
        <td>
        <fmt:formatDate value="${FaqDto.regdate }" type="date"/>
        <fmt:formatDate value="${FaqDto.regdate }" pattern="yyyy/MM/dd"/>
        </td>
      </tr>
    </c:forEach>
  </table>
</body>
</html>