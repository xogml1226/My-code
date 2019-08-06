<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<div class="alert-info">
    <i class="fas fa-info-circle"></i>
         질문과 답변을 할 수 있는 공간입니다.
</div>

<form name="boardForm" method="post" enctype="multipart/form-data">
  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
  <tbody id="tb">
  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">유&nbsp;&nbsp;&nbsp;&nbsp;형</td>
      <td style="padding-left:10px;"> 
        <select name="categoryNum" class="selectField" ${(mode=="update" && not empty dto.parent) || mode=="answer" ? "disabled='disabled'":"" }>
        	<c:forEach var="vo" items="${listCategory}">
        		<option value="${vo.categoryNum}" ${vo.categoryNum==dto.categoryNum?"selected='selected'":""}>${vo.category}</option>
        	</c:forEach>
        </select>
        
        <c:if test="${(mode=='update' && not empty dto.parent) || mode=='answer'}">
        	<input type="hidden" name="categoryNum" value="${dto.categoryNum}">
        </c:if>
      </td>
  </tr>

  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
      <td style="padding-left:10px;"> 
        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}"
               ${(mode=="update" && not empty dto.parent) || mode=="answer" ? "readonly='readonly'":"" }>
      </td>
  </tr>

  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
      <td style="padding-left:10px;"> 
          ${sessionScope.member.userName}
      </td>
  </tr>

  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">공개여부</td>
      <td style="padding-left:10px;">
        <input type="radio" name="questionPrivate" value="0" ${empty dto || dto.questionPrivate==0?"checked='checked'":"" }> 공개
        <input type="radio" name="questionPrivate" value="1" ${dto.questionPrivate==1?"checked='checked'":"" }> 비공개
      </td>
  </tr>

  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
      <td valign="top" style="padding:5px 0px 5px 10px;"> 
        <textarea name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
      </td>
  </tr>
  
  </table>

  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
     <tr height="45"> 
      <td align="center" >
	        <button type="button" class="btn" onclick="sendOk('${mode}', '${pageNo}');">${mode=='update'?'수정완료':'등록하기'}</button>
	        <button type="reset" class="btn">다시입력</button>
	        <button type="button" class="btn" onclick="sendCancel('${pageNo}');">${mode=='update'?'수정취소':'등록취소'}</button>
	         <c:if test="${mode=='update'}">
	         	 <input type="hidden" name="num" value="${dto.num}">
	        	 <input type="hidden" name="pageNo" value="${pageNo}">
	        </c:if>
	        <c:if test="${mode=='answer'}">
	        	<input type="hidden" name="parent" value="${dto.num}">
	        	<input type="hidden" name="pageNo" value="${pageNo}">
	        </c:if>
      </td>
    </tr>
  </table>
</form>
