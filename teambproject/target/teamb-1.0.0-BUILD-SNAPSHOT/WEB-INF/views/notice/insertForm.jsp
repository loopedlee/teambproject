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
  width: 60%;
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

<script type="text/javascript">
    function check(ff){
    	if(ff.writer.value==''){
    		alert("이름을 입력하세요");
    		ff.writer.focus();
    		return false;
    	}
    	
    	if(ff.subject.value==''){
    		alert("글제목을 입력하세요");
    		ff.subject.focus();
    		return false;
    	}
    	
    	if(ff.content.value==''){
    		alert("글내용을 입력하세요");
    		ff.content.focus();
    		return false;
    	}
    
    }

  </script>

</head>
<body>



  <h2><font color="#6799FF"><b>공지 쓰기</b></font></h2>
    <form name="writeForm" method="post" action="${ctxpath}/notice/insertPro.do" onSubmit="return check(this)">
    
    <table border="1" class="line">
      <tr height="50">
      <td class="line" align="center" bgcolor="#B2CCFF">글쓴이</td>
        <td colspan="2" class="line"><input type="text" name="writer" id="writer"></td>
      </tr>
      
      <tr height="50">
      <td class="line" align="center" bgcolor="#B2CCFF">글제목</td>
      <td colspan="2" class="line">
      <input type="text" name="subject" id="subject">
      </td>
      </tr>
      
      
       <tr height="50">
        <td colspan="2" class="line" align="center" bgcolor="#B2CCFF">공지 카테고리</td>
        <td class="line">
        <input type="checkbox" name="intent"  id="intent" value="1">안내
        <input type="checkbox" name="intent"  id="intent" value="2">긴급공지
        </td>
      </tr>
      
      <tr height="50">
        <td class="line" align="center" bgcolor="#B2CCFF">글내용</td>
        <td colspan="2" class="line">
          <textarea name="content" id="content" rows="10" cols="50"></textarea>
        </td>
      </tr>
   
      <tr class="line2">
        <td colspan="4" align="center">
          <input type="submit" value="글쓰기">
          <input type="reset" value="취소">
        </td>
      </tr>
    </table>
  </form>
</body>
</html>