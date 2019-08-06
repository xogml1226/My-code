<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<nav class="navbar">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="<%=cp%>/user/main"><span
					class="glyphicon glyphicon-map-marker"></span>YEOGIYO</a>
		</div>
		<ul class="nav navbar-nav">
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#">호텔관리 <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="#">호텔 기본정보</a></li>
					<li><a href="#">호텔 편의시설</a></li>
					<li><a href="#">호텔 일정</a></li>
					<li><a href="<%=cp%>/owner/hotplace/list">호텔 명소</a></li>
				</ul></li>	
		<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#">방관리 <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="<%=cp%>/owner/hotelDetail/roomDetail">방추가</a></li>
				</ul>
		</li>
		<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#">예약관리 <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="<%=cp%>/owner/reservation/list">전체예약확인</a></li>
				</ul></li>
		<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#">정산 <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="<%=cp%>/owner/jungsanD/list">일일정산</a></li>
					<li><a href="<%=cp%>/owner/jungsanM/list">월말정산</a></li>
				</ul></li>
		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#">고객센터 <span class="caret"></span></a>
			<ul class="dropdown-menu">
				<li><a href="<%=cp%>/owner/review/list">리뷰</a></li>
				<li><a href="<%=cp%>/owner/hotelqna/list">문의사항</a></li>
			</ul></li>
		</ul>
		
		<c:if test="${empty sessionScope.member }">
		<ul class="nav navbar-nav navbar-right">
			<li><a href="<%=cp%>/user/member/join"><span
					class="glyphicon glyphicon-user"></span> Sign Up</a></li>
			<li><a href="<%=cp%>/user/member/login"><span
					class="glyphicon glyphicon-log-in"></span> Login</a></li>
		</ul>
		</c:if>
		<c:if test="${not empty sessionScope.member }">
		<ul class="nav navbar-nav navbar-right">
			<li><a href="<%=cp%>/user/member/memberInfo"><span
					class="	glyphicon glyphicon-heart"></span> ${sessionScope.member.userId }</a></li>
			<li><a href="<%=cp%>/user/member/logout"><span
					class="glyphicon glyphicon-log-out"></span> Logout</a></li>
			<c:if test="${sessionScope.member.enabled==2 }">
			<li><a href="<%=cp%>/user/main"><span
					class="	glyphicon glyphicon-user"></span> UserPage</a></li>
			</c:if>		
		</ul>
		</c:if>
	</div>
</nav>

