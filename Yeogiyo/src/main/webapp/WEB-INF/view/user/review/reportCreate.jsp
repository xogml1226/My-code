<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style type="text/css">
</style>

<div class="container">
	<div style="padding-top:5px; padding-bottom: 50px; text-align:center;">
	
		<form name="reportForm" action="<%=cp%>/user/review/reportComplete" method="POST">
			<p>글번호</p><input type="text" name="reviewNum" value="${reviewNum}">
			<p>신고사유</p><input type="text" name="reportContent">
			<input type="hidden" name="hotelId" value="${hotelId}">
			<button type="submit">신고하기</button>
		</form>
	</div>
</div>