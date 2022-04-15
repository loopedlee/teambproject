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
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script type="text/javascript">
function updatestate(id) {
	
	var cf = confirm("구매를 확정하시겠습니까?");
	
	if(cf == true){
	
	var json = {
			"id" : id,
			"state" : 6
		};
	} else{
		return false;
	}
	
	$.ajax({
		url:"${ctxpath}/order/updatebst",
		type:"POST",			
		data:json,
		header:{"Content-Type":"application/json"},
		dataType:"json"
		
	}).done(function(data, textStatus, jqXHR){	
		console.log(data);
		console.log(textStatus);
		console.log(jqXHR);
		alert("구매확정 감사합니다.");
			
	}).fail(function(jqXHR, textStatus, errorThrown){
		console.log(jqXHR);
		console.log(errorThrown);
		console.log(textStatus);
	});

}

function takeback(id) {
	
	var cf = confirm("반품신청을 하시겠습니까?");
	
	if(cf == true){
	
	var json = {
			"id" : id,
			"state" : 7
		};
	} else{
		return false;
	}
	
	$.ajax({
		url:"${ctxpath}/order/updatebst",
		type:"POST",			
		data:json,
		header:{"Content-Type":"application/json"},
		dataType:"json"
		
	}).done(function(data, textStatus, jqXHR){	
		console.log(data);
		console.log(textStatus);
		console.log(jqXHR);
		alert("반품신청이 접수되었습니다.");
			
	}).fail(function(jqXHR, textStatus, errorThrown){
		console.log(jqXHR);
		console.log(errorThrown);
		console.log(textStatus);
	});

}

