<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">
function updateFaq(faqNum) {
	<c:if test="${sessionScope.member.enabled==3}">
		var url="<%=cp%>/admin/faq/update?faqNum="+faqNum;
		location.href=url;
	</c:if>
	<c:if test="${sessionScope.member.enabled!=3}">
		alert("게시물을 수정할 수 없습니다.");
	</c:if>
}
$(function() {
	$("body").on("click", ".deleteFaq", function() {
		<c:if test="${sessionScope.member.enabled==3}">
			if(! confirm("게시물을 삭제하시겠습니까?")) {
				return false;
			}
			
			var faqNum=$(this).attr("data-faqNum");
			var url="<%=cp%>/admin/faq/delete";
			var query="faqNum="+faqNum;
			var deleteclass=".tr"+faqNum;
			
			$.ajax({
				type:"post"
				,url:url
				,data:query
				,dataType:"json"
				,success:function(data) {
					var state=data.state;
					if(state="true") {
						alert("게시물을 삭제하였습니다.");
						$(deleteclass).remove();
					} else {
						alert("게시물을 삭제에 실패하였습니다.");
					}
				}
				,error:function(e) {
					console.log(e.responseText);
				}
			});
		</c:if>
		<c:if test="${sessionScope.member.enabled!=3}">
			alert("게시물을 삭제할 수 없습니다.");
		</c:if>
	});
});

$(function() {
	$("body").on("click", ".faqTitle", function() {
		
		var $div = $(this).closest("tr").next().find("div");

		var isVisible=$div.is(":visible");
		if(isVisible) {
			$div.hide();
		} else {
			$div.show();
		}
	});
	
});

</script>
<div class="container">
	<div style="margin: 0px auto; padding-top: 40px; margin-bottom:200px">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-info-sign"></span>&nbsp;<b>FAQ</b></h1>      
		</div>
		<div class="row">
		    <div class="col-sm-2">
		      <div class="panel panel-default">
			  <div class="panel-heading" style="height: 50px; font-size: 25px;"><b>고객센터</b></div>
			  
			  <div class="list-group">
				  <a href="<%=cp%>/admin/faq/list" class="list-group-item active">FAQ</a>
				  <a href="<%=cp%>/admin/qna/list" class="list-group-item">Q&amp;A</a>
			  </div>
			  
			</div>
		    </div>
		<div class="col-sm-10">
		<div>
			<div class="panel panel-default">
				<div class="panel-heading">
	      			<a href="<%=cp%>/admin/main" style="color:black;"><span class="glyphicon glyphicon-home"></span></a>&nbsp;
			        <span class="glyphicon glyphicon-chevron-right"></span>&nbsp;
			        <a href="<%=cp%>/admin/faq/list" style="color:black;">고객센터</a>&nbsp;
			        <span class="glyphicon glyphicon-chevron-right"></span>&nbsp;
			        <a href="<%=cp%>/admin/faq/list" style="color:black;">FAQ</a>&nbsp;
       			</div>
				<div class="panel-body">
					<table style="  border-collapse: separate; border-spacing: 0 5px;">
						<tbody>
						<c:forEach var="dto" items="${list }">
							<tr class="tr${dto.faqNum }">
								<td>
								<c:if test="${sessionScope.member.enabled==3}">
									<button type="button" class="btn btn-default faqTitle" style="width:700px; height: 50px; font-size: 15px;">
										<div align="left">
											${dto.faqTitle }
										</div>
									</button>
									<button type="button" class="btn" onclick="updateFaq(${dto.faqNum})" style="width:100px; height: 50px; font-size: 15px;">
									수정</button>
									<button type="button" class="btn deleteFaq" data-faqNum="${dto.faqNum }" style="width:100px; height: 50px; font-size: 15px;">
									삭제</button>
								</c:if>
								</td>
							</tr>
							<tr class="tr${dto.faqNum }">
								<td>
									<div style="width:700px; text-align: left; display: none; margin:10px; margin-top:0;"  class="faqContent">
									${dto.faqContent }
									</div>
								</td>
							</tr>
							
						</c:forEach>	
						</tbody>
					</table>
					<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
						<tr height="35">
							<td align="center">${dataCount!=0 ? paging : "등록된 게시물이 없습니다." }
							</td>
						</tr>
					</table>
					<div style="margin-top:20px;">
					<c:if test="${sessionScope.member.enabled==3 }">
					<button type="button" class="btn btn-default btn-sm" 
						onclick="javascript:location.href='<%=cp%>/admin/faq/created';">
						FAQ 작성</button>
					</c:if>
					</div>	
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</div>
