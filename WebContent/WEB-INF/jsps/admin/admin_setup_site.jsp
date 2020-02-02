<%@page import="model.FamilySiteModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	String menu = request.getParameter("menu");
	List<FamilySiteModel> listFS = (List<FamilySiteModel>) request.getAttribute("listFS");
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
	<span class="content-title">설정</span>
	<div class="content-div">
		<table style="width: 100%;">
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
		
		<div class="btn-wrap">
			<button type="button" class="btn-default" onclick="javascript: addFamilySiteModalOpen();">등록</button>
		</div>
		
		<table class="content-table" >
			<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
				<td style="width: 100px; text-align: center;">NO.</td>
				<td style="width: 200px; text-align: center;">패밀리 사이트 명</td>
				<td style="text-align: center;">링크</td>
				<td style="width: 150px; text-align: center;">등록일</td>
				<td style="width: 100px; text-align: center;">정렬</td>
				<td style="width: 150px; text-align: center;">편집</td>
			</tr>
			<%for(int i=0; i<listFS.size(); i++) {
				FamilySiteModel list = listFS.get(i);
				%>
				<tr>
					<td style="text-align: center;">
						<%=i+1 %>
						<input type="hidden" id="idx_<%=list.getIdx() %>" value="<%=list.getIdx() %>" />
						<input type="hidden" id="name_<%=list.getIdx() %>" value="<%=list.getName() %>" />
						<input type="hidden" id="link_<%=list.getIdx() %>" value="<%=list.getLink() %>" />
					</td>
					<td style="text-align: center;"><%=list.getName() %></td>
					<td style="text-align: center;"><a href="<%=list.getLink()%>" target="_blank"><%=list.getLink() %></a></td>
					<td style="text-align: center;"><%=list.getTs() %></td>
					<td style="text-align: center;">
						<%if(listFS.size()>1){
							if(i==0){
							%>
							<a href="javascript: downSortFamilySite(<%=list.getIdx()%>, <%=list.getSort()%>)">▼</a>
						<%}else if(i==listFS.size()-1){%>
							<a href="javascript: upSortFamilySite(<%=list.getIdx()%>, <%=list.getSort()%>)">▲</a>
						<%}else{ %>
							<a href="javascript: upSortFamilySite(<%=list.getIdx()%>, <%=list.getSort()%>)">▲</a> / <a href="javascript: downSortFamilySite(<%=list.getIdx()%>, <%=list.getSort()%>)">▼</a>
						<%}
						}%>
					</td>
					<td style="text-align: center;">
						<button type="button" class="btn-green" onclick="javascript: modifyFamilySiteModalOpen(<%=list.getIdx()%>)">수정</button>
						<button type="button" class="btn-red" onclick="javascript: deleteFamilySite(<%=list.getIdx()%>);">삭제</button>
					</td>
				</tr>
			<%} %>
		</table>
		
	</div>
</div>

<!-- family site add -->
<div id="site_add" class="modal">
	<div class="modal-wrap">
		<a href="javascript: addFamilySiteModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title">패밀리 사이트 등록</span>
		<div class="modal-content-wrap">
			<div class="input-wrap">
				<label class="input-label">사이트 명</label>
				<input type="text" class="input-box" id="name" />
			</div>
			<div class="input-wrap">
				<label class="input-label">링크</label>
				<input type="text" class="input-box" id="link" />
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-default" onclick="javascript: addFamilySite();">등록</button>
		</div>
	</div>
</div>

<!-- family site modify -->
<div id="site_modify" class="modal">
	<div class="modal-wrap">
		<a href="javascript: modifyFamilySiteModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title">패밀리 사이트 수정</span>
		<div class="modal-content-wrap">
			<input type="hidden" id="mod_idx" />
			<div class="input-wrap">
				<label class="input-label">사이트 명</label>
				<input type="text" class="input-box" id="mod_name" />
			</div>
			<div class="input-wrap">
				<label class="input-label">링크</label>
				<input type="text" class="input-box" id="mod_link" />
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-green" onclick="javascript: modifyFamilySite();">수정</button>
		</div>
	</div>
</div>


</body>
</html>