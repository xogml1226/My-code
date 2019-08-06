<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
function updateNotice() {
	<c:if test="${sessionScope.member.enabled==3}">
		var url="<%=cp%>/admin/notice/update?noticeNum=${dto.noticeNum}&page=${page}";
		location.href=url;
	</c:if>
	<c:if test="${sessionScope.member.enabled!=3}">
		alert("게시물을 수정할 수 없습니다.");
	</c:if>
}
function deleteNotice() {
	<c:if test="${sessionScope.member.enabled==3}">
	var url="<%=cp%>/admin/notice/delete?noticeNum=${dto.noticeNum}&page=${page}";
	if(confirm("이 공지사항을 삭제하시겠습니까?")) {
		location.href=url;
	}
	</c:if>
	<c:if test="${sessionScope.member.enabled!=3}">
	alert("게시물을 삭제할 수 없습니다.");
</c:if>
}
</script>
<div class="container">
	<div style="margin: 0px auto; padding-top: 40px; margin-bottom:100px;">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-bullhorn"></span>&nbsp;<b>공지사항</b></h1>      
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th colspan="2">${dto.noticeTitle }</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td width="50%" align="right" style="padding-right: 5px;">
								${dto.noticeCreated }</td>
						</tr>
						<tr>
							<td colspan="2" align="left" style="padding: 10px 5px;"
								valign="top" height="200">${dto.noticeContent }</td>
						</tr>
						<tr>
							<td colspan="2" align="left" style="padding-left: 5px;">
								다음글:
								<c:if test="${not empty ndto}">
									<a href="<%=cp%>/admin/notice/article?page=${page }&noticeNum=${ndto.noticeNum}">${ndto.noticeTitle}</a>
								</c:if>
								</td>
						</tr>
						<tr>
							<td colspan="2" align="left" style="padding-left: 5px;">
								이전글:
								<c:if test="${not empty pdto}">
									<a href="<%=cp%>/admin/notice/article?page=${page }&noticeNum=${pdto.noticeNum}">${pdto.noticeTitle}</a>
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
									onclick="updateNotice();">수정</button>
							</c:if><c:if test="${sessionScope.member.enabled==3}">
								<button type="button" class="btn btn-default"
									onclick="deleteNotice();">삭제</button>
							</c:if> </td>

						<td align="right">
							<button type="button" class="btn btn-default"
								onclick="javascript:location.href='<%=cp%>/admin/notice/list?page=${page}';">리스트</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>	
</div>
