<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<div class="alert-info">
    <i class="fas fa-info-circle"></i>
    1:1 문의 공간 입니다. 문의 결과를 이메일, 핸드폰등으로 확인 가능합니다.
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
      <th width="80" style="color: #787878;">분류</th>
      <th style="color: #787878;">제목</th>
      <th width="100" style="color: #787878;">작성자</th>
      <th width="80" style="color: #787878;">문의일자</th>
      <th width="80" style="color: #787878;">처리결과</th>
  </tr>
 
 <c:forEach var="dto" items="${list}">
  <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
      <td>${dto.category}</td>
      <td align="left" style="padding-left: 10px;">
           <a href="javascript:articleBoard('${dto.num}', '${pageNo}');">${dto.subject}</a>
      </td>
      <td>${dto.userName}</td>
      <td>${dto.created}</td>
      <td>${dto.state=="0"?"답변대기":"답변완료"}</td>
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
                  <c:if test="${sessionScore.member.userId=='admin'}">
                      <option value="userName" ${condition=="userName"?"selected='selected'":""}>작성자</option>
                  </c:if>
            </select>
            <input type="text" id="keyword" name="keyword" class="boxTF" value="${keyword}">
            <button type="button" class="btn" onclick="searchList();">검색</button>
        </form>
      </td>
      <td align="right" width="100">
          <button type="button" class="btn" onclick="insertForm();">글올리기</button>
      </td>
   </tr>
</table>
