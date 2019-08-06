<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<script type="text/javascript">
function hotAdd(){
	location.href="<%=cp%>/owner/hotplace/created";
}

function hotUpdate(placeNum){
	var query = "?page=${page}&condition=${condition}&keyword=${keyword}";
	query += "&placeNum="+placeNum;
	
	location.href="<%=cp%>/owner/hotplace/update"+query;
}

function hotDelete(placeNum, placePhoto){
	var query = "?page=${page}&condition=${condition}&keyword=${keyword}";
	query += "&placeNum="+placeNum+"&placePhoto="+placePhoto;
	if(confirm("해당 명소를 삭제 하시겠습니까?"))
		location.href = "<%=cp%>/owner/hotplace/delete"+query;
}

function hotSearch(){
	var f = document.searchForm;
	f.submit();
}

function reLoad(){
	location.href = "<%=cp%>/owner/hotplace/list";
}
</script>
	<div class="container">
		<div style="width:100%; margin:0 auto; padding-top:30px;">
			<h1><span class="glyphicon glyphicon-camera"></span>&nbsp;<b>호텔 명소</b></h1>
		</div>
		<hr>
		<div style="width:17%; float:left; border:1px solid #DDDDDD; margin-right:2px;">
			<div style="font-size:20px; background-color:#F5F5F5; padding:5px;"><b>호텔관리</b></div>
			<div style="font-size:16px; padding:5px; font-weight:bold; cursor:pointer">
				<p><a> - 호텔 기본정보</a></p>
				<p><a> - 호텔 편의시설</a></p>
				<p><a> - 호텔 일정</a></p>
				<p><a href="<%=cp%>/owner/hotplace/list"> - 호텔 명소</a></p>
			</div>
		</div>
		<div style="width:80%; float:right; border:1px solid #DDDDDD; margin-bottom:10px;">
		<div style="font-size:20px; font-weight:bold; background-color:#F5F5F5; padding:5px;">
			<span class="glyphicon glyphicon-home"></span>&nbsp;
			<span class="glyphicon glyphicon-chevron-right"></span>&nbsp;호텔 관리&nbsp;
			<span class="glyphicon glyphicon-chevron-right"></span>&nbsp;호텔 명소
		</div>
		<div style="padding:10px;">
		${dataCount }개(${page}/${total_page } 페이지)
		<table style="width:100%; margin:auto;">
		<c:forEach var="dto" items="${list }">
			<tr style="border:1px solid #DDDDDD;">
				<td style="padding:5px;" width="30%" align="center"><img src="<%=cp%>/uploads/hotplace/${dto.placePhoto}" width="200px" height="150px"></td>
				<td style="padding:5px; padding-left:10px; font-size:15px;" width="70%" align="left">
					<strong>장소명 :</strong>${dto.placeName }<br><br>
					<strong>숙소와의 거리 :</strong> ${dto.placeDis }Km<br><br>
					<strong>주소 :</strong>(${dto.placeZip })&nbsp;${dto.placeAddr1 }&nbsp;${dto.placeAddr2 }<br>
					<div style="float:right;">
						<button type="button" class="btn" onclick="hotUpdate('${dto.placeNum}')">수정</button>
						<button type="button" class="btn" onclick="hotDelete('${dto.placeNum}', '${dto.placePhoto }')">삭제</button>
					</div>
				</td>
			</tr>
			<tr><td><br></td></tr>
		</c:forEach>
		</table>
		<table style="width:100%; margin-bottom:15px;">
			<tr>
				<td align="center">
					<c:if test="${dataCount==0 }">
						등록된 호텔 명소가 없습니다.
					</c:if>
					<c:if test="${dataCount!=0 }">
						${paging }
					</c:if>
				</td>
			</tr>
		</table>
		<table style="width:100%">
			<tr>
			<td style="width:40%">
				<button type="button" class="btn" onclick="reLoad()">새로고침</button>
			</td>
			<td style="width:30%" align="center">
				<table style="margin-bottom:10px; width:100%; margin:auto;">
					<tr>
						<td>
						<form name="searchForm" action="<%=cp%>/owner/hotplace/list" method="post">
							<input type="hidden" name="condition" value="placeName">
		  					<input type="text" name="keyword" style="height:30px;" placeholder="명소이름 검색" value="${keyword }">
		  					<button type="button" class="btn" onclick="hotSearch()">검색</button>
						</form>
						</td>
					</tr>
				</table>
			</td>
			<td style="width:30%">
				<button type="button" class="btn" style="float:right;" onclick="hotAdd()">명소추가</button> 
			</td>
			</tr>
		</table>
		</div>
	</div>
</div>