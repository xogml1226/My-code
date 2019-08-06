<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
function deleteReport() {
	var q="&mode=report";
	var url="<%=cp%>/admin/report/delete?reviewNum=${dto.reviewNum}&${query}"+q;
	if(confirm("이 신고를 삭제하시겠습니까?")) {
		location.href=url;
	}
}

function deleteReview() {
	var q="&mode=review";
	var url="<%=cp%>/admin/report/delete?reviewNum=${dto.reviewNum}&${query}"+q;
	if(confirm("이 리뷰를 삭제하시겠습니까?")) {
		location.href=url;
	}
}
</script>
<div class="container">
	<div style="margin: 0px auto; padding-top: 40px; margin-bottom:100px;">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-edit"></span>&nbsp;<b>신고 리뷰</b></h1>      
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th colspan="2">${dto.reviewTitle }</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="50%" align="left" style="padding-left: 5px;"><b>작성자</b> 
								${dto.userId}</td>
							<td width="50%" align="right" style="padding-right: 5px;">
								${dto.reviewCreated }</td>
						</tr>
						<tr>
							<td width="50%" align="left" style="padding-left: 5px;"><b>호텔이름</b> 
								${dto.hotelName}</td>
							<td width="50%" align="right" style="padding-right: 5px;">
								<b>평점</b> ${dto.score }</td>
						</tr>
						<tr>
							<td colspan="2" align="left" style="padding: 10px 5px;"
								valign="top" height="200">${dto.reviewContent }</td>
						</tr>
						<tr>
							<td colspan="2" align="left" style="padding: 10px 5px;"
								valign="top" height="200">${dto.reportContent }</td>
						</tr>
						<tr>
							<td colspan="2" align="left" style="padding-left: 5px;">
								다음글:
								<c:if test="${not empty ndto}">
									<a href="<%=cp%>/admin/notice/article?page=${page }&reviewNum=${ndto.reviewNum}">${ndto.reviewTitle}</a>
								</c:if>
								</td>
						</tr>
						<tr>
							<td colspan="2" align="left" style="padding-left: 5px;">
								이전글:
								<c:if test="${not empty pdto}">
									<a href="<%=cp%>/admin/notice/article?page=${page }&reviewNum=${pdto.reviewNum}">${pdto.reviewTitle}</a>
								</c:if>
								</td>
						</tr>
					</tbody>
				</table>
				<table
					style="width: 100%; margin: 0px auto 10px; border-spacing: 0px;">
					<tr height="45">
						<td width="300" align="left">
							<c:if test="${sessionScope.member.enabled==3}">
								<button type="button" class="btn btn-default"
									onclick="deleteReview();">리뷰 삭제</button>
							</c:if><c:if test="${sessionScope.member.enabled==3}">
								<button type="button" class="btn btn-default"
									onclick="deleteReport();">신고 삭제</button>
							</c:if> </td>

						<td align="right">
							<button type="button" class="btn btn-default"
								onclick="javascript:location.href='<%=cp%>/admin/report/list';">리스트</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>	
</div>
