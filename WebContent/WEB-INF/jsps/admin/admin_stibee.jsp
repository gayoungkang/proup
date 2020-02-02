
<%@page import="model.SubscribeModel"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	List<SubscribeModel> listSubs = (List<SubscribeModel>) request.getAttribute("listSubs");
	SubscribeModel subs = (SubscribeModel) request.getAttribute("subs");
	int totalCount = (Integer) request.getAttribute("totalCount");
	
	String searchText = (String) request.getAttribute("searchText");
	String pageNavigator = (String) request.getAttribute("pageNavigator");
	
	NumberFormat nf = NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
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
	<span class="content-title">교육제안서 목록</span>
	<div class="content-div">
		<div class="search-wrap">
			<input class="input-default" id="searchText" style="height: 30px; width: 200px; float: left; margin-left: 5px;" value="<%=searchText %>" onkeyup="javascript: onSubsSearch()" />
			<button class="btn-default" style="float: left; margin-left: 5px;" onclick="javascript: subsSearch();">검색</button>
		</div>
		<div class="btn-wrap" style="width: 50%; height: 30px; float: right;">
			<button class="btn-green" style="float: right;" onclick="javascript: goStibeeExcel()">엑셀</button>
		</div>
		<div style="clear: both;"></div>
		
		<table class="content-table" style="width:600px;">
			<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
				<td style="text-align: center; width: 80px;">NO.</td>
				<td style="text-align: center;">이메일</td>
				<td style="text-align: center; width: 150px;">등록일</td>
			</tr>
			<%for(int i=0; i<listSubs.size(); i++){
				SubscribeModel list = listSubs.get(i);
				%>
				<tr>
					<td style="text-align: center;"><%=totalCount - i - (Integer.parseInt(subs.getPageNum()) - 1) * subs.getListCount() %></td>
					<td style="text-align: center;"><%=list.getEmail()%></td>
					<td style="text-align: center;"><%=list.getDate().substring(0, 19) %></td>
				</tr>
			<%} %>
			<tr style="height: 20px;">
			<tr style="border: none;">
				<td colspan="3" style="text-align: center;">
					<%=pageNavigator %>
				</td>
			</tr>
		</table>
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>

</body>
</html>