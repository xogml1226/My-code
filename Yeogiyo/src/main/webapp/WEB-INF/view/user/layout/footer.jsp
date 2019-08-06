<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<footer class="container-fluid">
<p>
<a href="">YEOGIYO 정책 및 약관</a>&nbsp;&nbsp;&nbsp;
<a href="">회사소개</a>&nbsp;&nbsp;&nbsp;
<a href="">제휴제안</a>&nbsp;&nbsp;&nbsp;
<a href="">이용약관</a>&nbsp;&nbsp;&nbsp;
<a href="">개인정보취급방침</a>&nbsp;&nbsp;&nbsp;
<c:if test="${sessionScope.member.enabled!=2 && not empty sessionScope.member}">
<a href="<%=cp%>/owner/hotelRegister/register1"><span class="glyphicon glyphicon-home"></span> HotelOwner계정등록</a>&nbsp;&nbsp;&nbsp;
</c:if>
© YEOGIYO Corp.
</p>
</footer>

