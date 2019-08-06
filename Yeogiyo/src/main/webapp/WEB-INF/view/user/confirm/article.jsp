<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">
function deleteConfirm() {
	var query="${query}&reservationNum=${dto.reservationNum}&mode=${mode}";
	<c:if test="${mode=='nomember'}">
	query+="&userName=${dto.userName}&userEmail=${dto.userEmail}&userTel=${dto.userTel}";
	</c:if>
	var url="<%=cp%>/user/confirm/delete?"+query;
	if(confirm("예약정보를 삭제하시겠습니까?")) {
		location.href=url;
	}
	
}
function reviewCreated() {
	var query="reservationNum=${dto.reservationNum}";
	var url="<%=cp%>/user/review/create?"+query;
	if(confirm("호텔에 대한 후기를 남기시겠습니까?")) {
		location.href=url;
	}
	
}
$(function() {
	var dt = new Date();
	 
    var recentYear = dt.getFullYear();
    var recentMonth = dt.getMonth() + 1;
    var recentDay = dt.getDate();
 
    if(recentMonth < 10) recentMonth = "0" + recentMonth;
    if(recentDay < 10) recentDay = "0" + recentDay;
 
    var today = recentYear + "-" + recentMonth + "-" + recentDay;
    var checkinDay="${dto.checkinDay}";
    var checkoutDay="${dto.checkoutDay}";
    if(today < checkinDay) {
    	$("#delReserve").show();
    } else if(checkoutDay < today) {
    	$("#reserveReview").show();
    }
});
</script>

<div class="container">
	<div style="margin: 0px auto; padding-top: 40px; margin-bottom:100px">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-home"></span>&nbsp;<b>예약 정보 확인</b></h1>      
		</div>
		<div>
			<div class="panel panel-default">
			  <div class="panel-heading">예약자 정보</div>
			  <div class="panel-body">
			  	<table class="table">
						<thead>
							<tr>
								<th width="150">예약자 이름</th>
								<th>${dto.userName }</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th width="150">예약자 전화번호</th>
								<td>${dto.userTel }</td>
							</tr>
							<tr>
								<th width="150">예약자 이메일</th>
								<td>${dto.userEmail }</td>
							</tr>
							<tr>
								<th width="150">인원수</th>
								<td>${dto.peopleCount }</td>
							</tr>
							<tr>
								<th width="150">예약 일자</th>
								<td>${dto.reservated }</td>
							</tr>
							<tr>
								<th width="150">예약 날짜</th>
								<td>${dto.checkinDay } ~ ${dto.checkoutDay }</td>
							</tr>
						</tbody>
					</table>
			  </div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">예약 호텔 정보</div>
				<div class="panel-body">
				<div class="row">
				
					<div class="col-md-4">
					<img src="<%=cp%>/resource/images/hotel/L7main.jpg" class="img-thumbnail" alt="mainPhoto" width="400">
					</div>
					<div class="col-md-8">
					<table class="table">
						<thead>
							<tr>
								<th width="150">호텔 이름</th>
								<th>${dto.hotelName }</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th width="150">호텔 유형</th>
								<td>${dto.type }</td>
							</tr>
							<tr>
								<th width="150">호텔 전화번호</th>
								<td>${dto.hotelTel }</td>
							</tr>
							
							<tr>
								<th width="150">호텔 주소</th>
								<td>${dto.addr1 }</td>
							</tr>
							<tr>
								<th width="150">호텔 상세주소</th>
								<td>${dto.addr2 }</td>
							</tr>
						</tbody>
						<tfoot>
							<tr height="50px">
								<td width="150" style="font:italic; font-size: 20px">총 가격</td>
								<td align="right" style="font:italic; font-size: 20px">${dto.totPrice }원</td>
							</tr>
						</tfoot>
					</table>
					</div>
					</div>
				</div>
				</div>
					<table style="width: 100%; margin: 5px auto; border-spacing: 0px;">
						<tr height="40">
							<td align="left" width="60" id="delReserve" style="display: none;">
								<button type="button" class="btn btn-default btn-sm" 
									onclick="deleteConfirm();">
									예약 취소</button>
							</td>
							<c:if test="${not empty sessionScope.member }">
							<td align="left" width="60" id="reserveReview" style="display: none;">
								<button type="button" class="btn btn-default btn-sm" 
									onclick="reviewCreated();">
									후기 작성</button>
							</td>
							<td align="right" width="60">
								<button type="button" class="btn btn-default btn-sm"
									onclick="javascript:location.href='<%=cp%>/user/confirm/list?${query }';">
									예약 리스트
								</button>
							</td>
							</c:if>
							<c:if test="${empty sessionScope.member }">
							<td align="right" width="60">
								<button type="button" class="btn btn-default btn-sm"
									onclick="javascript:location.href='<%=cp%>/';">
									메인페이지
								</button>
							</td>
							</c:if>
						</tr>
					</table>
					
				</div>
			</div>
		</div>
	

