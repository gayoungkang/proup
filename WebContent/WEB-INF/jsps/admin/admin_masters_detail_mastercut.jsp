<%@page import="model.MastersCutModel"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="util.CategorySearch"%>
<%@page import="model.MastersModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	MastersModel master = (MastersModel) request.getAttribute("master");
	List<MastersCutModel> listMC = (List<MastersCutModel>) request.getAttribute("listMC");
	
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
				<button type="button" class="btn-default" onclick="javascript: addMasterCutModalOpen();">등록</button>
			</div>
			
			<div class="cut-wrap">
				<ul class="cut-ul">
					<%for(int i=0; i<listMC.size(); i++){
						MastersCutModel list = listMC.get(i);
						%>
						<li class="cut-li">
							<div class="cut-content-wrap">
								<input type="hidden" id="title_<%=list.getIdx() %>" value="<%=list.getTitle() %>" />
								<input type="hidden" id="content_<%=list.getIdx() %>" value="<%=list.getContent() %>" />
								<div class="cut-content-div">
									<%if(list.getCategory() == 0){ %>
										<img class="img" src="upload/master_cut/<%=list.getIdx() %>/<%=list.getContent() %>" />
									<%}else{ %>
										<iframe class="youtube" src="https://www.youtube.com/embed/<%=list.getContent() %>?rel=0"></iframe>
									<%} %>
								</div>
							</div>
							<span class="cut-title"><%=list.getTitle() %></span>
							<div class="cut-btn-wrap">
								<button type="button" class="btn-green" onclick="javascript: modifyMasterCurModalOpen(<%=list.getCategory()%>, <%=list.getIdx()%>);">수정</button>
								<button type="button" class="btn-red" onclick="javascript: deleteMastersCut(<%=list.getIdx()%>);">삭제</button>
							</div>
						</li>
					<%} %>
				</ul>
			</div>
			<div style="width: 100%; clear: both;"></div>
		</div>
	
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>


<!-- master cut add -->
<div id="master_cut_add" class="modal">
	<div class="modal-wrap">
		<a href="javascript: addMasterCutModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title"><%=master.getName() %> 마스터 컷or영상 등록</span>
		<div class="modal-content-wrap">
			<div class="input-wrap">
				<label class="input-label">구분</label>
				<select class="input-box" id="category" onchange="javascript: addMasterCutCategoryChange();">
					<option value="0">이미지</option>
					<option value="1">영상</option>
				</select>
				
			</div>
			<div class="input-wrap" id="add_image" >
				<label class="input-label">이미지</label>
				<input type="file" class="input-box" id="img" name="img" onchange="javascript: masterCutFileUpload('img');" />
				<input type="hidden" id="img_data"  />
			</div>
			<div class="input-wrap" id="add_youtube" style="display: none;">
				<label class="input-label">영상</label>
				<input type="text" class="input-box" id="youtube" placeholder="유튜브 공유 링크" onchange="javascript: masterCutYoutube();" />
			</div>
			<div class="input-wrap" style="height: auto;">
				<label class="input-label">미리보기</label>
				<div style="width: 80%; float: right; position: relative;">
					<div style="width: 100%; padding-top: 50%; position: relative; overflow: hidden;">
						<div id="add_content_div" style="width: 100%; height: 100%; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
								
						</div>
					</div>
				</div>
				
				<div style="clear: both;"></div>
			</div>
			<div class="input-wrap">
				<label class="input-label">제목</label>
				<input type="text" class="input-box" id="title" />
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-default" onclick="javascript: addMasterCut();">등록</button>
		</div>
	</div>
</div>

<!-- master cut modify image -->
<div id="master_cut_modify_0" class="modal">
	<div class="modal-wrap">
		<a href="javascript: modifyMasterCutModalClose(0);" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title"><%=master.getName() %> 마스터 컷or영상 수정</span>
		<div class="modal-content-wrap">
			<div class="input-wrap"  >
				<label class="input-label">이미지</label>
				<input type="file" class="input-box" id="mod_img" name="mod_img" onchange="javascript: masterCutFileUploadMod('mod_img');" />
				<input type="hidden" id="mod_img_data"  />
				<input type="hidden" id="mod_img_old"  />
			</div>
			<div class="input-wrap" style="height: auto;">
				<label class="input-label">미리보기</label>
				<div style="width: 80%; float: right; position: relative;">
					<div style="width: 100%; padding-top: 50%; position: relative; overflow: hidden;">
						<div id="mod_content_div_0" style="width: 100%; height: 100%; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
								
						</div>
					</div>
				</div>
				
				<div style="clear: both;"></div>
			</div>
			<div class="input-wrap">
				<label class="input-label">제목</label>
				<input type="hidden" class="input-box" id="mod_idx_0" />
				<input type="text" class="input-box" id="mod_title_0" />
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-green" onclick="javascript: modifyMasterCut(0);">수정</button>
		</div>
	</div>
</div>

<!-- master cut modify youtube -->
<div id="master_cut_modify_1" class="modal">
	<div class="modal-wrap">
		<a href="javascript: modifyMasterCutModalClose(1);" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title"><%=master.getName() %> 마스터 컷or영상 수정</span>
		<div class="modal-content-wrap">
			<div class="input-wrap">
				<label class="input-label">영상</label>
				<input type="text" class="input-box" id="mod_youtube" placeholder="유튜브 공유 링크" onchange="javascript: masterCutYoutube();" />
			</div>
			<div class="input-wrap" style="height: auto;">
				<label class="input-label">미리보기</label>
				<div style="width: 80%; float: right; position: relative;">
					<div style="width: 100%; padding-top: 50%; position: relative; overflow: hidden;">
						<div id="mod_content_div_1" style="width: 100%; height: 100%; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
								
						</div>
					</div>
				</div>
				
				<div style="clear: both;"></div>
			</div>
			<div class="input-wrap">
				<label class="input-label">제목</label>
				<input type="hidden" class="input-box" id="mod_idx_1" />
				<input type="text" class="input-box" id="mod_title_1" />
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-green" onclick="javascript: modifyMasterCut(1);">수정</button>
		</div>
	</div>
</div>

</body>
</html>