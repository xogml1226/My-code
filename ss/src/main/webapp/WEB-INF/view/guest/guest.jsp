﻿<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.guest-write {
    border: #d5d5d5 solid 1px;
    padding: 10px;
    min-height: 50px;
}
.more:active, .more:focus, .more:hover {
    cursor: pointer;
    color: #333333;
}
</style>

<script type="text/javascript">
var pageNo=1;
var totalPage=1;

function login() {
	location.href="<%=cp%>/member/login";	
}

$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/guest/list";
	var query="pageNo="+page;
	$.ajax({
		type:"get"
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			printGuest(data);
		}
		,beforeSend : function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

// 무한 스크롤
$(function(){
	$(window).scroll(function(){
		if($(window).scrollTop()+100>=$(document).height()-$(window).height()) {
			if(pageNo<totalPage) {
				++pageNo;
				listPage(pageNo);
			}
		}
	});
});

function printGuest(data) {
	var uid="${sessionScope.member.userId}";
	var dataCount = data.dataCount;
	var page = data.pageNo;
	totalPage = data.total_page;
	
	var out="";
	if(dataCount!=0) {
		for(var idx=0; idx<data.list.length; idx++) {
			var num=data.list[idx].num;
			var userName=data.list[idx].userName;
			var userId=data.list[idx].userId;
			var content=data.list[idx].content;
			var created=data.list[idx].created;
			
			out+="    <tr height='35' bgcolor='#eeeeee'>";
			out+="      <td width='50%' style='padding-left: 5px; border:1px solid #cccccc; border-right:none;'>"+ userName+"</td>";
			out+="      <td width='50%' align='right' style='padding-right: 5px; border:1px solid #cccccc; border-left:none;'>" + created;
			if(uid==userId || uid=="admin") {
				out+=" | <a onclick='deleteGuest(\""+num+"\", \""+page+"\");'>삭제</a></td>" ;
			} else {
				out+=" | <a href='#'>신고</a></td>" ;
			}
			out+="    </tr>";
			out+="    <tr style='height: 50px;'>";
			out+="      <td colspan='2' style='padding: 5px;' valign='top'>"+content+"</td>";
			out+="    </tr>";
		}
		
		$("#listGuestBody").append(out);
		
		if(! checkScrollBar()) { // checkScrollBar() 함수는 util-jquery.js 에 존재
			if(pageNo<totalPage) {
				++pageNo;
				listPage(pageNo);
			}
		}
	}
}

function sendGuest() {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		login();
		return;
	}
	
	if(! check()) {
		return;
	}
	
	var query=$("form[name=guestForm]").serialize();
	$.ajax({
		type:"post"
		,url:"<%=cp%>/guest/insert"
		,data:query
		,dataType:"json"
		,success:function(data) {
			// var state = data.state;
			
			$("#content").val("");
			
			$("#listGuestBody").empty();
			pageNo=1;
			listPage(1);
		}
		,beforeSend : function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function check() {
	if(! $.trim($("#content").val()) ) {
		$("#content").focus();
		return false;
	}
	
	return true;
}

function deleteGuest(num, page) {
	var uid="${sessionScope.member.userId}";
	if(! uid) {
		alert("로그인이 필요 합니다.");
		return;
	}
	
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="<%=cp%>/guest/delete";
		var query="num="+num;
		$.ajax({
			type:"post"
			,url:url
			,data:query
			,dataType:"json"
			,success:function(data) {
				// var state=data.state;
				$("#listGuestBody").empty();
				pageNo=1;
				listPage(1);
			}
		    ,beforeSend:function(jqXHR) {
		    	jqXHR.setRequestHeader("AJAX", true);
		    }
		    ,error:function(jqXHR) {
		    	if(jqXHR.status==403) {
		    		login();
		    		return false;
		    	}
		    	console.log(jqXHR.responseText);
		    }
		});
		
	}
}
</script>

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><i class="far fa-edit"></i> 방명록 </h3>
    </div>
    
    <div>
             <form name="guestForm" method="post" action="">
             <div class="guest-write">
                 <div style="clear: both;">
                         <span style="font-weight: bold;">방명록쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
                 </div>
                 <div style="clear: both; padding-top: 10px;">
                       <textarea name="content" id="content" class="boxTF" rows="3" style="display:block; width: 100%; padding: 6px 12px; box-sizing:border-box;" required="required"></textarea>
                  </div>
                  <div style="text-align: right; padding-top: 10px;">
                       <button type="button" class="btn" onclick="sendGuest();" style="padding:8px 25px;"> 등록하기 </button>
                  </div>           
            </div>
           </form>
         
        <div id="listGuest">
           <table style='width: 100%; margin: 10px auto 0px; border-spacing: 0px; border-collapse: collapse;'>
	           <thead>
		           <tr height='35'>
		                <td width='50%'>
		                    <span style='color: #3EA9CD; font-weight: 700;'>방명록</span>
		                    <span>[목록]</span>
		                 </td>
		                 <td width='50%'>&nbsp;</td>
		           </tr>
	           </thead>
	           <tbody id="listGuestBody"></tbody>
	       </table>
        </div>
           
 	 </div>
    
</div>