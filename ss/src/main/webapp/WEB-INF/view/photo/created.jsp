<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
    function sendOk() {
        var f = document.photoForm;

    	var str = f.subject.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.subject.focus();
            return;
        }

    	str = f.content.value;
        if(!str) {
            alert("설명을 입력하세요. ");
            f.content.focus();
            return;
        }

        var mode="${mode}";
        if(mode=="created"||mode=="update" && f.upload.value!="") {
    		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
    			alert('이미지 파일만 가능합니다.(bmp 파일은 불가) !!!');
    			f.upload.focus();
    			return;
    		}
    	}
    	
    	f.action="<%=cp%>/photo/${mode}";

        f.submit();
    }
</script>

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><i class="far fa-image"></i> 포토갤러리 </h3>
    </div>
    
    <div>
			<form name="photoForm" method="post" enctype="multipart/form-data">
			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px;"> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}">
			      </td>
			  </tr>
			
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
			      <td style="padding-left:10px;"> 
			          ${sessionScope.member.userName}
			      </td>
			  </tr>
			
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">설&nbsp;&nbsp;&nbsp;&nbsp;명</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
			      </td>
			  </tr>
			  
			  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">이미지</td>
			      <td style="padding-left:10px;"> 
			          <input type="file" name="upload" class="boxTF" size="53"
			                     accept="image/*" 
			                     style="height: 25px;">
			       </td>
			  </tr>
			  

			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/photo/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			         <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="num" value="${dto.num}">
			         	 <input type="hidden" name="imageFilename" value="${dto.imageFilename}">
			        	 <input type="hidden" name="page" value="${page}">
			        </c:if>
			      </td>
			    </tr>
			  </table>
			</form>
    </div>
    
</div>