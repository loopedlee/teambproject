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
<h2>관리자 로그인</h2>
<form name="myForm" method="post" action="${ctxpath}/notice/loginSuccess.do">
     <table border="1">
       <tr>
         <td>ID</td>
         <td><input type="text" name="adminID" id="adminID" size="20"></td>
       </tr>
       
       <tr>
         <td colspan="2" align="center">
           <input type="submit" value="로그인">
         </td>
       </tr>
     </table>
  </form>
</body>
</html>