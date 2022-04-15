<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../constants.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertForm.jsp</title>

<script type="text/javascript">
	function back() {
		if(confirm("작성을 취소하시겠습니까?")) {
			location.href="${ctxpath}";
		}
	}

</script>

<style>
h2 {
text-align: center;
}

table {
border: 1px solid black;
margin: auto;
}
</style>

<script type="text/javascript">
	function check(ff) {
		
		
		if(ff.writer.value=='') {
			alert("이름을 입력하세요.");
			ff.writer.focus();
			return false;
		}
		
		if(ff.subject.value=='') {
			alert("제목을 입력하세요.");
			ff.subject.focus();
			return false;
		}
		if(ff.content.value=='') {
			alert("내용을 입력하세요.");
			ff.content.focus();
			return false;
		}
		return true;
	}
</script>

</head>
<body>
  <h2>게시판 글쓰기</h2> 
    <form name="myForm" method="post" action="${ctxpath}/faq/insertPro.do" onsubmit="return check(this)">
	  <table class="table table-hover">
	   
	    
	    <tr>
	      <td>이름</td>
	      <td><input type="text" name="writer" id="writer" size="30"></td>
	    </tr>
	    
	     <tr>
	      <td>글제목</td>
	      <td><input type="text" name="subject" id="subject" size="30"></td>
	    </tr>
	     <tr>
	      <td>글내용</td>
	      <td>
	      <textarea name="content" id="content" rows="10" cols="50"></textarea>
	      </td>
	    </tr>
	    
	    <tr>
	      <td colspan="2" align="center">
	        <input type="submit" value="글쓰기">
	        <input type="reset" value="취소">
	      </td>
	    </tr>
	  </table>    
    </form>
</body>
</html>



