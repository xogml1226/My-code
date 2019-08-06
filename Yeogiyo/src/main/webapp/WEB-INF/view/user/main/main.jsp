<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style type="text/css">
 .main {
	 background-image: url('<%=cp%>/resource/images/1.jpg');
	 background-repeat: no-repeat;
	 opacity: 0.9!important; filter:alpha(opacity=90);
	 background-size: 100%;
	 background-position: center;
 }
 .mainsearch {
 	width: 500px; 
 	margin: 60px; 
 	margin-bottom: 10px; 
 	min-height: 330px; 
 	border: 1px solid yellow; 
 	background-color: white; 
 	border-radius: 1em;
 }
</style>
<script type="text/javascript">
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
	$(function() {
		$("body").on("click", "#option", function() {
			var $div=$(this).next("div");
			var isVisible=$div.is(":visible");
			
			if(isVisible) {
				$div.hide();
				$("#shift").html(" ▽");
			} else {
				$div.show();
				$("#shift").html(" △");
			}
		});
	});
	
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
</script>

<div class="main">

<div class="container">
	<div id="mainsearch" style="margin-top: 20px; min-height: 500px;">
		<div class="mainsearch">
			<form action="" method="post" name="searchForm">
				<div style="margin: 20px;">
					<div>
						<label><b>여행지</b></label>
					</div>
					<div style="margin-top: 5px;">
						<input style="width: 420px; height: 40px; border: 1px solid #ccc; border-radius: 4px; padding: 5px;" type="text" placeholder="가고싶은 여행지를 입력해주세요" name="place"
							required="required">
					</div>
				</div>
				<div style="margin: 20px;">
					<div>
						<label><b>체크인 날짜</b></label> <span style="margin-right: 145px;"></span>
						<label><b>체크 아웃 날짜</b></label>
					</div>
					<div style="margin-top: 5px;">
						<input type="text" name="checkinday" id="form-sday"
							readonly="readonly"
							style="width: 200px; height: 40px; border: 1px solid #ccc; border-radius: 4px; padding: 5px;">

						<span style="margin-right: 20px;"></span> <input type="text"
							name="checkoutday" id="form-eday" readonly="readonly"
							style="width: 200px; height: 40px; border: 1px solid #ccc; border-radius: 4px; padding: 5px;">
					</div>
				</div>

				<div style="margin: 20px;">
					<div>
						<label><b>인원</b></label>
					</div>
					<div style="margin-top: 5px;">
						<select
							style="width: 200px; height: 40px; border: 1px solid #ccc; border-radius: 4px;" name="peoplecount">
							<option value="no">인원수 선택</option>
							<option value=1>성인1명</option>
							<option value=2>성인2명</option>
							<option value=4>성인4명</option>
							<option value=0>4명이상</option>
						</select> <span style="margin-right: 20px;"></span>
						<button type="button" onclick="hotelSearch()"
							style="width: 200px; height: 40px; background-color: skyblue; border: none; border-radius: 4px;">
							<b>검색</b>
						</button>
					</div>
				</div>
				<div style="margin: 20px;">
					<a id="option">추가 옵션 선택<span id="shift"> ▽</span></a>
					<div style="margin-top:10px; display: none;">	
						<div><b>호텔 등급 : </b></div>
						<div style="margin-bottom:5px;">
						<input type="checkbox" name="class1" value="1등급"> 1등급&nbsp;
						<input type="checkbox" name="class2" value="2등급"> 2등급&nbsp;
						<input type="checkbox" name="class3" value="3등급"> 3등급&nbsp;
						<input type="checkbox" name="class4" value="4등급"> 4등급&nbsp;
						</div>
						<div><b>숙소 유형 : </b></div>
						<div style="margin-bottom:5px;">
						<input type="checkbox" name="type1" value="hotel"> 호텔&nbsp;
						<input type="checkbox" name="type2" value="motel"> 모텔&nbsp;
						<input type="checkbox" name="type3" value="resort"> 리조트&nbsp;
						<input type="checkbox" name="type4" value="apartment"> 콘도&nbsp;
						</div>
						<div><b>평점 : </b></div>
						<div style="margin-bottom:5px;">
						<input type="checkbox" name="score1" value="9"> 9점:최고&nbsp;
						<input type="checkbox" name="score2" value="8"> 8점:매우 좋음&nbsp;
						<input type="checkbox" name="score3" value="7"> 7점:좋음&nbsp;
						<input type="checkbox" name="score4" value="6"> 6점:무난&nbsp;
						</div>
					</div>
				</div>
			</form>
			<div style="margin: 5px; margin-left: 20px; margin-bottom:20px;">
				<b>인기 여행지 :</b> &nbsp;<a href="">서울</a>&nbsp;&nbsp;<a href="">부산</a>
				&nbsp;&nbsp;<a href="">제주도</a>
				&nbsp;&nbsp;<a href="">도쿄</a>&nbsp;&nbsp;<a href="">오사카</a>
				&nbsp;&nbsp;<a href="">베이징</a>&nbsp;&nbsp;<a href="">상해</a>
			</div>
		</div>
	</div>
