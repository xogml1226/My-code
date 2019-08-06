<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">
$(function(){
	$(".wishlistChange").click(function(){
		var userId="${sessionScope.member.userId}";
		if(! userId){
			location.href ="<%=cp%>/user/member/login";
			return false;
		}
		
		var $btn=$(this);
		
		var hotelId = $(this).attr("data-hotelId");
		var addr1 = $(this).attr("data-addr1");
		var url ="<%=cp%>/user/wishlist/add";
		var userId=userId;
		
		$.ajax({
			type:"post"
			, url:url
			, data:{hotelId:hotelId, addr1:addr1, userId:userId}
			, dataType:"json"
			, success:function(data){
				var result=data.result;
				if(result==1) {
					$btn.find("span").removeClass("glyphicon-star-empty");
					$btn.find("span").addClass("glyphicon-star");
				} else if (result==0) {
					$btn.find("span").removeClass("glyphicon-star");
					$btn.find("span").addClass("glyphicon-star-empty");
				}
			}, beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		});
		
		
	});
});

function detailLoad(hotelName, checkinday, checkoutday, peoplecount){
	location.href = "<%=cp%>/user/hotel/detail?hotelName="+hotelName+"&checkinday="+checkinday+"&checkoutday="+checkoutday+"&peoplecount="+peoplecount;
}

function hotelSearch(){
	var f = document.searchForm;
	f.action="<%=cp%>/user/hotel/list";
	
	var place = f.place.value;
	if(!place){
		alert("여행지를 입력해주세요");
		f.place.focus();
		return;
	}
	
	var checkinday = f.checkinday.value;
	if(!checkinday){
		alert("체크인날짜를 선택해주세요");
		f.checkinday.focus();
		return;
	}
	
	var checkoutday = f.checkoutday.value;
	if(!checkoutday){
		alert("체크아웃날짜를 선택해주세요");
		f.checkoutday.focus();
		return;
	}
	
	var peoplecount = f.peoplecount.value;
	if(peoplecount=="no"){
		alert("인원수를 선택해주세요");
		f.peoplecount.focus();
		return;
	}
	
	f.submit();
}

$(function() {
	var minDate1 = new Date();
	var minDate2 = new Date();
	$("#form-sday").datepicker({
		showMonthAfterYear : true,
		minDate : minDate1,
		onSelect : function(dateText, inst){
			var s= dateText.split("-");
	
			minDate2 = new Date(parseInt(s[0]), parseInt(s[1])-1, parseInt(s[2])+1);
			$( "#form-eday" ).datepicker( "option", "minDate", minDate2);
		}
	});
	
	$("#form-eday").datepicker({
		showMonthAfterYear : true,
		minDate : minDate2
	});
});
</script>


<style type="text/css">
.showHotelList {
	border: 1px solid #C6C6C6;
	padding: 10px;
	margin-bottom: 10px;
}

.showHotelList:hover{
	background-color:#E9F0F4;
}

.showHotelList td {
	vertical-align: top;
	padding: 5px;
}

.showHotelList .mainPhoto {
	width: 230px;
	height: 180px;
}

.showHotelList .star {
	width: 15px;
	height: 15px;
}


.showHotelList .btn {
	float: right;
}

.showHotelList .wishlistChange {
	float: right;
	background-color:white;
}

.msg {
	padding-top: 20px;
	text-align: center;
}

</style>

