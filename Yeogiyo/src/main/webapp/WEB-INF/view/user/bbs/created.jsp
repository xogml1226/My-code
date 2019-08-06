<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
function check() {
	var f=document.bbsForm;
	var s=f.subject.value;
	if(! s) {
		alert("제목을 입력하세요");
		f.subject.focus();
		return;
	}
	s=f.content.value;
	if(!s || s=="<p>&nbsp;</p>") {
		alert("내용을 입력하세요");
		f.content.focus();
		return;
	}
	
	f.action="<%=cp%>/user/bbs/${mode}";
	return true;
}
</script>
<div class="container">
	<div style="margin: 0px auto; padding-top: 30px; margin-bottom:100px;">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-comment"></span>&nbsp;<b>자유게시판</b></h1>      
		</div>
		<div style="margin-top: 0">
			<div class="panel panel-default">
				<div class="panel-body">
					<form name="bbsForm" method="post" onsubmit="return submitContents(this);">
						<table
							style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
							<tr>
								<td width="80" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">제목</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 5px;">
										<input type="text" name="subject" value="${dto.subject }" style="width: 95%;"
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
										<textarea name="content" rows="12" class="boxTA"
											style="width: 95%;" id="content">${dto.content }</textarea>
									</p>
								</td>
							</tr>
						</table>
						<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
							<tr height="40">
								<td align="center"><c:if test="${mode=='update'}">
										<input type="hidden" name="num" value="${dto.num}">
										<input type="hidden" name="page" value="${page}">
										<input type="hidden" name="condition" value="${condition}">
										<input type="hidden" name="keyword" value="${keyword}">
									</c:if> 
									<button type="submit" class="btn btn-default">${mode=='update'?'수정완료':'등록하기'}</button>
									<button type="reset" class="btn btn-default">다시입력</button>
									<button type="button" class="btn btn-default"
										onclick="javascript:location.href='<%=cp%>/user/bbs/list';">${mode=='update'?'수정취소':'등록취소'}</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>		
		</div>
	</div>
<script type="text/javascript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "<%=cp%>/resource/se/SmartEditor2Skin.html",	
		htParams : {bUseToolbar : true,
			fOnBeforeUnload : function(){
				//alert("test");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
	
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
		var sHTML = oEditors.getById["content"].getIR();
		alert(sHTML);
	}
		
	function submitContents(elClickedObj) {
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
		
		try {
			// elClickedObj.form.submit();
			return check();
		} catch(e) {}
	}
	
	function setDefaultFont() {
		var sDefaultFont = '돋움';
		var nFontSize = 24;
		oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
	}
</script>      	
</div> 