<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style type="text/css">
.help-block {
	margin-bottom: 5px;
}
</style>

<script type="text/javascript">
$(function() {
	$("#birth").datepicker({
		showMonthAfterYear : true
	});
});

function memberOk() {
	var f=document.memberForm;
	var s=f.userId.value;
	s=s.trim();
	if(!s) {
		alert("아이디를 입력하세요.");
		f.userId.focus();
		return;
	}
	if(!/^[a-z][a-z0-9_]{4,14}$/i.test(s)) {
		alert("아이디는 5~15자이며 첫글자는 영문자이어야 합니다.");
		f.userId.focus();
		return;
	}
	f.userId.value=s;
	
	s=f.userPwd.value;
	s=s.trim();
	if(!s) {
		alert("패스워드를 입력하세요.");
		f.userPwd.focus();
		return;
	}
	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,15}$/i.test(s)) {
		alert("패스워드는 5~15자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
		f.userPwd.focus();
		return;
	}
	f.userPwd.value=s;
	
	if(str!= f.userPwdCheck.value) {
        alert("패스워드가 일치하지 않습니다. ");
        f.userPwdCheck.focus();
        return;
	}
	
	s=f.userName.value;
	s=s.trim();
	if(!s) {
		alert("이름을 입력하세요.");
		f.userName.focus();
		return;
	}
	f.userName.value=s;
	
	s=f.birth.value;
	s=s.trim();
	if(!s || !isValidDateFormat(s)) {
		alert("생년월일을 입력하세요.[YYYY-MM-DD]");
		f.birth.focus();
		return;
	}
	
	s=f.tel1.value;
	s=s.trim();
	if(!s) {
		alert("전화번호를 입력하세요.");
		f.tel1.focus();
		return;
	}
	
	s=f.tel2.value;
	s=s.trim();
	if(!s) {
		alert("전화번호를 입력하세요.");
		f.tel2.focus();
		return;
	}
	if(!/^(\d+)$/.test(s)) {
        alert("숫자만 가능합니다. ");
        f.tel2.focus();
        return;
    }
	
	s=f.tel3.value;
	s=s.trim();
	if(!s) {
		alert("전화번호를 입력하세요.");
		f.tel3.focus();
		return;
	}
	if(!/^(\d+)$/.test(s)) {
        alert("숫자만 가능합니다. ");
        f.tel3.focus();
        return;
    }
	
	s=f.email1.value;
	s=s.trim();
	if(!s) {
		alert("이메일을 입력하세요.");
		f.email1.focus();
		return;
	}
	
	s=f.email2.value;
	s=s.trim();
	if(!s) {
		alert("이메일을 입력하세요.");
		f.email2.focus();
		return;
	}
	
	f.action="<%=cp%>/user/member/${mode}";
	f.submit();
}

function changeEmail() {
    var f = document.memberForm;
	    
    var str = f.selectEmail.value;
    if(str!="direct") {
        f.email2.value=str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value="";
        f.email2.readOnly = false;
        f.email1.focus();
    }
}

function userIdCheck() {
	var userId = $("#userId").val();
	userId = userId.trim();
	if(!/^[a-z][a-z0-9_]{4,14}$/i.test(userId)) { 
		$("#userId").focus();
		return;
	}
	
	var url="<%=cp%>/user/member/userIdCheck";
	
	var q = "userId=" + userId;

	$.ajax({
		type : "post",
		url : url,
		data : q,
		dataType : "json",
		success : function(data) {
			var state = data.state;
			if (state == "true") {
				var s = "<span style='color:blue;font-weight:bold;'>"
						+ userId + "</span> 아이디는 사용 가능합니다.";
				$("#userId").parent().next(".help-block").html(s);
			} else {
				var s = "<span style='color:red;font-weight:bold;'>"
						+ userId + "</span> 아이디는 사용할 수 없습니다.";
				$("#userId").parent().next(".help-block").html(s);
				$("#userId").val("");
				$("#userId").focus();
			}
		},
		error : function(e) {
			console.log(e.responseText);
		}
	});
}
function changeEmail() {
	 var f = document.memberForm;
	    
    var str = f.selectEmail.value;
    if(str!="direct") {
        f.email2.value=str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value="";
        f.email2.readOnly = false;
        f.email1.focus();
    }
}	
</script>

