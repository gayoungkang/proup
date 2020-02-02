<%@page import="model.CurriculumDetailModel"%>
<%@page import="model.CurriculumModel"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="util.CategorySearch"%>
<%@page import="model.MastersModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	MastersModel master = (MastersModel) request.getAttribute("master");
	List<CurriculumModel> listCurri = (List<CurriculumModel>) request.getAttribute("listCurri");
	List<CurriculumDetailModel> listCD = (List<CurriculumDetailModel>) request.getAttribute("listCD");

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
				<button type="button" class="btn-default" onclick="javascript: addCurriculumModalOpen();">커리큘럼 등록</button>
			</div>
			
			<%for(int i=0; i<listCurri.size(); i++){
				CurriculumModel list = listCurri.get(i);
				%>
				<div class="curriculum-title-div" >
					<span class="curriculum-title">
						[커리큘럼 <%=i+1 %>] <%=list.getTitle() %>
						<input type="hidden" id="title_<%=list.getIdx() %>" value="<%=list.getTitle() %>" />
					</span>
					<button type="button" class="btn-red" style="float: right;" onclick="javascript: deleteCurriculumForDetail(<%=list.getIdx()%>)">삭제</button>
					<button type="button" class="btn-green" style="float: right; margin-right: 5px;" onclick="javascript: modifyCurriculumModalOpen(<%=list.getIdx()%>)">수정</button>
				</div>
				<div class="curriculum-content-wrap">
					<div class="curriculum-content-div" >
						<span class="curriculum-content-title" style="">특별함</span>
						<div class="curriculum-content-btn-div">
							<button type="button" class="btn-default" onclick="javascript: addCurriculumDetailModalOpen(<%=list.getIdx()%>, 1)">특별함 등록</button>
						</div>
						<div style="clear: both;"></div>
						<ul class="curriculum-content-ul">
							<%for(int j=0; j<listCD.size(); j++){
								CurriculumDetailModel detail = listCD.get(j);
								if(detail.getCurriculumIdx() == list.getIdx() && detail.getCategory() == 1){
								
								%>
								<li class="curriculum-content-li">
									<span class="curriculumn-content-1">제목</span>
									<span class="curriculumn-content-2"><%=detail.getTitle() %></span>
									<span class="curriculumn-content-3">내용</span>
									<span class="curriculumn-content-4"><%=detail.getContent() %></span>
									<div class="curriculmn-content-5">
										<input type="hidden" id="detail_title_<%=detail.getIdx() %>" value="<%=detail.getTitle() %>" />
										<input type="hidden" id="detail_content_<%=detail.getIdx() %>" value="<%=detail.getContent() %>" />
										<button type="button" class="btn-red" style="float: right;" onclick="javascript: deleteCurriculumDetail(<%=detail.getIdx()%>)">삭제</button>
										<button type="button" class="btn-green" style="float: right; margin-right: 5px;" onclick="javascript: modifyCurriculumDetailModalOpen(<%=detail.getIdx()%>, <%=detail.getCategory()%>)">수정</button>
									</div>
									<div style="clear: both;"></div>
								</li>
								<%}
							}%>
						</ul>
					</div>
					<div class="curriculum-content-div" >
						<span class="curriculum-content-title" style="">상세 커리큘럼</span>
						<div class="curriculum-content-btn-div">
							<button type="button" class="btn-default" onclick="javascript: addCurriculumDetailModalOpen(<%=list.getIdx()%>, 2)">상세 커리큘럼 등록</button>
						</div>
						<div style="clear: both;"></div>
						<ul class="curriculum-content-ul">
							<%for(int j=0; j<listCD.size(); j++){
								CurriculumDetailModel detail = listCD.get(j);
								if(detail.getCurriculumIdx() == list.getIdx() && detail.getCategory() == 2){
								
								%>
								<li class="curriculum-content-li">
									<span class="curriculumn-content-1">제목</span>
									<span class="curriculumn-content-2"><%=detail.getTitle() %></span>
									<span class="curriculumn-content-3">내용</span>
									<span class="curriculumn-content-4"><%=detail.getContent() %></span>
									<div class="curriculmn-content-5">
										<input type="hidden" id="detail_title_<%=detail.getIdx() %>" value="<%=detail.getTitle() %>" />
										<input type="hidden" id="detail_content_<%=detail.getIdx() %>" value="<%=detail.getContent() %>" />
										<button type="button" class="btn-red" style="float: right;" onclick="javascript: deleteCurriculumDetail(<%=detail.getIdx()%>)">삭제</button>
										<button type="button" class="btn-green" style="float: right; margin-right: 5px;" onclick="javascript: modifyCurriculumDetailModalOpen(<%=detail.getIdx()%>, <%=detail.getCategory()%>)">수정</button>
									</div>
									<div style="clear: both;"></div>
								</li>
								<%}
							}%>
						</ul>
					</div>
				</div>
				<div style="clear: both;"></div>
			<%} %>
			
			
		</div>
	
		<div style="width: 100%; height: 100px; clear: both;"></div>
	</div>
</div>


