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

.post-form {
	width: 300px;
	height: 30px;
	border: solid 1px #A9A9A9;
	border-radius: 2px;
	margin-bottom: 10px;
}

.small-form{
	height: 30px;
	border: solid 1px #A9A9A9;
	border-radius: 2px;
}

.submit-btn {
	width: 100px;
	height: 30px;
	border: none;
	color: #3B1E1E;;
	background: gold;
	border-radius: 2px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="left-nav">
			<ul>
				<li><a href="<%=cp%>/owner/hotelRegister/register1"><i class="fas fa-check" style="color:#3B1E1E"></i>기본 정보</a></li>
				<li class="left-nav-activated"><a href="<%=cp%>/owner/hotelRegister/register2"><i class="fas fa-check" style="color: #3B1E1E"></i>위치</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register3"><i class="fas fa-check" style="color: #3B1E1E"></i>소개</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register4"><i class="fas fa-check" style="color: #3B1E1E"></i>편의 시설/서비스</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register5"><i class="fas fa-check" style="color: #3B1E1E"></i>사진</a></li>
				<li><a href="<%=cp%>/owner/hotelRegister/register6"><i class="fas fa-check" style="color: #3B1E1E"></i>등록 완료</a></li>
			</ul>
		</div>


		<div class="contents-container">
			<form method="post" name="register2Form">
				<div class="title-box">
					<div class="title">지도상의 숙소 위치 표시/설정하기</div>
					<div class="description">투숙객이 머무르게 되는 곳이 어디인지 알려 주세요.</div>
				</div>
				<div class="big-contents-box">
					<div class="big-title">위치</div>
					<div>
						<input type="text" name="postCode" id="zip" readonly="readonly"
							class="post-form" value="${sessionScope.location.postCode}">
						<button type="button" onclick="daumPostcode();"
							class="submit-btn">우편번호</button>
					</div>

					<div>
						<input type="text" name="addr1" id="addr1" maxlength="50" value="${sessionScope.location.addr1}"
							placeholder="기본 주소" readonly="readonly" class="post-form">
					</div>

					<div>
						<input type="text" name="addr2" id="addr2" maxlength="50" value="${sessionScope.location.addr2}"
						placeholder="상세 주소" class="post-form">
					</div>
					
					<div>
						<input type="hidden" name="latitude" id="latitude" value="${sessionScope.location.latitude}">
						<input type="hidden" name="longitude" id="longitude" value="${sessionScope.location.longitude}">
					</div>
					<div id="map" style="width: 782px; height: 400px;"></div>
				</div>

				<div class="btn-box">
					<button type="button" class="pre-btn" id="pre-btn">이전</button>
					<button type="button" class="next-btn" id="next-btn" onclick="register2Ok();">다음</button>
				</div>
			</form>
		</div>
	</div>

	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=930c81a75d189ec6485debe0c7598cc9&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};
	
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);
		
		
		window.onload = pointMap();
		
		function pointMap(){
			var addr1 = document.getElementById("addr1").value;	
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();

			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(addr1, function(result, status) {
				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {

					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					
					// alert창 안 사라짐! 왜 이러지?
					var latitude = document.getElementById("latitude");
					latitude.value= result[0].y;
					
					var longitude = document.getElementById("longitude");	
					longitude.value = result[0].x;

					// 결과값으로 받은 위치를 마커로 표시합니다
					var marker = new kakao.maps.Marker({
						map : map,
						position : coords
					});

					// 인포윈도우로 장소에 대한 설명을 표시합니다
					var infowindow = new kakao.maps.InfoWindow(
							{
								content : '<div style="width:150px;text-align:center;padding:6px 0;">'+addr1+'</div>'
							});
					infowindow.open(map, marker);

					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					map.panTo(coords);
				}
			});
		}
	
		
		
		function daumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 각 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var fullAddr = ''; // 최종 주소 변수
					var extraAddr = ''; // 조합형 주소 변수

					// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						fullAddr = data.roadAddress;

					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						fullAddr = data.jibunAddress;
					}

					// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
					if (data.userSelectedType === 'R') {
						//법정동명이 있을 경우 추가한다.
						if (data.bname !== '') {
							extraAddr += data.bname;
						}
						// 건물명이 있을 경우 추가한다.
						if (data.buildingName !== '') {
							extraAddr += (extraAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
						fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')'
								: '');
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
					document.getElementById('addr1').value = fullAddr;

					// 커서를 상세주소 필드로 이동한다.
					document.getElementById('addr2').focus();
					
					pointMap();
				}
			}).open();
		}
		

		
		function register2Ok() {
			var f=document.register2Form;
			var s=f.postCode.value;
			if(!s) {
				alert("우편번호를 입력해주세요.");
				f.postCode.focus();
				return;
			}
			
			s=f.addr1.value;
			if(!s) {
				alert("기본 주소를 입력해주세요.");
				f.addr1.focus();
				return;
			}
			
			f.action="<%=cp%>/owner/hotelRegister/register2";
			f.submit();
		}
		
		var prev=document.getElementById("pre-btn");
		prev.addEventListener("click",back)
		
		function back(){
			window.location.href="<%=cp%>/owner/hotelRegister/register1";
		}
	</script>
</body>
</html>