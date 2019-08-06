<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
<c:if test="${dto.userId==sessionScope.member.userId || sessionScope.member.enabled==3}">
	function deleteQna(qnaNum) {
		if(confirm("게시물을 삭제 하시겠습니까?")) {
			var url="<%=cp%>/admin/qna/delete?qnaNum="+qnaNum+"&${query}";
			location.href=url;
		}
	}
</c:if>
</script>
<div class="container">
	<div style="margin: 0px auto; padding-top: 40px; margin-bottom:100px;">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<b>Q&amp;A</b></h1>      
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
			<table class="table">
				<thead>
					<tr>
						<th colspan="2">${dto.qnaDepth>0?"[Re] ":""}${dto.qnaTitle }</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="50%" align="left" style="padding-left: 5px;">작성자
							: ${dto.userId}</td>
						<td width="50%" align="right" style="padding-right: 5px;">
							${dto.qnaCreated }</td>
					</tr>
					<tr>
						<td colspan="2" align="left" style="padding: 10px 5px;"
							valign="top" height="200">${dto.qnaContent }</td>
					</tr>
					<tr>
						<td colspan="2" align="left" style="padding-left: 5px;">
							다음글:
							<c:if test="${not empty ndto}">
								<a href="<%=cp%>/admin/qna/article?${query}&qnaNum=${ndto.qnaNum}">${ndto.qnaTitle}</a>
							</c:if>
							</td>
					</tr>
					<tr>
						<td colspan="2" align="left" style="padding-left: 5px;">
							이전글:
							<c:if test="${not empty pdto}">
								<a href="<%=cp%>/admin/qna/article?${query}&qnaNum=${pdto.qnaNum}">${pdto.qnaTitle}</a>
							</c:if>
							</td>
					</tr>
				</tbody>
			</table>
			<table
				style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
				<tr height="45">
					<td width="300" align="left">
					<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.enabled==3}">
							<button type="button" class="btn btn-default"
								onclick="javascript:location.href='<%=cp%>/admin/qna/reply?qnaNum=${dto.qnaNum}&page=${page}';">답변</button>
					</c:if>
						<c:if test="${sessionScope.member.userId == dto.userId}">
							<button type="button" class="btn btn-default"
								onclick="javascript:location.href='<%=cp%>/admin/qna/update?qnaNum=${dto.qnaNum}&${query}';">수정</button>
						</c:if><c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
							<button type="button" class="btn btn-default"
								onclick="deleteQna('${dto.qnaNum}');">삭제</button>
						</c:if> </td>

					<td align="right">
						<button type="button" class="btn btn-default"
							onclick="javascript:location.href='<%=cp%>/admin/qna/list?${query}';">리스트</button>
					</td>
				</tr>
			</table>
			<hr>
			<table class="table">
				<thead>
					<tr>
						<th width="100">번호</th>
						<th>제목</th>
						<th width="150">작성자</th>
						<th width="150">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${listArticle }">
						<tr>
							<td>${vo.listNum }</td>
							<td>
							<c:forEach var="n" begin="1" end="${vo.qnaDepth}">
				               &nbsp;
				           </c:forEach>
				           <c:if test="${vo.qnaDepth!=0}">└&nbsp;</c:if>
				           <c:if test="${dto.qnaNum==vo.qnaNum }">
				           		${vo.qnaTitle }
				           </c:if>
				           <c:if test="${dto.qnaNum!=vo.qnaNum }">
				           <a href="<%=cp%>/admin/qna/article?${query }&qnaNum=${vo.qnaNum}">${vo.qnaTitle}</a>
	                       </c:if>
							</td>
							<td>${dto.userId }</td>
							<td>${dto.qnaCreated }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			</div>
		</div>	
	</div>
</div>