<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
<c:if test="${dto.userId==sessionScope.member.userId || sessionScope.member.enabled==3}">
	function deleteBbs(num) {
		if(confirm("게시물을 삭제 하시겠습니까?")) {
			var url="<%=cp%>/admin/bbs/delete?num="+num+"&${query}";
			location.href=url;
		}
	}
</c:if>
function login() {
	location.href="<%=cp%>/admin/member/login";
}
$(function() {
	$(".btnSendBbsLike").click(function() {
		<c:if test="${empty sessionScope.member}">
			alert("좋아요는 회원만 가능합니다.");
			return false;
		</c:if> 
		if(! confirm("좋아요 버튼을 눌르겠습니까?")) {
			return false;
		}
		var url="<%=cp%>/admin/bbs/insertBbsLike";
		var num="${dto.num}";
		$.ajax({
			type:"post"
			,url:url
			,data:{num:num}
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					var count=data.bbsLikeCount;
					$("#bbsLikeCount").text(count);
				} else {
					alert("좋아요는 한번만 가능합니다.!");
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
	var url="<%=cp%>/admin/bbs/listReply";
	var query="num=${dto.num}&pageNo="+page;
	
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
		var num="${dto.num}";
		var $tb=$(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(! content) {
			alert("댓글 내용을 입력해주세요");
			$tb.find("textarea").focus();
			return false;
		}
		content=encodeURIComponent(content);
		
		var query="num="+num+"&content="+content+"&answer=0";
		var url="<%=cp%>/admin/bbs/insertReply";
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,success:function(data) {
				$tb.find("textarea").val("");
				var state=data.state;
				if(state=="true") {
					listPage(1);
				} else {
					alert("댓글을 쓰는데 실패하였습니다");
				}
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
		
	});

	$("body").on("click", ".deleteReply", function() {
		if(! confirm("댓글을 삭제하시겠습니까?")) {
			return false;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url="<%=cp%>/admin/bbs/deleteReply";
		var query="replyNum="+replyNum+"&mode=reply";
		
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
	});

	$("body").on("click", ".btnSendReplyLike", function() {
		<c:if test="${empty sessionScope.member}">
			alert("좋아요는 회원만 가능합니다.");
			return false;
		</c:if> 
		if(! confirm("좋아요 버튼을 눌르겠습니까?")) {
			return false;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var $btn=$(this);
		
		var url="<%=cp%>/admin/bbs/insertReplyLike";
		var query="replyNum="+replyNum;
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					var likeCount=data.likeCount;
					$btn.parent("td").children().find("span").last().html(likeCount);
				} else {
					alert("좋아요는 한번만 가능합니다");
				}
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
	});
});

$(function() {
	$("body").on("click", ".btnReplyAnswerLayout", function() {
		var $trReplyAnswer=$(this).closest("tr").next();
		
		var isVisible=$trReplyAnswer.is(":visible");
		var replyNum=$(this).attr("data-replyNum");
		
		if(isVisible) {
			$trReplyAnswer.hide();
		} else {
			$trReplyAnswer.show();
			
			listReplyAnswer(replyNum);
			countReplyAnswer(replyNum);
		}
	});
	
	$("body").on("click", ".btnSendReplyAnswer", function() {
		var num="${dto.num}";
		var replyNum=$(this).attr("data-replyNum");
		var $textarea=$(this).closest("td").find("textarea");
		var content=$textarea.val().trim();
		console.log(content);
		if(! content) {
			alert("내용을 입력해 주세요.");
			$textarea.focus();
			return false;
		}
		content=encodeURIComponent(content);
		
		var url="<%=cp%>/admin/bbs/insertReply";
		var query="num="+num+"&content="+content+"&answer="+replyNum;
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					$textarea.val("");
					listReplyAnswer(replyNum);
					countReplyAnswer(replyNum);
				} else {
					alert("답글 등록에 실패하였습니다.");
				}
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
	});
});

function listReplyAnswer(answer) {
	var url="<%=cp%>/admin/bbs/listReplyAnswer";
	$.ajax({
		type:"get"
		,url:url
		,data:{answer:answer}
		,success:function(data) {
			var idAnswerList="#listReplyAnswer"+answer;
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

function countReplyAnswer(answer) {
	var url="<%=cp%>/admin/bbs/countReplyAnswer";
	$.ajax({
		type:"post"
		,url:url
		,data:{answer:answer}
		,dataType:"json"
		,success:function(data) {
			var answerCount=data.answerCount;
			var idAnswerCount="#answerCount"+answer;
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
		if(! confirm("답글을 삭제하시겠습니까?")) {
			return false;
		}
		
		var replyNum=$(this).attr("data-replyNum");
		var answer=$(this).attr("data-answer");
		
		var url="<%=cp%>/admin/bbs/deleteReply";
		var query="replyNum="+replyNum+"&mode=answer";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					listReplyAnswer(answer);
					countReplyAnswer(answer);
				} else {
					alert("답글을 지우는데 실패하였습니다");
				}
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
	});
});

</script>
<div class="container">
	<div style="margin: 0px auto; padding-top: 40px; margin-bottom:100px;">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-comment"></span>&nbsp;<b>자유게시판</b></h1>      
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
			<table class="table">
				<thead>
					<tr>
						<th colspan="2">${dto.subject }</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="50%" align="left" style="padding-left: 5px;">작성자
							: ${dto.userId}</td>
						<td width="50%" align="right" style="padding-right: 5px;">
							${dto.created } | 조회 ${dto.hitCount }</td>
					</tr>
					<tr>
						<td colspan="2" align="left" style="padding: 10px 5px;"
							valign="top" height="200">${dto.content }</td>
					</tr>
					<tr>
						<td colspan="2" height="40" style="padding-bottom: 15px;" align="center">
							<button type="button" class="btn btn-default btnSendBbsLike">
							<span class="glyphicon glyphicon-thumbs-up"></span>&nbsp;
							<span id="bbsLikeCount">${dto.bbsLikeCount}</span></button>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="left" style="padding-left: 5px;">
							다음글:
							<c:if test="${not empty ndto}">
								<a href="<%=cp%>/admin/bbs/article?${query}&num=${ndto.num}">${ndto.subject}</a>
							</c:if>
							</td>
					</tr>
					<tr>
						<td colspan="2" align="left" style="padding-left: 5px;">
							이전글:
							<c:if test="${not empty pdto}">
								<a href="<%=cp%>/admin/bbs/article?${query}&num=${pdto.num}">${pdto.subject}</a>
							</c:if>
							</td>
					</tr>
				</tbody>
			</table>
			<table
				style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
				<tr height="45">
					<td width="300" align="left">
						<c:if test="${sessionScope.member.userId == dto.userId}">
							<button type="button" class="btn btn-default"
								onclick="javascript:location.href='<%=cp%>/admin/bbs/update?num=${dto.num}&${query}';">수정</button>
						</c:if><c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.enabled==3}">
							<button type="button" class="btn btn-default"
								onclick="deleteBbs('${dto.num}');">삭제</button>
						</c:if> </td>

					<td align="right">
						<button type="button" class="btn btn-default"
							onclick="javascript:location.href='<%=cp%>/admin/bbs/list?${query}';">리스트</button>
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