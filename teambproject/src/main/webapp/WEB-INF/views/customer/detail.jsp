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
	function deleteconfirm() {
		
		var cf = confirm("게시물을 정말 삭제하시겠습니까?");
		
		if(cf == true){
		
			var json = {
				"id" : $("#deleteid").val()
			};
			
			$.ajax({
				url:"${ctxpath}/customer/deletect.do",
				type:"POST",
				data:json
			}).done(function(data, textStatus, jqXHR){	
				console.log(data);
				console.log(textStatus);
				console.log(jqXHR);
				
				alert("삭제가 완료되었습니다.");
				location.href = "${ctxpath}/customer/customer.do";
					
			}).fail(function(jqXHR, textStatus, errorThrown){
				console.log(jqXHR);
				console.log(errorThrown);
				console.log(textStatus);
			});
		}else{
			return false;
		}
	
	}
	
	function addreply() {
		
		if($("#content").val() == ''){
			alert("댓글을 입력해주세요!");
			return false;
		}
		
		var dto = {
				"cid" : $("#cid").val(),
				"writer" : $("#writer").val(),
				"content" : $("#content").val()
			};
		
		$.ajax({
			url:"${ctxpath}/reply/addreply.do",
			type:"POST",
			data:dto,
			header:{"Content-Type":"application/json"},
			dataType:"json"
		}).done(function(data, textStatus, jqXHR){	
			console.log(data);
			console.log(textStatus);
			console.log(jqXHR);
			
			var listStr = "";
		    
		    for(var i = 0; i<data.length; i++){
		    	if($("#writer").val() == data[i].writer){
		    		listStr +=	"<div class='card p-3' style='margin-bottom: 1rem;'>"+
    				"<div class='d-flex justify-content-between align-items-center'>"+
        			"<div class='user d-flex flex-row align-items-center'>"+ 
        			"<img src='${ctxpath}/resources/img/user1.png' width='30' class='user-img rounded-circle mr-2'>"+
        			"<span>"+
					"<small class='font-weight-bold text-primary'>"+data[i].writer+"</small>"+ 
        			"<small class='font-weight-bold'>"+data[i].content+"</small>"+
        			"<input type='button' id='sj' class='btn btn-sm btn-outline-success' value='수정' onclick='updatereply(this);'>"+
    				"<input type='button' id='sz' class='btn btn-sm btn-outline-danger' value='삭제' onclick='deletereply("+data[i].rid+", ${list.id})'>"+
        			"</span></div>"+ 
    				"<small>"+data[i].regdate+"</small></div></div>";
    				
		    		$('#list').html(listStr).trigger("create");
 				}else{
 					listStr +=	"<div class='card p-3' style='margin-bottom: 1rem;'>"+
    				"<div class='d-flex justify-content-between align-items-center'>"+
        			"<div class='user d-flex flex-row align-items-center'>"+ 
        			"<img src='${ctxpath}/resources/img/user1.png' width='30' class='user-img rounded-circle mr-2'>"+
        			"<span>"+
					"<small class='font-weight-bold text-primary'>"+data[i].writer+"</small>"+ 
        			"<small class='font-weight-bold'>"+data[i].content+"</small>"+
        			"</span></div>"+ 
    				"<small>"+data[i].regdate+"</small></div></div>";
    				
 					$('#list').html(listStr).trigger("create");
 					}
			    }

			
				
		}).fail(function(jqXHR, textStatus, errorThrown){
			console.log(jqXHR);
			console.log(errorThrown);
			console.log(textStatus);
			
			alert("실패");
		});
		
		
	}
	
	function updatereply(e) {
		
		var content = $(e).prev().text();
		var rid = $(e).prev().attr("id");
		console.log(rid);
		
		$(e).parent().parent().parent().html("<textarea style='width:80%;' placeholder='내용을 입력해 주세요.'>"+content+"</textarea>"+
		"<input type='button' id='sj' class='btn btn-outline-success' value='수정' style='float:right;' onclick='udreply(this, "+rid+");'>");	
	}
	
	function udreply(e, rid) {
		var ct = $(e).prev().val();
		var id = rid;
		
		var json = {
				"cid" : $("#cid").val(),
				"rid" : id,
				"content" : ct
			};
		
		$.ajax({
			url:"${ctxpath}/reply/updaterp.do",
			type:"POST",
			data:json,
			header:{"Content-Type":"application/json"},
			dataType:"json"
		}).done(function(data, textStatus, jqXHR){	
			console.log(data);
			console.log(textStatus);
			console.log(jqXHR);
			
			alert("댓글이 수정되었습니다.");
			
			var listStr = "";
	         
		    for(var i = 0; i<data.length; i++){
		    	if($("#writer").val() == data[i].writer){ 
		            listStr +=	"<div class='card p-3' style='margin-bottom: 1rem;'>"+
                				"<div class='d-flex justify-content-between align-items-center'>"+
                    			"<div class='user d-flex flex-row align-items-center'>"+ 
                    			"<img src='${ctxpath}/resources/img/user1.png' width='30' class='user-img rounded-circle mr-2'>"+
                    			"<span>"+
            					"<small class='font-weight-bold text-primary'>"+data[i].writer+"</small>"+ 
                    			"<small class='font-weight-bold'>"+data[i].content+"</small>"+
                    			"<input type='button' id='sj' class='btn btn-sm btn-outline-success' value='수정' onclick='updatereply(this);'>"+
                				"<input type='button' id='sz' class='btn btn-sm btn-outline-danger' value='삭제' onclick='deletereply("+data[i].rid+", ${list.id})'>"+
                    			"</span></div>"+ 
                				"<small>"+data[i].regdate+"</small></div></div>";
		            
                				$('#list').html(listStr).trigger("create");
		     	}else{
		     		listStr +=	"<div class='card p-3' style='margin-bottom: 1rem;'>"+
    				"<div class='d-flex justify-content-between align-items-center'>"+
        			"<div class='user d-flex flex-row align-items-center'>"+ 
        			"<img src='${ctxpath}/resources/img/user1.png' width='30' class='user-img rounded-circle mr-2'>"+
        			"<span>"+
					"<small class='font-weight-bold text-primary'>"+data[i].writer+"</small>"+ 
        			"<small class='font-weight-bold'>"+data[i].content+"</small>"+
        			"</span></div>"+ 
    				"<small>"+data[i].regdate+"</small></div></div>";
		     		
		     		$('#list').html(listStr).trigger("create");
		     		
		    	 	}
		     }
		     
				
		}).fail(function(jqXHR, textStatus, errorThrown){
			console.log(jqXHR);
			console.log(errorThrown);
			console.log(textStatus);
		});

	}
	
	function deletereply(rid, cid) {
		
		var id1 = cid;
		
		var id2 = rid;
		
		console.log(id1);
		console.log(id2);
		
		var cf = confirm("댓글을 정말 삭제하시겠습니까?");
		
		if(cf == true){
		
			
			var json = {
				"cid" : id1,
				"rid" : id2
			};
		
		}else{
			return false;
		}

		$.ajax({
			url:"${ctxpath}/reply/deleterp.do",
			type:"POST",
			data:json,
			header:{"Content-Type":"application/json"},
			dataType:"json"
		}).done(function(data, textStatus, jqXHR){	
			console.log(data);
			console.log(textStatus);
			console.log(jqXHR);
			
			alert("삭제가 완료되었습니다.");
			
			var listStr = "";
	         
		    for(var i = 0; i<data.length; i++){
		    	if($("#writer").val() == data[i].writer){
		            listStr +=	"<div class='card p-3' style='margin-bottom: 1rem;'>"+
                				"<div class='d-flex justify-content-between align-items-center'>"+
                    			"<div class='user d-flex flex-row align-items-center'>"+ 
                    			"<img src='${ctxpath}/resources/img/user1.png' width='30' class='user-img rounded-circle mr-2'>"+
                    			"<span>"+
            					"<small class='font-weight-bold text-primary'>"+data[i].writer+"</small>"+ 
                    			"<small class='font-weight-bold'>"+data[i].content+"</small>"+
                    			"<input type='button' id='sj' class='btn btn-sm btn-outline-success' value='수정' onclick='updatereply(this);'>"+
                				"<input type='button' id='sz' class='btn btn-sm btn-outline-danger' value='삭제' onclick='deletereply("+data[i].rid+", ${list.id})'>"+
                    			"</span></div>"+ 
                				"<small>"+data[i].regdate+"</small></div></div>";
                				
		          				$('#list').html(listStr).trigger("create");
		     	}else{
		    	 	listStr +=	"<div class='card p-3' style='margin-bottom: 1rem;'>"+
 								"<div class='d-flex justify-content-between align-items-center'>"+
     							"<div class='user d-flex flex-row align-items-center'>"+ 
     							"<img src='${ctxpath}/resources/img/user1.png' width='30' class='user-img rounded-circle mr-2'>"+
     							"<span>"+
								"<small class='font-weight-bold text-primary'>"+data[i].writer+"</small>"+ 
     							"<small class='font-weight-bold'>"+data[i].content+"</small>"+
     							"</span></div>"+ 
 								"<small>"+data[i].regdate+"</small></div></div>";
 							
		    	 				$('#list').html(listStr).trigger("create");
		     
		     	}
		     }
		     
		    
				
		}).fail(function(jqXHR, textStatus, errorThrown){
			console.log(jqXHR);
			console.log(errorThrown);
			console.log(textStatus);
		});
	}