</div>
</div><br>
<div class="container">
<h1 align="center">Yeogiyo</h1><br>
<p align="center">여기요 에서는 고객들이 원하는 장소, 원하는 날짜에 맞춰 가장 최고의 숙박을 제공합니다.</p>
<p align="center">여기요는 전세계 25,000호텔들과 리조트, 팬션과 함께합니다.</p>
<p align="center">여기요와 함께 전세계 여행을 떠나보세요</p><br><hr><br>
<h1 align="center">이번달 추천 여행 명소</h1><br>
<div class="row">
  <div class="col-md-4">
    <div class="thumbnail">
      <a href="<%=cp%>/resource/images/jeju.jpg">
        <img src="<%=cp%>/resource/images/jeju.jpg" alt="jeju" style="width:100%">
        <div class="caption">
          <p>제주도</p>
        </div>
      </a>
    </div>
  </div>
  <div class="col-md-4">
    <div class="thumbnail">
      <a href="<%=cp%>/resource/images/osaka.jpg">
        <img src="<%=cp%>/resource/images/osaka.jpg" alt="osaka" style="width:100%">
        <div class="caption">
          <p>오사카</p>
        </div>
      </a>
    </div>
  </div>
  <div class="col-md-4">
    <div class="thumbnail">
      <a href="<%=cp%>/resource/images/hongkong.jpg">
        <img src="<%=cp%>/resource/images/hongkong.jpg" alt="hongkong" style="width:100%">
        <div class="caption">
          <p>홍콩</p>
        </div>
      </a>
    </div>
  </div>
</div>
<div class="row">
  <div class="col-md-4">
    <div class="thumbnail">
      <a href="<%=cp%>/resource/images/be.jpg">
        <img src="<%=cp%>/resource/images/be.jpg" alt="beijing" style="width:100%; height: 250px;">
        <div class="caption">
          <p>베이징</p>
        </div>
      </a>
    </div>
  </div>
  <div class="col-md-4">
    <div class="thumbnail">
      <a href="<%=cp%>/resource/images/ba.jpg">
        <img src="<%=cp%>/resource/images/ba.jpg" alt="Barcelona" style="width:100%; height: 250px;">
        <div class="caption">
          <p>바르셀로나</p>
        </div>
      </a>
    </div>
  </div>
  <div class="col-md-4">
    <div class="thumbnail">
      <a href="<%=cp%>/resource/images/newyork.jpg">
        <img src="<%=cp%>/resource/images/newyork.jpg" alt="NewYork" style="width:100%; height: 250px;">
        <div class="caption">
          <p>뉴욕</p>
        </div>
      </a>
    </div>
  </div>
</div>
</div>