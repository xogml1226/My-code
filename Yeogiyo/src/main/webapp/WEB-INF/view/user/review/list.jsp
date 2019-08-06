<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style type="text/css">
.reviewHeader > th {
	text-align: center;
	border-top:1px solid #DEC750;
	border-bottom:1px solid #DEC750;
}

.reviews > td {
	text-align : center;
	border-bottom:1px solid #DEC750;
}

</style>

<div class="container">
	<div style="padding-top: 10px; padding-bottom: 20px;">
		<div class="page-header">
		    <h1><span class="reviewHeader"></span>&nbsp;<b>리뷰★</b></h1>      
		</div>
		<div class="reviewBody">
			<div class="panel panel-warning">
			<div class="panel-heading">리뷰 ${reviewCount}개
				
			</div>
			<div class="panel-body">
			    <table class="reviewList">		
					<tr class="reviewHeader">
						<th style="width:200px;">번호</th>
						<th style="width:400px;">제목</th>
						<th style="width:250px;">작성자</th>
						<th style="width:200px;">작성일</th>
					</tr>
					<c:forEach var="dto" items="${reviewlist}">
						<tr class="reviews">
							<td>${dto.listNum}</td>
							<td><a href="<%=cp%>/user/review/article?reviewNum=${dto.reviewNum}">${dto.reviewTitle}</a></td>
							<td>${dto.userName}</td>
							<td>${dto.reviewCreated}</td>
						</tr>
					</c:forEach>	
				</table>
				${paging}
			</div>
  			</div>	
		</div>
	</div>
</div>