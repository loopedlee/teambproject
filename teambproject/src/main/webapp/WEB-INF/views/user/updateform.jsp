<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  
  <%--daum API사용--%>
  <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
  
<script type="text/javascript">
function openDaumPostcode(){
	new daum.Postcode({
		oncomplete:function(data){
		document.getElementById('zipcode').value=data.zonecode;
		document.getElementById('address').value=data.address;
		}
	}).open();
}//openDaumPostcode()---

function check(){
	  if($('#pw').val()==''){
          alert("암호를 입력하세요");
          $('#pw').focus();
          return false;
       }
       
       if($('#pw2').val()==''){
          alert("암호 확인을 입력하세요");
          $('#pw2').focus();
          return false;
       }
	  
       if($('#pw2').val()!=$('#pw').val()){
          alert("암호 확인이 일치하지 않습니다");
          $('#pw').val('');
          $('#pw2').val('');
          $('#pw').focus();
          return false;
       }
	  
       $('#tel').val($('#tel1').val()+$('#tel2').val()+$('#tel3').val());
       
       //alert("aaa");
       //document.updateForm.submit();
  }
  
function deleteuser(){
	  
	var cf = confirm("회원탈퇴를 하시겠습니까?");
		
		if(cf == true){
			var json = {
			"id" : $("input[name=id]").val()
	  	}
	
		$.ajax({
			url:"${ctxpath}/user/deleteuser.do",
			type:"POST",
			data:json
		}).done(function(data, textStatus, jqXHR){	
			console.log(data);
			console.log(textStatus);
			console.log(jqXHR);
			
				alert("회원탈퇴가 완료되었습니다.");
				location.href = "${ctxpath}/user/logout.do";	
			
			
				
		}).fail(function(jqXHR, textStatus, errorThrown){
			console.log(jqXHR);
			console.log(errorThrown);
			console.log(textStatus);
		});
		
		
	}else {
		return false;
	}
	 
	  
	  
	  
  }
  </script>
  
<style type="text/css">
h2{
  	text-align: center;
  }
</style>
  
</head>
<body>
<h2><b>정보 수정하기</b></h2>
<div class="container">
	<div class="row">
		<div class="col">
  <form name="updateForm" method="post" action="${ctxpath}/user/updatepro.do" onsubmit="return check()" style="width: 40%; margin: auto;">
    <div class="input-group flex-nowrap">
  		<span class="input-group-text" id="addon-wrapping">이름</span>
        <input type="text" name="name" id="name" value="${sessionScope.name}" aria-label="Username" aria-describedby="addon-wrapping" class="form-control">
        <input type="hidden" name="id" value="${sessionScope.id}">
    </div>
    <br>
	<div class="input-group flex-nowrap">
  		<span class="input-group-text" id="addon-wrapping">암호</span>  
      	<input type="password" name="pw" id="pw" aria-label="Username" aria-describedby="addon-wrapping" class="form-control">
    </div>
    <br>
    <div class="input-group flex-nowrap">
  		<span class="input-group-text" id="addon-wrapping">암호확인</span>  
  		<input type="password" name="pw2" id="pw2" aria-label="Username" aria-describedby="addon-wrapping" class="form-control">
    </div>
    <br>
    <div class="input-group flex-nowrap">
    	<span class="input-group-text" id="addon-wrapping">이메일</span>  
        <input type="email" name="email" id="email" value="${sessionScope.email}" aria-label="Username" aria-describedby="addon-wrapping" class="form-control">
  	</div>
    <br>
    <div class="input-group flex-nowrap">
  		<span class="input-group-text" id="addon-wrapping">전화</span>  
      	<c:set var="usertel" value="${sessionScope.tel}"/>        	
        	<input type="text" name="tel1" id="tel1" value="${fn:substring(usertel,0,3)}" size="4" class="form-control">-
        <c:if test="${fn:length(usertel) eq 11}">
        	<input type="text" name="tel2" id="tel2" value="${fn:substring(usertel,3,7)}" size="4" class="form-control">-
        	<input type="text" name="tel3" id="tel3" value="${fn:substring(usertel,7,11)}" size="4" class="form-control">
        </c:if>
        <c:if test="${fn:length(usertel) eq 10}">
        	<input type="text" name="tel2" id="tel2" value="${fn:substring(usertel,3,6)}" size="4" class="form-control">-
        	<input type="text" name="tel3" id="tel3" value="${fn:substring(usertel,6,10)}" size="4" class="form-control">
        </c:if>
        	<input type="hidden" name="tel" id="tel" value="">
     </div>
     <br>
     <div class="input-group flex-nowrap">
  	 	<span class="input-group-text" id="addon-wrapping">우편번호</span>
  		<input type="text" class="form-control" placeholder="우편번호를 입력해주세요" aria-label="Username" aria-describedby="addon-wrapping" name="zipcode" id="zipcode" readOnly="readonly" value="${sessionScope.zipcode}">
  		<button class="btn btn-outline-secondary" type="button" id="button-addon2" onClick="openDaumPostcode()">주소 찾기</button>
	</div>
	<br>
	<div class="input-group flex-nowrap">
  		<span class="input-group-text" id="addon-wrapping">주소</span>
  		<input type="text" class="form-control" aria-label="Username" aria-describedby="addon-wrapping" name="address" id="address" value="${sessionScope.address}">
	</div>
	<br>
    <div class="input-group flex-nowrap">
  		<span class="input-group-text" id="addon-wrapping">상세주소</span>
  		<input type="text" class="form-control" placeholder="상세주소를 입력해주세요" aria-label="Username" aria-describedby="addon-wrapping" name="address2" id="address2">
	</div>
	<br>
	<div style="text-align: center;">
    	<button type="submit" class="btn btn-outline-success" style="width: 7rem;">수정 하기</button>
    	<input type="button" class="btn btn-outline-warning" value="수정 취소" onClick="history.back(); return false ;">
    	<input type="button" class="btn btn-outline-danger" value="탈퇴 하기" onclick="deleteuser();">
    </div>
  </form>
  </div>
  </div>
  </div>
</body>
</html>