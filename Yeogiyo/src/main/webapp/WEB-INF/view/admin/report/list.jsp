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
		    <h1><span class="glyphicon glyphicon-edit"></span>&nbsp;<b>신고 리뷰</b></h1>      
		</div>
		<div class="row">
		<div class="col-sm-2">
	      <div class="panel panel-default">
		  <div class="panel-heading" style="height: 50px; font-size: 25px;"><b>커뮤니티</b></div>
		  
		  <div class="list-group">
			  <a href="<%=cp%>/admin/bbs/list" class="list-group-item">자유게시판</a>
			  <a href="<%=cp%>/admin/report/list" class="list-group-item active">신고 리뷰</a>
		  </div>
		  
		</div>
	    </div>
	    <div class="col-sm-10">
		<div style="margin-top: 0">
			<div class="panel panel-default">
			<div class="panel-heading">
      			<a href="<%=cp%>/admin/main" style="color:black;"><span class="glyphicon glyphicon-home"></span></a>&nbsp;
		        <span class="glyphicon glyphicon-chevron-right"></span>&nbsp;
		        <a href="<%=cp%>/admin/bbs/list" style="color:black;">커뮤니티</a>&nbsp;
		        <span class="glyphicon glyphicon-chevron-right"></span>&nbsp;
		        <a href="<%=cp%>/admin/report/list" style="color:black;">신고 리뷰</a>&nbsp;
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
									<th width="80">번호</th>
									<th>제목</th>
									<th width="250">호텔이름</th>
									<th width="120">작성자</th>
									<th width="150">작성 날짜</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${list }">
									<tr>
										<td>${dto.listNum }</td>
										<td>
										<a href="${articleUrl }&reviewNum=${dto.reviewNum}">
										${dto.reviewTitle }
										</a>
										</td>
										<td>${dto.hotelName }</td>
										<td>${dto.userId }</td>
										<td>${dto.reviewCreated }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
							<tr height="35">
								<td align="center">${dataCount!=0 ? paging : "예약 내역이 없습니다." }
								</td>
							</tr>
						</table>
						<table style="width: 100%; margin: 20px auto; border-spacing: 0px;">
							<tr height="40">
								<td align="left" width="100">
									<button type="button" class="btn btn-default btn-sm"
										onclick="javascript:location.href='<%=cp%>/user/confirm/list';">새로고침</button>
								</td>
								<td align="center">
									<form name="searchForm" action="<%=cp%>/user/bbs/list"
										method="post">
										<select name="condition" class="selectField" style="height:30px;">
											<option value="all"
												${condition=="all" ? " selected='selected' ": "" }>제목+내용</option>
											<option value="hotelName"
												${condition=="hotelName" ? " selected='selected' ": "" }>호텔이름</option>
											<option value="userId"
												${condition=="userId" ? " selected='selected' ": "" }>작성자</option>
										</select> <input type="text" name="keyword" class="boxTF"
											value="${keyword}">
										<button type="button" class="btn btn-default btn-sm"
											onclick="searchList()">검색</button>
									</form>
								</td>
								<td align="right" width="100">
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