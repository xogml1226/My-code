<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<style type="text/css">
.ui-widget-header {
	background: none;
	border: none;
	height:35px;
	line-height:35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
}
.help-block {
	margin-top: 3px; 
}

.titleDate {
	display: inline-block;
	font-weight: 600; 
	font-size: 15px;
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
</style>
<script type="text/javascript">
$(function(){
	$("#tab-day").addClass("active");
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

$(function(){
	var today="${today}";
	var date="${date}";
	$("#smallCalendar .textDate").each(function (i) {
        var s=$(this).attr("data-date");
        if(s==today) {
        	$(this).parent().css("background", "#ffffd9");
        }
        if(s==date) {
        	$(this).css("font-weight", "600");
        }
    });
});

function changeDate(date) {
	var url="<%=cp%>/schedule/day?date="+date;
	location.href=url;
}

// 작은달력 날짜클릭-일일 일정보기
$(function(){
	$(".textDate").click(function(){
		var date=$(this).attr("data-date");
		var url="<%=cp%>/schedule/day?date="+date;
		location.href=url;
	});
});

<c:if test="${not empty dto}">
$(function(){
	$("#btnUpdate").click(function(){
		// 폼 reset
		$("form[name=scheduleForm]").each(function(){
			this.reset();
		});
		
		$("#form-sday").datepicker({showMonthAfterYear:true});
		$("#form-eday").datepicker({showMonthAfterYear:true});
		
		var date1="${dto.sday}";
		var date2="${dto.eday}";
		if(date2=="") {
			date2=date1;
			$("#form-eday").val(date2);
		}
		
		$("#form-sday").datepicker("option", "defaultDate", date1);
		$("#form-eday").datepicker("option", "defaultDate", date2);
		
		var stime="${dto.stime}";
		if(stime!="") {
			$("#form-stime").show();
			$("#form-etime").show();
		} else {
			$("#form-stime").hide();
			$("#form-etime").hide();
		}
		var repeat="${dto.repeat}";
		if(repeat=="1") {
			$("#form-repeat_cycle").show();
			$("#form-eday").closest("tr").hide();
		} else {
			$("#form-repeat_cycle").hide();
			$("#form-eday").closest("tr").show();
		}
		
		$('#schedule-dialog').dialog({
			  modal: true,
			  height: 650,
			  width: 600,
			  title: '스케쥴 수정',
			  close: function(event, ui) {
			  }
		});
	});
});

// 수정완료
$(function(){
	$("#btnScheduleSendOk").click(function(){
		if($("#form-repeat_cycle").val()=="") {
			$("#form-repeat_cycle").val("0");
		}
		
		if(! check()) {
			return;
		}
		
		var query=$("form[name=scheduleForm]").serialize();
		var url="<%=cp%>/schedule/update";
		
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				var state=data.state;
				if(state=="true") {
					var date="${date}";
					var num="${dto.num}";
					location.href="<%=cp%>/schedule/day?date="+date+"&num="+num;
				}
			}
			,beforeSend : function(jqXHR) {
		        jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		location.href="<%=cp%>/member/login";
		    		return;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
		
	});
});

// 수정 대화상자 닫기
$(function(){
	$("#btnScheduleSendCancel").click(function(){
		$('#schedule-dialog').dialog("close");
	});
});

$(function(){
	$("#form-allDay").click(function(){
		if(this.checked==true) {
			$("#form-stime").val("").hide();
			$("#form-etime").val("").hide();
		} else if(this.checked==false && $("#form-repeat").val()==0){
			$("#form-stime").val("00:00").show();
			$("#form-etime").val("00:00").show();
		}
	});

	$("#form-sday").change(function(){
		$("#form-eday").val($("#form-sday").val());
	});
	
	$("#form-repeat").change(function(){
		if($(this).val()=="0") {
			$("#form-repeat_cycle").val("0").hide();
			
			$("#form-allDay").prop("checked", true);
			$("#form-allDay").removeAttr("disabled");
			
			$("#form-eday").val($("#form-sday").val());
			$("#form-eday").closest("tr").show();
		} else {
			$("#form-repeat_cycle").show();
			
			$("#form-allDay").prop("checked", true);
			$("#form-allDay").attr("disabled","disabled");

			$("#form-stime").val("").hide();
			$("#form-eday").val("");
			$("#form-etime").val("");
			$("#form-eday").closest("tr").hide();
		}
	});
});

// 수정내용 유효성 검사
function check() {
	if(! $("#form-subject").val()) {
		$("#form-subject").focus();
		return false;
	}

	if(! $("#form-sday").val()) {
		$("#form-sday").focus();
		return false;
	}

	if($("#form-eday").val()) {
		var s1=$("#form-sday").val().replace("-", "");
		var s2=$("#form-eday").val().replace("-", "");
		if(s1>s2) {
			$("#form-sday").focus();
			return false;
		}
	}
	
	if($("#form-stime").val()!="" && !isValidTime($("#form-stime").val())) {
		$("#form-stime").focus();
		return false;
	}

	if($("#form-etime").val()!="" && !isValidTime($("#form-etime").val())) {
		$("#form-etime").focus();
		return false;
	}
	
	if($("#form-etime").val()) {
		var s1=$("#form-stime").val().replace(":", "");
		var s2=$("#form-etime").val().replace(":", "");
		if(s1>s2) {
			$("#form-stime").focus();
			return false;
		}
	}	
	
	if($("#form-repeat").val()!="0" && ! /^(\d){1,2}$/g.test($("#form-repeat_cycle").val())) {
		$("#form-repeat_cycle").focus();
		return false;
	}
	
	if($("#form-repeat").val()!="0" && $("#form-repeat_cycle").val()<1) {
		$("#form-repeat_cycle").focus();
		return false;
	}
	
	return true;
}

//시간 형식 유효성 검사
function isValidTime(data) {
	if(! /(\d){2}[:](\d){2}/g.test(data)) {
		return false;
	}
	
	var t=data.split(":");
	if(t[0]<0||t[0]>23||t[1]<0||t[1]>59) {
		return false;
	}

	return true;
}

function deleteOk(num) {
	if(confirm("일정을 삭제 하시 겠습니까 ? ")) {
		var date="${date}";
		var url="<%=cp%>/schedule/delete?date="+date+"&num="+num;
		location.href=url;
	}
}
</c:if>
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
		
		   <div id="tab-content" style="clear:both; padding: 20px 0px 0px; ">
		   
		       <div style="clear: both;">
			       <div id="scheduleLeft" style="float:left; padding-left: 0px; padding-rigth: 0px;">
				   		<table style="width: 280px; border-spacing: 0;" >
				   			<tr height="35">
				   			     <td align="center">
				   			         <span class="btnDate" onclick="changeDate('${today}');">오늘</span>
				   			         <span class="btnDate" onclick="changeDate('${preMonth}');">＜</span>
				   			         <span class="titleDate">${year}年 ${month}月</span>
				   			         <span class="btnDate" onclick="changeDate('${nextMonth}');">＞</span>
				   			     </td>
				   			</tr>
				   		</table>
			       
						<table id="smallCalendar" style="width: 280px;margin-top:5px; border-spacing: 1px; background: #cccccc; " >
							<tr align="center" height="33" bgcolor="#ffffff">
								<td width="40" style="color:#ff0000;">일</td>
								<td width="40">월</td>
								<td width="40">화</td>
								<td width="40">수</td>
								<td width="40">목</td>
								<td width="40">금</td>
								<td width="40" style="color:#0000ff;">토</td>
							</tr>
									   		
						    <c:forEach var="row" items="${days}" >
								<tr align="left" height="37" bgcolor="#ffffff">
									<c:forEach var="d" items="${row}">
										<td align="center" class="tdDay">
											${d}
										</td>
									</c:forEach>
								</tr>
						    </c:forEach>
						</table>			       
			       </div>
			       <div id="scheduleRight" style="float:left; padding-left: 30px; padding-rigth: 0px; width: 600px; box-sizing: border-box;">

						<table style="width: 100%; border-spacing: 0px;">
						   <tr height="35">
						      <td align="left">
						           <span class="titleDate">${year}年 ${month}月 ${day}日 일정</span>
						      </td>
						   </tr>
						</table>
						
						<c:if test="${empty dto}">
							<table style="width: 100%; margin-top:5px; border-spacing: 0px; border-collapse: collapse;">
								<tr height="35">
								     <td align="center">등록된 일정이 없습니다.</td>
								</tr>
							</table>
						</c:if>
						<c:if test="${not empty dto}">
							<table style="width: 100%; margin-top:5px; border-spacing: 0px; border-collapse: collapse;">
							  <tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
							      <td width="100" style="text-align: right;">
							            <label style="font-weight: 900;">제목</label>
							      </td>
							      <td style="text-align: left; padding-left: 7px;">
							        <p style="margin-top: 1px; margin-bottom: 1px;">
							            ${dto.subject}
							        </p>
							      </td>
							  </tr>
							  <tr height="35" style="border-bottom: 1px solid #cccccc;">
							      <td width="100" style="text-align: right;">
							            <label style="font-weight: 900;">날짜</label>
							      </td>
							      <td style="text-align: left;  padding-left: 7px;">
							        <p style="margin-top: 1px; margin-bottom: 1px;">
							            ${dto.period}
							        </p>
							      </td>
							  </tr>
							  <tr height="35" style="border-bottom: 1px solid #cccccc;">
							      <td width="100" style="text-align: right; ">
							            <label style="font-weight: 900;">일정분류</label>
							      </td>
							      <td style="text-align: left;  padding-left: 7px;">
							        <p style="margin-top: 1px; margin-bottom: 1px;">
						                 <c:choose>
						                 	<c:when test="${dto.color=='green'}">개인일정</c:when>
						                 	<c:when test="${dto.color=='blue'}">가족일정</c:when>
						                 	<c:when test="${dto.color=='tomato'}">회사일정</c:when>
						                 	<c:otherwise>기타일정</c:otherwise>
						                 </c:choose>, ${empty dto.stime?"종일일정":"시간일정"}
							        </p>
							      </td>
							  </tr>
							  <tr height="35" style="border-bottom: 1px solid #cccccc;">
							      <td width="100" style="text-align: right;">
							            <label style="font-weight: 900;">일정반복</label>
							      </td>
							      <td style="text-align: left; padding-left: 7px;">
							        <p style="margin-top: 1px; margin-bottom: 1px;">
								        <c:if test="${dto.repeat !=0 && dto.repeat_cycle!=0}">
								            반복일정, 반복주기 ${dto.repeat_cycle}년
								        </c:if>
								        <c:if test="${dto.repeat ==0 || dto.repeat_cycle==0}">
								            반복안함
								        </c:if>
							        </p>
							      </td>
							  </tr>
							  <tr height="35" style="border-bottom: 1px solid #cccccc;">
							      <td width="100" style="text-align: right;">
							            <label style="font-weight: 900;">등록일</label>
							      </td>
							      <td style="text-align: left; padding-left: 7px;">
							        <p style="margin-top: 1px; margin-bottom: 1px;">
								        ${dto.created}
							        </p>
							      </td>
							  </tr>
							  <tr height="45" style="border-bottom: 1px solid #cccccc;">
							      <td width="100" valign="top" style="text-align: right; margin-top: 5px;">
							            <label style="font-weight: 900;">메모</label>
							      </td>
							      <td valign="top" style="text-align: left; margin-top: 5px; padding-left: 7px;">
							        <p style="margin-top: 0px; margin-bottom: 1px;">
								        <span style="white-space: pre;">${dto.memo}</span>
							        </p>
							      </td>
							  </tr>
								<tr height="45">
                                    <td colspan="2" align="right" style="padding-right: 5px;">
                                       <button type="button" id="btnUpdate" class="btn" >수정</button>
                                       <button type="button" id="btnDelete" class="btn" onclick="deleteOk('${dto.num}');">삭제</button>
                                    </td>
			                    </tr>
			                     
							</table>
						</c:if>
						
						<c:if test="${list.size()>1}">
							<table style="width: 100%; margin-top:15px; border-spacing: 0px;">
							   <tr height="35">
							      <td align="left">
							           <span class="titleDate">${year}年 ${month}月 ${day}日 다른 일정</span>
							      </td>
							   </tr>
							</table>
						
							<table style="width: 100%; margin:5px 0 20px; border-spacing: 0px; border-collapse: collapse;">
							  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
							      <th width="80" style="color: #787878;">분류</th>
							      <th style="color: #787878;">제목</th>
							      <th width="80" style="color: #787878;">등록일</th>
							  </tr>
							  
							  <c:forEach var="vo" items="${list}">
							    <c:if test="${dto.num != vo.num}">
							      <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
							           <td>
							                 <c:choose>
							                 	<c:when test="${vo.color=='green'}">개인일정</c:when>
							                 	<c:when test="${vo.color=='blue'}">가족일정</c:when>
							                 	<c:when test="${vo.color=='tomato'}">회사일정</c:when>
							                 	<c:otherwise>기타일정</c:otherwise>
							                 </c:choose>
							           </td>
							           <td align="left" style="padding-left: 10px;">
							               <a href="<%=cp%>/schedule/day?date=${date}&num=${vo.num}">${vo.subject}</a>
							           </td>
							           <td>${vo.created}</td>
							      </tr>
							     </c:if>
							  </c:forEach>
							</table>
						</c:if>
						
			       
			       </div>
		       </div>
		   </div>

    </div>
</div>

<c:if test="${not empty dto}">    
    <div id="schedule-dialog" style="display: none;">
		<form name="scheduleForm">
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">제목</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="subject" id="form-subject" maxlength="100" class="boxTF" value="${dto.subject}" style="width: 95%;">
			        </p>
			        <p class="help-block">* 제목은 필수 입니다.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">일정분류</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			          <select name="color" id="form-color" class="selectField">
			              <option value="green" ${dto.color=="green"?"selected='selected' ":""}>개인일정</option>
			              <option value="blue" ${dto.color=="blue"?"selected='selected' ":""}>가족일정</option>
			              <option value="tomato" ${dto.color=="tomato"?"selected='selected' ":""}>회사일정</option>
			              <option value="purple" ${dto.color=="purple"?"selected='selected' ":""}>기타일정</option>
			          </select>
			        </p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">종일일정</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 5px; margin-bottom: 5px;">
			             <input type="checkbox" name="allDay" id="form-allDay" value="1" ${empty dto.stime?"checked='checked'":""}>
			             <label for="allDay">하루종일</label>
			        </p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">시작일자</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="sday" id="form-sday" maxlength="10" class="boxTF" value="${dto.sday}" readonly="readonly" style="width: 25%; background: #ffffff;">
			            <input type="text" name="stime" id="form-stime" maxlength="5" class="boxTF" value="${dto.stime}" style="width: 15%; display: none;" placeholder="시작시간">
  			        </p>
			        <p class="help-block">* 시작날짜는 필수입니다.</p>
			      </td>
			  </tr>

			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">종료일자</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="eday" id="form-eday" maxlength="10" class="boxTF" value="${dto.eday}" readonly="readonly" style="width: 25%; background: #ffffff;">
			            <input type="text" name="etime" id="form-etime" maxlength="5" class="boxTF" value="${dto.etime}" style="width: 15%; display: none;" placeholder="종료시간">
			        </p>
			        <p class="help-block">종료일자는 선택사항이며, 시작일자보다 작을 수 없습니다.</p>
			      </td>
			  </tr>

			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">일정반복</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <select name="repeat" id="form-repeat" class="selectField">
			              <option value="0" ${dto.repeat==0?"selected='selected' ":""}>반복안함</option>
			              <option value="1" ${dto.repeat==1?"selected='selected' ":""}>년반복</option>
			            </select>
			            <input type="text" name="repeat_cycle" id="form-repeat_cycle" maxlength="2" class="boxTF" value="${dto.repeat_cycle}" style="width: 20%; display: none;" placeholder="반복주기">
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">메모</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <textarea name="memo" id="form-memo" class="boxTA" style="width:93%; height: 70px;">${dto.memo}</textarea>
			        </p>
			      </td>
			  </tr>
			  
			  <tr height="45">
			      <td align="center" colspan="2">
			        <input type="hidden" name="num" value="${dto.num}">
			        <button type="button" class="btn" id="btnScheduleSendOk">수정완료</button>
			        <button type="button" class="btn" id="btnScheduleSendCancel">수정취소</button>
			      </td>
			  </tr>
			</table>
		</form>
    </div>
</c:if>