<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <style type="text/css">
  h2{text-align: center;}
  table{margin: auto; border: 1px solid black; width: 70%;}
  </style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/jquery-migrate-3.4.0.js"></script>
  <script type="text/javascript">
function rateUp(){
  	location.href="${ctxpath}/goods/rateUp.do?id=${id}";
}
  
function reviewpaging(id, pageNum) {

	var json = {
			"gid" : id,
			"pageNum" : pageNum
		};
	
	$.ajax({
		url:"${ctxpath}/review/pagingreview",
		type:"POST",
		data:json,
		header:{"Content-Type":"application/json"},
		dataType:"json"
	}).done(function(data, textStatus, jqXHR){	
		console.log(data);
		console.log(textStatus);
		console.log(jqXHR);
		
		var listStr = "";
		
		for(var i = 0; i<data.length; i++){
	         
            listStr +="<div class='card' id='clist'>"+
            "<div class='card-header'>"+
            "<div class='row justify-content-start'>"+
            "<div class='col' style='float: left;'>"+
            "<span style='font-size: 30px; font-weight: bold;'>"+data[i].subject+"</span></div></div></div>"+
            "<div class='card-body'>"+
            "<p class='card-subtitle mb-2 text-muted'>"+
            "<img src='${ctxpath}/resources/img/user1.png' width='20' style='margin-right: 5px;' class='user-img rounded-circle mr-2'>작성자 : "+data[i].writer+"<span>"+
            "<c:if test='${dto.rate==1}'>"+
            "<font color='#B2CCFF'>★</font></c:if>"+
            "<c:if test='${dto.rate==2}'>"+
            "<font color='#B2CCFF'>★★</font></c:if>"+
            "<c:if test='${dto.rate==3}'>"+
            "<font color='#B2CCFF'>★★★</font></c:if>"+
            "<c:if test='${dto.rate==4}'>"+
            "<font color='#B2CCFF'>★★★★</font></c:if>"+
            "<c:if test='${dto.rate==5||dto.rate==null}'>"+
            "<font color='#B2CCFF'>★★★★★</font></c:if></span></p>"+
            "<small style='float: right;'>"+data[i].regdate+"</small>"+
            "<p class='card-text'>"+data[i].content+"</p>"+
            "<c:if test='${"+data[i].writer+" eq sessionScope.id}'>"+
            "<input type='button' id='sj' class='btn btn-sm btn-outline-success' value='수정'>"+
            "<input type='button' id='sz' class='btn btn-sm btn-outline-danger' value='삭제'>"+
            "</c:if></div></div>";
     	}
     
    	$('#clist').html(listStr).trigger("create");

	}).fail(function(jqXHR, textStatus, errorThrown){
		console.log(jqXHR);
		console.log(errorThrown);
		console.log(textStatus);
		
		alert("실패");
	});
	
	
}

function chform(e) {
	
	var content = $(e).prev().text();
	var id = $(e).prev().attr("id");
	
	$(e).prev().html("<textarea style='width:80%;' placeholder='내용을 입력해 주세요.'>"+content+"</textarea>"+
	"<input type='button' id='sj' class='btn btn-outline-success' value='수정' style='float:right;' onclick='updatereview(this, "+id+");'>");
	$(e).css("display" ,"none");
	$(e).next("input").css("display" ,"none");
	
	console.log(content);
	console.log(id);
}

function updatereview(e, id){
	
	var content = $(e).prev().val();
	
	var json = {
		"id" : id,
		"content" : content
	}
	
	$.ajax({
		url:"${ctxpath}/review/updaterv",
		type:"POST",
		data:json,
		header:{"Content-Type":"application/json"},
		dataType:"json"
	}).done(function(data, textStatus, jqXHR){	
		console.log(data);
		console.log(textStatus);
		console.log(jqXHR);
		
		alert("수정이 완료되었습니다.");
		
		var listStr = "<p class='card-text' id='${dto.id}'>"+content+"</p>"+
					  "<input type='button' id='sj' class='btn btn-sm btn-outline-success' value='수정' onclick='chform(this);'>"+
					  "<input type='button' id='sz' class='btn btn-sm btn-outline-danger' value='삭제' onclick='deletereview(this);'>";
		
    	$(e).parent().html(listStr);

	}).fail(function(jqXHR, textStatus, errorThrown){
		console.log(jqXHR);
		console.log(errorThrown);
		console.log(textStatus);
		
		alert("실패");
	});
}

