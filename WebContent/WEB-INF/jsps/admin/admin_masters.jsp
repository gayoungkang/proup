<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="util.CategorySearch"%>
<%@page import="model.MastersModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	List<MastersModel> listMaster = (List<MastersModel>) request.getAttribute("listMaster");
	int totalCount = (Integer) request.getAttribute("totalCount");
	MastersModel masters = (MastersModel) request.getAttribute("master");
	String searchText = (String) request.getAttribute("searchText");
	String pageNavigator = (String) request.getAttribute("pageNavigator");
	
	DecimalFormat form = new DecimalFormat("#.##");
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
	<span class="content-title">마스터 관리</span>
	<div class="content-div">
		<div class="search-wrap">
			<input class="input-default" id="searchText" style="height: 30px; width: 200px; float: left; margin-left: 5px;" value="<%=searchText %>" onkeyup="javascript: onMainReviewSearch()" />
			<button class="btn-default" style="float: left; margin-left: 5px;" onclick="javascript: mainReviewSearch();">검색</button>
		</div>
		<div class="btn-wrap" style="width: 50%; height: 30px; float: right;">
			<button type="button" class="btn-green" onclick="javascript: goMastersExcel();">엑셀</button>
			<button type="button" class="btn-default" onclick="javascript: addMasters();">등록</button>
		</div>
		<div style="clear: both;"></div>
		
		<table class="content-table" >
			<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
				<td style="width: 80px; text-align: center;">NO.</td>
				<td style="width: 150px; text-align: center;">카테고리</td>
				<td style="width: 150px; text-align: center;">이름</td>
				<td style="width: 150px; text-align: center;">교육 평가 결과</td>
				<td style="width: 150px; text-align: center;">강의/컨설팅</td>
				<td style="width: 150px; text-align: center;">누적 교육생 수</td>
				<td style="width: 120px; text-align: center;">후기 수</td>
				<td style="width: 120px; text-align: center;">명예의전당</td>
				<td style="width: 120px; text-align: center;">숨김</td>
				<td style="width: 150px; text-align: center;">등록일</td>
				<td style="width: 120px; text-align: center;">상세</td>
			</tr>
			<%for(int i=0; i<listMaster.size(); i++){ 
				MastersModel list = listMaster.get(i);
			%>
				<tr>
					<td style="text-align: center;"><%=totalCount - i - (Integer.parseInt(masters.getPageNum()) - 1) * masters.getListCount() %></td>
					<td style="text-align: center;"><%=CategorySearch.getMasterCategory(list.getCategory()) %></td>
					<td style="text-align: center;"><%=list.getName() %></td>
					<td style="text-align: center;"><%=nf.format(list.getReferenceScore()) %> / 5</td>
					<td style="text-align: center;"><%=nf.format(list.getReferenceCount()) %></td>
					<td style="text-align: center;"><%=nf.format(list.getReferencePeople()) %>명</td>
					<td style="text-align: center;"><%=nf.format(list.getReviewCount()) %></td>
					<%if(list.getBestHide() == 0){ %>
						<td style="text-align: center; background-color: #D6FFD0;">보임</td>
					<%}else{ %>
						<td style="text-align: center; background-color: #FFC6C6;">숨김</td>
					<%} %>
					<%if(list.getHide() == 0){ %>
						<td style="text-align: center; background-color: #D6FFD0;">보임</td>
					<%}else{ %>
						<td style="text-align: center; background-color: #FFC6C6;">숨김</td>
					<%} %>
					<td style="text-align: center;"><%=list.getDate().substring(0, 19) %></td>
					<td style="text-align: center;"><button type="button" class="btn-default" onclick="javascript: mastersDetailHistory(<%=list.getIdx()%>);">상세보기</button></td>
				</tr>
			<%} %>
			<tr style="height: 20px;">
			<tr style="border: none;">
				<td colspan="11" style="text-align: center;">
					<%=pageNavigator %>
				</td>
			</tr>
		</table>
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>


</body>
</html>