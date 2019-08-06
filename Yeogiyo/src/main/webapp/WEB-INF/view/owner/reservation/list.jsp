<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<style>
table.ui-datepicker-calendar { display:none; }

.modal{
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0,0,0); /* Fallback color */
	background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

.modal-content {
	background-color: #fefefe;
	margin: 10% auto; /* 15% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
	width: 60%; /* Could be more or less, depending on screen size */  
	height: 40%;  

	                       
}

.modal-content label{
	color:gray;
}

.modal-content h2{
	text-align:center;
}
</style>
<script type="text/javascript">
var date = new Date("${day}");
var y = date.getFullYear();
var m = date.getMonth();
var d = date.getDate();

var theDate = new Date(y,m,1);
var theDay = theDate.getDay();

var last = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

if(y%4 && y% 100!=0 || y%400===0){
	lastDate = last[1] = 29;
}

var lastDate = last[m];

var row = Math.ceil((theDay+lastDate)/7);

var calendar = "";

var dNum = 1;
for(var i=1; i<=row; i++){
	calendar += "<tr>";
	for(var k=1; k<=7; k++){
		if(i===1 && k<=theDay || dNum>lastDate){
			calendar += "<td> &nbsp; </td>";
		} else {
			var tdClass = "";
			if(dNum == d){
				tdClass = "today";
			} else {
				tdClass = "";
			}
			if(k==1){
				tdClass += " sun";
			}
			
			calendar += "<td style='height:100px;' valign='top' class='"+tdClass+"'>"
						+ "<strong class='date'>"+dNum+"</strong>"
						+ "<ul class='schedule RW'"
						+ "<li><a onclick='modal("+dNum+")' style='cursor:pointer'>예약상세확인</a></li>"
						+ "</ul>"
						+ "</td>";
						dNum++;
		}
	}
	calendar += "</tr>";
}

function modal(dNum){
	dNum = pad(dNum, 2);
	var yyyymm = "${day}";
	var url = "<%=cp%>/owner/reservation/modal";
	var query = "day="+yyyymm+"-"+dNum;
	var $reservation = $("#reservation");
	$.ajax({
		type:"post"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data){
			$reservation.empty();
			var count = 0;
			var out = "<table style='width:100%'>";
			out += "<tr style='border-bottom:1px solid black;'>";
			out += "<th style='width:15%'>방이름</th>";
			out += "<th style='width:15%'>방타입</th>";
			out += "<th style='width:10%'>인원</th>";
			out += "<th style='width:13%'>체크인</th>";
			out += "<th style='width:13%'>체크아웃</th>";
			out += "<th style='width:20%'>전화번호</th>";
			out += "<th style='width:20%'>예약자</th>";
			out += "</tr>";
			$.each(data.list, function(index, item){
				out += "<tr>";
				out += "<td style='width:15%'>"+item.roomName+"</td>";
				out += "<td style='width:15%'>"+item.roomType+"</td>";
				out += "<td style='width:10%'>"+item.peopleCount+"</td>";
				out += "<td style='width:13%'>"+item.checkInday+"</td>";
				out += "<td style='width:13%'>"+item.checkOutday+"</td>";
				out += "<td style='width:15%'>"+item.userTel+"</td>";
				out += "<td style='width:15%'>"+item.userName+"</td>";
				out += "</tr>";
				count ++;
			});
			out += "</table>";
			
			if(count == 0){
				out+= "<div style='width:100%; text-align:center;'>예약이 없습니다.</div>";
			}
			
			$reservation.html(out);
		}
		,error:function(e){
			console.log(e.responseText);
		}
	});
	
	$("#Modal").show();
}

function closes(){
	$("#Modal").hide();
}

function pad(n, width) {
	  n = n + '';
	  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

$(function(){
	$("#calendarBody").append(calendar);
});

function view(){
	var f = document.formName;
	f.action = "<%=cp%>/owner/reservation/list";
	f.submit();
}

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
</script>
<div class="container">
	<div style="width:100%; margin:0 auto; padding-top:30px;">
		 <h1><span class="glyphicon glyphicon-calendar"></span>&nbsp;<b>전체예약확인</b></h1>
	</div>
	<hr>
	<div style="width:17%; float:left; border:1px solid #DDDDDD; margin-right:2px;">
		<div style="font-size:20px; background-color:#F5F5F5; padding:5px;"><b>예약관리</b></div>
		<div style="font-size:16px; padding:5px; font-weight:bold; cursor:pointer">
			<p><a href="<%=cp%>/owner/reservation/list"> - 전체 예약 관리</a></p>
		</div>
	</div>
	<div style="width:80%; float:right; border:1px solid #DDDDDD; margin-bottom:10px;">
		<div style="font-size:20px; font-weight:bold; background-color:#F5F5F5; padding:5px;">
			<span class="glyphicon glyphicon-home"></span>&nbsp;
			<span class="glyphicon glyphicon-chevron-right"></span>&nbsp;예약관리&nbsp;
			<span class="glyphicon glyphicon-chevron-right"></span>&nbsp;전체 예약 관리
		</div>
	<div style="padding:10px;">
	<div style="width: 100%; margin: 0 auto; font-size:25px; text-align:center;">
		${day }월&nbsp;예약현황
	</div>
	<div style="float: right; margin-bottom:10px;">
		<form action="" name="formName">
			<strong>${msg }</strong> <input type="text" name="day"
				id="form-sday" readonly="readonly" value="${day }"
				style="text-align: center; width: 100px; height: 30px; border: 1px solid #ccc; border-radius: 4px;">
			<button type="button" class="btn btn-sm" onclick="view()">보기</button>
		</form>
	</div>
	<table style="width: 100%; margin-left: auto; margin-right: auto; margin-bottom:10px; border:3px solid #DDDDDD" border=1 >
		<thead style="text-align:center;">
			<tr>
				<td>일</td>
				<td>월</td>
				<td>화</td>
				<td>수</td>
				<td>목</td>
				<td>금</td>
				<td>토</td>
			</tr>
		</thead>
		<tbody id="calendarBody">
		</tbody>
	</table>
	<div id="Modal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closes()">&times;</span>
			<div id="reservation" style="height:100%; overflow: auto;">
				
			</div>
		</div>
	</div>
	</div>
	</div>
</div>