<div class="container">
	<div style="margin: 0px auto; padding-top: 40px; width: 700px;">
		<div class="page-header">
		<h1><span class="glyphicon glyphicon-user"></span>&nbsp;
			<b>${mode=="join"?"회원 가입":"회원 정보 수정" }</b></h1>
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
			<span style="font-family: Webdings; font-weight: 600;"> 여기요를
				가입하시면 더욱 많은 혜택을 받을 수 있습니다. </span>	
				<form name="memberForm" method="post">
					<div style="margin-top: 15px;">
						<table
							style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
							<tr>
								<td width="120" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">아이디</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 5px;">
										<input type="text" name="userId" id="userId"
											value="${dto.userId}" onchange="userIdCheck()"
											style="width: 95%;"
											${mode=="update" ? "readonly='readonly' ":""} maxlength="15"
											class="boxTF" placeholder="아이디">
									</p>
									<p class="help-block">아이디는 5~15자 이내이며, 첫글자는 영문자로 시작해야 합니다.</p>
								</td>
							</tr>
							<tr>
								<td width="120" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">패스워드</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 5px;">
										<input type="password" name="userPwd" style="width: 95%;"
											maxlength="15" class="boxTF" placeholder="패스워드">
									</p>
									<p class="help-block">패스워드는 5~10자 이내이며, 하나 이상의 숫자나 특수문자가
										포함되어야 합니다.</p>
								</td>
							</tr>
							<tr>
								<td width="120" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">패스워드 확인</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 5px;">
										<input type="password" name="userPwdCheck" maxlength="15"
											class="boxTF" style="width: 95%;" placeholder="패스워드 확인">
									</p>
									<p class="help-block">패스워드를 한번 더 입력해주세요.</p>
								</td>
							</tr>
							<tr>
								<td width="120" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">이름</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 10px;">
										<input type="text" name="userName" value="${dto.userName}"
											style="width: 95%;"
											${mode=="update" ? "readonly='readonly' ":""} maxlength="15"
											class="boxTF" placeholder="이름">
									</p>
								</td>
							</tr>
							<tr>
								<td width="120" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">생년월일</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 10px;">
										<input type="text" name="birth" maxlength="15" class="boxTF" 
											id="birth" readonly="readonly"
											style="width: 95%;" placeholder="생년월일" value="${dto.birth }">
									</p>
								</td>
							</tr>
							<tr>
								<td width="100" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">이메일</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-top: 1px; margin-bottom: 5px;">
										<select name="selectEmail" onchange="changeEmail();"
											class="selectField" style="height: 30px">
											<option value="">선 택</option>
											<option value="naver.com"
												${dto.email2=="naver.com" ? "selected='selected'" : ""}>네이버
												메일</option>
											<option value="hanmail.net"
												${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>한
												메일</option>
											<option value="hotmail.com"
												${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>핫
												메일</option>
											<option value="gmail.com"
												${dto.email2=="gmail.com" ? "selected='selected'" : ""}>지
												메일</option>
											<option value="direct">직접입력</option>
										</select> <input type="text" name="email1" value="${dto.email1}"
											size="13" maxlength="30" class="boxTF"> @ <input
											type="text" name="email2" value="${dto.email2}" size="13"
											maxlength="30" class="boxTF" readonly="readonly">
									</p>
								</td>
							</tr>
		
							<tr>
								<td width="120" valign="top"
									style="text-align: right; padding-top: 5px;"><label
									style="font-weight: 900;">전화번호</label></td>
								<td style="padding: 0 0 15px 15px;">
									<p style="margin-bottom: 5px;">
										<select class="selectField" id="tel1" name="tel1"
											style="height: 30px">
											<option value="">선 택</option>
											<option value="010"
												${dto.tel1=="010" ? "selected='selected'" : ""}>010</option>
											<option value="011"
												${dto.tel1=="011" ? "selected='selected'" : ""}>011</option>
											<option value="016"
												${dto.tel1=="016" ? "selected='selected'" : ""}>016</option>
											<option value="017"
												${dto.tel1=="017" ? "selected='selected'" : ""}>017</option>
											<option value="018"
												${dto.tel1=="018" ? "selected='selected'" : ""}>018</option>
											<option value="019"
												${dto.tel1=="019" ? "selected='selected'" : ""}>019</option>
										</select> - <input type="text" name="tel2" value="${dto.tel2}"
											class="boxTF" maxlength="4"> - <input type="text"
											name="tel3" value="${dto.tel3}" class="boxTF" maxlength="4">
									</p>
								</td>
							</tr>
							<c:if test="${mode=='join'}">
								<tr>
									<td width="120" valign="top"
										style="text-align: right; padding-top: 5px;"><label
										style="font-weight: 900;">약관동의</label></td>
									<td style="padding: 0 0 15px 15px;">
										<p style="margin-top: 7px; margin-bottom: 5px;">
											<label> <input id="agree" name="agree" type="checkbox"
												checked="checked"
												onchange="form.sendButton.disabled = !checked"> <a
												href="#">이용약관</a>에 동의합니다.
											</label>
										</p>
									</td>
								</tr>
							</c:if>
						</table>
		
						<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
							<tr height="45">
								<td align="center">
									<button type="button" name="sendButton" class="btn btn-default"
										onclick="memberOk();">${mode=="join"?"회원가입":"정보수정"}</button>
									<button type="reset" class="btn btn-default">다시입력</button>
									<button type="button" class="btn btn-default"
										onclick="javascript:location.href='<%=cp%>/';">${mode=="join"?"가입취소":"수정취소"}</button>
								</td>
							</tr>
							<tr height="30">
								<td align="center" style="color: blue;">${message}</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>		
	</div>
</div>