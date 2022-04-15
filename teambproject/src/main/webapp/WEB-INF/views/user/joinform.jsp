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
  
  <script>
   function openDaumPostcode(){
       
      new daum.Postcode({
         oncomplete:function(data){
            document.getElementById('zipcode').value=data.zonecode;
            document.getElementById('address').value=data.address;
          }
         
      }).open();
   }//openDaumPostcode()---
  </script>


  <script type="text/javascript">
  function check(){
      //데이터 입력 여부 체크
      if($('#id').val()==''){
         alert("ID를 입력하세요");
         $('#id').focus();
         return false;
      }
      
      if($('#pw').val()==''){
         alert("암호를 입력하세요");
         $('#pw').focus();
         return false;
      }
      
      if($('#pwcheck').val()==''){
         alert("암호 확인을 입력하세요");
         $('#pw2').focus();
         return false;
      }
      
      if($('#pwcheck').val()!=$('#pw').val()){
         alert("암호 확인이 일치하지 않습니다");
         $('#pwcheck').val('')
         $('#pw').val('').focus();
         return false;
      }

      if($('#name').val()==''){
         alert("이름을 입력하세요");
         $('#name').focus();
         return false;
      }
      
      if($('#tel').val()==''){
          alert("전화번호를 입력하세요");
          $('#tel').focus();
          return false;
       }
      
      if($('#email').val()==''){
         alert("이메일을 입력하세요");
         $('#email1').focus();
         return false;
      }     
      
      if($('#address').val()==''){
          alert("주소를 입력하세요");
          $('#address').focus();
          return false;
       }
      
      if($('#address2').val()==''){
         alert("상세주소를 입력하세요");
         $('#address').focus();
         return false;
      }
      
      $('#address').val($('#address').val()+$('#address2').val());
      
      if($("#state").val() == ''){
    	  alert("아이디 중복체크를 해주세요");
    	  return false;
      }
      
      return true;
   }//check()-end
   
function idCheck(){
	if($('#id').val()==''){
		alert("ID를 입력하세요");
		$('#id').focus();
		return false;
	} else {
        	   
		var id = {
				"id" : $('#id').val()
		}
		
		console.log(id);
		
		$.ajax({
			url:"${ctxpath}/user/idcheck.do",
			type:"POST",
			data:id,
			dataType:"json"
		}).done(function(data, textStatus, jqXHR){	
			console.log(data);
			console.log(textStatus);
			console.log(jqXHR);
			if (data == 0) {
				alert("사용 가능한 아이디입니다.");	
				$("#state").val(0);
			}else{
				alert("사용 불가능한 아이디입니다.");
				$("#state").val(1);
			}		

		}).fail(function(jqXHR, textStatus, errorThrown){
			console.log(jqXHR);
			console.log(errorThrown);
			console.log(textStatus);
			
			alert("실패");
		});
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
<h2><b>회원가입</b></h2>
<div class="container">
	<div class="row">
		<div class="col">
		<form name="myForm" method="post" action="${ctxpath}/user/insertuser.do" onSubmit="return check()" style="width: 40%; margin: auto;">
			<div class="input-group flex-nowrap">
  				<span class="input-group-text" id="addon-wrapping">아이디</span>
  					<input type="text" class="form-control" placeholder="아이디를 입력해주세요" aria-label="Username" aria-describedby="addon-wrapping" name="id" id="id">
  					<input type="hidden" id="state" value="">
  					<button class="btn btn-outline-secondary" type="button" id="button-addon2" onClick="idCheck()">아이디 중복체크</button>
			</div>
			<br>
			<div class="input-group flex-nowrap">
  				<span class="input-group-text" id="addon-wrapping">암호</span>
  					<input type="password" class="form-control" placeholder="암호를 입력해주세요" aria-label="Username" aria-describedby="addon-wrapping" name="pw" id="pw">
			</div>
			<br>
			<div class="input-group flex-nowrap">
  				<span class="input-group-text" id="addon-wrapping">암호확인</span>
  					<input type="password" class="form-control" placeholder="암호를 한번 더 입력해주세요" aria-label="Username" aria-describedby="addon-wrapping" name="pwcheck" id="pwcheck">
			</div>
			<br>
			<div class="input-group flex-nowrap">
  				<span class="input-group-text" id="addon-wrapping">이름</span>
  					<input type="text" class="form-control" placeholder="이름을 입력해주세요" aria-label="Username" aria-describedby="addon-wrapping" name="name" id="name">
			</div>
			<br>
			<div class="input-group flex-nowrap">
  				<span class="input-group-text" id="addon-wrapping">전화</span>
  					<input type="text" class="form-control" placeholder="'-'없이 입력해주세요." aria-label="Username" aria-describedby="addon-wrapping" name="tel" id="tel" maxlength="11">
			</div>
			<br>
			<div class="input-group flex-nowrap">
  				<span class="input-group-text" id="addon-wrapping">이메일</span>
  					<input type="email" class="form-control" placeholder="이메일을 입력해주세요" aria-label="Username" aria-describedby="addon-wrapping" name="email" id="email">
			</div>
			<br>
			<div class="input-group flex-nowrap">
  				<span class="input-group-text" id="addon-wrapping">우편번호</span>
  					<input type="text" class="form-control" placeholder="우편번호를 입력해주세요" aria-label="Username" aria-describedby="addon-wrapping" name="zipcode" id="zipcode" readOnly="readonly">
  					<button class="btn btn-outline-secondary" type="button" id="button-addon2" onClick="openDaumPostcode()">주소 찾기</button>
			</div>
			<br>
			<div class="input-group flex-nowrap">
  				<span class="input-group-text" id="addon-wrapping">주소</span>
  					<input type="text" class="form-control" aria-label="Username" aria-describedby="addon-wrapping" name="address" id="address">
			</div>
			<br>
			<div class="input-group flex-nowrap">
  				<span class="input-group-text" id="addon-wrapping">상세주소</span>
  					<input type="text" class="form-control" placeholder="상세주소를 입력해주세요" aria-label="Username" aria-describedby="addon-wrapping" name="address2" id="address2">
			</div>
			<br>
			<div style="text-align: center;">
    			<button type="submit" class="btn btn-outline-success" style="width: 7rem;">회원가입</button>
    			<button type="button" class="btn btn-outline-danger" style="width: 7rem;" onclick="history.back()">뒤로가기</button>
    		</div>
		</form>
		</div>
	</div>
</div>
</body>
</html>