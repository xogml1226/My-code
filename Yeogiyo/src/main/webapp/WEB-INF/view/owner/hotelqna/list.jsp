<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
function hotSearch(){
   var f = document.searchForm;
   f.submit();
}

function replaceAll(str, searchStr, replaceStr) {
     return str.split(searchStr).join(replaceStr);
}

function reLoad(){
	location.href = "<%=cp%>/owner/hotelqna/list";
}

$(function(){
   $("body").on("click",".qnalist", function(){
      var qnaNum = $(this).next().val();
      var isHidden = $(this).next().next().is(':hidden');
      var $list = $(this).next().next();
      var parentContent = $(this).next().next().next().val();
      var url = "<%=cp%>/owner/hotelqna/lists";
      var query = "qnaNum="+qnaNum;
      $(".qna").hide();
      if(isHidden){
         $(this).next().next().show();
         $.ajax({
            type:"post"
            ,url:url
            ,data:query
            ,dataType:"json"
            ,success:function(data){
               $list.empty();
               var count = 0;
               var out = "<div style='background-color:#FAFAFA;'><span class='glyphicon glyphicon-question-sign'></span>&nbsp;<strong>질문</strong>";
               out += "<div>" + parentContent + "</div></div>";
               $.each(data.list, function(index, item){
                  count++;
                  out += "<div style='background-color:#FAFAFA; margin-top:5px;'><span class='glyphicon glyphicon-info-sign'></span>&nbsp;";
                  out += "<strong>답변</strong>&nbsp;(<a class='deleteQna' style='cursor:pointer;'>삭제</a>|<a class='updateQna' style='cursor:pointer;'>수정</a>)";
                  out += "<div>"+item.qnaContent+"</div></div>";
               });
               if(count == 0){
                  out += "<div style='width:100%'><textarea name='qnaContent' style='width:100%'></textarea>&nbsp;<button type='button' style='float:right;' class='btn btn-sm writeQna'>답변하기</button></div>";
               }
            
               $list.html(out);
            }
            ,error:function(e){
               console.log(e.responseText);
            }
         });
      } else {
         $(this).next().next().hide();
      }
      
   });
   
   $("body").on("click",".writeQna", function(){
      var HotelQna = {};
      HotelQna.qnaParent = $(this).parent().parent().prev().val();
      HotelQna.qnaContent = $(this).prev().val();
      var url = "<%=cp%>/owner/hotelqna/insert";
      var $list = $(this).parent().parent();
      var $no = $(this).parent().parent().parent().prev().children().first();
   
      $.ajax({
         type:"post"
         ,url:url
         ,data:HotelQna
         ,dataType:"json"
         ,success:function(data){
            var state = data.state;
            if(state=="false"){
               alert("데이터를 추가하지 못했습니다.");
               return false;
            }
            $no.empty();
            $no.css("color","blue");
            $no.html("답변완료");
            $list.hide();
         }
         ,error:function(e){
            console.log(e.responseText);
         }
      });
      
   });
   
   $("body").on("click",".deleteQna", function(){
      var qnaNum = $(this).parent().parent().prev().val();
      var url = "<%=cp%>/owner/hotelqna/delete";
      var query = "qnaNum="+qnaNum;
      var $list = $(this).parent().parent();
      var $yes = $(this).parent().parent().parent().prev().children().first();
      if(! confirm("정말 삭제하시겠습니까?")){
         return false;
      }
      $.ajax({
         type:"post"
         ,url:url
         ,data:query
         ,dataType:"json"
         ,success:function(data){
            var state = data.state;
            if(state=="false"){
               alert("데이터를 삭제하지 못했습니다.");
               return false;
            }
            $yes.empty();
            $yes.css("color","red");
            $yes.html("답변미완료");
            $list.hide();
         }
         ,error:function(e){
            console.log(e.responseText);
         }
      });
      
   });
   
   $("body").on("click",".updateQna", function(){
      var qnaContent = $(this).parent().children().last().html();
      qnaContent = replaceAll(qnaContent, "<br>", "\n");
      var $content = $(this).parent().children().last();
      
      var out = "<textarea name='qnaContent' style='width:100%'>"+qnaContent+"</textarea>&nbsp;";
      out += "<button type='button' style='float:right;' class='btn btn-sm updateCon'>수정</button>&nbsp;";
      out += "<button type='button' style='float:right;' class='btn btn-sm updateCan'>취소</button>"
      
      $content.empty();
      $content.html(out);
      
   });
   
   $("body").on("click",".updateCon", function(){
      var hotelQna = {};
      var qnaNum = $(this).parent().parent().parent().prev().val();
      var qnaContent = $(this).parent().children().first().val();
      hotelQna.qnaNum = qnaNum;
      hotelQna.qnaContent = qnaContent;
      
      var url = "<%=cp%>/owner/hotelqna/update";
      var $list = $(this).parent().parent().parent();
      
      $.ajax({
         type:"post"
         ,url:url
         ,data:hotelQna
         ,dataType:"json"
         ,success:function(data){
            var state = data.state;
            if(state=="false"){
               alert("데이터를 수정하지 못했습니다.");
               return false;
            }
            $list.hide();
         }
         ,error:function(e){
            console.log(e.responseText);
         }
      });
   });
   
   $("body").on("click",".updateCan", function(){
      var qnaContent = $(this).parent().children().first().val();
      qnaContent = replaceAll(qnaContent, "\n", "<br>");
      var $content = $(this).parent().parent().children().last();
      
      $content.empty();
      $content.html(qnaContent);
   });
});
</script>
<div class="container">
   <div style="width:100%; margin:0 auto; padding-top:30px;">
       <h1><span class="glyphicon glyphicon-question-sign"></span>&nbsp;<b>Q&amp;A</b></h1>
   </div>
   		<hr>
	<div style="width:17%; float:left; border:1px solid #DDDDDD; margin-right:2px;">
		<div style="font-size:20px; background-color:#F5F5F5; padding:5px;"><b>고객센터</b></div>
		<div style="font-size:16px; padding:5px; font-weight:bold; cursor:pointer">
			<p><a href="<%=cp%>/owner/review/list"> - 리뷰</a></p>
			<p><a href="<%=cp%>/owner/hotelqna/list"> - 문의사항</a></p>
		</div>
	</div>
	<div style="width:80%; float:right; border:1px solid #DDDDDD; margin-bottom:10px;">
	<div style="font-size:20px; font-weight:bold; background-color:#F5F5F5; padding:5px;">
			<span class="glyphicon glyphicon-home"></span>&nbsp;
			<span class="glyphicon glyphicon-chevron-right"></span>&nbsp;고객센터&nbsp;
			<span class="glyphicon glyphicon-chevron-right"></span>&nbsp;문의사항
		</div>
   <div style="padding:10px; margin-bottom:10px;">
   ${dataCount }개(${page}/${total_page } 페이지)

   <div style="width:100%; margin:0 auto; padding:10px; margin-top:10px;" >
      <table style="width:100%; margin-left:auto; margin-right:auto;" >
         <tr style="border-bottom: 2px solid gray;">
            <th style="width:10%">번호</th>
            <th style="width:10%">상태</th>
            <th style="width:60%">제목</th>
            <th style="width:10%">작성자</th>
            <th style="width:10%">작성일</th>
         </tr>
         <c:forEach var="dto" items="${list }" >
         <tr style="border-bottom: 1px solid gray;">
            <td style="padding:3px;">${dto.rnum }</td>
            <td style="padding:3px;">
               <c:if test="${dto.count == 0}">
                  <b class="no" style="color:red">답변미완료</b>
               </c:if>
               <c:if test="${dto.count == 1}">
                  <b class="yes" style="color:blue">답변완료</b>
               </c:if>
            </td>
            <td style="padding:3px;">
               <a style="cursor:pointer" class="qnalist">${dto.qnaTitle }</a>
               <input type="hidden" value="${dto.qnaNum }">
               <div class="qna"></div>
               <input type="hidden" value="${dto.qnaContent }">
            </td>
            <td style="padding:3px;">${dto.userId }</td>
            <td style="padding:3px;">${dto.qnaCreated }</td>
         </tr>
         </c:forEach>
      </table>
   </div>
   <table style="width:100%; margin-bottom:15px;">
      <tr>
         <td align="center">
            <c:if test="${dataCount==0 }">
               등록된 호텔 문의사항이 없습니다.
            </c:if>
            <c:if test="${dataCount!=0 }">
               ${paging }
            </c:if>
         </td>
      </tr>
   </table>
    <table style="margin-bottom:10px; width:100%; margin:auto;">
      <tr>
      <td style="width:10%"><button type="button" class="btn" onclick="reLoad()">새로고침</button></td>
         <td align="center">
         <form name="searchForm" action="" method="post">
            <select name="condition" style="height:30px;">
               <option value="all" ${condition=="all"?"selected='selected'":"" }>모두</option>
               <option value="qnaTitle" ${condition=="qnaTitle"?"selected='selected'":"" }>제목</option>
               <option value="qnaCreated" ${condition=="qnaCreated"?"selected='selected'":"" }>작성일</option>
               <option value="userId" ${condition=="userId"?"selected='selected'":"" }>아이디</option>
            </select>
             <input type="text" name="keyword" style="height:30px;" placeholder="문의사항 검색" value="${keyword }">
             <button type="button" class="btn" onclick="hotSearch()">검색</button>
         </form>
         </td>
      </tr>
   </table>
   </div>
     
   </div>
</div>