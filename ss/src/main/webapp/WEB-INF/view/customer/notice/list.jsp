<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<div class="alert-info">
  <i class="fas fa-info-circle"></i>
    중요한 일정 및 알림, 이벤트 등은 공지사항 통해 고객님께 알려 드립니다.
</div>

<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
   <tr height="35">
      <td align="left" width="50%">
          ${dataCount}개(${pageNo}/${total_page} 페이지)
      </td>
      <td align="right">
          &nbsp;
      </td>
   </tr>
</table>

<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <th width="60" style="color: #787878;">번호</th>
      <th style="color: #787878;">제목</th>
      <th width="100" style="color: #787878;">작성자</th>
      <th width="80" style="color: #787878;">작성일</th>
      <th width="60" style="color: #787878;">첨부</th>
      <th width="60" style="color: #787878;">조회수</th>
  </tr>
 
 <c:forEach var="dto" items="${noticeList}">
  <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
      <td><span style="display: inline-block; padding:1px 3px; background: #ED4C00;color: #FFFFFF">공지</span></td>
      <td align="left" style="padding-left: 10px;">
           <a href="javascript:articleBoard('${dto.num}', '${pageNo}');">${dto.subject}</a>
      </td>
      <td>${dto.userName}</td>
      <td>${dto.created}</td>
      <td>
	      <c:if test="${dto.fileCount > 0}">
	      	<a href="<%=cp%>/customer/notice/zipdownload?num=${dto.num}"><i class="fas fa-file-archive"></i></a>
	      </c:if>
      </td>
      <td>${dto.hitCount}</td>
  </tr>
</c:forEach>

<c:forEach var="dto" items="${list}">
  <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
      <td>${dto.listNum}</td>
      <td align="left" style="padding-left: 10px;">
           <a href="javascript:articleBoard('${dto.num}', '${pageNo}');">${dto.subject}</a>
           <c:if test="${dto.gap < 1}">
               <img src='<%=cp%>/resource/images/new.gif'>
           </c:if>
      </td>
      <td>${dto.userName}</td>
      <td>${dto.created}</td>
      <td>
	      <c:if test="${dto.fileCount > 0}">
	      	<a href="<%=cp%>/customer/notice/zipdownload?num=${dto.num}"><i class="fas fa-file-archive"></i></a>
	      </c:if>
      </td>
      
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
          <button type="button" class="btn" onclick="reloadBoard();">새로고침</button>
      </td>
      <td align="center">
          <form name="searchForm" action="" method="post">
              <select id="condition" name="condition" class="selectField">
                  <option value="all" ${condition=="all"?"selected='selected'":""}>모두</option>
                  <option value="subject" ${condition=="subject"?"selected='selected'":""}>제목</option>
                  <option value="content" ${condition=="content"?"selected='selected'":""}>내용</option>
                  <option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
                  <option value="created" ${condition=="created"?"selected='selected'":""}>등록일</option>
            </select>
            <input type="text" id="keyword" name="keyword" class="boxTF" value="${keyword}">
            <button type="button" class="btn" onclick="searchList();">검색</button>
        </form>
      </td>
      <td align="right" width="100">
      	<c:if test="${sessionScope.member.userId=='admin'}">
          <button type="button" class="btn" onclick="insertForm();">글올리기</button>
        </c:if>
      </td>
   </tr>
</table>
