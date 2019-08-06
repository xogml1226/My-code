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
function sendPwd() {
	var f=document.pwdForm;
	
	var s=f.userPwd.value;
	if(!s) {
		alert("패스워드를 입력하세요");
		f.userPwd.focus();
		return;
	}
	f.action="<%=cp%>/user/member/pwd";
	f.submit();
}
</script>

<div class="container">

	<div style="margin: 0px auto; padding-top: 90px; width:400px;">
		<div class="mainform">
			<span style="font-weight: bold; font-size: 30px;">비밀번호확인</span>
		</div>
		<form name="pwdForm" method="post" action="">
		<div style="margin-top: 20px;">
		<div>
		<span style="font-weight: bold; font-size: 15px; ">
			정보 보호를 위해 패스워드를 다시 한 번 입력해주세요.
		</span>
		</div>
			<label>
			<span style="font-weight: bold; font-size: 20px; ">아이디</span>
			</label>
			<div style="margin-top: 10px;">
				<input type="text" name="userId" id="userId" tabindex="2"
					class="logintext" value="${sessionScope.member.userId }" readonly="readonly">
			</div>
		</div>
		<div style="margin-top: 15px;">
			<label>
			<span style="font-weight: bold; font-size: 20px; ">패스워드</span>
			</label>
			<div style="margin-top: 10px;">
				<input type="password" name="userPwd" id="userPwd" tabindex="2"
					class="logintext">
			</div>
			<div style="margin-top: 15px;">
				<button type="button" onclick="sendPwd()" class="btnconfirm">
			    	<span style="font-weight: bold; font-size: 25px;">확인</span>
			    </button>
			    <input type="hidden" name="mode" value=${mode }>
			</div>
			<div style="margin-top: 20px; margin-bottom:100px; text-align:center;">
			<span style="color:blue;">${message }</span>
			</div>
			
		</div>
		</form>
	</div>
</div>


