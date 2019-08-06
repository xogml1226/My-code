<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<div class="container">
	<div style="padding-top: 10px; padding-bottom: 30px;">
		<div class="page-header">
		    <h1><span class="reviewHeader"></span>&nbsp;<b>호텔 문의사항</b></h1>      
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
				<form name="hotelqnaCreateForm" method="post" action="<%=cp%>/user/hotel/hotelqnaCreateComplete">
					<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
						<tr>						
							<td style="width:70px; padding-left:30px;">
								<label style="font-weight: 900; valign:top;">제목 : </label>
							</td>
							<td style="width:700px; padding-left:50px;"><input type="text" name="hotelqnaTitle" style="width:860px; padding:5px 5px 5px 5px;"></td>
						</tr>	
						<tr>					
							<td style="width:70px; padding-left:30px;">
								<label style="font-weight: 900; valign:top; ">내용 : </label>
							</td>					
							<td style="width:500px; padding-left:50px; padding-top:30px;">
								<textarea rows="10" cols="120" class="noresize" name="hotelqnaContent" style="padding:5px 5px 5px 5px; resize:none;"></textarea>
							</td>
						</tr>
					</table>
					
					<input type="hidden" name="hotelId" value="${map.hotelId}">
					<input type="hidden" name="userId" value="${map.userId}">
					<div>
						<button type="submit" style="align:rignt">글쓰기</button>
						<button type="button" onclick="javascript:location.href='<%=cp%>/user/main';" style="align:rignt">홈으로</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>