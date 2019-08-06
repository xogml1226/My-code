<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<div class="container">
	<div style="margin: 0px auto; padding-top: 120px; width: 400px; margin-bottom:100px;">
		<div class="mainform">
			<span style="font-weight: bold; font-size: 30px;">${title }</span>
		</div>
		<div style="margin-top: 15px;">
			<button type="button" onclick="javascript:location.href='<%=cp%>/user/main';" class="btnconfirm">
				<span style="font-weight: bold; font-size: 25px;"> 
				메인 페이지로 가기 </span>
			</button>
		</div>
		<div align=center style="line-height: 150%; padding-top: 35px; color:blue;">
                       ${message}            
        </div>
	</div>
</div>