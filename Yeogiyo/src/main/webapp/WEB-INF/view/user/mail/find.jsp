<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style type="text/css">
.logintext {
	width: 100%; 
	height: 50px; 
	border: 1px solid #ccc; 
	border-radius: 4px;"
}
</style>
<script type="text/javascript">
function sendFind() {
	var f=document.findForm;
	var s="";
	<c:if test="${mode=='findPwd'}">
	
	s=f.userName.value;
	if(!s) {
		alert("이름을 입력하세요");
		f.userName.focus();
		return;
	}
	</c:if>
	s=f.userEmail.value;
	if(!s) {
		alert("이메일을 입력하세요");
		f.userEmail.focus();
		return;
	}
	s=f.userTel.value;
	if(!s) {
		alert("핸드폰번호를 입력하세요");
		f.userTel.focus();
		return;
	}
	f.action="<%=cp%>/user/mail/send";
	f.submit();
}
</script>

<div class="container">
	<div style="margin: 0px auto; padding-top: 120px; width: 400px;">
		<div class="mainform">
			<span style="font-weight: bold; font-size: 30px;">${title }</span>
		</div>
		<form name="findForm" method="post">
		<c:if test="${mode=='findPwd' }">
			<div style="margin-top: 15px;">
				<label>
				<span style="font-weight: bold; font-size: 20px; ">아이디</span>
				</label>
				<div style="margin-top: 10px;">
					<input type="text" name="userId" id="userId" tabindex="2"
						class="logintext">
				</div>
			</div>
		</c:if>	
			<div style="margin-top: 15px;">
				<label>
				<span style="font-weight: bold; font-size: 20px; ">이름</span>
				</label>
				<div style="margin-top: 10px;">
					<input type="text" name="userName" id="userName" tabindex="2"
						class="logintext">
				</div>
			</div>
			<div style="margin-top: 15px;">
				<label>
				<span style="font-weight: bold; font-size: 20px; ">이메일</span>
				</label>
				<div style="margin-top: 10px;">
					<input type="email" name="userEmail" id="userEmail" tabindex="2"
						class="logintext">
				</div>
			</div>
			<div style="margin-top: 15px;">
				<label>
				<span style="font-weight: bold; font-size: 20px; ">핸드폰번호</span>
				</label>
				<div style="margin-top: 10px;">
					<input type="text" name="userTel" id="userTel" tabindex="2"
						class="logintext">
				</div>
			</div>
			<div style="margin-top: 15px;">
				<button type="button" onclick="sendFind()" class="btnconfirm">
			    	<span style="font-weight: bold; font-size: 25px;">${title }</span>
			    </button>
			</div>
			
			<div style="margin-top: 20px; margin-bottom:100px; text-align:center;">
				<span style="color:blue;">${message }</span>
			</div>
			
		</form>
	</div>

</div>

