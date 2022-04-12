<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/constants.jsp"%>
<!DOCTYPE html>
<script>
    var msg = "<c:out value='${msg}'/>";
    alert(msg);
    location.href='${ctxpath}/cart/cartList.do'
</script>