<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../constants.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>editForm.jsp</title>


<style>
table {
margin: auto;
width: 60%;
background-color: ivory;
}
</style>


</head>
<body>
<h2>글수정 폼</h2>
<form method="post" action="${ctxpath }/faq/editPro.do">
  <table border="1">
    <tr>
      <td>이름</td>
      <td>
      <input type="text" name="writer" id="writer" value="${FaqDto.writer}">
      <input type="hidden" name="id" value="${FaqDto.id}">
      </td>
      
    </tr>
     
    <tr>
      <td>글제목</td>
      <td><input type="text" name="subject" id="subject" value="${FaqDto.subject}"></td>
    </tr>
     
    <tr>
      <td>글내용</td>
      <td>
      <textarea name="content" id="content" rows="10" cols="50">${FaqDto.content}</textarea>
      </td>
    </tr>
     
    <tr>
      <td colspan="2" align="center">
		<input type="submit" value="글수정">      
		<a href="${ctxpath }/faq/list.do">리스트</a>
      </td>
    </tr>
    
  </table>
</form>

</body>
</html>