<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">
function sendQna() {
	var f=document.qnaForm;
	var s=f.qnaTitle.value;
	if(! s) {
		alert("제목을 입력하세요");
		f.qnaTitle.focus();
		return;
	}
	s=f.qnaContent.value;
	if(! s) {
		alert("내용을 입력하세요");
		f.qnaTitle.focus();
		return;
	}
	f.action="<%=cp%>/admin/qna/${mode}";
	f.submit();
}
</script>
<div class="container">
	<div style="margin: 0px auto; padding-top: 30px; margin-bottom:100px;">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<b>Q&amp;A</b></h1>      
		</div>
		<div style="margin-top: 0">
			<div class="panel panel-default">
				<div class="panel-body">
					<form name="qnaForm" method="post">
						<table
							style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
							<tr>
								<td width="80" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">제목</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 5px;">
										<input type="text" name="qnaTitle" value="${dto.qnaTitle }" style="width: 95%;"
											maxlength="100" class="boxTF">
									</p>
								</td>
							</tr>
							<tr>
								<td width="80" valign="top"
									style="text-align: right; padding-bottom: 5px;"><label
									style="font-weight: 900;">작성자</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 5px;">${sessionScope.member.userId }</p>
								</td>
							</tr>
		
							<tr>
								<td width="80" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">내용</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 10px;">
										<textarea name="qnaContent" rows="15" class="boxTA"
											style="width: 95%;">${dto.qnaContent }</textarea>
									</p>
								</td>
							</tr>
						</table>
						<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
							<tr height="40">
								<td align="center"><c:if test="${mode=='update'}">
										<input type="hidden" name="qnaNum" value="${dto.qnaNum}">
										<input type="hidden" name="page" value="${page}">
										<input type="hidden" name="condition" value="${condition}">
										<input type="hidden" name="keyword" value="${keyword}">
									</c:if> <c:if test="${mode=='reply' }">
										<input type="hidden" name="qnaGroupNum" value="${dto.qnaGroupNum }">
										<input type="hidden" name="qnaOrderNo" value="${dto.qnaOrderNo }">
										<input type="hidden" name="qnaDepth" value="${dto.qnaDepth }">
										<input type="hidden" name="qnaParent" value="${dto.qnaNum }">
										<input type="hidden" name="page" value="${page}">
									</c:if>
		
									<button type="button" class="btn btn-default" onclick="sendQna();">${mode=='update'?'수정완료':(mode=='reply'? '답변완료':'등록하기')}</button>
									<button type="reset" class="btn btn-default">다시입력</button>
									<button type="button" class="btn btn-default"
										onclick="javascript:location.href='<%=cp%>/admin/qna/list';">${mode=='update'?'수정취소':(mode=='reply'? '답변취소':'등록취소')}</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>		
		</div>

	</div>
</div>