<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<div class="container">
	<div style="margin: 0px auto; padding-top: 40px; width: 600px; margin-bottom:100px">
		<div class="page-header">
		    <h1><b>회원정보확인</b></h1>      
		</div>
		<div>
			<div class="panel panel-default">
				<div class="panel-body">
					<table class="table">
						<thead>
							<tr>
								<th width="150">회원아이디</th>
								<th>${dto.userId }</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th width="150">회원이름</th>
								<th>${dto.userName }</th>
							</tr>
							<tr>
								<th width="150">생년월일</th>
								<th>${dto.birth }</th>
							</tr>
							<tr>
								<th width="150">전화번호</th>
								<th>${dto.userTel }</th>
							</tr>
							<tr>
								<th width="150">이메일</th>
								<th>${dto.userEmail }</th>
							</tr>
							<tr>
								<th width="150">회원가입일</th>
								<th>${dto.userCreated }</th>
							</tr>
							<tr>
								<th width="150">최근정보수정일</th>
								<th>${dto.userModified }</th>
							</tr>
							
						</tbody>
					</table>
					<button type="button" class="btn btn-default btn-sm" 
						onclick="javascript:location.href='<%=cp%>/user/member/pwd?mode=update';">
						회원정보수정</button>
					<span style="margin-right:400px;"></span>	
					<button type="button" class="btn btn-default btn-sm" 
						onclick="javascript:location.href='<%=cp%>/user/member/pwd?mode=delete';">
						회원탈퇴</button>
				</div>
			</div>
		</div>
	</div>
</div>

