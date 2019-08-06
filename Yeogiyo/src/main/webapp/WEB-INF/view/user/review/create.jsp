<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style type="text/css">
.reviewCreate {
		width:850px;
		text-align:center;
		height: 750px;
		margin:30px auto;
		padding:10px;
		
}
.noresize {
	resize: none; 
}

</style>

<div class="container">
	<div style="padding-top:5px; padding-bottom: 50px; text-align:center;">
		
		<div class="reviewCreate">
			<div class="panel-body" style="border:1px solid black">
				<div class="reviewAbout">
			<h2>${review.hotelName}</h2>
			<h4>${review.roomName}</h4>
		</div>
				
				<h3>리뷰 작성하기</h3>	
				<form action="<%=cp%>/user/review/complete" name="reviewCreateForm" method="post" style="height:600px;">
					<p>제목</p>
					<p><input type="text" name="reviewTitle" style="width:550px;"></p>
					<p>내용</p>
					<p><textarea rows="15" cols="75" class="noresize" name="reviewContent"></textarea></p>
					<p>★평점★ (0~10) </p>
					<p>
						<select name="score">
							<c:forEach varStatus="s" begin="1" end="10">
								<option value="${s.count}">${s.count}</option>
							</c:forEach>
						</select>
					</p>
					<input type="hidden" name="hotelName" value="${review.hotelName}">
					<input type="hidden" name="hotelId" value="${review.hotelId}">
					<input type="hidden" name="roomName" value="${review.roomName}">
					<input type="hidden" name="reservationNum" value="${reservationNum}">
					
					<p><button type="submit">글 작성하기</button></p>
				</form>
			</div>
		</div>
	</div>
</div>