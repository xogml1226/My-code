<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">

$(function(){
	$(".wishDeleteBtn").click(function(){
		var userId="${sessionScope.member.userId}";
		if(! userId){
			location.href ="<%=cp%>/user/member/login";
			return false;
		}
		var hotelId = $(this).attr("data-hotelId");
		var userId=userId;
		location.href ="<%=cp%>/user/wishlist/delete?hotelId="+hotelId+"&userId="+userId;
	});
});
</script>

<style type="text/css">

.wish {
	margin-top:50px;
	height:700px;
}

.wishList{
	text-align:center;
	
}

</style>
<div class="container">
	<div style="padding-bottom: 20px;">
		<h1> 위시리스트</h1>
		<div class="panel-body">
			<div>
				총 ${wishlistCount} 개  ${current_page}/ ${total_page}
			</div>
			<table class="wishList">
				<tr>
					<th>호텔명</th>
					<th>주소</th>
					<th>특징</th>
					<th>대표사진</th>
					<th></th>
				</tr>
				
				<c:forEach var="dto" items="${list}">
					<tr>
						<td style="width:150px; padding:20px; marging:20px;"><a>${dto.hotelName}</a></td>
						<td style="width:150px; padding:20px; marging:20px;">${dto.addr1}, ${dto.addr2}</td>
						<td style="width:350px; padding:20px; marging:20px;">${dto.detail}</td>
						<td style="width:250px; padding:20px; marging:20px;"><img src="<%=cp%>/resource/images/hotel/${dto.mainphoto}.jpg" style="width:200px; height:100px;"></td>
						<td style="width:150px; padding:20px; marging:20px;"><button type="button" class="wishDeleteBtn" data-hotelId="${dto.hotelId}">삭제하기</button></td>
					</tr>
				</c:forEach>
			</table>
			${paging}
		</div>
	</div>
</div>