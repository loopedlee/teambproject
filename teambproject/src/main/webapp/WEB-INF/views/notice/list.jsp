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
  border: 1px solid black;
  width: 50%;
  }
  .line{
  border: 1px solid white;
  }
  
  .line2{
  border: 1px solid lightgray;
  }
  </style>
</head>
<body>
<h2><font color="#6799FF"><b>공지글</b></font></h2>
    <table class="line">
      <tr>
        <td align="right">
          <c:if test="${sessionScope.grade eq 1}">
            <a href="${ctxpath}/notice/insertForm.do">글쓰기</a>&nbsp;&nbsp;&nbsp;&nbsp;
          </c:if>
        </td>
      </tr>
    </table>
    
     <c:if test="${count==0}"> <!-- 글갯수(count가 0이면)없으면 -->
      공지사항에 저장된 글이 없습니다
     </c:if>
      
      <form name="searchForm" method="post" action="${ctxpath}/notice/list.do?pageNum=${currentPage}">
        <table class="line">
          <tr>
            <td align="center">
              <select name="keyField">
                <option value="subject">글제목</option>
                <option value="content">글내용</option>
              </select>
              
              <input type="text" name="keyWord">
              <input type="submit" value="검색">
            </td>
          </tr>
        </table>
      </form>
      
    <c:if test="${count>0}"> <!-- 글갯수가 있으면! -->
      <table border="1" class="line2">
        <tr bgcolor="#B2CCFF">
          <th>번호</th>
          <th>제목</th>
          <th>비고</th>
          <th>작성자</th>
          <th>작성일</th>
          <th>조회</th>
        </tr>
        
    <c:forEach var="dto" items="${list}">
       <tr>
         <td>
           <c:out value="${number}"/>
           <c:set var="number" value="${number-1}"/>
         </td>
        
         
         <!-- 글제목 -->
          <td>
            <!-- 제목을 클릭하면 글내용 보기로 가기 -->
            <a href="${ctxpath}/notice/content.do?id=${dto.id}&pageNum=${currentPage}">
              ${dto.subject}
            </a>
            
            <!-- 조회수가 10번 이상이면 hot.gif표시하기 -->
            <c:if test="${dto.readcount>=10}">
				🌸
			</c:if>
			
			
          </td>
          
         
           <td>
          <c:if test="${dto.intent==1}">
           <font color="purple">[안내]</font>
          </c:if>
          
          <c:if test="${dto.intent==2}">
            <font color="purple">[긴급공지]</font>
          </c:if>
          </td>
          
          <td>${dto.writer}</td>
          <td>${dto.regdate}</td>
          <td>${dto.readcount}</td>
      </tr>
    </c:forEach>
      </table>
    </c:if>
    
    <%--블럭, 페이지처리 --%>
    <table class="line">
      <tr>
        <td align="center">
          <!--에러방지  -->
          <c:if test="${endPage>pageCount}">
            <c:set var="endPage" value="${pageCount}"/>
          </c:if>
          
          <!-- 이전 블럭 -->
          <c:if test="${startPage>10}">
            <a href="${ctxpath}/notice/list.do?pageNum=${startPage-10}">[이전 블럭]</a>
          </c:if>
          
          <!-- 페이지 처리 -->
          <c:forEach var="i" begin="${startPage}" end="${endPage}">
            <a href="${ctxpath}/notice/list.do?pageNum=${i}">[${i}]</a>
          </c:forEach>
          
          <!-- 다음 블럭 처리 -->
          <c:if test="${endPage<pageCount}">
            <a href="${ctxpath}/notice/list.do?pageNum=${startPage+10}">[다음 블럭]</a>
          </c:if>
        </td>
      </tr>
    </table>
</body>
</html>