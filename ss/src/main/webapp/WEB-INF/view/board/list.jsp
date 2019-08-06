<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
	function searchList() {
		var f=document.searchForm;
		f.submit();
	}
	
	function boardList() {
		var f=document.boardListForm;
		f.submit();
	}
</script>

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><i class="fas fa-chalkboard-teacher"></i> 답변형 게시판 </h3>
    </div>
    
    <div>
		<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
		   <tr height="35">
		      <td align="left" width="50%">
		          ${dataCount}개(${page}/${total_page} 페이지)
		      </td>
		      <td align="right">
		          <form action="<%=cp%>/board/list" name="boardListForm" method="post">
		          		<select name="rows" class="selectField" onchange="boardList();">
		          			<option value="10" ${rows==10?"selected='selected' ":"" }>10개씩 출력</option>
		          			<option value="20" ${rows==20?"selected='selected' ":"" }>20개씩 출력</option>
		          			<option value="30" ${rows==30?"selected='selected' ":"" }>30개씩 출력</option>
		          			<option value="40" ${rows==40?"selected='selected' ":"" }>40개씩 출력</option>
		          			<option value="50" ${rows==50?"selected='selected' ":"" }>50개씩 출력</option>
		          		</select>
		          		<input type="hidden" name="condition" value="${condition}">
		          		<input type="hidden" name="keyword" value="${keyword}">
		          </form>
		      </td>
		   </tr>
		</table>
		
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
		  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
		      <th width="60" style="color: #787878;">번호</th>
		      <th style="color: #787878;">제목</th>
		      <th width="100" style="color: #787878;">작성자</th>
		      <th width="80" style="color: #787878;">작성일</th>
		      <th width="60" style="color: #787878;">조회수</th>
		  </tr>
		 
		 <c:forEach var="dto" items="${list}">
		  <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
		      <td>${dto.listNum}</td>
		      <td align="left" style="padding-left: 10px;">
			           <c:forEach var="n" begin="1" end="${dto.depth}">
			               &nbsp;
			           </c:forEach>
			           <c:if test="${dto.depth!=0}">└&nbsp;</c:if>
			           <a href="${articleUrl}&boardNum=${dto.boardNum}">${dto.subject}</a>
                       <c:if test="${dto.gap < 1}">
                             <img src='<%=cp%>/resource/images/new.gif'>
                       </c:if>
		      </td>
		      <td>${dto.userName}</td>
		      <td>${dto.created}</td>
		      <td>${dto.hitCount}</td>
		  </tr>
		  </c:forEach>
		  
		</table>
		 
		<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		   <tr height="35">
			<td align="center">
			        ${dataCount==0?"등록된 게시물이 없습니다.":paging}
			</td>
		   </tr>
		</table>
		
		<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
		   <tr height="40">
		      <td align="left" width="100">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/board/list';">새로고침</button>
		      </td>
		      <td align="center">
		          <form name="searchForm" action="<%=cp%>/board/list" method="post">
		              <select name="condition" class="selectField">
		                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
		                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
		                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
		                  <option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
		                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
		            </select>
		            <input type="text" name="keyword" value="${keyword}" class="boxTF">
		            <input type="hidden" name="rows" value="${rows}">
		            <button type="button" class="btn" onclick="searchList()">검색</button>
		        </form>
		      </td>
		      <td align="right" width="100">
		          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/board/created';">글올리기</button>
		      </td>
		   </tr>
		</table>
    </div>

</div>