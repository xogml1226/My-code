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
					class="glyphicon glyphicon-map-marker"></span> YEOGIYO</a>
		</div>
		<ul class="nav navbar-nav">
			<li><a href="<%=cp%>/admin/main"><span
					class="glyphicon glyphicon-home"></span> 호텔승인</a></li>
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#">커뮤니티 관리 <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="<%=cp%>/admin/bbs/list">자유게시판</a></li>
					<li><a href="<%=cp%>/admin/report/list">신고 리뷰</a></li>
				</ul></li>	
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#">소식 관리<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="<%=cp%>/admin/notice/list">공지사항</a></li>
					<li><a href="<%=cp%>/admin/event/list">Event</a></li>
				</ul></li>	
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#">고객센터 관리<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="<%=cp%>/admin/faq/list">FAQ</a></li>
					<li><a href="<%=cp%>/admin/qna/list">Q&amp;A</a></li>
				</ul></li>
		</ul>
		
		<c:if test="${not empty sessionScope.member }">
		<ul class="nav navbar-nav navbar-right">
			<li><a href="<%=cp%>/user/member/memberInfo"><span
					class="	glyphicon glyphicon-heart"></span> ${sessionScope.member.userId }</a></li>
			<li><a href="<%=cp%>/user/member/logout"><span
					class="glyphicon glyphicon-log-out"></span> Logout</a></li>
			<c:if test="${sessionScope.member.enabled==3 }">
			<li><a href="<%=cp%>/user/main"><span
					class="	glyphicon glyphicon-user"></span> UserPage</a></li>
			</c:if>		
		</ul>
		</c:if>
	</div>
</nav>

