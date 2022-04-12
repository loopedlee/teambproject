<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../constants.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>content.jsp</title>

<style>
h2 { 
text-align: center;
}

table {
margin: auto;
border: 1px solid black;
width: 60%;
}
</style>

</head>
<body>
<h2>FAQ 내용보기</h2>
<table>
  <tr>
    <td align="right">
       <a href="${ctxpath}/faq/editForm.do?num=${FaqDto.id}">글수정</a>&nbsp;
       <a href="${ctxpath}/faq/delete.do?num=${FaqDto.id}">글삭제</a>&nbsp;
       <a href="${ctxpath}/faq/insertForm.do">새글쓰기</a>&nbsp;
       <a href="${ctxpath}/faq/list.do?num=${FaqDto.id}">리스트</a>&nbsp;
    </td>
  </tr>
</table>

<table border="1">
  <tr>
    <td>글번호</td>
    <td>${FaqDto.id}</td>
  </tr>
  
  <tr>
    <td>작성자</td>
    <td>${FaqDto.writer }</td>
   
    <td>작성일</td>
    <td>${FaqDto.regdate }</td>
  </tr>
  
  <tr>
    <td>글제목</td>
    <td colspan="3">
      ${FaqDto.subject }
    </td>
  </tr>
  
  <tr>
    <td>글내용</td>
    <td colspan="3">
      ${FaqDto.content }
    </td>
  </tr>
  
</table>

</body>
</html>