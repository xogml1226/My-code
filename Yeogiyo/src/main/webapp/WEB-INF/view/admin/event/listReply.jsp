<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<table style='width: 100%; margin: 10px auto 30px; border-spacing: 0px;'>
	<thead id='listReplyHeader'>
		<tr height='35'>
		    <td colspan='2'>
		       <div style='clear: both;'>
		           <div style='float: left;'><span style='color: #3EA9CD; font-weight: bold;'>댓글 ${replyCount}개</span> <span>[댓글 목록, ${pageNo}/${total_page} 페이지]</span></div>
		           <div style='float: right; text-align: right;'></div>
		       </div>
		    </td>
		</tr>
	</thead>
	
	<tbody id='listReplyBody'>
	<c:forEach var="vo" items="${listReply}">
	    <tr height='35' style='background: #eeeeee;'>
	       <td width='50%' style='padding:5px 5px; border:1px solid #cccccc; border-right:none;'>
	           <span><b>${vo.userId}</b></span>
	        </td>
	       <td width='50%' style='padding:5px 5px; border:1px solid #cccccc; border-left:none;' align='right'>
	           <span>${vo.eventreplyCreated}</span> |
	           <c:if test="${vo.userId == sessionScope.member.userId ||  sessionScope.member.enabled==3 }">
	                <span class="deleteReply" style="cursor: pointer;" data-eventreplyNum='${vo.eventreplyNum}' data-pageNo='${pageNo}'>삭제</span>
	           	</c:if>
	        </td>
	    </tr>
	    <tr>
	        <td colspan='2' valign='top' style='padding:5px 5px;'>
	              ${vo.eventreplyContent}
	        </td>
	    </tr>
	    
	    <tr>
	        <td style='padding:7px 5px;'>
	            <button type='button' class='btn btn-default btnReplyAnswerLayout' data-eventreplyNum='${vo.eventreplyNum}'>답글 
	            <span id="answerCount${vo.eventreplyNum}">${vo.eventreplyAnswerCount}</span></button>
	        </td>
	        
	    </tr>
	
	    <tr class='replyAnswer' style='display: none;'>
	        <td colspan='2'>
	            <div id='listReplyAnswer${vo.eventreplyNum}' class='answerList' style='border-top: 1px solid #cccccc;'></div>
	            <c:if test="${not empty sessionScope.member}">
		            <div style='clear: both; padding: 10px 10px;'>
		                <div style='float: left; width: 5%;'>└</div>
		                <div style='float: left; width:95%'>
		                    <textarea cols='72' rows='12' class='boxTA' style='width:98%; height: 70px;'></textarea>
		                 </div>
		            </div>
		             <div style='padding: 0px 13px 10px 10px; text-align: right;'>
		                <button type='button' class='btn btn-default btnSendReplyAnswer' data-eventreplyNum='${vo.eventreplyNum}'>답글 등록</button>
		            </div>
	        	</c:if>
	        </td>
	    </tr>
	</c:forEach>
	</tbody>
	
	<tfoot id='listReplyFooter'>
		<tr height='40' align="center">
            <td colspan='2' >
              ${paging}
            </td>
           </tr>
	</tfoot>
</table>
