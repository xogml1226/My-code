<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">
function sendOk() {
	var f=document.noticeForm;
	var s=f.noticeTitle.value;
	if(! s) {
		alert("공지사항 제목을 입력하세요.");
		f.noticeTitle.focus();
		return;
	}
	
	s=f.noticeContent.value;
	if(! s) {
		alert("공지사항 내용을 입력하세요.");
		f.noticeTitle.focus();
		return;
	}
	
	f.action="<%=cp%>/admin/notice/${mode}";
	f.submit();
}
</script>
<div class="container">
	<div style="margin: 0px auto; padding-top: 40px; margin-bottom:100px;">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-bullhorn"></span>&nbsp;<b>공지사항</b></h1>      
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
				<form name="noticeForm" method="post">
					<table
						style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
						<tr>
							<td width="80" valign="top"
								style="text-align: right; padding-top: 5px;"><label
								style="font-weight: 900;">제목</label></td>
							<td style="padding: 0 0 15px 15px;">
								<p style="margin-bottom: 5px;">
									<input type="text" name="noticeTitle" style="width: 95%;"
										maxlength="100" class="boxTF" value="${dto.noticeTitle }">
								</p>
							</td>
						</tr>
						<tr>
							<td width="80" valign="top"
								style="text-align: right; padding-top: 5px;"><label
								style="font-weight: 900;">내용</label></td>
							<td style="padding: 0 0 15px 15px;">
								<p style="margin-bottom: 10px;">
									<textarea name="noticeContent" rows="12" class="boxTA"
										style="width: 95%;">${dto.noticeContent }</textarea>
								</p>
							</td>
						</tr>
						<tr>
							<td width="80" valign="top"
								style="text-align: right; padding-bottom: 5px;"><label
								style="font-weight: 900;">공지</label></td>
							<td style="padding: 0 0 15px 15px;">
								<p style="margin-bottom: 5px;">
								<input type="checkbox" name="notice" value="1" ${dto.notice==1 ? "checked='checked' ":"" } > 
								이 게시물을 공지합니다.
								</p>
							</td>
						</tr>
					</table>
					<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
						<tr height="40">
							<td align="center"><c:if test="${mode=='update'}">
									<input type="hidden" name="noticeNum" value="${dto.noticeNum}">
									<input type="hidden" name="page" value="${page}">
								</c:if> 
								<button type="button" class="btn btn-default" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
								<button type="reset" class="btn btn-default">다시입력</button>
								<button type="button" class="btn btn-default"
									onclick="javascript:location.href='<%=cp%>/admin/notice/list';">${mode=='update'?'수정취소':'등록취소'}</button>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>