<div class="container">
	<div style="padding-top: 30px; padding-bottom: 20px;">
		<div class="panel panel-warning">
			<div class="panel-heading">
				<h2>호텔 정보 확인하기</h2>
				<p>검색 결과 : ${hotelCount} 개</p>
				
			</div>

			<div class="panel-body" style="margin: 0 auto;">
					<div style="width:17%; float:left; border:1px solid #DDDDDD; margin-right:2px;">
			<div style="font-size:20px; background-color:#F5F5F5; padding:5px;"><b>검색내용</b></div>
			<div style="font-size:13px; padding:5px; font-weight:bold; cursor:pointer">
			<form action="<%=cp%>/user/hotel/list" method="post" name="searchForm">
				<p><span class="glyphicon glyphicon-flag"></span>여행지
				<input style="width: 170px; height: 40px; border: 1px solid #ccc; border-radius: 4px; padding: 5px;" 
				type="text" placeholder="가고싶은 여행지를 입력해주세요" name="place" required="required" value="${place}">
				</p>
				<p><span class="glyphicon glyphicon-calendar"></span>체크인 
				<input type="text" name="checkinday" id="form-sday"readonly="readonly" value="${checkinday}"
							style="width: 170px; height: 40px; border: 1px solid #ccc; border-radius: 4px; padding: 5px;">
				</p>
				<p><span class="glyphicon glyphicon-calendar"></span>체크아웃 
				<input type="text"name="checkoutday" id="form-eday" readonly="readonly" value="${checkoutday}"
							style="width: 170px; height: 40px; border: 1px solid #ccc; border-radius: 4px; padding: 5px;">
				</p>
				<p><span class="glyphicon glyphicon-user"></span>인원
				<select
					style="width: 170px; height: 40px; border: 1px solid #ccc; border-radius: 4px;" name="peoplecount">
					<option value="no">인원수 선택</option>
					<option value=1 ${peoplecount=="1"?"selected='selected'":"" }>성인1명</option>
					<option value=2 ${peoplecount=="2"?"selected='selected'":"" }>성인2명</option>
					<option value=4 ${peoplecount=="4"?"selected='selected'":"" }>성인4명</option>
					<option value=0 ${peoplecount=="0"?"selected='selected'":"" }>4명이상</option>
				</select>
				</p>
				<p>
				<button type="button" onclick="hotelSearch()"
					style="width: 170px; height: 40px; background-color: skyblue; border: none; border-radius: 4px;">
					<b>검색</b>
				</button>
				</p>
				</form>
			</div>
		</div>
			<div style="width:80%; float:right; margin-bottom:10px;">
				<c:forEach var="dto" items="${list}">
					<div class="showHotelList">
						<table>
							<tr>
								<td><img class="mainPhoto"
									src="<%=cp%>/resource/images/hotel/${dto.mainphoto}.jpg"></td>
								<td>
									<h3>
										<a
											href="<%=cp%>/user/hotel/detail?hotelName=${dto.hotelName}&checkinday=${checkinday}&checkoutday=${checkoutday}&peoplecount=${peoplecount}">${dto.hotelName}</a>
										<c:set var="chk" value="0" />
										<c:if test="${not empty idlist}">
											<c:forEach var="vo" items="${idlist}">
												<c:if test="${vo.hotelId==dto.hotelId}">
													<c:set var="chk" value="1" />
												</c:if>
											</c:forEach>
										</c:if>

										<c:choose>
											<c:when test="${chk==1}">
												<button type="button" data-hotelId="${dto.hotelId}"
													data-addr1="${dto.addr1}" class="wishlistChange">
													<span class="glyphicon glyphicon-star"></span>
												</button>
											</c:when>
											<c:otherwise>
												<button type="button"   data-hotelId="${dto.hotelId}"
													data-addr1="${dto.addr1}" class="wishlistChange">
													<span class="glyphicon glyphicon-star-empty"></span>
												</button>
											</c:otherwise>
										</c:choose>
									</h3>
									<p>
									평점(${dto.scores } 점) :
									<c:if test="${dto.score < 2 }">
										<img class="star" src="<%=cp%>/resource/images/hotel/star.jpg">
									</c:if>
									<c:forEach var="i" begin="1" end="${dto.score/2 }">
										<img class="star" src="<%=cp%>/resource/images/hotel/star.jpg">
									</c:forEach>
									</p>
									<p>${dto.addr1},&nbsp;${dto.addr2}</p>
									<p>${dto.detail}</p>
									<p>
										<button type="button" class="btn"
											onclick="detailLoad('${dto.hotelName}','${checkinday}','${checkoutday}','${peoplecount}')">자세히보기
											></button>
									</p>
								</td>
							</tr>
						</table>
					</div>
				</c:forEach>
				${paging}
				</div>
			</div>
			<div class="msg">
				<p>더많은 정보를 보실려면 원하시는 호텔을 선택하세요.</p>
			</div>
		</div>
	</div>
</div>