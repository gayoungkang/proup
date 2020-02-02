<%@page import="java.text.NumberFormat"%>
<%@page import="util.CategorySearch"%>
<%@page import="model.MastersHistoryModel"%>
<%@page import="model.MastersModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	MastersModel master = (MastersModel) request.getAttribute("master");
	List<MastersHistoryModel> listHistory = (List<MastersHistoryModel>) request.getAttribute("listHistory");
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
				<button type="button" class="btn-default" onclick="javascript: addMasterHistoryModalOpen();">등록</button>
			</div>
			
			<table class="content-table" >
				<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
					<td style="width: 100px; text-align: center;">NO.</td>
					<td>마스터 이력</td>
					<td style="width: 200px; text-align: center;">등록일</td>
					<td style="width: 150px; text-align: center;">편집</td>
				</tr>
				<%for(int i=0; i<listHistory.size(); i++){
					MastersHistoryModel list = listHistory.get(i);
					%>
					<tr>
						<td style="text-align: center;">
							<%=i+1 %>
							<input type="hidden" id="history_<%=list.getIdx() %>" value="<%=list.getHistory() %>" />
						</td>
						<td><%=list.getHistory() %></td>
						<td style="text-align: center;"><%=list.getDate().substring(0, 19) %></td>
						<td style="text-align: center;">
							<button type="button" class="btn-green" onclick="javascript: modifyMasterHistoryModalOpen(<%=list.getIdx()%>)">수정</button>
							<button type="button" class="btn-red" onclick="javascript: deleteMasterHistory(<%=list.getIdx()%>);">삭제</button>
						</td>
					</tr>
				<%} %>
			</table>
		</div>
	
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>


<!-- master history add -->
<div id="master_history_add" class="modal">
	<div class="modal-wrap">
		<a href="javascript: addMasterHistoryModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title"><%=master.getName() %> 마스터 이력 등록</span>
		<div class="modal-content-wrap">
			<div class="input-wrap">
				<label class="input-label">마스터 이력</label>
				<input type="text" class="input-box" id="history" />
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-default" onclick="javascript: addMasterHistoryForDetail();">등록</button>
		</div>
	</div>
</div>

<!-- master history modify -->
<div id="master_history_modify" class="modal">
	<div class="modal-wrap">
		<a href="javascript: modifyMasterHistoryModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title"><%=master.getName() %> 마스터 이력 수정</span>
		<input type="hidden" id="mod_idx" />
		<div class="modal-content-wrap">
			<div class="input-wrap">
				<label class="input-label">마스터 이력</label>
				<input type="text" class="input-box" id="mod_history" />
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-green" onclick="javascript: modifyMasterHistoryForDetail();">수정</button>
		</div>
	</div>
</div>


</body>
</html>