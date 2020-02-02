<%@page import="model.MastersReviewModel"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="util.CategorySearch"%>
<%@page import="model.MastersModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	MastersModel master = (MastersModel) request.getAttribute("master");
	List<MastersReviewModel> listMR = (List<MastersReviewModel>) request.getAttribute("listMR");
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
	<span class="content-title">마스터 상세보기</span>
	<div class="content-div">
		<input type="hidden" id="master_index" value="<%=master.getIdx() %>" />
		<div class="btn-wrap" >
			
			<button type="button" class="btn-green" onclick="javascript: goMasterModify(<%=master.getIdx()%>);">마스터 기본정보 수정</button>
			<button type="button" class="btn-red" onclick="javascript: deleteMasters(<%=master.getIdx()%>);">마스터 삭제</button>
		</div>
		<div style="clear: both;"></div>
		
		<div style="width: 20%; float: left;">
			<img style="width: 100%;" src="upload/masters/<%=master.getIdx() %>/<%=master.getImg() %>" />
		</div>
		<div style="width: 80%; float: right; padding-left: 10%;">
			<table class="content-table" >
				<tr>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">카테고리</td>
					<td style="width: 35%; text-align: center;"><%=CategorySearch.getMasterCategory(master.getCategory()) %></td>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">이름</td>
					<td style="width: 35%; text-align: center;"><%=master.getName() %></td>
				</tr>
				<tr>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">슬로건</td>
					<td style="width: 35%; text-align: center;"><%=master.getSlogan() %></td>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">태그</td>
					<td style="width: 35%; text-align: center;"><%=master.getTag() %></td>
				</tr>
				<tr>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">이력1</td>
					<td style="width: 35%; text-align: center;"><%=master.getCompany() %></td>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">이력2</td>
					<td style="width: 35%; text-align: center;"><%=master.getPosition() %></td>
				</tr>
				<tr>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">명예의전당</td>
					<%if(master.getBestHide() == 0){ %>
						<td style="width: 35%; text-align: center; background-color: #D6FFD0;">보임</td>
					<%}else{ %>
						<td style="width: 35%; text-align: center; background-color: #FFC6C6;">숨김</td>
					<%} %>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">숨김</td>
					<%if(master.getHide() == 0){ %>
						<td style="width: 35%; text-align: center; background-color: #D6FFD0;">보임</td>
					<%}else{ %>
						<td style="width: 35%; text-align: center; background-color: #FFC6C6;">숨김</td>
					<%} %>
				</tr>
				<tr>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">등록일</td>
					<td style="width: 35%; text-align: center;"><%=master.getDate().substring(0, 19) %></td>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">검색 타이틀</td>
					<td style="width: 35%; text-align: center;"><%=master.getTitle() %></td>
				</tr>
				<tr>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">검색 설명</td>
					<td style="width: 35%; text-align: center;"><%=master.getDescription() %></td>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">검색 키워드</td>
					<td style="width: 35%; text-align: center;"><%=master.getKeywords() %></td>
				</tr>
				<tr>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">교육 평가 결과</td>
					<td style="width: 35%; text-align: center;"><%=nf.format(master.getReferenceScore()) %> / 5</td>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">강의 컨설팅</td>
					<td style="width: 35%; text-align: center;"><%=nf.format(master.getReferenceCount()) %></td>
				</tr>
				<tr>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">누적 교육생 수</td>
					<td style="width: 35%; text-align: center;"><%=nf.format(master.getReferencePeople()) %></td>
					<td style="width: 15%; text-align: center; background-color: #f3f3f3;">후기 수</td>
					<td style="width: 35%; text-align: center;"><%=nf.format(master.getReviewCount()) %></td>
				</tr>
			</table>
		</div>
		<div style="clear: both;"></div>
		<div class="content-div">
			<jsp:include page="./admin_masters_detail_sub_menu.jsp"></jsp:include>
			
			<div class="btn-wrap">
				<button type="button" class="btn-default" onclick="javascript: addMasterReviewModalOpen();">등록</button>
			</div>
			
			<table class="content-table" >
				<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
					<td style="width: 100px; text-align: center;">NO.</td>
					<td style="width: 100px; text-align: center;">썸네일</td>
					<td style="width: 250px; text-align: center;">이름</td>
					<td style="text-align: center;">내용</td>
					<td style="width: 150px; text-align: center;">편집</td>
				</tr>
				<%for(int i=0; i<listMR.size(); i++){
					MastersReviewModel list = listMR.get(i);
					%>
					<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
						<td style="width: 100px; text-align: center;">
							<%=i+1 %>
							<input type="hidden" id="idx_<%=list.getIdx() %>" value="<%=list.getIdx() %>" />
							<input type="hidden" id="img_<%=list.getIdx() %>" value="<%=list.getImg() %>" />
							<input type="hidden" id="name_<%=list.getIdx() %>" value="<%=list.getName() %>" />
							<input type="hidden" id="content_<%=list.getIdx() %>" value="<%=list.getContent() %>" />
						</td>
						<td style="width: 100px; text-align: center;"><img src="upload/review/<%=list.getIdx() %>/<%=list.getImg() %>" style="height: 40px;" /></td>
						<td style="width: 250px; text-align: center;"><%=list.getName() %></td>
						<td style="text-align: left;"><%=list.getContent() %></td>
						<td style="width: 150px; text-align: center;">
							<button type="button" class="btn-green" onclick="javascript: modifyMasterReviewModalOpen(<%=list.getIdx()%>)">수정</button>
							<button type="button" class="btn-red" onclick="javascript: deleteMasterReview(<%=list.getIdx()%>);">삭제</button>
						</td>
					</tr>
				<%} %>
				<tr style="height: 20px;">
			</table>
		</div>
	
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>


<!-- master review add -->
<div id="master_review_add" class="modal">
	<div class="modal-wrap">
		<a href="javascript: addMasterReviewModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title"><%=master.getName() %> 마스터 후기 등록</span>
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
			<button type="button" class="btn-default" onclick="javascript: addMasterReview();">등록</button>
		</div>
	</div>
</div>

<!-- main review modify -->
<div id="master_review_modify" class="modal">
	<div class="modal-wrap">
		<a href="javascript: modifyMasterReviewModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title"><%=master.getName() %> 마스터 후기 수정</span>
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
			<button type="button" class="btn-green" onclick="javascript: modifyMasterReview();">수정</button>
		</div>
	</div>
</div>


</body>
</html>