<!-- curriculum detail add -->
<div id="curriculum_detail_add" class="modal">
	<div class="modal-wrap">
		<a href="javascript: addCurriculumDetailModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title" id="curriculum_detail_add_title">마스터 이력 등록</span>
		<input type="hidden" id="detail_curriculum_idx" />
		<input type="hidden" id="detail_category" />
		<div class="modal-content-wrap">
			<div class="input-wrap">
				<label class="input-label">제목</label>
				<input type="text" class="input-box" id="detail_title" />
			</div>
			<div class="input-wrap">
				<label class="input-label">내용</label>
				<input type="text" class="input-box" id="detail_content" />
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-default" onclick="javascript: addCurriculumDetail();">등록</button>
		</div>
	</div>
</div>

<!-- curriculum modify modify -->
<div id="curriculum_detail_modify" class="modal">
	<div class="modal-wrap">
		<a href="javascript: modifyCurriculumDetailModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title" id="curriculum_detail_modify_title">수정</span>
		<input type="hidden" id="mod_detail_idx" />
		<div class="modal-content-wrap">
			<div class="input-wrap">
				<label class="input-label">제목</label>
				<input type="text" class="input-box" id="mod_detail_title" />
			</div>
			<div class="input-wrap">
				<label class="input-label">내용</label>
				<input type="text" class="input-box" id="mod_detail_content" />
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-green" onclick="javascript: modifyCurriculumDetail();">수정</button>
		</div>
	</div>
</div>

<!-- curriculum modify -->
<div id="curriculum_modify" class="modal">
	<div class="modal-wrap">
		<a href="javascript: modifyCurriculumModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title"><%=master.getName() %> 마스터 커리큘럼 수정</span>
		<input type="hidden" id="mod_idx" />
		<div class="modal-content-wrap">
			<div class="input-wrap">
				<label class="input-label">제목</label>
				<input type="text" class="input-box" id="mod_title" />
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-green" onclick="javascript: modifyCurriculum();">수정</button>
		</div>
	</div>
</div>

<!-- curriculum add -->
<div id="curriculum_add" class="modal">
	<div class="modal-wrap">
		<form action="admin" method="post" onsubmit="javascript:return addCurriculumSubmit()">
			<a href="javascript: addCurriculumModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
			<span class="modal-title"><%=master.getName() %> 마스터 커리큘럼 등록</span>
			<input type="hidden" name="mode" value="insert_curriculum" />
			<input type="hidden" name="masters_idx" value="<%=master.getIdx() %>" />
			<div class="modal-content-wrap" id="add_curriculum_wrap">
				<div class="input-wrap">
					<label class="input-label">제목</label>
					<input type="text" class="input-box" id="title" name="title" />
				</div>
				<div class="curri-sub-wrap">
					<input type="hidden" id="curri_size_1" name="curri_size_1" value="1" />
					<span class="curri-sub-title" >특별함</span>
					<button type="button" class="btn-default" style="float: right;" onclick="javascript: curriSubAddForDetail(1)">특별함 추가</button>
					<div style="clear: both;"></div>
					<ul class="td-ul" id="curri_ul_1">
						<li class="td-li" id="curri_li_1_1">
							<div class="td-li-wrap">
								<span class="td-span" style="width: 10%; float: left;">1.</span>
								<span class="td-span" style="width: 10%; float: left;">제목</span>
								<input class="input-default" style="width: 20%; float: left;" id="curri_title_1_1" name="curri_title_1_1" />
								<span class="td-span" style="width: 10%; float: left;">내용</span>
								<input class="input-default" style="width: 40%; float: left;" id="curri_content_1_1" name="curri_content_1_1" />
								<input type="hidden" id="curri_del_1_1" name="curri_del_1_1" value="0" />
								<button type="button" class="btn-red" style="width: 10%;" onclick="javascript: curriSubRemoveForDetail(1, 1);">삭제</button>
							</div>
						</li>
					</ul>
				</div>
				<div class="curri-sub-wrap">
					<input type="hidden" id="curri_size_2" name="curri_size_2" value="1" />
					<span class="curri-sub-title" >상세 커리큘럼</span>
					<button type="button" class="btn-default" style="float: right;" onclick="javascript: curriSubAddForDetail(2)">상세 커리큘럼 추가</button>
					<div style="clear: both;"></div>
					<ul class="td-ul" id="curri_ul_2">
						<li class="td-li" id="curri_li_2_1">
							<div class="td-li-wrap">
								<span class="td-span" style="width: 10%; float: left;">1.</span>
								<span class="td-span" style="width: 10%; float: left;">제목</span>
								<input class="input-default" style="width: 20%; float: left;" id="curri_title_2_1" name="curri_title_2_1" />
								<span class="td-span" style="width: 10%; float: left;">내용</span>
								<input class="input-default" style="width: 40%; float: left;" id="curri_content_2_1" name="curri_content_2_1" />
								<input type="hidden" id="curri_del_2_1" name="curri_del_2_1" value="0" />
								<button type="button" class="btn-red" style="width: 10%;" onclick="javascript: curriSubRemoveForDetail(2, 1);">삭제</button>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<div class="modal-bottom-wrap">
				<button type="submit" class="btn-default">등록</button>
			</div>
		</form>
	</div>
</div>

</body>
</html>