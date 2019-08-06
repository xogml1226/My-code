<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<style type="text/css">

.payment{
	width: 500px;
	text-align:center;
	margin:0 auto;
	padding: 0px 10px auto;
	padding-bottom: 30px;
}
.bills{
	padding-top: 30px;
	padding-bottom: 30px;
}
.panel panel-warning class{
	width: 300px;
	text-align:center;
	margin:0 auto;
	padding:10px auto;
}
 
</style>
<div class="container">
	<div class= "payment">
		<div class="bills">
			<h1>결제 내역</h1>
			<div class="panel panel-warning class">
			    <div class="panel-heading">${hotelName}</div>
			    <div class="panel-body">
				    <p>${map.roomtype}</p>
				</div>
			</div>
			<div class="panel panel-warning class">
			    <div class="panel-heading">체크인</div>
			    <div class="panel-body">
				    <p>${map.checkinday}</p>
				</div>
			</div>
			
			<div class="panel panel-warning class">
			    <div class="panel-heading">체크아웃</div>
			    <div class="panel-body">
				    <p>${map.checkoutday}</p>
				</div>
			</div>	
			<div class="panel panel-warning class">
			    <div class="panel-heading">방 가격</div>
			    <div class="panel-body">${map.roomprice}</div>
			</div>
			
		
				<c:forEach var ="opt" items="${plist}" varStatus="s">	
					<div class="panel panel-warning class">
					   	<div class="panel-heading">
					    	옵션 ${s.count}
					    </div>
					    
					   	<div class="panel-body">
					    	${opt.optName} / ${opt.optPrice}원 / ${opt.optCount}명 / 합계 : ${opt.total} 원
						</div>						    
					 </div>
				</c:forEach>	
			<div class="panel panel-warning class">
			    <div class="panel-heading">총 결제 금액</div>
			    <div class="panel-body">${map.tot}</div>
			</div>
			
			<p>이용해 주셔서 감사합니다.</p>
			<p>최선을 다해서 고객님을 모시겠습니다.</p>
		</div>
		<a href="<%=cp%>/user/main">메인페이지로 돌아가기</a>
	</div>
	
	
</div>