function deletereview(e, id) {
	
	var cf = confirm("리뷰를 정말 삭제하시겠습니까?");
	
	var json = {
			"id" : id
		};
	if(cf == true){
		$.ajax({
			url:"${ctxpath}/review/deleterv",
			type:"POST",
			data:json
		}).done(function(data, textStatus, jqXHR){	
			console.log(data);
			console.log(textStatus);
			console.log(jqXHR);
	     
			alert("리뷰가 삭제되었습니다.");
			
			location.reload();

		}).fail(function(jqXHR, textStatus, errorThrown){
			console.log(jqXHR);
			console.log(errorThrown);
			console.log(textStatus);
			
			alert("실패");
		});
		
		
	}else{
		return false;
	}
	
}

function check() {
	
	if($("#stockop").val() == ''){
		alert("수량을 선택해주세요.");
		return false;
	}
	
	var option = $("#stockop").val();
	
	$("#stock").val(option);
	
	return true;
	
}

  </script>
</head>
<body>
<div class="container">
	<div class="row">
    	<div class="col-md-4" style="height: 459.111pt;">
    		<img src="${ctxpath}/resources/flowerimgs/${goodsDto.img}" class="img-fluid" alt="Responsive image">
    	</div>
    	<div class="col-md-8" style="height: 557.143px;">
    	<div>상품번호 : ${goodsDto.id}</div>
    	<div>상품명 : ${goodsDto.name}
    	<c:if test="${sessionScope.grade eq 1}">
    		<div style="float: right;">
    			<a href="${ctxpath}/goods/editForm.do?id=${id}&pageNum=${pageNum}">글수정</a>&nbsp;
        		<a href="${ctxpath}/goods/delete.do?id=${id}&pageNum=${pageNum}">글삭제</a>&nbsp;
        	</div>
        </c:if>
    	</div>
    	<div>
    		<c:choose>
          <c:when test="${goodsDto.type==1}">상품 타입 : [꽃다발]</c:when>
          <c:when test="${goodsDto.type==2}">상품 타입 : [꽃바구니]</c:when>
          <c:when test="${goodsDto.type==3}">상품 타입 : [축하화환]</c:when>
          <c:when test="${goodsDto.type==4}">상품 타입 : [근조화환]</c:when>
          <c:otherwise>
            undefined
          </c:otherwise>
        </c:choose>
        <c:if test="${goodsDto.stock > 0 and sessionScope.id ne null}">
        <form name="cartInsertForm" action="${ctxpath}/cart/insertCartPro.do" method="post" onsubmit="return check()">
        	<button type="submit" class="btn btn-outline-success" style="font-size: 15px; font-weight:bold; float: right;">장바구니에 추가</button>
        	<input type="hidden" id="gid" name="gid" value="${goodsDto.id}">
    		<input type="hidden" id="uid" name="uid" value="${sessionScope.id}">
    		<input type="hidden" id="stock" name="stock" value="">
    	</form>
        </c:if>
        <c:if test="${goodsDto.stock eq 0}">
        <button style="background-color: gray; pointer-events : none;">현재 주문하실수 없습니다.</button>
        </c:if>
    	</div>
    	<hr>
    	<div>
    		<h4>상품설명</h4>
    		<h4>${goodsDto.detail}</h4>
    	</div>
    	<div>가격 : <fmt:formatNumber value="${goodsDto.price}" pattern="#,###"/>원</div>
    	<c:if test="${goodsDto.stock > 0}">
    		<div>상품 재고 : ${goodsDto.stock}개</div>
    	</c:if>
    	<c:if test="${goodsDto.stock eq 0}">
    		<div>재고가 없습니다.</div>
    	</c:if>
    	<label>수량</label>
    	<div style="margin-bottom: 20px;">
    		<select class="custom-select" style="width:auto;" id="stockop">
    			<option value="" selected>선택</option>
    			<option value="1">1</option>
    			<option value="2">2</option>
    			<option value="3">3</option>
    			<option value="4">4</option>
    			<option value="5">5</option>
    			<option value="6">6</option>
    			<option value="7">7</option>
    			<option value="8">8</option>
    			<option value="9">9</option>
    			<option value="10">10</option>
    		</select>
    	 </div>
    	 <div style="margin-bottom: 20px;">추천수 : ${goodsDto.rate}</div>
    	 <c:if test="${goodsDto.stock > 0 and sessionScope.id ne null}">
    	   <button type="button" class="btn btn-outline-success" onClick="rateUp()">게시물 추천!</button>
    	 </c:if>
    	</div>
	</div>
