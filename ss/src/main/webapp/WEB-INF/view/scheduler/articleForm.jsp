<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<table style="margin: 10px auto 0px; width: 100%; border-spacing: 0px;">
		  <tr height="40"> 
		      <td width="100"style="font-weight:600; padding-right:15px; text-align: right;">구&nbsp;&nbsp;분</td>
		      <td> 
                     <span id="schGroup"></span>
              </td>
		  </tr>

		  <tr height="40"> 
		      <td width="100"style="font-weight:600; padding-right:15px; text-align: right;">항&nbsp;&nbsp;목</td>
		      <td> 
                     <span id="schResource"></span>
              </td>
		  </tr>

		  <tr height="40"> 
		      <td width="100"style="font-weight:600; padding-right:15px; text-align: right;">제&nbsp;&nbsp;목</td>
		      <td> 
                     <span id="schTitle"></span>
              </td>
		  </tr>

		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">작성자</td>
		      <td> 
		             <span id="schUserName"></span>
		      </td>
		  </tr>
		
		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">일정분류</td>
		      <td> 
		        	<span id="schAllDay"></span>
		      </td>
		  </tr>

		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">시작일자</td>
		      <td> 
		        	<span id="schStartDay"></span>
		      </td>
		  </tr>
		  
		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">종료일자</td>
		      <td> 
		        	<span id="schEndDay"></span>
		      </td>
		  </tr>
		
		  <tr height="40"> 
		      <td width="100" style="font-weight:600; padding-right:15px; text-align: right;">사용인원</td>
		      <td> 
		        	<span id="schInwon"></span>
		      </td>
		  </tr>
</table>
