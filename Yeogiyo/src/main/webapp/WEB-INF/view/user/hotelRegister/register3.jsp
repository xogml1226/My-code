<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/12328aec17.js"></script>
<title>호텔등록 및 회원가입</title>
<style>
.left-nav {
	float: left;
	margin: 35px;
	border-radius: 2px;
	box-shadow: 0 3px 6px rgba(0, 0, 0, 0.16), 0 3px 6px rgba(0, 0, 0, 0.23);
}

.left-nav ul {
	margin-bottom: 0px;
}

.left-nav ul li {
	list-style-type: none;
	padding: 10px;
}

.left-nav ul li a {
	color: #3B1E1E;
	display:block;
}

.left-nav ul li a:hover{
	color: #3B1E1E;
	display:block;
	text-decoration: none;
}

.left-nav ul li:hover{
	background: gold;;
}

.left-nav-activated{
	background: gold;
}
.contents-container {
	float: left;
	height: 100%;
	width: 70%;
	margin: 20px;
}

.big-contents-box {
	margin-bottom: 20px;
	padding: 15px;
}

.small-contents-box {
	margin-bottom: 25px;
}

.plus-minus-input {
	width: 43px;
	height: 43px;
	margin-left: -1px;
	margin-right: -1px;
	vertical-align: middle;
	border-left: none;
	border-right: none;
	border-top: gold solid 1px;
	border-bottom: gold solid 1px;
	outline: none;
	text-align: center;
}

.plus-btn {
	border-top-left-radius: 8px;
	border-bottom-left-radius: 8px;
}

.minus-btn {
	border-top-right-radius: 8px;
	border-bottom-right-radius: 8px;
}

.form-row {
	display: table-row;
	margin-top: 10px;
	margin-bottom: 10px;
}

.form-row button {
	width: 43px;
	height: 43px;
	background: gold;
	color: #3B1E1E;
	font-size: 20pt;
	text-align: center;
	display: table-cell;
	vertical-align: middle;
	cursor: pointer;
	border: solid 1px gold;
}

.building-iconBox {
	padding: 15px;
	text-align: center;
	width: 135px;
	height: 90px;
	border: solid 1px #3B1E1E;
	display: inline-block;
	color: #3B1E1E;
}

.building-iconBox:hover {
	color: white;
	background: gold;
}

.title-box{
	padding: 15px;
}

.title{
	font-size: 25px;
	font-weight: bold;
}

.big-title {
	font-size: 20px;
	font-weight: bold;
}

.small-title {
	font-size: 15px;
	font-weight: bold;
	margin-bottom: 7px;
	margin-bottom: 7px;
}

.description {
	margin-top: 7px;
	margin-bottom: 7px;
}

.btn-box {
	text-align: right;
}

.pre-btn {
	width: 210px;
	height: 46px;
	background: white;
	color: #3B1E1E;
	font-size: 15pt;
	text-align: center;
	border: solid 1px #3B1E1E;
	border-radius: 2px;
}

.next-btn {
	width: 210px;
	height: 46px;
	background: gold;
	color: #3B1E1E;
	font-size: 15pt;
	text-align: center;
	border: solid 1px gold;
	border-radius: 2px;
}

#big-form {
	width: 150px;
	height: 35px;
	border: solid 1px #A9A9A9;
	border-radius: 2px;
}

.description-form{
	width: 782px;
	height: 100px;
}

.post-form {
	width: 300px;
	height: 30px;
	border: solid 1px #A9A9A9;
	border-radius: 2px;
	margin-bottom: 10px;
}

</style>
</head>
<body>
	<div class="container">
		<div class="left-nav">
			<ul>
				<li><a href="<%=cp%>/owner/hotelRegister/register1"><i class="fas fa-check" style="color:#3B1E1E"></i>기본 정보</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register2"><i class="fas fa-check" style="color: #3B1E1E"></i>위치</a></li>
				<li class="left-nav-activated"><a href="<%=cp%>/owner/hotelRegister/register3"><i class="fas fa-check" style="color: #3B1E1E"></i>소개</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register4"><i class="fas fa-check" style="color: #3B1E1E"></i>편의 시설/서비스</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register5"><i class="fas fa-check" style="color: #3B1E1E"></i>사진</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register6"><i class="fas fa-check" style="color: #3B1E1E"></i>등록 완료</a></li>
			</ul>
		</div>


		<div class="contents-container">
			<form method="post" name="register3Form">
				<div class="title-box">
					<div class="title">숙소의 특별함과 좋은 점 입력/설정하기</div>
					<div class="description">모든 객실과 집은 특별합니다. 숙소가 가진 특별함을 이야기해 주세요.</div>
				</div>
				<div class="big-contents-box">
					<div class="big-title ">숙소명 입력</div>
					<div>의미있고 마음을 끄는 숙소명을 사용해 보세요.</div>
					<input type="text" class="post-form" name="hotelName" value="${sessionScope.description.hotelName}">
				</div>

				<div class="big-contents-box">
					<div class="big-title ">숙소 소개</div>
					<div>여행객들이 꼭 이 숙소에서 투숙해야 하는 이유를 알려주세요.</div>
					<input type="text" class="description-form" name="detail" value="${sessionScope.description.detail}">
				</div>

				<div class="big-contents-box">
					<div class="big-title ">숙소 준비사항</div>
					<div>숙소에 오기 전에 준비해야 할 것들에 대해 알려주세요.</div>
					<input type="text" class="description-form" name="prepareContent" value="${sessionScope.description.prepareContent}">
				</div>
				
				<div class="btn-box">
					<button type="button" class="pre-btn" id="pre-btn" onclick="back();">이전</button>
					<button type="button" class="next-btn" id="next-btn" onclick="register3Ok();">다음</button>
				</div>
			</form>
		</div>
	</div>

	<script>
		function register3Ok() {
			var f=document.register3Form;
			var s=f.hotelName.value;
			if(!s) {
				alert("숙소이름을 입력해주세요.");
				f.zip.focus();
				return;
			}
			
			s=f.detail.value;
			if(!s) {
				alert("숙소 소개를 입력해주세요.");
				f.detail.focus();
				return;
			}
			
			s=f.prepareContent.value;
			if(!s) {
				alert("숙소 준비사항을 입력해주세요.");
				f.prepareContent.focus();
				return;
			}
			
			f.action="<%=cp%>/owner/hotelRegister/register3";
			f.submit();
		}
		
		function back(){
			window.location.href="<%=cp%>/owner/hotelRegister/register2";
		}
	</script>
</body>
</html>