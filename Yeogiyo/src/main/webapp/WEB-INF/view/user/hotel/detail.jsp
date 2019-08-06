<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script type="text/javascript">
$(function() {
	$("#form-sday").datepicker({showMonthAfterYear:true});
	$("#form-eday").datepicker({showMonthAfterYear:true});
	
	$(".reservationBtn").click(function(){
		var hotelId=$(this).attr("data-hotelId");
		var roomdetails=$(this).attr("data-roomdetails");
		var roomtype=$(this).attr("data-roomtype");
		var roomprice=$(this).attr("data-roomprice");
		var maxpeople=$(this).attr("data-maxpeople");
		var userId="${sessionScope.member.userId}";
		
		var optNum= 0;
		var optCount="0";
		var price=0;
		var optName;
		$(".optNum").each(function(){
			if($(this).is(":checked")){
				optNum=$(this).val();
				optCount=$(this).closest("tr").find("select").val();
				price=$(this).attr("data-price");
				optName=$(this).attr("data-name");
				$("form[name=reserForm]").append("<input type='hidden' name='optNum' value='"+optNum+"'>");
				$("form[name=reserForm]").append("<input type='hidden' name='optCount' value='"+optCount+"'>");
				$("form[name=reserForm]").append("<input type='hidden' name='optPrice' value='"+price+"'>");
				$("form[name=reserForm]").append("<input type='hidden' name='optName' value='"+optName+"'>");
			}
		});
		
		if(! optCount) {
			alert("인원수를 선택하세요");
			return false;
		}
		
		$("form[name=reserForm] input[name=hotelId]").val(hotelId);
		$("form[name=reserForm] input[name=roomdetails]").val(roomdetails);
		$("form[name=reserForm] input[name=roomtype]").val(roomtype);
		$("form[name=reserForm] input[name=roomprice]").val(roomprice);
		$("form[name=reserForm] input[name=maxpeople]").val(maxpeople);
		$("form[name=reserForm] input[name=userId]").val(userId);


		$("form[name=reserForm]").submit();
	});
	
	$(".hotelQnA").click(function(){
		var hotelName = $(this).attr("data-hotelName");
		location.href="<%=cp%>/user/hotel/hotelqnaCreate?hotelName=" + hotelName;
	});
	
});
 
</script>


<style type="text/css">
.hoteldetail {
	margin: 0px auto;
	text-align: center;
	width: 1000px;
	padding-bottom: 20px;
}

.room {
	margin: 15px auto;
	width: 700px;
	text-align: center;
}

.room img {
	width: 200px;
	height: 100px;
	padding: 5px 5px auto;
}

.room tr {
	
}

.room tr td {
	width: 100px;
	text-align: center;
}

.room tr th {
	text-align: center;
}

.hotelname {
	margin: 15px auto;
	width: 80%;
}

.detail {
	margin: 15px auto;
	width: 80%;
}

.convenient {
	margin: 15px auto;
	width: 80%;
}

.carousel-inner>.item>img {
	margin: auto;
	width: 600px;
	height: 350px;
}

#map {
	margin: 0 auto;
	margin-top: 30px;
	margin-bottom: 30px;
	width: 550px;
	height: 350px;
}
</style>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=36a2d6acf409cd1a8f5692734e8c365b">
</script>


