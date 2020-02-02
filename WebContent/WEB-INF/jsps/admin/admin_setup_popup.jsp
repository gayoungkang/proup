<%@page import="model.PopupModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	String menu = request.getParameter("menu");
	PopupModel popup = (PopupModel) request.getAttribute("popup");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자</title>
<!-- jQuery -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/admin.js"></script>

<link rel="stylesheet" href="css/jquery-ui.css">
<link rel="stylesheet" href="css/admin.css">

</head>
<body>

<jsp:include page="./admin_menu.jsp"></jsp:include>

<div class="content-wrap">
	<span class="content-title">팝업 관리</span>
	<div class="content-div">
		<table style="width: 100%; margin-bottom: 10px;">
			<tr height="30px">
				<td 
					<%if("admin_setup_content".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: setupSubMenuTab('content');"
					<%} %>>
					설정
				</td>
				<td 
					<%if("admin_setup_information".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: setupSubMenuTab('information');"
					<%} %>>
					개인정보처리방침
				</td>
				<td 
					<%if("admin_setup_site".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: setupSubMenuTab('site');"
					<%} %>>
					패밀리 사이트
				</td>
				<td 
					<%if("admin_setup_popup".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: setupSubMenuTab('popup');"
					<%} %>>
					팝업 관리
				</td>
				<td 
					<%if("admin_setup_password".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: setupSubMenuTab('password');"
					<%} %>>
					비밀번호 변경
				</td>
			</tr>
		</table>
		<form action="admin" method="post" onsubmit="javascript:return popupSubmit();" > 
			<input type="hidden" name="mode" value="update_popup" />
			<table class="content-table" >
				<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
					<td style="width: 150px; text-align: center;">구분</td>
					<td style="width: 300px; text-align: center;">입력</td>
					<td  style="text-align: center;">비고</td>
					
				</tr>
				<tr>
					<td style="text-align: center;">팝업 배너</td>
					<td>
						<input type="file" id="img" name="img"  class="input-default" style="padding-top: 3px;" onchange="javascript: setupFileUpload('img');" />
						<input type="hidden" id="img_data" name="img_data" />
						<input type="hidden" name="img_old" value="<%=popup.getImg() %>" />
					</td>
					<td style="text-align: center;"><img style="width: 500px;" id="img_img" src="<%=popup.getImg() %>" /></td>
				</tr>		
				
				<tr>
					<td style="text-align: center;">링크</td>
					<td><input type="text" class="input-default" id="link" name="link" value="<%=popup.getLink() %>" /></td>
					<td></td>
				</tr>
				<tr>
					<td style="text-align: center;">숨김</td>
					<td>
						<select class="input-default" name="hide">
							<option value="1" <%if(popup.getHide() == 1){%>selected="selected"<%} %>>숨김</option>
							<option value="0" <%if(popup.getHide() == 0){%>selected="selected"<%} %>>보임</option>
						</select>
					</td>
					<td></td>
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