</div>
<div class="row"> 
  <div class="col-md-12">
 <hr> 
 </div>
</div>
<div class="container" style="height:500px;">
 <div class="row">
<div class="col" style="text-align:left;">
 <h1>리뷰</h1>
<div id=reviewlist>
<c:if test="${count eq 0}">
      <p>행운의 첫번째 리뷰어가 돼주세요!</p>
</c:if>
<c:if test="${count > 0}">
<c:forEach var="dto" items="${list}">
<div class="card" id="clist">
	<div class="card-header">
		<div class="row justify-content-start">
			<div class="col" style="float: left;">		
				<span style="font-size: 30px; font-weight: bold;">${dto.subject}</span>
			</div>
		</div>
	</div>
	<div class="card-body">
		<p class="card-subtitle mb-2 text-muted">
		<img src="${ctxpath}/resources/img/user1.png" width="20" style="margin-right: 5px;" class="user-img rounded-circle mr-2">
		작성자 : ${dto.writer} 	
			<span>
				<c:if test="${dto.rate==1}">
            		<font color="#B2CCFF">★</font>
            	</c:if>
            	<c:if test="${dto.rate==2}">
           			<font color="#B2CCFF">★★</font>
            	</c:if>
            	<c:if test="${dto.rate==3}">
            		<font color="#B2CCFF">★★★</font>
            	</c:if>
            	<c:if test="${dto.rate==4}">
           			<font color="#B2CCFF">★★★★</font>
            	</c:if>
            	<c:if test="${dto.rate==5||dto.rate==null}">
           			<font color="#B2CCFF">★★★★★</font>
            	</c:if>
			</span>
		</p>
		<small style="float: right;">${dto.regdate}</small>	
    <%-- <h6 class="card-subtitle mb-2 text-muted">${dto.writer}</h6>--%>
    <p class="card-text" id="${dto.id}">${dto.content}</p>
    <c:if test="${dto.img ne null}">
    <img src="${ctxpath}/resources/imgs/${dto.img}" width="150" height="150"><br><br>
    </c:if>
    <c:if test="${dto.writer eq sessionScope.id}">
    	<input type="button" id="sj" class="btn btn-sm btn-outline-success" value="수정" onclick="chform(this);">
		<input type="button" id="sz" class="btn btn-sm btn-outline-danger" value="삭제" onclick="deletereview(this,${dto.id});">
	</c:if>
  </div>
</div>
</c:forEach>
</c:if>
 </div> 
<%--블럭, 페이지처리 --%>
<nav aria-label="Page navigation example" style="margin-top: 3rem;">
	<c:if test="${endPage>pageCount}">
		<c:set var="endPage" value="${pageCount}"/>
	</c:if>
	<ul class="pagination justify-content-center">
    <li class="page-item">
    <c:if test="${startPage>10}">
      <a class="page-link" href="javascript:reviewpaging(${goodsDto.id},${startPage-10});" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </c:if>
    </li>
    <c:forEach var="i" begin="${startPage}" end="${endPage}">
<%--    <li class="page-item"><a class="page-link" href="${ctxpath}/goods/content.do?id=${goodsDto.id}&pageNum=${i}">${i}</a></li> --%>
    	<li class="page-item"><a class="page-link" href="javascript:reviewpaging(${goodsDto.id},${i});">${i}</a></li>
    </c:forEach>
    <li class="page-item">
    <c:if test="${endPage<pageCount}">
      <a class="page-link" href="javascript:reviewpaging(${goodsDto.id},${startPage+10});" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </c:if>
    </li>
  </ul>
</nav>
		</div>
	</div>
</div>
</body>
</html>