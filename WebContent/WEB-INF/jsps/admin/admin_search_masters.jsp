<%@page import="model.SearchModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	String menu = request.getParameter("menu");
	SearchModel search = (SearchModel) request.getAttribute("search");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자</title>
<!-- jQuery -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/admin.js"></script>

<link rel="stylesheet" href="css/jquery-ui.css">
<link rel="stylesheet" href="css/admin.css">

</head>
<body>

<jsp:include page="./admin_menu.jsp"></jsp:include>

<div class="content-wrap">
	<span class="content-title">마스터 목록 검색 키워드 관리 (* 자주 바꾸시면 검색 적용이 잘 안됩니다.)</span>
	<div class="content-div">
		<table style="width: 100%;">
			<tr height="30px">
				<td 
					<%if("admin_search_main".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: searchSubMenuTab('main');"
					<%} %>>
					메인
				</td>
				<td 
					<%if("admin_search_references".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: searchSubMenuTab('references');"
					<%} %>>
					레퍼런스
				</td>
				<td 
					<%if("admin_search_masters".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: searchSubMenuTab('masters');"
					<%} %>>
					강사 리스트
				</td>
				<td 
					<%if("admin_search_news".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: searchSubMenuTab('news');"
					<%} %>>
					뉴스
				</td>
			</tr>
		</table>
		
		<form action="admin" method="post" onsubmit="javascript:return searchSubmit();" > 
			<input type="hidden" name="mode" value="update_search" />
			<input type="hidden" name="idx" value="3" />
			<input type="hidden" name="location" value="admin_search_masters" />
			<table class="content-table" >
				<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
					<td style="width: 150px; text-align: center;">구분</td>
					<td style="width: 500px; text-align: center;">입력</td>
					<td style="text-align: center;">비고</td>
					
				</tr>
				<tr>
					<td style="text-align: center;">타이틀</td>
					<td><input type="text" class="input-default" id="title" name="title" value="<%=search.getTitle() %>" /></td>
					<td style="text-align: left;">검색 순위 : 1순위</td>
				</tr>
				<tr>
					<td style="text-align: center;">설명</td>
					<td><textarea class="input-default" style="height: 80px;" id="description" name="description"><%=search.getDescription() %></textarea></td>
					<td style="text-align: left;">검색 순위 : 2순위<br/>* 100자 이내로 해야 검색 로봇이 잘 캐치합니다.</td>
				</tr>
				<tr>
					<td style="text-align: center;">키워드</td>
					<td><textarea class="input-default" style="height: 80px;" id="keywords" name="keywords"><%=search.getKeywords() %></textarea></td>
					<td style="text-align: left;">검색 순위 : 3순위<br/>* 10개 이하를 추천합니다.</td>
				</tr>
			</table>
			<div class="btn-center-wrap">
				<button type="submit" class="btn-default">적용</button>
			</div>
		</form>
		
	</div>
</div>


</body>
</html>