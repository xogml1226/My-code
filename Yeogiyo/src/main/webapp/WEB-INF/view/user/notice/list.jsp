<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<div class="container">
	<div style="margin: 0px auto; padding-top: 40px; margin-bottom:100px;">
		<div class="page-header">
		    <h1><span class="glyphicon glyphicon-bullhorn"></span>&nbsp;<b>공지사항</b></h1>      
		</div>
		<div class="row">
		    <div class="col-sm-2">
		      <div class="panel panel-default">
			  <div class="panel-heading" style="height: 50px; font-size: 25px;"><b>소식</b></div>
			  
			  <div class="list-group">
				  <a href="<%=cp%>/user/notice/list" class="list-group-item active">공지사항</a>
				  <a href="<%=cp%>/user/event/list" class="list-group-item">이벤트</a>
			  </div>
			  
			</div>
		    </div>
		    <div class="col-sm-10">
			<div>
			<div class="panel panel-default">
			<div class="panel-heading">
      			<a href="<%=cp%>/user/main" style="color:black;"><span class="glyphicon glyphicon-home"></span></a>&nbsp;
		        <span class="glyphicon glyphicon-chevron-right"></span>&nbsp;
		        <a href="<%=cp%>/user/notice/list" style="color:black;">소식</a>&nbsp;
		        <span class="glyphicon glyphicon-chevron-right"></span>&nbsp;
		        <a href="<%=cp%>/user/notice/list" style="color:black;">공지사항</a>&nbsp;
        		</div>
				<div class="panel-body">
				
					<table
							style="width: 100%; margin: 5px auto 0px; border-spacing: 0px;">
							<tr height="10">
								<td align="left" width="50%">
									${dataCount}개 (${page} / ${total_page}페이지)</td>
								<td align="right">&nbsp;</td>
							</tr>
						</table>
						<table class="table">
							<thead>
								<tr>
									<th width="100">번호</th>
									<th>제목</th>
									<th width="150">작성일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dto" items="${toplist }">
									<tr>
										<td><span style="display: inline-block;padding:1px 3px; background: #ED4C00;color: #FFFFFF">공지</span></td>
										<td>
										<a href="${articleUrl }&noticeNum=${dto.noticeNum}">${dto.noticeTitle }</a>
										</td>
										<td>${dto.noticeCreated }</td>
									</tr>
								</c:forEach>
								<c:forEach var="dto" items="${list }">
									<tr>
										<td>${dto.listNum }</td>
										<td>
										<a href="${articleUrl }&noticeNum=${dto.noticeNum}">${dto.noticeTitle }</a>
										<c:if test="${dto.gap < 1 }"><img src='<%=cp%>/resource/images/new.gif'></c:if>
										</td>
										<td>${dto.noticeCreated }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
							<tr height="35">
								<td align="center">${dataCount!=0 ? paging : "등록된 게시물이 없습니다." }
								</td>
							</tr>
						</table>
					</div>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>


