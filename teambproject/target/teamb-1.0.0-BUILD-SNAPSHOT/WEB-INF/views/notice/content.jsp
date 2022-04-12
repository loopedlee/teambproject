<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
  h2{
  text-align: center;
  }
  table{
  margin: auto;
  border: 1px solid black;
  width: 50%;
  border-collapse:collapse;
  }
  .line{
  border:1px solid lightgray;
  }
 
  .line2{
  border:0px solid lightgray;
  }
  </style>
</head>
<body>
 <h2><font color="#6799FF"><b>내용보기</b></font></h2>
  <table class="line2">
    <tr>
      <td align="right">
        <%--  <c:if test="${adminID != null}">--%>
          <a href="${ctxpath}/notice/editForm.do?id=${id}&pageNum=${pageNum}">글수정하기🖋</a>&nbsp;
          <a href="${ctxpath}/notice/delete.do?id=${id}&pageNum=${pageNum}">글삭제하기✂</a>&nbsp;
          <a href="${ctxpath}/notice/insertForm.do">글쓰기✒</a>&nbsp;
    <%--   </c:if>--%>
      
          <a href="${ctxpath}/notice/list.do?pageNum=${pageNum}">목록가기🌈</a>
      </td>
    </tr>
  </table>
 
  <table border="1">

   <tr>
      <td class="line" bgcolor="#B2CCFF">작성자</td>
      <td class="line">${noticeDto.writer}</td>
      
      <td class="line" bgcolor="#B2CCFF">작성일</td>
      <td class="line">${noticeDto.regdate}</td>
    </tr>


    <tr>
      <td class="line" bgcolor="#B2CCFF">글제목</td>
      <td class="line" colspan="3">
        ${noticeDto.subject}
      </td>
    </tr>
    
    <tr>
      <td class="line" bgcolor="#B2CCFF">글내용</td>
      <td class="line" colspan="3" height="150">
        <pre>${noticeDto.content}</pre>
      </td>
    </tr>
  </table>
</body>
</html>