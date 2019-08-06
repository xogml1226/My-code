<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<c:forEach var="vo" items="${listReplyAnswer}">
    <div class='answer' style='padding: 0px 10px;'>
        <div style='clear:both; padding: 10px 0px;'>
            <div style='float: left; width: 5%;'>└</div>
            <div style='float: left; width:95%;'>
                <div style='float: left;'><b>${vo.userId}</b></div>
                <div style='float: right;'>
                    <span>${vo.eventreplyCreated}</span> |
                    <c:if test="${sessionScope.member.userId==vo.userId || sessionScope.member.enabled==3}">
                    	<span class='deleteReplyAnswer' style='cursor: pointer;' data-eventreplyNum='${vo.eventreplyNum}' data-eventreplyAnswer='${vo.eventreplyAnswer}'>삭제</span>
                    </c:if>
                </div>
            </div>
        </div>
        <div style='clear:both; padding: 5px 5px 5px 5%; border-bottom: 1px solid #ccc;'>
            ${vo.eventreplyContent}
        </div>
    </div>			            
</c:forEach>
<div style="margin:5px;">
${answerCount==0 ? "등록된 답글이 없습니다" :""}
</div>