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

</head>
<body>

<jsp:include page="./admin_menu.jsp"></jsp:include>

<div class="content-wrap">
	<span class="content-title">설정</span>
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
		<form action="admin" method="post" onsubmit="javascript:return setupSubmit();" > 
			<input type="hidden" name="mode" value="update_setup" />
			<table class="content-table" >
				<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
					<td style="width: 150px; text-align: center;">구분</td>
					<td style="width: 300px; text-align: center;">입력</td>
					<td  style="text-align: center;">비고</td>
					
				</tr>
				<tr>
					<td style="text-align: center;">메인화면 배너</td>
					<td>
						<input type="file" id="banner" name="banner"  class="input-default" style="padding-top: 3px;" onchange="javascript: setupFileUpload('banner');" />
						<input type="hidden" id="banner_data" name="banner_data" />
						<input type="hidden" name="banner_old" value="<%=setup.getBanner() %>" />
					</td>
					<td style="text-align: center;"><img style="height: 300px;" id="banner_img" src="<%=setup.getBanner() %>" /></td>
				</tr>		
				<tr>
					<td style="text-align: center;">pdf 파일</td>
					<td>
						<input type="file" id="pdf" name="pdf" class="input-default" style="padding-top: 3px;"  onchange="javascript: setupFileUpload('pdf');" />
						<input type="hidden" id="pdf_data" name="pdf_data" />
						<input type="hidden" name="pdf_old" value="<%=setup.getPdf() %>" />
					</td>
					<td style="text-align: center;"><a id="pdf_a" href="<%=setup.getPdf() %>" target="_blank">미리보기</a></td>
				</tr>		
				<tr>
					<td style="text-align: center;">연락처</td>
					<td><input type="text" class="input-default" id="contact" name="contact" value="<%=setup.getContact() %>" /></td>
					<td></td>
				</tr>		
				<tr>
					<td style="text-align: center;">로고</td>
					<td>
						<input type="file" id="logo" name="logo"  class="input-default" style="padding-top: 3px;" onchange="javascript: setupFileUpload('logo');" />
						<input type="hidden" id="logo_data" name="logo_data" />
						<input type="hidden" name="logo_old" value="<%=setup.getLogo() %>" />
					</td>
					<td style="background-color: #021847; text-align: center;"><img style="height: 26px;" id="logo_img" src="<%=setup.getLogo() %>" /></td>
				</tr>
				<tr>
					<td style="text-align: center;">헤더 컬러</td>
					<td><input type="text" class="input-default" id="color" name="color" value="<%=setup.getColor() %>" /></td>
					<td></td>
				</tr>	
				<tr>
					<td style="text-align: center;">카테고리</td>
					<td>
						<select class="input-default" name="category">
							<option value="1" <%if(setup.getCategory() == 1){%>selected="selected"<%} %>>보임</option>
							<option value="0" <%if(setup.getCategory() == 0){%>selected="selected"<%} %>>안보임</option>
						</select>
					</td>
					<td></td>
				</tr>
				<tr>
					<td style="text-align: center;">이메일</td>
					<td><input type="text" class="input-default" id="email" name="email" value="<%=setup.getEmail() %>" /></td>
					<td></td>
				</tr>
				<tr>
					<td style="text-align: center;">회사명</td>
					<td><input type="text" class="input-default" id="company_name" name="company_name" value="<%=setup.getCompanyName() %>" /></td>
					<td></td>
				</tr>
				<tr>
					<td style="text-align: center;">사업자등록번호</td>
					<td><input type="text" class="input-default" id="company_num" name="company_num" value="<%=setup.getCompanyNum() %>" /></td>
					<td></td>
				</tr>
				<tr>
					<td style="text-align: center;">주소</td>
					<td><input type="text" class="input-default" id="address" name="address" value="<%=setup.getAddress() %>" /></td>
					<td></td>
				</tr>
				<tr>
					<td style="text-align: center;">교육추천서 문구</td>
					<td><input type="text" class="input-default" id="recommand" name="recommand" value="<%=setup.getRecommand() %>" /></td>
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