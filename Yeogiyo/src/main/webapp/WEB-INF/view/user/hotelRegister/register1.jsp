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
	cursor: pointer;
}

.building-iconBox:hover {
	color: white;
	background: gold;
}

.title-box {
	padding: 15px;
}

.title {
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

.small-form {
	height: 30px;
	border: solid 1px #A9A9A9;
	border-radius: 2px;
}

.post-form {
	width: 300px;
	height: 30px;
	border: solid 1px #A9A9A9;
	border-radius: 2px;
	margin-bottom: 10px;
}
.building-iconBox-activated{
	background: gold;
	color: white;
}
</style>
</head>
<body>
	<div class="container">
		<div class="left-nav">
			<ul>
				<li class="left-nav-activated"><a href="<%=cp%>/owner/hotelRegister/register1"><i class="fas fa-check" style="color:#3B1E1E"></i>기본 정보</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register2"><i class="fas fa-check" style="color: #3B1E1E"></i>위치</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register3"><i class="fas fa-check" style="color: #3B1E1E"></i>소개</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register4"><i class="fas fa-check" style="color: #3B1E1E"></i>편의 시설/서비스</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register5"><i class="fas fa-check" style="color: #3B1E1E"></i>사진</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register6"><i class="fas fa-check" style="color: #3B1E1E"></i>등록 완료</a></li>
			</ul>
		</div>

		<div class="contents-container">
			<form method="post" enctype="multipart/form-data" name="register1Form">
				<div class="title-box">
					<div class="title">숙소를 찾고 있는 여행객들을 정확히 사로잡아보세요!</div>
					<div class="description">선택 사항 표시가 없는 한 모든 정보는 필수 항목입니다.</div>
				</div>
				<div class="big-contents-box">
					<div class="big-title">숙소</div>
					<div class="small-contents-box">
						<div class="small-title">숙소 종류</div>
						<div class="building-iconBox" onclick="motelClick();" id="motel">
							<div>
								<i class="fas fa-building" style="font-size: 45px;"></i>
							</div>
							<div>모텔</div>
						</div>

						<div class="building-iconBox" onclick="hotelClick();" id="hotel">
							<div>
								<i class="fas fa-hotel" style="font-size: 45px;"></i>
							</div>
							<div>호텔</div>
						</div>

						<div class="building-iconBox" onclick="homeClick();" id="home">
							<div>
								<i class="fas fa-home" style="font-size: 45px;"></i>
							</div>
							<div>홈스테이</div>					
						</div>

						<div class="building-iconBox" onclick="campClick();" id="camp">
							<div>
								<i class="fas fa-campground" style="font-size: 45px;"></i>
							</div>
							<div>캠핑장</div>
						</div>
						<input type="hidden" id="type" name="typeNum" readonly="readonly" value="${sessionScope.basicInfo.typeNum}">
					</div>
					
					<div class="small-contents-box">
						<div class="small-title">숙소 크기</div>
						<input type="text" class="small-form" name="hotelSize" value="${sessionScope.basicInfo.hotelSize}">㎡
					</div>
				</div>
				
				<div class="big-contents-box">
					<div class="big-title">체크인 시간</div>
					<div>체크인 시간을 입력해주세요.(00:00)</div>
					<input type="text" class="post-form" name="checkIn" value="${sessionScope.basicInfo.checkIn}">
				</div>
				
				<div class="big-contents-box">
					<div class="big-title">체크아웃 시간</div>
					<div>체크아웃 시간을 입력해주세요.(00:00)</div>
					<input type="text" class="post-form" name="checkOut" value="${sessionScope.basicInfo.checkOut}">
				</div>

				<div class="big-contents-box">
					<div class="big-title ">전화번호</div>
					<div>숙소에 연락하기위한 번호를 알려주세요.(010-0000-0000)</div>
					<input type="text" class="post-form" name="hotelTel" value="${sessionScope.basicInfo.hotelTel}">
				</div>
				
				<div class="big-contents-box">
					<div class="big-title ">호텔 등급</div>
					<div>호텔이 몇성급인지 알려주세요.</div>
					<input type="text" class="post-form" name="grade" value="${sessionScope.basicInfo.grade}">
				</div>
				
				<div class="big-contents-box">
					<div class="big-title ">사업자번호</div>
					<div>사업자번호를 입력해주세요</div>
					<input type="text" class="post-form" name="businessNum" value="${sessionScope.basicInfo.businessNum}">
				</div>
				
				<div class="btn-box">
				<!-- 양식 다시제출 어떻게 해결? -->
					<button type="button" class="next-btn" id="next-btn" onclick="register1Ok();">다음</button>
				</div>
			</form>
		</div>
	</div>

	<script type="text/javascript">	
	function sessiontype(){
		var f = document.getElementById("type");
		if(!f){
			if(f=="모텔"){
				motelClick();
				alert("asdfsadf");
			}
			else if(f=="호텔"){
				hotelClick();
			}
			else if(f=="홈스테이"){
				homeClick();
			}
			else if(f=="캠핑장"){
				campClick();
			}
		}
	}
	
	function motelClick(){
		var iconBox=document.getElementById("motel");
		
		if(iconBox.classList.contains("building-iconBox-activated")){
			iconBox.classList.remove("building-iconBox-activated");
			
			var f=document.getElementById("type");
			f.value=null;
			
		} else{
			iconBox.classList.add("building-iconBox-activated");
			
			iconBox=document.getElementById("hotel");
			iconBox.classList.remove("building-iconBox-activated");
			
			iconBox=document.getElementById("home");
			iconBox.classList.remove("building-iconBox-activated");
			
			iconBox=document.getElementById("camp");
			iconBox.classList.remove("building-iconBox-activated");
			
			var f=document.getElementById("type");
			f.value="2";
		}
		
		return;
	}
	
	function hotelClick(){		
		var iconBox=document.getElementById("hotel");
		
		if(iconBox.classList.contains("building-iconBox-activated")){
			iconBox.classList.remove("building-iconBox-activated");
			
			var f=document.getElementById("type");
			f.value=null;
			
		} else{
			iconBox.classList.add("building-iconBox-activated");
			
			iconBox=document.getElementById("motel");
			iconBox.classList.remove("building-iconBox-activated");
			
			iconBox=document.getElementById("home");
			iconBox.classList.remove("building-iconBox-activated");
			
			iconBox=document.getElementById("camp");
			iconBox.classList.remove("building-iconBox-activated");
			
			var f=document.getElementById("type");
			f.value="1";
		}
		
		return;
	}
	
	function homeClick(){
		var iconBox=document.getElementById("home");
		
		if(iconBox.classList.contains("building-iconBox-activated")){
			iconBox.classList.remove("building-iconBox-activated");
			
			var f=document.getElementById("type");
			f.value=null;

		} else{
			iconBox.classList.add("building-iconBox-activated");
			
			iconBox=document.getElementById("hotel");
			iconBox.classList.remove("building-iconBox-activated");
			
			iconBox=document.getElementById("motel");
			iconBox.classList.remove("building-iconBox-activated");
			
			iconBox=document.getElementById("camp");
			iconBox.classList.remove("building-iconBox-activated");
			
			var f=document.getElementById("type");
			f.value="3";
		}
		
		return;
	}
	
	function campClick(){
		var iconBox=document.getElementById("camp");
		
		if(iconBox.classList.contains("building-iconBox-activated")){
			iconBox.classList.remove("building-iconBox-activated");
			
			var f=document.getElementById("type");
			f.value=null;
			
		} else{
			iconBox.classList.add("building-iconBox-activated");
			
			iconBox=document.getElementById("hotel");
			iconBox.classList.remove("building-iconBox-activated");
			
			iconBox=document.getElementById("home");
			iconBox.classList.remove("building-iconBox-activated");
			
			iconBox=document.getElementById("motel");
			iconBox.classList.remove("building-iconBox-activated");
			
			var f=document.getElementById("type");
			f.value="4";
		}
		
		return;
	}
	
	function register1Ok() {
		var f=document.register1Form;
		var s=f.type.value;
		if(!s) {
			alert("숙박업소의 종류를 선택해주세요.");
			return;
		}
		
		s=f.hotelSize.value;
		if(!s) {
			alert("숙박업소 크기를 입력해주세요.");
			f.hotelSize.focus();
			return;
		}
		
		s=f.checkIn.value;
		if(!s) {
			alert("체크인 시간을 입력해주세요");
			f.checkIn.focus();
			return;
		}
		
		s=f.checkOut.value;
		if(!s) {
			alert("체크아웃 시간을 입력해주세요");
			f.checkOut.focus();
			return;
		}
		
		s=f.hotelTel.value;
		if(!s) {
			alert("연락을 위한 전화번호를입력해주세요");
			f.hotelTel.focus();
			return;
		}
		
		s=f.grade.value;
		if(!s) {
			alert("호텔등급을 선택해주세요");
			f.grade.focus();
			return;
		}
		
		s=f.businessNum.value;
		if(!s) {
			alert("사업자번호를 입력해주세요");
			f.businessNum.focus();
			return;
		}
		
		if(!f.type){
			alert("호텔 종류를 선택해주세요");
			f.type.focus();
			return;
		}
		
		f.action="<%=cp%>/owner/hotelRegister/register1";
		f.submit();
	}

	</script>
</body>
</html>