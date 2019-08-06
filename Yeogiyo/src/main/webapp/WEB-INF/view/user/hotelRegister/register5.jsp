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
</style>
</head>
<body>
	<div class="container">
		<div class="left-nav">
			<ul>
				<li><a href="<%=cp%>/owner/hotelRegister/register1"><i class="fas fa-check" style="color:#3B1E1E"></i>기본 정보</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register2"><i class="fas fa-check" style="color: #3B1E1E"></i>위치</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register3"><i class="fas fa-check" style="color: #3B1E1E"></i>소개</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register4"><i class="fas fa-check" style="color: #3B1E1E"></i>편의 시설/서비스</a></li>
				<li class="left-nav-activated"><a href="<%=cp%>/owner/hotelRegister/register5"><i class="fas fa-check" style="color: #3B1E1E"></i>사진</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register6"><i class="fas fa-check" style="color: #3B1E1E"></i>등록 완료</a></li>
			</ul>
		</div>


		<div class="contents-container">
			<form action="<%=cp%>/owner/hotelRegister/register5" method="post" name="registerForm" enctype="multipart/form-data">
				<div class="title-box">
					<div class="title">숙소 사진 업로드 및 관리하기</div>
					<div class="description">숙소 사진은 여행객들에게 중요합니다. 보유하고 있는 많은 고화질의 숙소 사진을 업로드하세요. 나중에 더 많은 사진을 추가할 수도 있습니다.</div>
				</div>
				
				<div class="big-contents-box">
					<div class="big-title">숙소 사진 업로드 및 관리하기</div>
					<div>숙소 사진은 여행객들에게 중요합니다. 보유하고 있는 많은 고화질의 숙소 사진을 업로드하세요. 나중에
						더 많은 사진을 추가할 수도 있습니다.
					</div>
					
					<div class="big-contents-box">
						<div class="small-contents-box">
							<div class="big-title">숙소 사진</div>
							<div>숙소사진을 업로드하세요. 대표사진은 검색시 썸네일로 사용될 사진을 의미합니다.</div>
							<div class="small-title">숙소 사진</div>
							<input type="file" name="uploads" accept="image/*" multiple="multiple" required="required">
						</div>
						
						<div class="small-contents-box">
							<div class="small-title">대표 사진</div>
							<input type="file" name="mainUpload" accept="image/*" required="required">
						</div>
					</div>
				</div>

				<div class="btn-box">
					<button type="button" class="pre-btn" id="pre-btn" onclick="back();">이전</button>
					<button type="submit" class="next-btn" id="next-btn">다음</button>
				</div>
			</form>
		</div>
	</div>

	<script>
		function back(){
			window.location.href="<%=cp%>/owner/hotelRegister/register4";
		}
	</script>
</body>
</html>