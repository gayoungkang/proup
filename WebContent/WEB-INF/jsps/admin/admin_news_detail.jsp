<%@page import="util.CategorySearch"%>
<%@page import="model.NewsInfoModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	NewsInfoModel ni = (NewsInfoModel) request.getAttribute("ni");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자</title>
<!-- jQuery -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/admin.js"></script>
<link rel="stylesheet" href="css/admin.css">
<style type="text/css">
* {max-width: 100%;}

</style>
</head>
<body>

<jsp:include page="./admin_menu.jsp"></jsp:include>

<div class="content-wrap">
	<span class="content-title" style="margin-top: 20px;">뉴스 상세페이지</span>
	
	<div class="content-div">
		<div class="btn-wrap" style="width: 1000px;">
			<button type="button" class="btn-green" onclick="javascript: goNewsModify(<%=ni.getIdx()%>)">수정</button>
			<button type="button" class="btn-red" onclick="javascript: deleteNews(<%=ni.getIdx()%>)">삭제</button>
		</div>
		<table class="content-table" style="width: 1000px;">
			<tr>
				<td style="width: 200px; text-align: center;">카테고리</td>
				<td style="width: 800px; text-align: center;">
					<%=CategorySearch.getNewsCategory(ni.getType()) %>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">썸네일</td>
				<td>
					<img src="upload/news/<%=ni.getIdx() %>/<%=ni.getThumbnail() %>" style="height: 200px;" />
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">리스팅 일자</td>
				<td style="text-align: center;">
					<%=ni.getViewDate().substring(0, 19) %> 
						
				</td>
			</tr>
			
			<tr>
				<td style="text-align: center;">제목</td>
				<td>
					<%=ni.getTitle() %>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">내용</td>
				<td>
					<%=ni.getContent() %>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">검색 키워드</td>
				<td>
					<%=ni.getKeywords() %>
				</td>
			</tr>
			<tr style="border: none; height: 80px;">
				<td style="text-align: center;" colspan="2">
					<button type="button" class="btn-default" onclick="javascript: location.href='admin?type=news&menu=admin_news_list';">목록으로</button>
				</td>
			</tr>
		</table>
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>


</body>
</html>