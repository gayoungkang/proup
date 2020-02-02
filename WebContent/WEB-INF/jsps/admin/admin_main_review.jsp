
<%@page import="model.MainReviewModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	List<MainReviewModel> listMR = (List<MainReviewModel>) request.getAttribute("listMR");
	int totalCount = (Integer) request.getAttribute("totalCount");
	MainReviewModel mr = (MainReviewModel) request.getAttribute("mr");
	String searchType = (String) request.getAttribute("searchType");
	String searchText = (String) request.getAttribute("searchText");
	String pageNavigator = (String) request.getAttribute("pageNavigator");
	
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
	<span class="content-title">메인 리뷰 관리</span>
	<div class="content-div">
		<div class="search-wrap">
			<select class="input-default" id="searchType" style="height: 30px; width: 100px; float: left;">
				<option value="all" <%if("all".equals(searchType)){ %>selected="selected"<%} %>>전체검색</option>
				<option value="name" <%if("name".equals(searchType)){ %>selected="selected"<%} %>>이름</option>
				<option value="content" <%if("content".equals(searchType)){ %>selected="selected"<%} %>>내용</option>
			</select>
			<input class="input-default" id="searchText" style="height: 30px; width: 200px; float: left; margin-left: 5px;" value="<%=searchText %>" onkeyup="javascript: onMainReviewSearch()" />
			<button class="btn-default" style="float: left; margin-left: 5px;" onclick="javascript: mainReviewSearch();">검색</button>
		</div>
		<div class="btn-wrap" style="width: 50%; height: 30px; float: right;">
			<button type="button" class="btn-default" onclick="javascript: addMainReviewModalOpen();">등록</button>
		</div>
		<div style="clear: both;"></div>
		
		<table class="content-table" >
			<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
				<td style="width: 100px; text-align: center;">NO.</td>
				<td style="width: 100px; text-align: center;">썸네일</td>
				<td style="width: 250px; text-align: center;">이름</td>
				<td style="text-align: center;">내용</td>
				<td style="width: 150px; text-align: center;">편집</td>
			</tr>
			<%for(int i=0; i<listMR.size(); i++){
				MainReviewModel list = listMR.get(i);
				%>
				<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
					<td style="width: 100px; text-align: center;">
						<%=totalCount - i - (Integer.parseInt(mr.getPageNum()) - 1) * mr.getListCount() %>
						<input type="hidden" id="idx_<%=list.getIdx() %>" value="<%=list.getIdx() %>" />
						<input type="hidden" id="img_<%=list.getIdx() %>" value="<%=list.getImg() %>" />
						<input type="hidden" id="name_<%=list.getIdx() %>" value="<%=list.getName() %>" />
						<input type="hidden" id="content_<%=list.getIdx() %>" value="<%=list.getContent() %>" />
					</td>
					<td style="width: 100px; text-align: center;"><img src="upload/main_review/<%=list.getIdx() %>/<%=list.getImg() %>" style="height: 40px;" /></td>
					<td style="width: 250px; text-align: center;"><%=list.getName() %></td>
					<td style="text-align: left;"><%=list.getContent() %></td>
					<td style="width: 150px; text-align: center;">
						<button type="button" class="btn-green" onclick="javascript: modifyMainReviewModalOpen(<%=list.getIdx()%>)">수정</button>
						<button type="button" class="btn-red" onclick="javascript: deleteMainReview(<%=list.getIdx()%>);">삭제</button>
					</td>
				</tr>
			<%} %>
			<tr style="height: 20px;">
			<tr style="border: none;">
				<td colspan="5" style="text-align: center;">
					<%=pageNavigator %>
				</td>
			</tr>
			
		</table>
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>

<!-- main review add -->
<div id="main_review_add" class="modal">
	<div class="modal-wrap">
		<a href="javascript: addMainReviewModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title">메인 리뷰 등록</span>
		<div class="modal-content-wrap">
			<div class="input-wrap">
				<label class="input-label">썸네일</label>
				<input type="file" class="input-box" id="img" name="img" onchange="javascript: mainReviewFileUpload('img');" />
				<input type="hidden" id="img_data"  />
			</div>
			<div class="input-wrap">
				<label class="input-label">미리보기</label>
				<img id="img_img" style="height: 40px;" />
			</div>
			<div class="input-wrap">
				<label class="input-label">이름</label>
				<input type="text" class="input-box" id="name" />
			</div>
			<div class="input-wrap" style="height: 100px;">
				<label class="input-label">내용</label>
				<textarea class="input-box" id="content" style="height: 100px;"></textarea>
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-default" onclick="javascript: addMainReview();">등록</button>
		</div>
	</div>
</div>

<!-- main review modify -->
<div id="main_review_modify" class="modal">
	<div class="modal-wrap">
		<a href="javascript: modifyMainReviewModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title">메인 리뷰 수정</span>
		<div class="modal-content-wrap">
			<div class="input-wrap">
				<label class="input-label">썸네일</label>
				<input type="file" class="input-box" id="mod_img" name="mod_img" onchange="javascript: mainReviewFileUpload('mod_img');" />
				<input type="hidden" id="mod_img_data"  />
				<input type="hidden" id="mod_img_old"  />
				<input type="hidden" id="mod_idx"  />
			</div>
			<div class="input-wrap">
				<label class="input-label">미리보기</label>
				<img id="mod_img_img" style="height: 40px;" />
			</div>
			<div class="input-wrap">
				<label class="input-label">이름</label>
				<input type="text" class="input-box" id="mod_name" />
			</div>
			<div class="input-wrap" style="height: 100px;">
				<label class="input-label">내용</label>
				<textarea class="input-box" id="mod_content" style="height: 100px;"></textarea>
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-green" onclick="javascript: modifyMainReview();">수정</button>
		</div>
	</div>
</div>


</body>
</html>