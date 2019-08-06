<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
<c:if test="${sessionScope.member.enabled==3}">
	function deleteEvent(eventNum) {
		if(confirm("게시물을 삭제 하시겠습니까?")) {
			var url="<%=cp%>/admin/event/delete?eventNum="+eventNum+"&${query}";
			location.href=url;
		}
	}

	function updateEvent(eventNum) {
		if(confirm("게시물을 수정 하시겠습니까?")) {
			var url="<%=cp%>/admin/event/update?eventNum="+eventNum+"&${query}";
			location.href=url;
		}
	}
</c:if>

function login() {
	location.href="<%=cp%>/user/member/login";
}

$(function() {
	$("body").on("click", ".btnSendEventLike", function() {	
		<c:if test="${empty sessionScope.member}">
			alert("좋아요는 회원만 가능합니다.");
			return false;
		</c:if>
		if(! confirm("좋아요 버튼을 눌르겠습니까?")) {
			return false;
		}
		var url="<%=cp%>/admin/event/insertEventLike";  
		var eventNum="${dto.eventNum}";
		$.ajax({
			type:"post"
			,url:url
			,data:{eventNum:eventNum}
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					var count=data.eventLikeCount;
					$("#eventLikeCount").text(count);
				} else {
					alert("좋아요는 한번만 가능합니다.");
				}	
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		login();
		    		return false;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
	});
});
$(function() {
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/admin/event/listReply"
	var query="eventNum=${dto.eventNum}&pageNo="+page;
	
	$.ajax({
		type:"get"
		,url:url
		,data:query
		,success:function(data) {
			$("#listReply").html(data);
		}
		,beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		}
		,error:function(jqXHR) {
			if(jqXHR.status==403) {
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
	
}

$(function() {
	$(".btnSendReply").click(function() {
		var eventNum="${dto.eventNum}";
		var $tb=$(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			alert("댓글 내용을 입력해주세요");
			$tb.find("textarea").focus();
			return false;
		}
		content=encodeURIComponent(content);
		
		var query="eventNum="+eventNum+"&eventreplyContent="+content+"&eventreplyAnswer=0";
		var url="<%=cp%>/admin/event/insertReply";
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				$tb.find("textarea").val("");
				var state=data.state;
				if(state=="true") {
					listPage(1);
				} else {
					alert("댓글을 쓰는데 실패하였습니다");
				}	
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		login();
		    		return false;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
	});
	
	$("body").on("click", ".deleteReply", function() {
		if(! confirm("댓글을 삭제하시겠습니까?")) {
			return false;
		}
		
		var eventreplyNum=$(this).attr("data-eventreplyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="<%=cp%>/admin/event/deleteReply";
		var query="eventreplyNum="+eventreplyNum+"&mode=reply";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					listPage(page);
				} else {
					alert("댓글을 지우는데 실패하였습니다");
				}	
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		login();
		    		return false;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
	});
});

$(function() {
	$("body").on("click", ".btnReplyAnswerLayout", function() {
		var $trReplyAnswer=$(this).closest("tr").next();
		
		var isVisible=$trReplyAnswer.is(":visible");
		var eventreplyNum=$(this).attr("data-eventreplyNum");
		
		if(isVisible) {
			$trReplyAnswer.hide();
		} else {
			$trReplyAnswer.show();
			
			listReplyAnswer(eventreplyNum);
			countReplyAnswer(eventreplyNum);
		}
	});
	
	
	$("body").on("click", ".btnSendReplyAnswer", function() {	
		var eventNum="${dto.eventNum}";
		var eventreplyNum=$(this).attr("data-eventreplyNum");
		var $textarea=$(this).closest("td").find("textarea");
		var content=$textarea.val().trim();
		if(! content) {
			alert("댓글 내용을 입력해주세요");
			$textarea.focus();
			return false;
		}
		content=encodeURIComponent(content);
		
		var query="eventNum="+eventNum+"&eventreplyContent="+content+"&eventreplyAnswer="+eventreplyNum;
		var url="<%=cp%>/admin/event/insertReply";
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					$textarea.val("");
					listReplyAnswer(eventreplyNum);
					countReplyAnswer(eventreplyNum);
				} else {
					alert("댓글을 쓰는데 실패하였습니다");
				}	
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		login();
		    		return false;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
	});
});

function listReplyAnswer(eventreplyAnswer) {
	var url="<%=cp%>/admin/event/listReplyAnswer";
	$.ajax({
		type:"get"
		,url:url
		,data:{eventreplyAnswer:eventreplyAnswer}
		,success:function(data) {
			var idAnswerList="#listReplyAnswer"+eventreplyAnswer;
			$(idAnswerList).html(data);
		}
		,beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		}
		,error:function(jqXHR) {
			if(jqXHR.status==403) {
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

function countReplyAnswer(eventreplyAnswer) {
	var url="<%=cp%>/admin/event/countReplyAnswer";
	$.ajax({
		type:"post"
		,url:url
		,data:{eventreplyAnswer:eventreplyAnswer}
		,dataType:"json"
		,success:function(data) {
			var answerCount=data.answerCount;
			var idAnswerCount="#answerCount"+eventreplyAnswer;
			$(idAnswerCount).html(answerCount);
		}
		,beforeSend:function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		}
		,error:function(jqXHR) {
			if(jqXHR.status==403) {
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}
$(function() {
	$("body").on("click", ".deleteReplyAnswer", function() {
		if(! confirm("댓글을 삭제하시겠습니까?")) {
			return false;
		}
		
		var eventreplyNum=$(this).attr("data-eventreplyNum");
		var eventreplyAnswer=$(this).attr("data-eventreplyAnswer");
		
		var url="<%=cp%>/admin/event/deleteReply";
		var query="eventreplyNum="+eventreplyNum+"&mode=answer";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					listReplyAnswer(eventreplyAnswer);
					countReplyAnswer(eventreplyAnswer);
				} else {
					alert("댓글을 지우는데 실패하였습니다");
				}	
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		login();
		    		return false;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
	});
});

</script>
<div class="container">
	<div style="margin: 0px auto; padding-top: 40px; margin-bottom:100px;">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-gift"></span>&nbsp;<b>이벤트</b></h1>      
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
			<table class="table">
				<thead>
					<tr>
						<th colspan="2">${dto.eventTitle }</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="50%" align="left" style="padding-left: 5px;">이벤트 날짜
							: ${dto.eventStart} ~ ${dto.eventEnd }</td>
						<td width="50%" align="right" style="padding-right: 5px;">
							${dto.eventCreated } | 상태 <b>${dto.eventStatus }</b></td>
					</tr>
					<tr>
						<td colspan="2" align="left" style="padding: 10px 5px;">
							<img src="<%=cp%>/uploads/eventPhoto/${dto.eventPhoto}"
								style="max-width:100%; height:auto; resize:both;">
						</td>
					</tr>
					<tr>
						<td colspan="2" align="left" style="padding: 10px 5px; height:auto;"
							valign="top">${dto.eventContent }</td>
					</tr>
					<tr>
						<td colspan="2" height="40" style="padding-bottom: 15px;" align="center">
							<button type="button" class="btn btn-default btnSendEventLike">
							<span class="glyphicon glyphicon-thumbs-up"></span>&nbsp;
							<span id="eventLikeCount">${dto.eventLikeCount}</span></button>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="left" style="padding-left: 5px;">
							다음글:
							<c:if test="${not empty ndto}">
								<a href="<%=cp%>/admin/event/article?${query}&eventNum=${ndto.eventNum}">${ndto.eventTitle}</a>
							</c:if>
							</td>
					</tr>
					<tr>
						<td colspan="2" align="left" style="padding-left: 5px;">
							이전글:
							<c:if test="${not empty pdto}">
								<a href="<%=cp%>/admin/event/article?${query}&eventNum=${pdto.eventNum}">${pdto.eventTitle}</a>
							</c:if>
							</td>
					</tr>
				</tbody>
			</table>
			<table
				style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
				<tr height="45">
					<td width="300" align="left">
						<c:if test="${sessionScope.member.enabled==3}">
							<button type="button" class="btn btn-default"
								onclick="updateEvent('${dto.eventNum}');">수정</button>
						</c:if><c:if test="${sessionScope.member.enabled==3}">
							<button type="button" class="btn btn-default"
								onclick="deleteEvent('${dto.eventNum}');">삭제</button>
						</c:if> </td>

					<td align="right">
						<button type="button" class="btn btn-default"
							onclick="javascript:location.href='<%=cp%>/admin/event/list?${query}';">리스트</button>
					</td>
				</tr>
			</table>
			<hr>
			<c:if test="${not empty sessionScope.member }">
			<table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
				<tr height='30'> 
					 <td align='left' >
					 	<span style='font-weight: bold;' >댓글쓰기</span>
					 </td>
				</tr>
				<tr>
				   	<td style='padding:5px 5px 0px;'>
						<textarea class='boxTA' style='width:100%; height: 70px;'></textarea>
				    </td>
				</tr>
				<tr>
				   <td align='right'>
				        <button type='button' class='btn btn-default btnSendReply' data-num='10'>댓글 등록</button>
				    </td>
				 </tr>
			</table>
			</c:if>
			<div id="listReply"></div>
			</div>
		</div>	
	</div>
</div>