<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">
function sendFaq() {
	var f=document.faqForm;
	var s=f.faqTitle.value;
	if(! s) {
		alert("질문을 입력하세요.");
		f.faqTitle.focus();
		return;
	}
	s=f.faqContent.value;
	if(! s) {
		alert("답변을 입력하세요.");
		f.faqContent.focus();
		return;
	}
	f.action="<%=cp%>/admin/faq/${mode}";
	f.submit();
}
</script>
<div class="container">
	<div style="margin: 0px auto; padding-top: 40px;">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-info-sign"></span>&nbsp;<b>FAQ</b></h1>      
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
				<form name="faqForm" method="post">
				<table
					style="width: 100%; margin: 10px auto 0px; border-spacing: 0px;">
					<tr>
						<td width="80" valign="top"
							style="text-align: right; padding-top: 5px;"><label
							style="font-weight: 900;">질문</label></td>
						<td style="padding: 0 0 15px 15px;">
							<p style="margin-bottom: 5px;">
								<input type="text" name="faqTitle" value="${dto.faqTitle }"
									style="width: 95%;" maxlength="100" class="boxTF">
							</p>
						</td>
					</tr>
		
					<tr>
						<td width="80" valign="top"
							style="text-align: right; padding-top: 5px;"><label
							style="font-weight: 900;">답변</label></td>
						<td style="padding: 0 0 15px 15px;">
							<p style="margin-bottom: 10px;">
								<textarea name="faqContent" rows="15" class="boxTA"
									style="width: 95%;">${dto.faqContent }</textarea>
							</p>
						</td>
					</tr>
				</table>
				<table style="width: 100%; margin:0px auto; margin-top: 10px;">
					<tr height="45">
						<td align="center">
							<c:if test="${mode=='update'}">
								<input type="hidden" name="faqNum" value="${dto.faqNum}">
							</c:if> 
							<button type="button" class="btn btn-default" onclick="sendFaq();">${mode=='update'?'수정완료':'등록하기'}</button>
							<button type="reset" class="btn btn-default">다시입력</button>
							<button type="button" class="btn btn-default"
								onclick="javascript:location.href='<%=cp%>/admin/faq/list';">${mode=='update'?'수정취소':'등록취소'}</button>
						</td>
					</tr>
				</table>
			</form>
			</div>
		</div>
	</div>		
</div>
