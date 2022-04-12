<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/jquery-migrate-3.4.0.js"></script>
<script type="text/javascript">
	function updatestate(id) {
		
		var state = $("select[name=state]").val();
		
		var json = {
				"id" : id,
				"state" : state
			};
		
		$.ajax({
			url:"${ctxpath}/order/updatest",
			type:"POST",			
			data:json,
			header:{"Content-Type":"application/json"},
			dataType:"json"
			
		}).done(function(data, textStatus, jqXHR){	
			console.log(data);
			console.log(textStatus);
			console.log(jqXHR);
			alert("상태가 변경되었습니다.");
				
		}).fail(function(jqXHR, textStatus, errorThrown){
			console.log(jqXHR);
			console.log(errorThrown);
			console.log(textStatus);
		});

	}
	
	function takeback(id, state) {
			
		if(state == 8){
		
		var cf = confirm("반품신청을 승인하시겠습니까?");
		
		if(cf == true){
			var json = {
				"id" : id,
				"state" : state
			};
		$.ajax({
			url:"${ctxpath}/order/updatest",
			type:"POST",			
			data:json,
			header:{"Content-Type":"application/json"},
			dataType:"json"
				
		}).done(function(data, textStatus, jqXHR){	
			console.log(data);
			console.log(textStatus);
			console.log(jqXHR);
				
			if(state == 8){
				alert("반품 신청을 승인하셨습니다.");	
			}
				
		}).fail(function(jqXHR, textStatus, errorThrown){
			console.log(jqXHR);
			console.log(errorThrown);
			console.log(textStatus);
		});
			
		}else{
			return false;	
		}
		}else if(state == 9){
			var cf = confirm("반품신청을 거부하시겠습니까?");
			
			if(cf == true){
				var json = {
					"id" : id,
					"state" : state
				};
			$.ajax({
				url:"${ctxpath}/order/updatest",
				type:"POST",			
				data:json,
				header:{"Content-Type":"application/json"},
				dataType:"json"
					
			}).done(function(data, textStatus, jqXHR){	
				console.log(data);
				console.log(textStatus);
				console.log(jqXHR);

				if(state == 9){
					alert("반품 신청을 거부하셨습니다.");	
				}
					
			}).fail(function(jqXHR, textStatus, errorThrown){
				console.log(jqXHR);
				console.log(errorThrown);
				console.log(textStatus);
			});
		}else {
			return false;	
			}
		}

	}
</script>
</head>
<body>
<table class="table table-hover align-middle">
	<thead>
		<tr align="center">
			<th scope="col">날짜/주문번호</th>
			<th scope="col">배송지</th>
			<th scope="col">상품명</th>
			<th scope="col">상품금액/수량</th>
			<th scope="col">주문상태</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="view" items="${list}">
	<tr align="center">
		<td>
			<fmt:parseDate value="${view.orderdate}" var='time' pattern='yyyymmdd'/>
			<fmt:formatDate value="${time}" pattern="yyyy-MM-dd"/>
			<p>${view.id}</p></td>
		<td>${view.address}</td>
		<td><a href="${ctxpath}/goods/content.do?id=${view.gid}"><img src="${ctxpath}/resources/flowerimgs/${view.img}" width="100" height="100">${view.name}</a></td>
		<td>${view.price}원 / ${view.stock}개</td>
		<td>
		<c:choose>
                <c:when test="${view.state < 6}">
                	<select name='state'>
                		<option value='0'<c:if test="${view.state == 0}">selected</c:if>>결제 대기</option>
  						<option value='1'<c:if test="${view.state == 1}">selected</c:if>>결제 완료</option>
  						<option value='2'<c:if test="${view.state == 2}">selected</c:if>>상품 준비중</option>
  						<option value='3'<c:if test="${view.state == 3}">selected</c:if>>배송 준비</option>
  						<option value='4'<c:if test="${view.state == 4}">selected</c:if>>배송 출발</option>
  						<option value='5'<c:if test="${view.state == 5}">selected</c:if>>배송 완료</option>
					</select>
                </c:when>
                <c:when test="${view.state == 6}">구매 확정</c:when>
                <c:when test="${view.state == 7}">
                	<p>반품신청 접수</p>
                	<input type="button" class="btn btn-outline-success btn-sm" onclick="takeback(${view.id},8);" value="반품신청 승인"><br><br>
                	<input type="button" class="btn btn-outline-danger btn-sm" onclick="takeback(${view.id},9);" value="반품신청 거부">
                </c:when>
                <c:when test="${view.state == 8}">반품신청 승인</c:when>
                <c:when test="${view.state == 9}">반품신청 거부</c:when>
            </c:choose>
        <c:choose>
        	<c:when test="${view.state < 6}">
				<input type="button" class="btn btn-primary btn-sm" onclick="updatestate(${view.id});" value="변경">
			</c:when>
		</c:choose>
		</td>		
	</tr>
	</c:forEach>
	</tbody>
</table>
</body>
</html>