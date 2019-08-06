<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<style type="text/css">
.titleDate {
	display: inline-block;
	font-weight: 600; 
	font-size: 19px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
	padding:2px 4px 4px;
	text-align:center;
	position: relative;
	top: 4px;
}
.btnDate {
	display: inline-block;
	font-size: 10px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
	color:#333333;
	padding:3px 5px 5px;
	border:1px solid #cccccc;
    background-color:#fff;
    text-align:center;
    cursor: pointer;
    border-radius:2px;
}

.textDate {
      font-weight: 500; cursor: pointer;  display: block; color:#333333;
}
.preMonthDate, .nextMonthDate {
      color:#aaaaaa;
}
.nowDate {
      color:#111111;
}
.saturdayDate{
      color:#0000ff;
}
.sundayDate{
      color:#ff0000;
}

#yearCalendar .lineBottomRight{
   border-bottom: 1px solid #cccccc;
   border-right: 1px solid #cccccc;
}
#yearCalendar .lineTop{
   border-Top: 1px solid #cccccc;
}
#yearCalendar .lineLeft{
   border-Left: 1px solid #cccccc;
}
</style>

<script type="text/javascript">
$(function(){
	$("#tab-year").addClass("active");
});

$(function(){
	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		var url="<%=cp%>/schedule"	
		if(tab=="month") {
			url+="/month";
		} else if(tab=="day") {
			url+="/day";
		} else if(tab=="year") {
			url+="/year";
		}
		
		location.href=url;
		
	});
});

function changeDate(year) {
	var url="<%=cp%>/schedule/year?year="+year;
	location.href=url;
}

$(function(){
	var today="${today}";
	$("#yearCalendar .textDate").each(function (i) {
        var s=$(this).attr("data-date");
        if(s==today) {
        	$(this).parent().css("background", "#ffffd9");
        }
    });
});

// 달력 날짜클릭-일일 일정보기
$(function(){
	$(".textDate").click(function(){
		var date=$(this).attr("data-date");
		var url="<%=cp%>/schedule/day?date="+date;
		location.href=url;
	});
});
</script>

<div class="body-container" style="width: 900px;">
    <div class="body-title">
        <h3><i class="far fa-calendar-alt"></i> 일정관리 </h3>
    </div>

    <div>

            <div style="clear: both;">
	           <ul class="tabs">
			       <li id="tab-month" data-tab="month">월별일정</li>
			       <li id="tab-day" data-tab="day">상세일정</li>
			       <li id="tab-year" data-tab="year">년도</li>
			   </ul>
		   </div>
		
		   <div id="tab-content" style="clear:both; padding: 20px 0px 0px;">
		   		<table style="width: 805px; margin:0px auto; border-spacing: 0;" >
		   			<tr height="60">
		   			     <td align="center">
		   			         <span class="btnDate" onclick="changeDate(${todayYear});">오늘</span>
		   			         <span class="btnDate" onclick="changeDate(${year-1});">＜</span>
		   			         <span class="titleDate">${year}年度</span>
		   			         <span class="btnDate" onclick="changeDate(${year+1});">＞</span>
		   			     </td>
		   			</tr>
		   		</table>
		   		
		   		<table id="yearCalendar" style="width: 805px; margin-top:5px; border-spacing: 0px; border-collapse: collapse;">
		   		    <c:forEach var="m" begin="1" end="12" step="3">
							<tr align="center" height="33">
								<td colspan="7" align="center" style="font-weight: 600;">${m}月</td>
								<td width="35">&nbsp;</td>
								<td colspan="7" align="center" style="font-weight: 600;">${m+1}月</td>
								<td width="35">&nbsp;</td>
								<td colspan="7" align="center" style="font-weight: 600;">${m+2}月</td>
							</tr>
							<tr align="center" height="33">
								<td width="35" style="color:#ff0000;" class="lineBottomRight lineLeft lineTop">일</td>
								<td width="35" class="lineBottomRight lineTop">월</td>
								<td width="35" class="lineBottomRight lineTop">화</td>
								<td width="35" class="lineBottomRight lineTop">수</td>
								<td width="35" class="lineBottomRight lineTop">목</td>
								<td width="35" class="lineBottomRight lineTop">금</td>
								<td width="35" style="color:#0000ff;" class="lineBottomRight lineTop">토</td>
								<td width="35">&nbsp;</td>
								
								<td width="35" style="color:#ff0000;" class="lineBottomRight lineLeft lineTop">일</td>
								<td width="35" class="lineBottomRight lineTop">월</td>
								<td width="35" class="lineBottomRight lineTop">화</td>
								<td width="35" class="lineBottomRight lineTop">수</td>
								<td width="35" class="lineBottomRight lineTop">목</td>
								<td width="35" class="lineBottomRight lineTop">금</td>
								<td width="35" style="color:#0000ff;" class="lineBottomRight lineTop">토</td>
								<td width="35">&nbsp;</td>
								
								<td width="35" style="color:#ff0000;" class="lineBottomRight lineLeft lineTop">일</td>
								<td width="35" class="lineBottomRight lineTop">월</td>
								<td width="35" class="lineBottomRight lineTop">화</td>
								<td width="35" class="lineBottomRight lineTop">수</td>
								<td width="35" class="lineBottomRight lineTop">목</td>
								<td width="35" class="lineBottomRight lineTop">금</td>
								<td width="35" style="color:#0000ff;" class="lineBottomRight lineTop">토</td>
							</tr>
							
							<c:forEach var="row" begin="0" end="5">
								<tr align="left" height="35">
								    <c:forEach var="i" begin="0" end="2">
								        <c:forEach var="col" begin="0" end="6">
								             <td align="center" class="lineBottomRight ${col==0?'lineLeft':''}">
								                 <c:if test="${not empty days[m-1+i][row][col]}">${days[m-1+i][row][col]}</c:if>
								                 <c:if test="${empty days[m-1+i][row][col]}">&nbsp;</c:if>
								             </td>
								        </c:forEach>
								        <c:if test="${i<2}"><td>&nbsp;</td></c:if>
								    </c:forEach>
								</tr>
							</c:forEach>
							<tr align="center" height="33">
								<td colspan="7">&nbsp;</td>
								<td width="35">&nbsp;</td>
								<td colspan="7">&nbsp;</td>
								<td width="35">&nbsp;</td>
								<td colspan="7">&nbsp;</td>
							</tr>
		   		    </c:forEach>
		   		</table>
		   </div>

    </div>
</div>