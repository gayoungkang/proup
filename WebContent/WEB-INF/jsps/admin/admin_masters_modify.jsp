
<%@page import="model.MastersModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	MastersModel master = (MastersModel) request.getAttribute("master");
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

</head>
<body>

<jsp:include page="./admin_menu.jsp"></jsp:include>

<div class="content-wrap">
	<span class="content-title" style="margin-top: 20px;">마스터 수정</span>
	<div class="content-div">
		
		<form action="admin" method="post" onsubmit="javascript:return modifyMasterSubmit();">
			<input type="hidden" name="mode" value="update_masters" />
			<input type="hidden" name="idx" value="<%=master.getIdx() %>" />
			<table class="content-table" style="width: 1000px;">
				<tr>
					<td style="width: 200px; text-align: center;">카테고리</td>
					<td style="width: 800px;">
						<select class="input-default" name="category" >
							<option value="1" <%if(master.getCategory() == 1){ %>selected="selected"<%} %> >디지털 혁신</option>
							<option value="2" <%if(master.getCategory() == 2){ %>selected="selected"<%} %>>라이프</option>
							<option value="3" <%if(master.getCategory() == 3){ %>selected="selected"<%} %>>직무역량</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">썸네일</td>
					<td>
						<input type="file" id="img" name="img" class="input-default" style="padding-top: 3px;" onchange="javascript: mastersFileUpload('img');" />
						<input type="hidden" id="img_data" name="img_data" />
						<input type="hidden" id="img_old" name="img_old" value="<%=master.getImg() %>" />
					</td>
				</tr>
				
				<tr>
					<td style="text-align: center;">이름</td>
					<td>
						<input type="text" id="name" name="name" class="input-default" value="<%=master.getName() %>" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">슬로건</td>
					<td>
						<input type="text" id="slogan" name="slogan" class="input-default" value="<%=master.getSlogan() %>" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">태그</td>
					<td>
						<input type="text" id="tag" name="tag" class="input-default" value="<%=master.getTag() %>" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">이력1</td>
					<td>
						<input type="text" id="company" name="company" class="input-default" value="<%=master.getCompany() %>" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">이력2</td>
					<td>
						<input type="text" id="position" name="position" class="input-default" value="<%=master.getPosition() %>" />
					</td>
				</tr>
				<tr>
					<td style="width: 200px; text-align: center;">명예의전당</td>
					<td style="width: 800px;">
						<select class="input-default" name="best_hide" >
							<option value="0" <%if(master.getBestHide() == 0){ %>selected="selected"<%} %> >보임</option>
							<option value="1" <%if(master.getBestHide() == 1){ %>selected="selected"<%} %>>숨김</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 200px; text-align: center;">숨김</td>
					<td style="width: 800px;">
						<select class="input-default" name="hide" >
							<option value="0" <%if(master.getHide() == 0){ %>selected="selected"<%} %> >보임</option>
							<option value="1" <%if(master.getHide() == 1){ %>selected="selected"<%} %>>숨김</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">검색 타이틀</td>
					<td>
						<input type="text" id="title" name="title" class="input-default" value="<%=master.getTitle() %>" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">검색 설명</td>
					<td>
						<textarea class="input-default" style="height: 50px;" id="description" name="description"><%=master.getDescription() %></textarea>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">검색 키워드</td>
					<td>
						<textarea class="input-default" style="height: 50px;" id="keywords" name="keywords"><%=master.getKeywords() %></textarea>
					</td>
				</tr>
				<tr style="border: none; height: 80px;">
					<td style="text-align: center;" colspan="2">
						<button type="submit" class="btn-green">수정</button>
					</td>
				</tr>
			</table>
		</form>
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>


</body>
</html>