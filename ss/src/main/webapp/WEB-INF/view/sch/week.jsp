<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<script type="text/javascript">
$(function(){
	$("#tab-week").addClass("active");
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
		} else if(tab=="week") {
			url+="/week";
		} else if(tab=="day") {
			url+="/day";
		} else if(tab=="year") {
			url+="/year";
		}
		
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
			       <li id="tab-month" data-tab="month">월별</li>
			       <li id="tab-week" data-tab="week">주별</li>
			       <li id="tab-day" data-tab="day">일자별</li>
			       <li id="tab-year" data-tab="year">년별</li>
			   </ul>
		   </div>
		
		   <div id="tab-content" style="clear:both; padding: 20px 0px 0px;">
		   </div>
    </div>
</div>

