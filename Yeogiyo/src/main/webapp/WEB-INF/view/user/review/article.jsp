<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script type="text/javascript">
$(function(){
	$(".reviewCreateBtn").click(function(){
		var userId="${sessionScope.member.userId}";
		if(! userId){
			location.href ="<%=cp%>/user/member/login";
			return false;
		}
		var hotelId = $(this).attr("data-hotelId");
		var userId=userId;
		var reviewNum = $(this).attr("data-reviewNum");	
		var $tb = $(this).closest("tr");
		var replyContent=$tb.find("textarea").val().trim();
		if(! replyContent) {
			$tb.find("textarea").focus();
			return false;
		}
		replyContent = encodeURIComponent(replyContent);
		
		var query="reviewNum="+reviewNum+"&replyContent="+replyContent+"&userId="+userId;
		var url="<%=cp%>/user/review/replycreate";
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				$tb.find("textarea").val("");
				
				var state=data.state;
				if(state=="true") {
					location.href="<%=cp%>/user/review/article?reviewNum="+reviewNum;
				} else if(state=="false") {
					alert("댓글을 추가 하지 못했습니다.");
				}
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
			}
		});
		
	});
	
	$(".reviewReportBtn").click(function(){
		var reviewNum = $(this).attr("data-reviewNum");	
		var hotelId = $(this).attr("data-hotelId");
		
		if(confirm("이 리뷰를 신고 하시겠습니까 ? ")) {
		
			$("form[name=reportForm] input[name=hotelId]").val(hotelId);
			$("form[name=reportForm] input[name=reviewNum]").val(reviewNum);
			$("form[name=reportForm]").submit();
		}
		
	});

	$(".reviewDeleteBtn").click(function(){
		var reviewNum = $(this).attr("data-reviewNum");	
		var query ="reviewNum="+reviewNum;
		if(confirm("이 글을 삭제 하시겠습니까 ? ")) {
			location.href="<%=cp%>/user/review/delete?" + query;
		}
	});
	
	$(".replyDelete").click(function(){
		var replyNum = $(this).attr("data-replyNum");	
		var reviewNum = $(this).attr("data-reviewNum");
		var query ="replyNum="+replyNum+"&reviewNum="+reviewNum;
		var url="<%=cp%>/user/review/replydelete";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					location.href="<%=cp%>/user/review/article?reviewNum="+reviewNum;
				} else if(state=="false") {
					alert("댓글을 삭제 하지 못했습니다.");
				}
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
			}
		});
		
	});
});

</script>
<style type="text/css">

.reviewarticle{
	margin: 0 auto;
}
.reviewBtn {
	padding-bottom : 10px;
	float:right;
}

.reviewReplytext{
	resize: none;
}
.reviewReplyList{
	resize: none;
	
}

.reviewCreateBtn {
	float:right;
}
.replyDelete {
	float:right; 
}


</style>
<div class="container" style="width:800px;">
	<div style="padding-top: 10px; padding-bottom: 20px;">
		<div class="page-header">
		    <h1><span class="reviewHeader"></span>&nbsp;<b>리뷰★</b></h1>      
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
				<table>
					<tr>
						<td style="width:60px; padding-bottom:5px;">제목 :<td>
						<td style="width:660px; padding-bottom:5px;">${article.reviewTitle}</td>
					</tr>
					<tr>
						<td style="padding-bottom:5px;">작성일 :<td>
						<td style="padding-bottom:5px;">${article.reviewCreated}</td>
					</tr>
					
					<tr>
						<td style="padding-bottom:5px;">작성자 :<td>
						<td style="padding-bottom:5px;">${article.userName}</td>
					</tr>
					<tr>
						<td style="padding-bottom:5px;">평점 :<td>
						<td style="padding-bottom:5px;">${article.score}점</td>
					</tr>
					<tr>
						<td style="padding-bottom:5px;">내용 :<td>
						<td style="padding-bottom:5px;">${article.reviewContent}</td>
					</tr>
				
				</table>
				
				<div class="reviewBtn">
					<button type="button" onclick="location.href='<%=cp%>/user/review/list';">리스트</button>
					<c:if test="${sessionScope.member.userId=='admin' || sessionScope.member.userId==article.userId}">
						<button type="button" class="reviewDeleteBtn" data-reviewNum="${article.reviewNum}" name="reviewDeleteBtn">리뷰삭제</button>&nbsp;
						
					</c:if>
					<c:if test="${sessionScope.member.enabled==2}">
						<button type="button" class="reviewReportBtn" data-reviewNum="${article.reviewNum}" data-hotelId="${article.hotelId}" name="reviewReportBtn">리뷰신고</button>						
					</c:if>
				</div>
					
			</div>	
		</div>	
			
		
		<div class="panel panel-default">
			<div class="panel-body">
				<table class="reviewReplyListTable">
					<c:forEach var="dto" items="${replylist}">
						<tr style="height:100px; padding-left:10px;" >
							<td style="padding:10px;">
								${dto.userId}
							</td>
							<td style="padding-left:10px;">
								<div class="panel panel-default">
									<div class="panel-body" style="width:600px;">
										${dto.replyContent}
									</div>
								</div>
							</td>
							<td style="padding-left:10px;">
								<button type="button" class="replyDelete" data-replyNum="${dto.replyNum}" data-reviewNum="${dto.reviewNum}">삭제</button>
							</td>
						</tr>
						
					</c:forEach>
				</table>	
				<table class="reviewReplyListTable">
					<tr>
						<td style="width:84px; padding-left:10px;"></td>
						<td style="padding-left:10px;"><textarea cols="80" rows="5" class="reviewReplytext"></textarea></td>
						<td style="padding-left:20px;"><button type="button" class="reviewCreateBtn" data-reviewNum="${article.reviewNum}">등록</button></td>			
					</tr>
				</table>
			
			</div>
		</div>
	</div>
</div>

<form action="<%=cp%>/user/review/report" method="post" name="reportForm">
	<input type="hidden" name="reviewNum">
	<input type="hidden" name="hotelId">
</form>