<%@page import="model.SetupModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	String menu = request.getParameter("menu");
	SetupModel setup = (SetupModel) request.getAttribute("setup");
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

<script type="text/javascript">

</script>
</head>
<body>

<jsp:include page="./admin_menu.jsp"></jsp:include>

<div class="content-wrap">
	<span class="content-title">비밀번호 변경</span>
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
		<form action="admin" method="post" onsubmit="javascript:return onSubmitPassword()">
			<input type="hidden" name="mode" value="update_password" />
			<table class="content-table">
				<tr>
					<td width="10%" style="text-align: center;">현재 비밀번호</td>
					<td width="45%"><input type="password" class="input-default" id="old_pw" name="old_pw" /></td>
					<td width="45%"></td>
				</tr>
				<tr>
					<td style="text-align: center;">새 비밀번호</td>
					<td><input type="password" class="input-default" id="new_pw" name="new_pw" onkeyup="javascript: pwCheck()" /></td>
					<td width="300px;" style="text-align: left;"></td>
				</tr>
				<tr>
					<td style="text-align: center;">새 비밀번호 확인</td>
					<td><input type="password" class="input-default" id="new_pw2" name="new_pw2" onkeyup="javascript: pwCheck()" /></td>
					<td style="text-align: left;" id="pw_check_td"></td>
				</tr>
				<tr height="30px;"></tr>
				<tr style="border-bottom: none;">
					<td colspan="3" style="text-align: center;"><button type="submit" class="btn-default">수정</button></td>
					
				</tr>
			</table>
		</form>
		
	</div>
</div>
</body>
</html>