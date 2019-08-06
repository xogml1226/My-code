<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<div class="header-top">
    <div class="header-left">
        <p style="margin: 2px;">
            <a href="<%=cp%>/" style="text-decoration: none;">
                <span style="width: 200px; height: 70; position: relative; left: 0; top:20px; color: #2984ff; filter: mask(color=red) shadow(direction=135) chroma(color=red);font-style: italic; font-family: arial black; font-size: 30px; font-weight: bold;">SPRING</span>
            </a>
        </p>
    </div>
    <div class="header-right">
        <div style="padding-top: 20px;  float: right;">
            <c:if test="${empty sessionScope.member}">
                <a href="<%=cp%>/member/login">로그인</a>
                    &nbsp;|&nbsp;
                <a href="<%=cp%>/member/member">회원가입</a>
            </c:if>
            <c:if test="${not empty sessionScope.member}">
                <span style="color:blue;">${sessionScope.member.userName}</span>님
                &nbsp;|&nbsp;
                <a href="<%=cp%>/member/logout">로그아웃</a>
                &nbsp;|&nbsp;
                <a href="<%=cp%>/member/pwd">정보수정</a>
                <c:if test="${sessionScope.member.userId=='admin'}">
                    &nbsp;|&nbsp;
                    <a href="<%=cp%>/admin">관리자</a>
                </c:if>
            </c:if>
        </div>
    </div>
</div>

<div class="menu">
    <ul class="nav">
        <li>
            <a href="#">회사소개</a>
            <ul>
                <li><a href="#">회사개요</a></li>
                <li><a href="#">회사연혁</a></li>
                <li><a href="#">사업분야</a></li>
                <li><a href="#">조직도</a></li>
                <li><a href="#">찾아오시는길</a></li>
            </ul>
        </li>
			
        <li>
            <a href="#">커뮤니티</a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/guest/guest">방명록</a></li>
                <li><a href="${pageContext.request.contextPath}/bbs/list">게시판</a></li>
                <li><a href="${pageContext.request.contextPath}/board/list">답변형 게시판</a></li>
                <li><a href="#">자료실</a></li>
                <li><a href="<%=cp%>/photo/list">포토갤러리</a></li>
                <li><a href="${pageContext.request.contextPath}/chat/main">채팅</a></li>
            </ul>
        </li>

        <li>
            <a href="#">스터디룸</a>
            <ul>
                <li><a href="#">프로그래밍</a></li>
                <li><a href="#">데이터베이스</a></li>
                <li><a href="#">웹</a></li>
                <li><a href="${pageContext.request.contextPath}/scheduler/main">스케쥴러</a></li>
            </ul>
        </li>

        <li>
            <a href="<%=cp%>/customer/main">고객센터</a>
        </li>

        <c:if test="${not empty sessionScope.member}">
        <li>
            <a href="#">마이페이지</a>
            <ul>
                <li><a href="#" style="margin-left:230px; " onmouseover="this.style.marginLeft='230px';">정보확인</a></li>
                <li><a href="#">쪽지</a></li>
                <li><a href="${pageContext.request.contextPath}/schedule/month">일정관리</a></li>
                <li><a href="#">친구관리</a></li>
                <li><a href="#">사진첩</a></li>
            </ul>
        </li>
        </c:if>
			
        <li style="float: right;"><a href="#"><span style="font-size: 17px; font-weight: 700;">▦</span></a></li>

    </ul>      
</div>
