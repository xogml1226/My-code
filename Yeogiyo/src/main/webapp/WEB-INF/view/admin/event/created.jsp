<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">
$(function() {
	$("#eventStart").datepicker({
		showMonthAfterYear : true
	});
	$("#eventEnd").datepicker({
		showMonthAfterYear : true
	});
	
	$("#eventEnd").change(function() {
		var eventStart = new Date($("#eventStart").datepicker("getDate"));
	    var eventEnd = new Date($("#eventEnd").datepicker("getDate"));
	    if(eventEnd - eventStart < 0) {
	      alert("종료 날짜가 시작날짜보다 이전일수 없습니다"); 
	      $("#eventEnd").val("");
	      return false;
	    } 
		
	});

});

function sendEvent() {
	
	var f=document.eventForm;
	var s=f.eventTitle.value;
	if(! s) {
		alert("제목을 입력하세요.");
		f.eventTitle.focus();
		return;
	}
	s=f.eventStart.value;
	if(! s) {
		alert("시작 날짜를 입력하세요.");
		f.eventStart.focus();
		return;
	}
	s=f.eventEnd.value;
	if(! s) {
		alert("종료 날짜를 입력하세요.");
		f.eventEnd.focus();
		return;
	}
	s=f.eventContent.value;
	if(! s) {
		alert("내용을 입력하세요.");
		f.eventContent.focus();
		return;
	}
	s=f.upload.value;
	<c:if test="${mode=='created'}">
	if(! s) {
		alert("이벤트 사진을 넣어주세요");
		f.upload.focus();
		return;
	}
	</c:if>
	var mode="${mode}";
    if(mode=="created"||mode=="update" && s!="") {
		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(s)) {
			alert('이미지 파일만 가능합니다.(bmp 파일은 불가) !!!');
			f.upload.focus();
			return;
		}
	}
	f.action="<%=cp%>/admin/event/${mode}";
	f.submit();
}
</script>
<div class="container">
	<div style="margin: 0px auto; padding-top: 30px; margin-bottom:100px;">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-gift"></span>&nbsp;<b>이벤트</b></h1>      
		</div>
		<div style="margin-top: 0">
			<div class="panel panel-default">
				<div class="panel-body">
					<form name="eventForm" method="post" enctype="multipart/form-data">
						<table
							style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
							<tr>
								<td width="80" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">제목</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 5px;">
										<input type="text" name="eventTitle" value="${dto.eventTitle }" style="width: 95%;"
											maxlength="100" class="boxTF">
									</p>
								</td>
							</tr>
							<tr>
								<td width="80" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">이벤트날짜</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 5px;">
									<input type="text" name="eventStart" id="eventStart" readonly="readonly" 
										class="boxTF" style="width: 250px; text-align: center;"
										value="${dto.eventStart }">
									~
						 			<input type="text" name="eventEnd" id="eventEnd" readonly="readonly" 
						 				class="boxTF" style="width: 250px; text-align: center;"
						 				value="${dto.eventEnd }">
									</p>
								</td>
							</tr>
							<tr>
								<td width="80" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">내용</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 5px;">
										<textarea name="eventContent" rows="15" class="boxTA"
											style="width: 95%;">${dto.eventContent }</textarea>
									</p>
								</td>
							</tr>
							<tr>
								<td width="80" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">이벤트사진</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 5px;">
										<input type="file" name="upload" class="boxTF" accept="image/*" >
									</p>
								</td>
							</tr>
						</table>
						<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
							<tr height="40">
								<td align="center">
									<c:if test="${mode=='update'}">
										<input type="hidden" name="eventNum" value="${dto.eventNum}">
										<input type="hidden" name="page" value="${page}">
										<input type="hidden" name="keyword" value="${keyword}">
										<input type="hidden" name="status" value="${status}">
										<input type="hidden" name="eventPhoto" value="${dto.eventPhoto}">
										
									</c:if>
									<button type="button" class="btn btn-default" onclick="sendEvent();">${mode=='update'?'수정완료':'등록하기'}</button>
									<button type="reset" class="btn btn-default">다시입력</button>
									<button type="button" class="btn btn-default"
										onclick="javascript:location.href='<%=cp%>/admin/event/list';">${mode=='update'?'수정취소':'등록취소'}</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>		
		</div>
	</div>
</div>