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
		    <h1><span class="glyphicon glyphicon-gift"></span>&nbsp;<b>이벤트</b></h1>      
		</div>
		<div class="row">
		    <div class="col-sm-2">
		      <div class="panel panel-default">
			  <div class="panel-heading" style="height: 50px; font-size: 25px;"><b>소식</b></div>
			  <div class="list-group">
				  <a href="<%=cp%>/user/notice/list" class="list-group-item">공지사항</a>
				  <a href="<%=cp%>/user/event/list" class="list-group-item active">이벤트</a>
			  </div>
			</div>
		    </div>
		    <div class="col-sm-10">
		<div>
			<div class="panel panel-default">
			<div class="panel-heading">
      			<a href="<%=cp%>/user/main" style="color:black;"><span class="glyphicon glyphicon-home"></span></a>&nbsp;
		        <span class="glyphicon glyphicon-chevron-right"></span>&nbsp;
		        <a href="<%=cp%>/user/notice/list" style="color:black;">소식</a>&nbsp;
		        <span class="glyphicon glyphicon-chevron-right"></span>&nbsp;
		        <a href="<%=cp%>/user/event/list" style="color:black;">이벤트</a>&nbsp;
        		</div>
				<div class="panel-body">
					<table style="width: 100%; margin: 5px auto 0px; border-spacing: 0px;">
							<tr height="10">
								<td align="left" width="50%">
									${dataCount}개(${page}/${total_page} 페이지)</td>
								<td align="right">&nbsp;</td>
							</tr>
						</table>
						<div>
						<c:forEach var="dto" items="${list }" varStatus="status">
							<c:if test="${status.index%3==0 }">
								<c:out value="<div class='row'>" escapeXml="false"/>
							</c:if>
								<div class="col-md-4">
									<div class="thumbnail">
								        <a href="${articleUrl}&eventNum=${dto.eventNum}">
								          <img src="<%=cp%>/uploads/eventPhoto/${dto.eventPhoto}" alt="eventPhoto" style="width:100%; height:200px;"> 
								          <div class="caption">
								            <p style="text-align: center;">${dto.eventTitle }</p>
								            <p style="text-align: center; margin-bottom:0px;"><b>${dto.eventStatus }</b></p>
								          </div>
								        </a>
								      </div>
								</div>
							<c:if test="${status.index%3==2 }">
								<c:out value="</div>" escapeXml="false"/>
							</c:if>	
						</c:forEach>
						</div>
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
										onclick="javascript:location.href='<%=cp%>/user/event/list';">새로고침</button>
								</td>
								<td align="center">
									<form name="searchForm" action="<%=cp%>/user/event/list"
										method="post">
										<input type="text" name="keyword" class="boxTF"
											value="${keyword}">
										<button type="button" class="btn btn-default btn-sm"
											onclick="searchList()">검색</button>
									</form>
								</td>
								<td align="right" width="80">
									<button type="button" class="btn btn-default btn-sm"
										onclick="javascript:location.href='<%=cp%>/user/event/list?status=진행중';">
										진행중
									</button>
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