<div class="container">
	<div style="padding-top: 30px; padding-bottom: 50px;">
		<div>
			<div class="panel panel-warning">
				<div class="panel-heading">
					<div class="hotelname">
						<h3>${detail.hotelName}</h3>
						<small style="margin-right:10px;">${detail.addr1}, ${detail.addr2}</small>
						<c:if test="${not empty sessionScope.member}">
							<button style="align:right;" class="btn btn-default btn-sm hotelQnA" data-hotelName="${detail.hotelName}">호텔에 문의하기</button>
						</c:if>
					</div>
				</div>
						
				<div class="panel-body">
					<div class="hoteldetail">
						<div class="detail">
							<h4>
								<b>소개</b>
							</h4>
							<p>${detail.detail}</p>
						</div>
						
						<h4><b>찾아 오는 길</b></h4>
						<div id="map"  style="width:800px; margin-top:50px; margin-bottom:30px;">
							
							<script>
								var mapContainer = document.getElementById('map');// 지도를 표시할 div 
								mapOption = {
									center : new kakao.maps.LatLng(${detail.latitude},${detail.longitude}), 
									level : 3
								};
							
								var map = new kakao.maps.Map(mapContainer, mapOption); 
								var markerPosition = new kakao.maps.LatLng(${detail.latitude},${detail.longitude});
			
								var marker = new kakao.maps.Marker({
									position : markerPosition
								});
							
								marker.setMap(map);
							</script>
						</div>
						
						<h4><b>호텔 사진</b></h4>
						<div class="imgshow" style="width:800px; margin:0 auto; margin-top:50px;">
							<div id="myCarousel" class="carousel slide" data-ride="carousel">
								<ol class="carousel-indicators">
									<c:forEach var="dto" items="${plist}" varStatus="status">
										<li data-target="#myCarousel" data-slide-to="${status.index}"
											${status.index==0?"class='active'":""}></li>
									</c:forEach>
								</ol>
	
								<div class="carousel-inner" style="width:800px; margin:0 auto;">
									<c:forEach var="dto" items="${plist}" varStatus="status">
										<div class="item ${status.index==0?'active':''}">
											<img
												src="<%=cp%>/resource/images/hotel/${dto.hotelphotoName}.jpg"
												style="width:1000px;">
										</div>
									</c:forEach>
								</div>
	
								<a class="left carousel-control" href="#myCarousel"
									data-slide="prev"> <span
									class="glyphicon glyphicon-chevron-left"></span> <span
									class="sr-only">Previous</span>
								</a> <a class="right carousel-control" href="#myCarousel"
									data-slide="next"> <span
									class="glyphicon glyphicon-chevron-right"></span> <span
									class="sr-only">Next</span>
								</a>
							</div>
						</div>


	
						<div class="convenient" style="margin-top:70px;">
							<h4>
								<b>편의시설</b>
							</h4>
							<p>${detail.detail}</p>
						</div>

						<div class="addoption" style="margin-top:70px;">
							<h4><b>추가옵션 선택사항</b></h4>
								<table style="text-align:center; margin-top:70px; margin-left:40px;">
									<tr>
										<th style="text-align:center;">선택</th>
										<th style="text-align:center;">이름</th>
										<th	style="text-align:center;">가격</th>
										<th	style="text-align:center;">인원수</th>
									</tr>
									<c:forEach var="op" items="${optlist}">
										<tr>
											<td style="width: 180px; text-align:center;">
												<input type="checkbox" class="optNum" name="optNum" value="${op.optNum}" data-price="${op.optPrice}" data-name="${op.optName}">
											</td>
											<td style="width: 280px; text-align:center;">${op.optName}</td>
											<td style="width: 280px; text-align:center;">${op.optPrice}</td>
											<td>
												<select class="optCount">
														<option value="">--선택--</option>
													<c:forEach varStatus="s" begin="1" end="${peoplecount}">
														<option value="${s.index}">${s.index}</option>
													</c:forEach>
												</select>
											</td>
										</tr>
									</c:forEach>		
								</table>
								
								
						
						</div>
						<table class="room" style="margin-top:70px;">
							<tr>
								<th>방유형</th>
								<th>세부사항</th>
								<th>최대 수용인원</th>
								<th>총가격</th>
								<th>임시의 칸</th>
							</tr>
	
							<c:forEach var="dto" items="${rlist}" varStatus="status">
								<tr class="room${status.index}">
									<td><p>${dto.roomtype}</p>
										<img src="<%=cp%>/resource/images/hotel/${dto.roomphotoName}"></td>
									<td style="width: 80px;">${dto.roomdetails}</td>
									<td>${dto.maxpeople}</td>
									<td>${dto.roomprice}</td>
									<td>	
										<button type="button" class="btn btn-default btn-sm reservationBtn"
											data-hotelId="${hotelId}" data-maxpeople="${dto.maxpeople}"
											data-roomprice="${dto.roomprice}"
											data-roomtype="${dto.roomtype}"
											data-roomdetails="${dto.roomdetails}">예약하기</button>
									</td>
								</tr>
							</c:forEach>
						</table>
						
						<h4><b>주변 명소 사진</b></h4>
						<div class="hotshow" style="width:800px; margin:0 auto; margin-top:50px;">
							<div id="myCarousel1" class="carousel slide" data-ride="carousel">
								<ol class="carousel-indicators">
									<c:forEach var="dto" items="${hotlist}" varStatus="status">
										<li data-target="#myCarousel" data-slide-to="${status.index}"
											${status.index==0?"class='active'":""}></li>
									</c:forEach>
								</ol>
	
								<div class="carousel-inner" style="width:800px; margin:0 auto;">
									<c:forEach var="dto" items="${hotlist}" varStatus="status">
										<div class="item ${status.index==0?'active':''}">
											<img
												src="<%=cp%>/uploads/hotplace/${dto.placePhoto}"
												style="width:1000px;">
											<p>${dto.placeName}</p>
											<p>${dto.placeDis}</p>	
										</div>
									</c:forEach>
								</div>
	
								<a class="left carousel-control" href="#myCarousel1"
									data-slide="prev"> <span
									class="glyphicon glyphicon-chevron-left"></span> <span
									class="sr-only">Previous</span>
								</a> <a class="right carousel-control" href="#myCarousel1"
									data-slide="next"> <span
									class="glyphicon glyphicon-chevron-right"></span> <span
									class="sr-only">Next</span>
								</a>
							</div>
						</div>

						
						<div style="width:800px; margin:0 auto; margin-top:30px;">
						<h4><b>리뷰</b></h4>
							<c:forEach var="rv" items="${reviewlist}">
								<div class="panel panel-warning" style="width:800px; margin:0 auto; margin-bottom:30px;">
									<div class="panel-heading">${rv.reviewTitle}</div>
									<div class="panel-body"><p>평점 : ${rv.score}</p>${rv.reviewContent}</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<form action="<%=cp%>/user/reservation/reservation" method="post"
	name="reserForm">
	<input type="hidden" name="hotelId">
	<input type="hidden" name="maxpeople"> 
	<input type="hidden" name="roomdetails">
	<input type="hidden" name="roomtype">
	<input type="hidden" name="roomprice">
	<input type="hidden" name="userId">
	<input type="hidden" value="${checkinday}" name="checkinday"> 
	<input type="hidden" value="${checkoutday}" name="checkoutday"> 
	<input type="hidden" value="${peoplecount}" name="peoplecount">

</form>