</script>
</head>
<body>
<table class="table table-condensed">
	<thead>
		<tr>
			<th width="10%">글제목</th>
			<th width="60%">${list.subject}</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>작성일</td>
			<td>${list.regdate}</td>
		</tr>
		<tr>
			<td>글쓴이</td>
			<td>${list.writer} <span style='float:right'>조회수 : ${list.readcount}</span></td>
		</tr>
		<tr>
			<td colspan="2">
				<p>${list.content}</p>
			</td>
		</tr>
	</tbody>
</table>
<c:if test="${sessionScope.grade eq 1}">
<div align="right" style="margin-bottom: 3rem;">
	<input type="hidden" value="${list.id}" id="deleteid">
	<button class="btn btn-outline-success" onclick="location.href='${ctxpath}/customer/updatect.do/${list.id}'">수정</button>
	<button class="btn btn-outline-danger" onclick="deleteconfirm();">삭제</button>
</div>
</c:if>
<div id="list">
<label for="content" class="form-label">댓글</label>
<c:if test="${!empty rlist}">
<c:forEach var="view" items="${rlist}">
<div class="card p-3" style="margin-bottom: 1rem;">
	<div class="d-flex justify-content-between align-items-center">
		<div class="user d-flex flex-row align-items-center"> 
			<img src="${ctxpath}/resources/img/user1.png" width="30" class="user-img rounded-circle mr-2"> 
			<span>
				<small class="font-weight-bold text-primary">${view.writer}</small> 
				<small class="font-weight-bold" id="${view.rid}">${view.content}</small>
				<c:if test="${view.writer eq sessionScope.id}">
				<input type="button" id="sj" class="btn btn-sm btn-outline-success" value="수정" onclick="updatereply(this);">
				<input type="button" id="sz" class="btn btn-sm btn-outline-danger" value="삭제" onclick="deletereply(${view.rid}, ${list.id})">
				</c:if>
            </span>
		</div>
		<small>
			${view.regdate}
    	</small>
	</div>
</div>
</c:forEach>
</c:if>
</div>
<div class="mb-3">
  				<%-- <label for="content" class="form-label">댓글</label>--%>
  				
  				<c:if test="${empty sessionScope.id}">
  					<textarea class="form-control" id="content" rows="3" placeholder="로그인후 댓글 작성이 가능합니다."></textarea>
  				</c:if>
  				<c:if test="${list.writer eq sessionScope.id || sessionScope.grade eq 1}">
  				<textarea class="form-control" id="content" rows="3" placeholder="내용을 입력해 주세요."></textarea>
  				<br>
  				<input type="hidden" id="writer" value="${sessionScope.id}">
  				<input type="hidden" id="cid" value="${list.id}">
  				<input type="button" value="댓글 등록" style="float: right; margin-bottom: 1rem;" class="btn btn-outline-primary" onclick="addreply();">
  				</c:if>  				
			</div>
</body>