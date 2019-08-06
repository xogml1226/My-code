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
		    <h1><span class="glyphicon glyphicon-home"></span>&nbsp;<b>예약 정보 확인</b></h1>      
		</div>
		<div style="margin-top: 0">
			<div class="panel panel-default">
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
									<th>호텔 이름</th>
									<th width="120">예약자명</th>
									<th width="120">예약일자</th>
									<th width="200">예약 날짜</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${list }">
									<tr>
										<td>${dto.listNum }</td>
										<td>
										<a href="${articleUrl }&reservationNum=${dto.reservationNum}">
										${dto.hotelName }
										</a>
										</td>
										<td>${dto.userName }</td>
										<td>${dto.reservated }</td>
										<td>${dto.checkinDay } ~ ${dto.checkoutDay }</td>
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
						<c:if test="${not empty sessionScope.member }">
						<table style="width: 100%; margin: 20px auto; border-spacing: 0px;">
							<tr height="40">
								<td align="left" width="100">
									<button type="button" class="btn btn-default btn-sm"
										onclick="javascript:location.href='<%=cp%>/user/confirm/list';">새로고침</button>
								</td>
								<td align="center">
									<form name="searchForm" action="<%=cp%>/user/confirm/list"
										method="post">
										<select name="condition" class="selectField" style="height:30px;">
											<option value="hotelName"
												${condition=="hotelName" ? " selected='selected' ": "" }>호텔이름</option>
											<option value="userName"
												${condition=="userName" ? " selected='selected' ": "" }>예약자명</option>
											<option value="date"
												${condition=="content" ? " selected='selected' ": "" }>예약일자</option>
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
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>