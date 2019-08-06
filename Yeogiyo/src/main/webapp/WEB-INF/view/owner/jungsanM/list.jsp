<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style>
table.ui-datepicker-calendar { display:none; }
</style>
<script type="text/javascript">
	$(document).ready(function () {
	    $.datepicker.regional['ko'] = {
   	       closeText: '닫기',
   	        prevText: '이전달',
   	        nextText: '다음달',
   	        currentText: '오늘',
   	        monthNames: ['1월(JAN)','2월(FEB)','3월(MAR)','4월(APR)','5월(MAY)','6월(JUN)',
   	        '7월(JUL)','8월(AUG)','9월(SEP)','10월(OCT)','11월(NOV)','12월(DEC)'],
   	        monthNamesShort: ['1월','2월','3월','4월','5월','6월',
   	        '7월','8월','9월','10월','11월','12월'],
   	        dayNames: ['일','월','화','수','목','금','토'],
   	        dayNamesShort: ['일','월','화','수','목','금','토'],
   	        dayNamesMin: ['일','월','화','수','목','금','토'],
   	        weekHeader: 'Wk',
   	        dateFormat: 'yy-mm-dd',
   	        firstDay: 0,
   	        isRTL: false,
   	        showMonthAfterYear: true,
   	        yearSuffix: '',
   	        showOn: 'focus',
   	        //buttonText: "달력",
   	        changeMonth: true,
   	        changeYear: true,
   	        showButtonPanel: true,
   	        yearRange: 'c-99:c+99'
	    };
	    $.datepicker.setDefaults($.datepicker.regional['ko']);
	 
	    var datepicker_default = {
	        showOn: 'focus',
	        //buttonText: "달력",
	        currentText: "이번달",
	        changeMonth: true,
	        changeYear: true,
	        showButtonPanel: true,
	        yearRange: 'c-99:c+99',
	        showOtherMonths: true,
	        selectOtherMonths: true
	    }
	 
	    datepicker_default.closeText = "선택";
	    datepicker_default.dateFormat = "yy-mm";
	    datepicker_default.onClose = function (dateText, inst) {
	        var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	        var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	        $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
	        $(this).datepicker('setDate', new Date(year, month, 1));
	    }
	 
	    datepicker_default.beforeShow = function () {
	        var selectDate = $("#form-sday").val().split("-");
	        var year = Number(selectDate[0]);
	        var month = Number(selectDate[1]) - 1;
	        $(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
	    }
	 
	    $("#form-sday").datepicker(datepicker_default);
	});
	function jungsan() {
		var f = document.formName;
		f.action = "<%=cp%>/owner/jungsanM/insert";
		f.submit();
	}

	function view() {
		var f = document.formName;
		f.action = "<%=cp%>/owner/jungsanM/list";
		f.submit();
	}
	
	function excel() {
		var f = document.formName;
		f.action = "<%=cp%>/owner/jungsanM/excel";
		f.submit();
	}

	$(function(){
		var url = "<%=cp%>/owner/jungsanM/bar";
		var day = "day=${day}";
		$.getJSON(url, day, function(data){
			$("#barContainer").highcharts({
				chart:{
					type:"column"
				},
				title:{
					text:"월별 매출"
				},
				xAxis:{
					categories: data.list
				},
				yAxis:{
					title:{
						text:"매출(￦)"
					}
				},
				series:data.series
			});
		});
	});
	
	$(function(){
		var url = "<%=cp%>/owner/jungsanM/bar2";
		var day = "day=${day}";
		$.getJSON(url, day, function(data) {
			$("#barContainer2").highcharts({
				chart : {
					type : "column"
				},
				title : {
					text : "월별 방문객수"
				},
				xAxis : {
					categories : data.list
				},
				yAxis : {
					title : {
						text : "인원(명)"
					}
				},
				series : data.series
			});
		});
	});
</script>
<div class="container">
	<div style="width:100%; margin:0 auto; padding-top:30px;">
		 <h1><span class="glyphicon glyphicon-usd"></span>&nbsp;<b>월말정산</b></h1>
	</div>
	<hr>
	<div style="width:17%; float:left; border:1px solid #DDDDDD; margin-right:2px;">
		<div style="font-size:20px; background-color:#F5F5F5; padding:5px;"><b>정산</b></div>
		<div style="font-size:16px; padding:5px; font-weight:bold; cursor:pointer">
			<p><a href="<%=cp%>/owner/jungsanD/list"> - 일일정산</a></p>
			<p><a href="<%=cp%>/owner/jungsanM/list"> - 월말정산</a></p>
		</div>
	</div>
	<div style="width:80%; float:right; border:1px solid #DDDDDD; margin-bottom:10px;">
	<div style="font-size:20px; font-weight:bold; background-color:#F5F5F5; padding:5px;">
			<span class="glyphicon glyphicon-home"></span>&nbsp;
			<span class="glyphicon glyphicon-chevron-right"></span>&nbsp;정산&nbsp;
			<span class="glyphicon glyphicon-chevron-right"></span>&nbsp;월말정산
		</div>
	<div style="padding:10px;">
	<div style="width: 100%; margin: 0 auto;">
		<div style="float: right;  padding-bottom:10px;">
			<form action="" name="formName">
				<strong>${msg }</strong> <input type="text" name="day"
					id="form-sday" readonly="readonly" value="${day }"
					style="text-align: center; width: 100px; height: 30px; border: 1px solid #ccc; border-radius: 4px;">
				<button type="button" class="btn btn-sm" onclick="view()">보기</button>
				<button type="button" class="btn btn-sm" onclick="jungsan()">정산</button>
				<button type="button" class="btn btn-sm" onclick="excel()">엑셀</button>
			</form>
		</div>
	</div>
	<div style="clear: both; border:1px solid #DDDDDD; padding:10px; border-radius:20px; margin-bottom:10px;">
	<div style="width: 100%; margin: 0 auto;">
		<table style="width: 100%; margin-left: auto; margin-right: auto;">
		<tr style="border-bottom: 2px solid gray;">
			<th style="width: 13%; text-align: center">결제일</th>
			<th style="width: 30%; text-align: center">방이름</th>
			<th style="width: 10%; text-align: center">결제종류</th>
			<th style="width: 10%; text-align: center">인원수</th>
			<th style="width: 13%; text-align: center">체크인</th>
			<th style="width: 13%; text-align: center">체크아웃</th>
			<th style="width: 11%; text-align: center">금액</th>
		</tr>
		</table>
	</div>
	<div
		style="width: 100%; height: 300px; margin: 0 auto; overflow: auto;">
		<table style="width: 100%; margin-left: auto; margin-right: auto;">

			<c:forEach var="dto" items="${list }">
				<tr
					style="border-bottom: 1px solid gray; background-color:${dto.num%2 == 0?'#FFFFFF':'#E6E6E6'};">
					<td style="width: 13%; text-align: center;">${dto.payDate }</td>
					<td style="width: 30%; text-align: left;">&nbsp;${dto.roomName }</td>
					<td style="width: 10%; text-align: center;">${dto.payType }</td>
					<td style="width: 10%; text-align: center;">${dto.peopleCount }</td>
					<td style="width: 13%; text-align: center;">${dto.checkinDay }</td>
					<td style="width: 13%; text-align: center;">${dto.checkoutDay }</td>
					<td style="width: 11%; text-align: right;">￦${dto.price }&nbsp;</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<c:if test="${sum == 0}">
		<div style="width: 100%; text-align: center;">정산자료가 존재하지 않습니다.</div>
	</c:if>
	<c:if test="${sum != 0}">
		<div style="width: 100%; text-align: right;">
			<strong>총금액 : ￦${sum }</strong>
		</div>
	</c:if>
	</div>
	<div style="clear: both; border:1px solid #DDDDDD; padding:10px; border-radius:20px; margin-bottom:10px;">
		<div id="barContainer"
			style="width: 100%; height: 300px; margin: 10px;"></div>
	</div>
	<div style="clear: both; border:1px solid #DDDDDD; padding:10px; border-radius:20px; margin-bottom:10px;">
		<div id="barContainer2"
			style="width: 100%; height: 300px; margin: 10px;"></div>
	</div>
	</div>
	</div>
</div>