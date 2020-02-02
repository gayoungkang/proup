<%@page import="dao.AdminDAO"%>
<%@page import="model.SetupModel"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	AdminDAO aDao = new AdminDAO();
	SetupModel setup = aDao.selectSetup();
	aDao.dbClose();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자</title>
<!-- script files -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script src="js/admin.js"></script>

<!-- CSS -->
<link rel="stylesheet" href="css/jquery-ui.css">
<link rel="stylesheet" href="css/admin.css">

<script type="text/javascript">

function onSubmit(){
	var id = document.getElementById('id').value;
	var passwd = document.getElementById('passwd').value;
	
	if(id == ""){
		alert("아이디를 입력하세요.");
		return false;
	}
	
	if(passwd == ""){
		alert("비밀번호를 입력하세요.");
		return false;
	}
}

</script>	
</head>
<body >
	<div class="login-wrap">
		<div class="login-box">
			<form action="admin" method="post" onsubmit="javascript:return loginSubmit()">
				<input type="hidden" name="mode" value="admin_login" />
				<img class="login-logo" src="<%=setup.getLogo() %>" alt="로고">
				<div class="login-input-wrap">
					<label class="login-input-label">아이디</label>
					<input type="text" class="login-input" id="id" name="id"  tabindex="1" />
				</div>
				<div class="login-input-wrap">
					<label class="login-input-label">비밀번호</label>
					<input type="password" class="login-input" name="password" id="password" tabindex="2" />
				</div>
				<button type="submit" class="login-button" tabindex="3" >로그인</button>
			</form>
		</div>	
	</div>
	
		<!-- <div style="padding-top: 20px;">
			<form action="admin" method="post" onsubmit="javascript:return onSubmit()">
				<input type="hidden" name="mode" value="admin_login" />
				<table style="position: relative;">
					<tr>
						<td style="width: 80px; text-align: right;">ID</td>
						<td style="width: 220px;"><input type="text" class="input-style" id="id" name="id"  tabindex="1" /></td>
						<td rowspan="2" style="width: 80px;"><button type="submit" class="btn-blue" style="width: 100%; height: 70px;" tabindex="3">Login</button></td>
					</tr>
					<tr>
						<td style="text-align: right;">Password</td>
						<td style=""><input type="password" class="input-style" name="password" id="passwd" tabindex="2" /></td>
					</tr>
				</table>
			</form>
		</div> -->
	
</body>
</html>