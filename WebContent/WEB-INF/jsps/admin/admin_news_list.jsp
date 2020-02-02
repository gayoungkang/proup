<%@page import="util.CategorySearch"%>
<%@page import="model.NewsInfoModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	String menu = request.getParameter("menu");
	List<NewsInfoModel> listNI = (List<NewsInfoModel>) request.getAttribute("listNI");
	List<NewsInfoModel> topListNI = (List<NewsInfoModel>) request.getAttribute("topListNI");
	int totalCount = (Integer) request.getAttribute("totalCount");
	NewsInfoModel ni = (NewsInfoModel) request.getAttribute("ni");
	String pageNavigator = (String) request.getAttribute("pageNavigator");
	String searchType = (String) request.getAttribute("searchType");
	String searchText = (String) request.getAttribute("searchText");
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
	<div class="content-div">
		<div class="search-wrap">
			<select class="input-default" id="searchType" style="height: 30px; width: 100px; float: left;">
				<option value="all" <%if("all".equals(searchType)){ %>selected="selected"<%} %>>전체검색</option>
				<option value="title" <%if("title".equals(searchType)){ %>selected="selected"<%} %>>제목</option>
				<option value="content" <%if("content".equals(searchType)){ %>selected="selected"<%} %>>내용</option>
			</select>
			<input class="input-default" id="searchText" style="height: 30px; width: 200px; float: left; margin-left: 5px;" value="<%=searchText %>" onkeyup="javascript: onNewsSearch()" />
			<button class="btn-default" style="float: left; margin-left: 5px;" onclick="javascript: newsSearch();">검색</button>
		</div>
		<div class="btn-wrap" style="width: 50%; height: 30px; float: right;">
			<button type="button" class="btn-default" onclick="javascript: addNews();">등록</button>
		</div>
		<div style="clear: both;"></div>
	</div>
	<span class="content-title" style="margin-top: 20px;">상단 롤링 고정 목록</span>
	<div class="content-div">
		<table class="content-table" >
			<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
				<td style="width: 100px; text-align: center;">NO.</td>
				<td style="width: 200px; text-align: center;">카테고리</td>
				<td >제목</td>
				<td style="width: 150px; text-align: center;">리스팅 일자</td>
				<td style="width: 120px; text-align: center;">롤링 고정</td>
				<td style="width: 100px; text-align: center;">상세보기</td>
			</tr>
			<%for(int i=0; i<topListNI.size(); i++){ 
				NewsInfoModel list = topListNI.get(i);
				%>
				<tr>
					<td style="text-align: center;"><%=i+1 %></td>
					<td style="text-align: center;"><%=CategorySearch.getNewsCategory(list.getType()) %></td>
					<td ><%=list.getTitle() %></td>
					<td style="text-align: center;"><%=list.getViewDate().substring(0, 19) %></td>
					<td style="text-align: center;">
						<button type="button" class="btn-red" onclick="javascript: newsRollingCancel(<%=list.getIdx()%>);">고정 취소</button>
					</td>
					<td style="text-align: center;"><button type="button" class="btn-default" onclick="javascript: newsDetail(<%=list.getIdx()%>)">상세보기</button></td>
				</tr>
			<%} %>
		</table>
	</div>
	<span class="content-title" style="margin-top: 50px;">뉴스 목록</span>
	<div class="content-div">
		<table class="content-table" >
			<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
				<td style="width: 100px; text-align: center;">NO.</td>
				<td style="width: 200px; text-align: center;">카테고리</td>
				<td >제목</td>
				<td style="width: 180px; text-align: center;">리스팅 일자</td>
				<td style="width: 150px; text-align: center;">리스팅 여부</td>
				<td style="width: 120px; text-align: center;">롤링 고정</td>
				<td style="width: 100px; text-align: center;">상세보기</td>
			</tr>
			<%for(int i=0; i<listNI.size(); i++){ 
				NewsInfoModel list = listNI.get(i);
				%>
				<tr>
					<td style="text-align: center;"><%=totalCount - i - (Integer.parseInt(ni.getPageNum()) - 1) * ni.getListCount() %></td>
					<td style="text-align: center;"><%=CategorySearch.getNewsCategory(list.getType()) %></td>
					<td ><%=list.getTitle() %></td>
					<td style="text-align: center;"><%=list.getViewDate().substring(0, 19) %></td>
					<%if(list.getListingCheck() == 1){ %>
						<td style="text-align: center; background-color: #D6FFD0;">리스팅 완료</td>
					<%}else{ %>
						<td style="text-align: center; background-color: #FFC6C6;">리스팅 예정</td>
					<%} %>
					<td style="text-align: center;">
						<%if(list.getListingCheck() == 0){ %>
							<button type="button" class="btn-red" onclick="javascript: alert('리스팅 완료만 가능합니다.');">롤링 불가</button>
						<%}else{ %>
							<%if(list.getTop() == 1){ %>
								<button type="button" class="btn-red" onclick="javascript: newsRollingCancel(<%=list.getIdx()%>);">고정 취소</button>
							<%}else{ %>
								<button type="button" class="btn-yellow" onclick="javascript: newsRollingFix(<%=list.getIdx()%>, <%=topListNI.size()%>)">롤링 고정</button>
							<%} %>
						<%} %>
					</td>
					<td style="text-align: center;"><button type="button" class="btn-default" onclick="javascript: newsDetail(<%=list.getIdx()%>)">상세보기</button></td>
				</tr>
			<%} %>
			<tr style="height: 20px;">
			<tr style="border: none;">
				<td colspan="7" style="text-align: center;">
					<%=pageNavigator %>
				</td>
			</tr>
		</table>
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>


</body>
</html>