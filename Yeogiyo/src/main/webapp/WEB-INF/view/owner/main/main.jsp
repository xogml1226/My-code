<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>
<style type="text/css">
 .main {
	 background-image: url('<%=cp%>/resource/images/owner4.jpg');
	 background-repeat: no-repeat;
	 opacity: 0.9!important; filter:alpha(opacity=90);
	 background-size: 100%;
	 background-position: center;
	 height: 550px;
 }
  .ownermain{
 	width: 500px; 
 	margin: 150px; 
 	margin-left: 100px; 
 	min-height: 330px; 
 	border-radius: 1em;
 }
</style>
<div class="main">
	<div class="container">
	    <div style="margin-top: 50px;">
	    	<div class="ownermain">
	        <h1 style="color:white;"><b>어떠한 비용도 필요 없습니다.</b></h1>
	        <h1><span style="color:red;"><b>여기요</b></span>&nbsp;<span style="color:white;"><b>에서</b></span></h1>
	        <h1 style="color:white;"><b>수익을 올려보세요!!</b></h1>
	        </div>
	    </div>
	</div>
</div>