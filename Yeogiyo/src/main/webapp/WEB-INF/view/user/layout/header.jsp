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
				data-toggle="dropdown" href="#">커뮤니티 <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="<%=cp%>/user/bbs/list">자유게시판</a></li>
				</ul></li>	
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#">소식 <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="<%=cp%>/user/notice/list">공지사항</a></li>
					<li><a href="<%=cp%>/user/event/list">이벤트</a></li>
				</ul></li>	
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#">고객센터 <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="<%=cp%>/user/faq/list">FAQ</a></li>
					<li><a href="<%=cp%>/user/qna/list">Q&amp;A</a></li>
					
				</ul></li>
			<c:if test="${not empty sessionScope.member }">	
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#">마이페이지 <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="<%=cp%>/user/member/memberInfo">회원정보확인</a></li>
					<li><a href="<%=cp%>/user/confirm/list">예약확인</a></li>
					<li><a href="<%=cp%>/user/review/list">내가 쓴 리뷰 확인</a></li>
				</ul></li>
			<li><a href="<%=cp%>/user/wishlist/list"><span
					class="glyphicon glyphicon-star"></span> 위시리스트</a></li>
			</c:if>
			<c:if test="${empty sessionScope.member }">
			<li><a href="<%=cp%>/user/confirm/nomember"><span
					class="glyphicon glyphicon-calendar"></span> 예매확인</a></li>
			</c:if>		
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
			<c:if test="${sessionScope.member.enabled==3 }">
			<li><a href="<%=cp%>/admin/main"><span
					class="	glyphicon glyphicon-user"></span> AdminPage</a></li>
			</c:if>
			<c:if test="${sessionScope.member.enabled==2 }">
			<li><a href="<%=cp%>/owner/main"><span
					class="	glyphicon glyphicon-user"></span> OwnerPage</a></li>
			</c:if>		
		</ul>
		</c:if>
	</div>
</nav>

