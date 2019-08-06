<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">
function grantedUpdate() {
	var query="page=${page}&hotelId=${dto.hotelId}";
	var url="<%=cp%>/admin/granted/update?"+query;
	if(confirm("여기요에 호텔을 가입시키겠습니까?")) {
		location.href=url;
	}
	
}
</script>

<div class="container">
	<div style="margin: 0px auto; padding-top: 40px; margin-bottom:100px">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-home"></span>&nbsp;<b>요청 호텔 확인</b></h1>      
		</div>
		<div>
			<div class="panel panel-default">
			  <div class="panel-heading">호텔 오너 정보</div>
			  <div class="panel-body">
			  	<table class="table">
						<thead>
							<tr>
								<th width="150">오너 아이디</th>
								<th>${dto.userId }</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th width="150">오너 이름</th>
								<th>${dto.userName }</th>
							</tr>
							<tr>
								<th width="150">오너 전화번호</th>
								<th>${dto.userTel }</th>
							</tr>
							<tr>
								<th width="150">오너 이메일</th>
								<th>${dto.userEmail }</th>
							</tr>
						</tbody>
					</table>
			  </div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">호텔 정보</div>
				<div class="panel-body">
				<div class="row">
				
					<div class="col-md-4">
					<img src="<%=cp %>/uploads/hotelMain/${dto.mainPhoto}" class="img-thumbnail" alt="mainPhoto" width="400">
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
									<th width="150">사업자번호</th>
									<th>${dto.businessNum }</th>
								</tr>
								<tr>
									<th width="150">호텔 유형</th>
									<th>${dto.type }</th>
								</tr>
								<tr>
									<th width="150">호텔 전화번호</th>
									<th>${dto.hotelTel }</th>
								</tr>
								
								<tr>
									<th width="150">호텔 주소</th>
									<th>${dto.addr1 }</th>
								</tr>
								<tr>
									<th width="150">호텔 상세주소</th>
									<th>${dto.addr2 }</th>
								</tr>
								<tr>
									<th colspan="2">호텔 설명</th>
								</tr>
								<tr>
									<td colspan="2">${dto.detail }</td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>
					<table style="width: 100%; margin: 5px auto; border-spacing: 0px;">
						<tr height="40">
							<td align="left" width="60">
								<button type="button" class="btn btn-default btn-sm" 
									onclick="grantedUpdate();">
									호텔 승인</button>
							</td>
							<td align="right" width="60">
								<button type="button" class="btn btn-default btn-sm"
									onclick="javascript:location.href='<%=cp%>/admin/main?page=${page }';">
									승인 리스트
								</button>
							</td>
						</tr>
					</table>
					
				</div>
			</div>
		</div>
	</div>
</div>

