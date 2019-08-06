<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.submit();
}
</script>

<div class="container">
	<div style="margin: 0px auto; padding-top: 30px;  margin-bottom:100px;">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<b>Q&amp;A</b></h1>      
		</div>
		<div class="row">
		    <div class="col-sm-2">
		      <div class="panel panel-default">
			  <div class="panel-heading" style="height: 50px; font-size: 25px;"><b>고객센터</b></div>
			  
			  <div class="list-group">
				  <a href="<%=cp%>/user/faq/list" class="list-group-item">FAQ</a>
				  <a href="<%=cp%>/user/qna/list" class="list-group-item active">Q&amp;A</a>
			  </div>
			  
			</div>
		    </div>
		    <div class="col-sm-10">
		<div>
			<div class="panel panel-default">
				<div class="panel-heading">
      			<a href="<%=cp%>/user/main" style="color:black;"><span class="glyphicon glyphicon-home"></span></a>&nbsp;
		        <span class="glyphicon glyphicon-chevron-right"></span>&nbsp;
		        <a href="<%=cp%>/user/faq/list" style="color:black;">고객센터</a>&nbsp;
		        <span class="glyphicon glyphicon-chevron-right"></span>&nbsp;
		        <a href="<%=cp%>/user/qna/list" style="color:black;">Q&amp;A</a>&nbsp;
        		</div>
				<div class="panel-body">
					<table style="width: 100%; margin: 5px auto 0px; border-spacing: 0px;">
							<tr height="10">
								<td align="left" width="50%">
									${dataCount}개(${page}/${total_page} 페이지)</td>
								<td align="right">&nbsp;</td>
							</tr>
						</table>
						<table class="table">
							<thead>
								<tr>
									<th width="100">번호</th>
									<th>제목</th>
									<th width="150">작성자</th>
									<th width="150">작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${list }">
									<tr>
										<td>${dto.listNum }</td>
										<td>
										<c:forEach var="n" begin="1" end="${dto.qnaDepth}">
							               &nbsp;
							           </c:forEach>
							           <c:if test="${dto.qnaDepth!=0}">└&nbsp;</c:if>
							           <a href="${articleUrl}&qnaNum=${dto.qnaNum}">${dto.qnaTitle}</a>
				                       <c:if test="${dto.gap < 1}">
				                             <img src='<%=cp%>/resource/images/new.gif'>
				                       </c:if>
										</td>
										<td>${dto.userId }</td>
										<td>${dto.qnaCreated }</td>
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
						<table style="width: 100%; margin: 20px auto; border-spacing: 0px;">
							<tr height="40">
								<td align="left" width="100">
									<button type="button" class="btn btn-default btn-sm"
										onclick="javascript:location.href='<%=cp%>/user/qna/list';">새로고침</button>
								</td>
								<td align="center">
									<form name="searchForm" action="<%=cp%>/user/qna/list"
										method="post">
										<select name="condition" class="selectField" style="height:30px;">
											<option value="all"
												${condition=="all" ? " selected='selected' ": "" }>모두</option>
											<option value="subject"
												${condition=="subject" ? " selected='selected' ": "" }>제목</option>
											<option value="userId"
												${condition=="userId" ? " selected='selected' ": "" }>아이디</option>
											<option value="content"
												${condition=="content" ? " selected='selected' ": "" }>내용</option>
											<option value="created"
												${condition=="created" ? " selected='selected' ": "" }>등록일</option>
										</select> <input type="text" name="keyword" class="boxTF"
											value="${keyword}">
										<button type="button" class="btn btn-default btn-sm"
											onclick="searchList()">검색</button>
									</form>
								</td>
								
								<td align="right" width="100">
								<c:if test="${not empty sessionScope.member }">
									<button type="button" class="btn btn-default btn-sm"
										onclick="javascript:location.href='<%=cp%>/user/qna/created';">
										Q&amp;A 작성
									</button>
								</c:if>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>