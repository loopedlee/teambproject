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
  }
   .line{
  border: 1px solid lightgray;
  left: 50%;
  top: 50%;
  }
  
  .line2{
  border: 1px solid white;
  }
  </style>
</head>
<body>

  <h2><font color="#6799FF"><b>수정하기</b></font></h2>
  <form method="post" action="${ctxpath}/notice/editPro.do">
    <table border="1" class="line">
      <tr>
        <td class="line" align="center" bgcolor="#B2CCFF">이름</td>
        <td>
          <input type="text" name="writer" id="writer" value="${noticeDto.writer}">
          <input type="hidden" name="id" value="${noticeDto.id}">
        </td>
      </tr>
      
      <tr>
        <td class="line" align="center" bgcolor="#B2CCFF">글제목</td>
        <td><input type="text" name="subject" id="subject" value="${noticeDto.subject}"></td>
      </tr>
      
      <tr>
        <td class="line" align="center" bgcolor="#B2CCFF">글내용</td>
        <td>
          <textarea name="content" id="content" rows="10" cols="50">${noticeDto.content}</textarea>
        </td>
      </tr>

      <tr>
        <td colspan="2" align="center">
          <input type="submit" value="수정완료">
        </td>
      </tr>
    </table>
  </form>

</body>
</html>