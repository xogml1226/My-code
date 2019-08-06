<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


<script type="text/javascript">
$(function(){
	$("#replyContent").val("");
	
	$("#replayAdd").click(function(){

		var reviewNum = $("#reviewNum").val();
		var replyContent = $("#replyContent").val();
		
		var query = "?reviewNum="+reviewNum+"&replyContent="+replyContent;
		query += "&page=${page}&condition=${condition}&keyword=${keyword}";

		location.href = "<%=cp%>/owner/review/insert"+query;
		
	});
});

function deleteReply(replyNum){
	var reviewNum = $("#reviewNum").val();
	var query = "?replyNum="+replyNum+"&reviewNum="+reviewNum
	query += "&page=${page}&condition=${condition}&keyword=${keyword}";
	if(confirm("정말 삭제하시겠습니까?"))
		location.href = "<%=cp%>/owner/review/delete"+query;
	
}

function backList(){
	var query = "page=${page}&condition=${condition}&keyword=${keyword}";
	location.href = "<%=cp%>/owner/review/list?"+query;
}
</script>
<div class="container">
	<div style="width:100%; margin:0 auto; padding-top:30px;">
		 <h1><span class="glyphicon glyphicon-comment"></span>&nbsp;<b>댓글</b></h1>
	</div>
	<div style="border:1px solid gray; padding:10px; border-radius:20px; margin-bottom:10px;">
		<table style="width:100%; height:50%;" border="1">
			<tr>
				<th style="text-align:center;">제목</th>
				<td>&nbsp;${dto.reviewTitle }</td>
			</tr>
			<tr>
				<th style="text-align:center;">작성자</th>
				<td>&nbsp;${dto.userId }</td>
			</tr>
			<tr>
				<th style="text-align:center;">작성일</th>
				<td>&nbsp;${dto.reviewCreated }</td>
			</tr>
			<tr>
				<th style="text-align:center;">내용</th>
				<td>&nbsp;${dto.reviewContent}</td>
			</tr>
		</table>
		<div style="margin-top:10px;">
			<p><b><h4>댓글</h4></b></p>
			<input type="hidden" id="reviewNum" value="${dto.reviewNum }">
			<div id="replyList" style="background-color:#DDDDDD;">
				<c:forEach var="dto" items="${list }">
				<input type="hidden" class="replyNum" value="${dto.replyNum}">
					<p>└&nbsp;${dto.userId }
						<c:if test="${sessionScope.member.userId==dto.userId}">	
						(<a style="cursor:pointer" onclick="deleteReply('${dto.replyNum}')">삭제</a>)
						</c:if>
					</p>
					<div class="replyContent" style="padding-left:20px;">${dto.replyContent }</div>
					 
				</c:forEach>
			</div>
			
			<textarea id="replyContent" rows="3" cols="50">
			</textarea>
			<p><button type="button" id="replayAdd" class="btn">댓글작성</button>
			&nbsp;<button type="button" id="backList" onclick="backList()" class="btn">리스트</button></p>
		</div>
	</div>
</div>