function insertrv(e) {
	if($("#insertsubject").val() == ''){
		alert("제목을 입력해주세요.");
		return false;
	}
	
	if($("#insertcontent").val() == ''){
		alert("내용을 입력해주세요.");
		return false;
	}
	
	var id = $("#modalid").val();
	
	var gid = $(e).next().val();
	
	var subject = $("#insertsubject").val();
	
	var writer = $("#modalwriter").val();
	
	var content = $("#insertcontent").val();
	
	var rate = $("#insertrate").val();
	
	var formdata = new FormData();
	
	formdata.append("id",id);
	formdata.append("gid",gid);
	formdata.append("subject",subject);
	formdata.append("writer",writer);
	formdata.append("content",content);
	formdata.append("reviewimg",$("#insertimg")[0].files[0]);
	formdata.append("rate",rate);
	
	$.ajax({
		url:"${ctxpath}/review/insertPro.do",
		type:"POST",
		data:formdata,
		enctype:'multipart/form-data',
		processData: false,
		contentType: false
		
	}).done(function(data, textStatus, jqXHR){	
		console.log(data);
		console.log(textStatus);
		console.log(jqXHR);
		alert("리뷰가 등록되었습니다.");
		location.reload();
			
	}).fail(function(jqXHR, textStatus, errorThrown){
		console.log(jqXHR);
		console.log(errorThrown);
		console.log(textStatus);
	});

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
			<th scope="col">확인/리뷰</th>
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
                <c:when test="${view.state == 0}">결제 대기</c:when>
                <c:when test="${view.state == 1}">결제 완료</c:when>
                <c:when test="${view.state == 2}">상품 준비중</c:when>
                <c:when test="${view.state == 3}">배송 준비</c:when>
                <c:when test="${view.state == 4}">배송 시작</c:when>
                <c:when test="${view.state == 5}">배달 완료</c:when>
                <c:when test="${view.state == 6}">구매 확정</c:when>
                <c:when test="${view.state == 7}">반품신청 진행중</c:when>
                <c:when test="${view.state == 8}">반품완료</c:when>
                <c:when test="${view.state == 9}">반품신청 거부</c:when>
                <c:when test="${view.state == 10}">구매 확정</c:when>
            </c:choose>
		</td>	
		<td>
			<c:choose>
                <c:when test="${view.state == 0}"></c:when>
                <c:when test="${view.state == 1}"></c:when>
                <c:when test="${view.state == 2}"></c:when>
                <c:when test="${view.state == 3}"></c:when>
                <c:when test="${view.state == 4}"></c:when>
                <c:when test="${view.state == 5}">
                	<input type="button" class="btn btn-outline-success btn-sm" onclick="updatestate(${view.id});" value="구매확정"><br><br>
                	<input type="button" class="btn btn-outline-danger btn-sm" onclick="takeback(${view.id});"value="반품신청">
                </c:when>
                <c:when test="${view.state == 6}">
                	<input type="hidden" id="${view.gid}">
                	<input type="button" class="btn btn-outline-success btn-sm" value="리뷰 남기기" data-bs-toggle="modal" data-bs-target="#insert" id="gidbtn">
                	<input type="hidden" id="${view.id}">
                </c:when>
                <%--onclick="location.href='${ctxpath}/review/insertForm.do'" --%>
                <c:when test="${view.state == 7}">반품신청 접수</c:when>
                <c:when test="${view.state == 9}"><input type="button" class="btn btn-outline-success btn-sm" onclick="location.href='${ctxpath}/customer/customer.do'" value="문의하기"></c:when>
                <c:when test="${view.state == 10}">리뷰등록 완료</c:when>
            </c:choose>
		</td>	
	</tr>
	</c:forEach>
	</tbody>
</table>
<!-- Modal -->
<div class="modal fade" id="insert" tabindex="-1" role="dialog" aria-labelledby="insertLabel" aria-hidden="true">
  							<div class="modal-dialog" role="document">
    							<div class="modal-content">
      								<div class="modal-header">
        								<h5 class="modal-title" id="insertLabel">리뷰 등록</h5>
      								</div>
      									<div class="modal-body">
      										<div class="form-group">
      											<label for="loginid">제목:</label>
      											<input type="text" class="form-control" id="insertsubject" placeholder="제목을 입력해주세요.">
    										</div>
      										<br>
      										<div class="form-group">
      											<label for="name">내용:</label>
      											<input type="text" class="form-control" id="insertcontent" placeholder="내용을 입력해주세요." style="line-height: 300px;">
    										</div>
    										<br>
      										<div class="form-group">
      											<label for="file">이미지 업로드:</label>
      											<input type="file" name="file" id="insertimg">
    										</div>
    										<br>
    										<div class="form-group">
      											<label for="rate">평점:</label>
      											<select id="insertrate" style="color: #B2CCFF;">
      												<option value="1" style="color: #B2CCFF;">★☆☆☆☆</option>
      												<option value="2" style="color: #B2CCFF;">★★☆☆☆</option>
      												<option value="3" style="color: #B2CCFF;">★★★☆☆</option>
      												<option value="4" style="color: #B2CCFF;">★★★★☆</option>
      												<option value="5" style="color: #B2CCFF;">★★★★★</option>
      											</select>
    										</div>
      									</div>
      								<div class="modal-footer">
        								<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        								<button type="button" class="btn btn-success insertbtn" onclick="insertrv(this);">등록</button>
        								<input type="hidden" id="updateid" value="">
        								<input type="hidden" id="modalwriter" value="${sessionScope.id}">
        								<input type="hidden" id="modalid" value="">
      								</div>
    							</div>
  							</div>
						</div>
<script>
$(document).ready(function() {
	var myModal = document.getElementById('insert');

	var myInput = document.getElementById('insertsubject');

	myModal.addEventListener('shown.bs.modal', function() {
	  myInput.focus();
	})
	
	$("#gidbtn").click(function() {
		var btn = $(this);
		
		var gid = btn.prev().attr("id");
		
		var id = btn.next().attr("id");

		$("#updateid").val(gid);
		
		$("#modalid").val(id);
		
	})
  });
</script>
</body>
</html>
