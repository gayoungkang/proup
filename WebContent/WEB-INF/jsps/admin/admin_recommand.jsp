<%@page import="model.RecommandModel"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	List<RecommandModel> listRec = (List<RecommandModel>) request.getAttribute("listRec");
	RecommandModel rec = (RecommandModel) request.getAttribute("rec");
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
			<input class="input-default" id="searchText" style="height: 30px; width: 200px; float: left; margin-left: 5px;" value="<%=searchText %>" onkeyup="javascript: onRecSearch()" />
			<button class="btn-default" style="float: left; margin-left: 5px;" onclick="javascript: recSearch();">검색</button>
		</div>
		<div class="btn-wrap" style="width: 50%; height: 30px; float: right;">
			<button class="btn-green" style="float: right;" onclick="javascript: goRecommandExcel()">엑셀</button>
		</div>
		<div style="clear: both;"></div>
		
		<table class="content-table">
			<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
				<td style="text-align: center; width: 60px;">NO.</td>
				<td style="text-align: center; width: 100px;">강의분야</td>
				<td style="text-align: center; width: 100px;">교육목적</td>
				<td style="text-align: center; width: 100px;">교육대상자</td>
				<td style="text-align: center; width: 100px;">대상자직무</td>
				<td style="text-align: center; width: 100px;">교육시간</td>
				<td style="text-align: center; width: 100px;">교육비예산</td>
				<td style="text-align: center; width: 100px;">교육장소</td>
				<td style="text-align: center; width: 100px;">교육요청일</td>
				<td style="text-align: center; width: 100px;">교육운영</td>
				<td style="text-align: center;">요청사항</td>
				<td style="text-align: center; width: 120px;">회사명</td>
				<td style="text-align: center; width: 120px;">연락처</td>
				<td style="text-align: center; width: 180px;">이메일</td>
			</tr>
			<%for(int i=0; i<listRec.size(); i++){
				RecommandModel list = listRec.get(i);
				%>
				<tr>
					<td style="text-align: center;"><%=totalCount - i - (Integer.parseInt(rec.getPageNum()) - 1) * rec.getListCount() %></td>
					<td style="text-align: center;"><%=list.getCategory()%></td>
					<td style="text-align: center;"><%=list.getPurpose() %></td>
					<td style="text-align: center;"><%=list.getTarget() %></td>
					<td style="text-align: center;"><%=list.getTargetPosition() %></td>
					<td style="text-align: center;"><%=list.getHour() %></td>
					<td style="text-align: center;"><%=list.getPrice() %></td>
					<td style="text-align: center;"><%=list.getPlace() %></td>
					<td style="text-align: center;"><%=list.getRequestDate() %></td>
					<td style="text-align: center;"><%=list.getManage() %></td>
					<td><%=list.getRequest().replaceAll("\n", "<br/>") %></td>
					<td style="text-align: center;"><%=list.getCompany() %></td>
					<td style="text-align: center;"><%=list.getContact() %></td>
					<td style="text-align: center;"><%=list.getEmail() %></td>
				</tr>
			<%} %>
			<tr style="height: 20px;">
			<tr style="border: none;">
				<td colspan="14" style="text-align: center;">
					<%=pageNavigator %>
				</td>
			</tr>
		</table>
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>

</body>
</html>