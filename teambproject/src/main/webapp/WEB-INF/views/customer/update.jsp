<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/jquery-migrate-3.4.0.js"></script>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script type="text/javascript">
	function updatect() {
		
		var json = {
				"id" : $("#ctid").val(),
				"subject" : $("#sj").val(),
				"content" : $("#ta").val()
			};
			
			$.ajax({
				url:"${ctxpath}/customer/updateconfirm.do",
				type:"POST",
				data:json
			}).done(function(data, textStatus, jqXHR){	
				console.log(data);
				console.log(textStatus);
				console.log(jqXHR);
				alert("글이 수정되었습니다.");
				location.href = "${ctxpath}/customer/customer.do";
					
			}).fail(function(jqXHR, textStatus, errorThrown){
				console.log(jqXHR);
				console.log(errorThrown);
				console.log(textStatus);
			});
	}
</script>
</head>
<div style="margin: auto; width: 80%;">
<div class="input-group mb-3">
  <span class="input-group-text" id="basic-addon1" style="width: 10%;">글 제목</span>
  <input type="text" class="form-control" placeholder="글 제목을 입력하세요." aria-label="Username" aria-describedby="basic-addon1" id="sj" value="${list.subject}">
</div>
<div class="input-group">
  <span class="input-group-text" style="width: 10%;">글 내용</span>
  <textarea class="form-control" aria-label="With textarea" style="height: 50vh;" id="ta">${list.content}</textarea>
</div>
<div style="text-align: center; margin-top: 1rem;">
<input type="hidden" id="ctid" value="${list.id}"> 
<input type="button" class="btn btn-outline-success" value="수정" onclick="updatect();">
<input type="reset" class="btn btn-outline-danger" value="취소" onclick="history.back()">
</div>
</div>