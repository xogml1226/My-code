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
function sendLogin() {
	var f=document.loginForm;
	var s=f.userId.value;
	if(!s) {
		alert("아이디를 입력하세요");
		f.userId.focus();
		return;
	}
	s=f.userPwd.value;
	if(!s) {
		alert("패스워드를 입력하세요");
		f.userPwd.focus();
		return;
	}
	f.action="<%=cp%>/user/member/login";
	f.submit();
}
</script>

<div class="container">
	<div style="margin: 0px auto; padding-top: 120px; width: 400px;">
		<div class="mainform">
			<span style="font-weight: bold; font-size: 30px;">회원로그인</span>
		</div>
		<form name="loginForm" method="post" action="">
		<div style="margin-top: 20px;">
			<label>
			<span style="font-weight: bold; font-size: 20px; ">아이디</span>
			</label>
			<div style="margin-top: 10px;">
				<input type="text" name="userId" id="userId" tabindex="2"
					class="logintext">
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
				<button type="button" onclick="sendLogin()" class="btnconfirm">
			    	<span style="font-weight: bold; font-size: 25px;">로그인</span>
			    </button>
			</div>
			<div style="margin-top: 10px;">
			<span style="margin-right:85px;"><a href="<%=cp%>/user/mail/findId">아이디 찾기</a></span>
			<span style="margin-right:85px;"><a href="<%=cp%>/user/mail/findPwd">비밀번호 찾기</a></span>
			<span><a href="<%=cp%>/user/member/join">회원가입</a></span>
			</div>
			<div style="margin-top: 20px; margin-bottom:100px; text-align:center;">
			<span style="color:blue;">${message }</span>
			</div>
			
		</div>
		</form>
	</div>

</div>

