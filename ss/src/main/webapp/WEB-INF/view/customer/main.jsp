<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="<%=cp%>/resource/css/tabs.css" type="text/css">
<style>
.alert-info {
    border: 1px solid #9acfea;
    border-radius: 4px;
    background-color: #d9edf7;
    color: #31708f;
    padding: 15px;
    margin-top: 10px;
    margin-bottom: 20px;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.form.js"></script>
<script type="text/javascript">
$(function(){
	$("#tab-notice").addClass("active");
	listPage(1);

	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$("ul.tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		// listPage(1);
		reloadBoard();
	});
});

// 글리스트 및 페이징 처리
function listPage(page) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	var url="<%=cp%>/customer/"+tab+"/list";
	
	var query="pageNo="+page;
	var search=$('form[name=customerSearchForm]').serialize();
	query=query+"&"+search;
	
	ajaxHTML(url, "get", query);
}

// 글리스트 및 글쓰기폼, 글보기, 글수정폼 ajax
function ajaxHTML(url, type, query) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			if($.trim(data)=="error") {
				listPage(1);
				return false;
			}
			$("#tab-content").html(data);
		}
		,beforeSend : function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		location.href="<%=cp%>/member/login";
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

// 검색
function searchList() {
	var f=document.customerSearchForm;
	f.condition.value=$("#condition").val();
	f.keyword.value=$.trim($("#keyword").val());

	listPage(1);
}

// 새로고침
function reloadBoard() {
	var f=document.customerSearchForm;
	f.condition.value="all";
	f.keyword.value="";
	
	listPage(1);
}

// 글쓰기폼
function insertForm() {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	var url="<%=cp%>/customer/"+tab+"/created";

	var query="tmp="+new Date().getTime();
	ajaxHTML(url, "get", query);
}

// 글등록, 수정등록, 답변등록
function sendOk(mode, page) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
    var f = document.boardForm;

	var str = f.subject.value;
    if(!str) {
        alert("제목을 입력하세요. ");
        f.subject.focus();
        return;
    }

	str = f.content.value;
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }
    
    if(tab=="inquiry" && mode=="created") {
    	if(f.emailRecv.checked && ! f.email.value) {
    		alert("이메일을 입력하세요. ");
            f.email.focus();
            return;
    	}
    	
    	if(f.phoneRecv.checked && ! f.phone.value) {
    		alert("전화번호를 입력하세요. ");
            f.phone.focus();
            return;
    	}
    }
	
    var url="<%=cp%>/customer/"+tab+"/"+mode;
    var query = new FormData(f); // IE는 10이상에서만 가능
    
	$.ajax({
        type:"post"
        ,url:url
        ,processData: false  // file 전송시 필수
        ,contentType: false  // file 전송시 필수
        ,data: query
        ,dataType:"json"
        ,success:function(data) {
            var state=data.state;
            if(state=="false")
                alert("게시물을 추가(수정)하지 못했습니다. !!!");

        	if(page==undefined || page=="")
        		page="1";
        	
        	if(mode=="created" || mode=="reply") {
        		reloadBoard()
        	} else {
        		listPage(page);
        	}
        }
        ,beforeSend : function(jqXHR) {
            jqXHR.setRequestHeader("AJAX", true);
        }
        ,error : function(jqXHR) {
        	if(jqXHR.status==403) {
	    		location.href="<%=cp%>/member/login";
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
        }
	});
}

// 글쓰기 취소, 수정 취소, 답변 취소
function sendCancel(page) {
	if(page==undefined || page=="")
		page="1";
	
	listPage(page);
}

// 게시글 보기
function articleBoard(num, page) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	var url="<%=cp%>/customer/"+tab+"/article";
	
	var query="num="+num;
	
	var search=$('form[name=customerSearchForm]').serialize();
	query=query+"&pageNo="+page+"&"+search;
	
	ajaxHTML(url, "get", query);
}

// 글 수정폼
function updateForm(num, page) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	var url="<%=cp%>/customer/"+tab+"/update";
	
	var query;
	if(tab=="board")
		query="boardNum="+num;
	else
		query="num="+num;
	query=query+"&pageNo="+page
	
	ajaxHTML(url, "get", query);
}

// 글 답변폼
function replyForm(num, page) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	var url="<%=cp%>/customer/"+tab+"/answer";
	
	var query="num="+num+"&pageNo="+page
	
	ajaxHTML(url, "get", query);
}

// 글 삭제
function deleteBoard(num, page, mode) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	var url="<%=cp%>/customer/"+tab+"/delete";
	
	var query="num="+num;
	if(tab=="qna") {
		query+="&mode="+mode;
	}
	
	if(! confirm("위 게시물을 삭제 하시 겠습니까 ? "))
		  return;
	  
	$.ajax({
	        type:"post"
	        ,url:url
	        ,data: query
	        ,dataType:"json"
	        ,success:function(data) {
	            listPage(page);
	        }
	        ,beforeSend : function(jqXHR) {
	            jqXHR.setRequestHeader("AJAX", true);
	        }
	        ,error : function(jqXHR) {
	        	if(jqXHR.status==403) {
		    		location.href="<%=cp%>/member/login";
		    		return false;
		    	}
		    	console.log(jqXHR.responseText);
	        }
	});
}

</script>

<div class="body-container" style="width: 800px;">
    <div class="body-title">
        <h3><i class="fas fa-phone-square"></i> 고객센터 </h3>
    </div>
    
    <div>
            <div style="clear: both;">
	           <ul class="tabs">
			       <li id="tab-notice" data-tab="notice">공지사항</li>
			       <li id="tab-inquiry" data-tab="inquiry">1:1문의</li>
			       <li id="tab-qna" data-tab="qna">질문답변</li>
			   </ul>
		   </div>
		   <div id="tab-content" style="clear:both; padding: 20px 10px 0px;"></div>
    </div>
</div>

<form name="customerSearchForm" action="" method="post">
    <input type="hidden" name="condition" value="all">
    <input type="hidden" name="keyword" value="">
</form>

