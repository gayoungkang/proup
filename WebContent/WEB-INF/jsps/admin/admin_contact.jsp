<%@page import="model.ContactModel"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	List<ContactModel> listContact = (List<ContactModel>) request.getAttribute("listContact");
	ContactModel contact = (ContactModel) request.getAttribute("contact");
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
	<span class="content-title">문의하기 목록</span>
	<div class="content-div">
		<div class="search-wrap">
			<input class="input-default" id="searchText" style="height: 30px; width: 200px; float: left; margin-left: 5px;" value="<%=searchText %>" onkeyup="javascript: onContactSearch()" />
			<button class="btn-default" style="float: left; margin-left: 5px;" onclick="javascript: contactSearch();">검색</button>
		</div>
		<div class="btn-wrap" style="width: 50%; height: 30px; float: right;">
			<button class="btn-green" style="float: right;" onclick="javascript: goContactExcel()">엑셀</button>
		</div>
		<div style="clear: both;"></div>
		
		<table class="content-table">
			<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
				<td style="text-align: center; width: 80px;">NO.</td>
				<td style="text-align: center; width: 120px;">이름</td>
				<td style="text-align: center; width: 120px;">기업명</td>
				<td style="text-align: center; width: 200px;">이메일</td>
				<td style="text-align: center; width: 150px;">연락처</td>
				<td style="text-align: center; width: 200px;">교육대상자</td>
				<td style="text-align: center;">문의내용</td>
				<td style="text-align: center; width: 150px;">등록일</td>
			</tr>
			<%for(int i=0; i<listContact.size(); i++){
				ContactModel list = listContact.get(i);
				%>
				<tr>
					<td style="text-align: center;"><%=totalCount - i - (Integer.parseInt(contact.getPageNum()) - 1) * contact.getListCount() %></td>
					<td style="text-align: center;"><%=list.getName() %></td>
					<td style="text-align: center;"><%=list.getCompany() %></td>
					<td style="text-align: center;"><%=list.getEmail() %></td>
					<td style="text-align: center;"><%=list.getContact() %></td>
					<td style="text-align: center;"><%=list.getTarget() %></td>
					<td ><%=list.getContent().replaceAll("\n", "<br/>") %></td>
					<td style="text-align: center;"><%=list.getDate().substring(0, 19) %></td>
				</tr>
			<%} %>
			<tr style="height: 20px;">
			<tr style="border: none;">
				<td colspan="8" style="text-align: center;">
					<%=pageNavigator %>
				</td>
			</tr>
		</table>
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>

</body>
</html>