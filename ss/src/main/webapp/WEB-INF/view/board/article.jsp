<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
<c:if test="${dto.userId == sessionScope.member.userId || sessionScope.member.userId == 'admin' }">
function deleteBoard(num) {
	if(confirm("게시물을 삭제 하시겠습니까 ?")) {
		var url="<%=cp%>/board/delete?boardNum="+num+"&${query}";
		location.href=url;
	}
}
</c:if>
</script>
</head>

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><i class="fas fa-chalkboard-teacher"></i> 답변형 게시판 </h3>
    </div>
    
    <div>
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="center">
				   <c:if test="${dto.depth!=0}">[Re]</c:if>
				   ${dto.subject}
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td width="50%" align="left" style="padding-left: 5px;">
			       이름 : ${dto.userName}
			    </td>
			    <td width="50%" align="right" style="padding-right: 5px;">
			        ${dto.created} | 조회 ${dto.hitCount}
			    </td>
			</tr>
			
			<tr style="border-bottom: 1px solid #cccccc;">
			  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
			      ${dto.content}
			   </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       이전글 :
					<c:if test="${not empty preReadDto}">
						<a href="<%=cp%>/board/article?boardNum=${preReadDto.boardNum}&${query}">${preReadDto.subject}</a>
					</c:if>
			    </td>
			</tr>
			
			<tr height="35" style="border-bottom: 1px solid #cccccc;">
			    <td colspan="2" align="left" style="padding-left: 5px;">
			       다음글 :
					<c:if test="${not empty nextReadDto}">
						<a href="<%=cp%>/board/article?boardNum=${nextReadDto.boardNum}&${query}">${nextReadDto.subject}</a>
					</c:if>
			    </td>
			</tr>
			</table>
			
			<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
			    <td width="300" align="left">
			          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/board/reply?boardNum=${dto.boardNum}&page=${page}&rows=${rows}';">답변</button>
			          <c:if test="${dto.userId == sessionScope.member.userId}">
			          		<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/board/update?boardNum=${dto.boardNum}&page=${page}&rows=${rows}';">수정</button>
			          </c:if>
			          <c:if test="${dto.userId == sessionScope.member.userId || sessionScope.member.userId == 'admin' }">
			          		<button type="button" class="btn" onclick="deleteBoard('${dto.boardNum}');">삭제</button>
			          </c:if>
			    </td>
			
			    <td align="right">
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/board/list?${query}';">리스트</button>
			    </td>
			</tr>
			</table>
			
			<table style="width: 100%; margin: 25px auto; border-spacing: 0px; border-collapse: collapse;">
			  <tr><td height="1" colspan="5" bgcolor="#cccccc"></td></tr>
			  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <th width="60" style="color: #787878;">번호</th>
			      <th style="color: #787878;">제목</th>
			      <th width="100" style="color: #787878;">작성자</th>
			      <th width="80" style="color: #787878;">작성일</th>
			      <th width="60" style="color: #787878;">조회수</th>
			  </tr>
			 
			 <c:forEach var="vo" items="${listArticle}">
			  <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;"> 
			      <td>${vo.listNum}</td>
			      <td align="left" style="padding-left: 10px;">
				           <c:forEach var="n" begin="1" end="${vo.depth}">
				               &nbsp;
				           </c:forEach>
				           <c:if test="${vo.depth!=0}">└&nbsp;</c:if>
				           <c:if test="${dto.boardNum == vo.boardNum}">
				                ${vo.subject}
				           </c:if>
				           <c:if test="${dto.boardNum != vo.boardNum}">
				                <a href="<%=cp%>/board/article?${query}&boardNum=${vo.boardNum}">${vo.subject}</a>
				           </c:if>
			      </td>
			      <td>${vo.userName}</td>
			      <td>${vo.created}</td>
			      <td>${vo.hitCount}</td>
			  </tr>
			  </c:forEach>
			  
			</table>
			
    </div>
    
</div>