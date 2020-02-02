<%@page import="java.util.Calendar"%>
<%@page import="model.ReferenceModel"%>
<%@page import="model.MastersActivityModel"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="util.CategorySearch"%>
<%@page import="model.MastersModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	MastersModel master = (MastersModel) request.getAttribute("master");
	List<ReferenceModel> listReference = (List<ReferenceModel>) request.getAttribute("listReference");
	NumberFormat nf = NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	

	Calendar cal = Calendar.getInstance();
	String curDate = String.format("%04d-%02d-%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1, cal.get(Calendar.DAY_OF_MONTH));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자</title>
<!-- jQuery -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/admin.js"></script>
<!-- calendar -->
<script src="js/jquery-ui.js"></script>
<link rel="stylesheet" href="css/jquery-ui.css">

<link rel="stylesheet" href="css/admin.css">

<script type="text/javascript">

$(function(){
	$.datepicker.regional['ko'] = {
		closeText: '닫기',
		prevText: '이전',
		nextText: '다음',
		currentText: '오늘',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true,
		changeMonth: true,
		changeYear: true,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	$("#date").datepicker();
	$("#mod_date").datepicker();
	$("#date").datepicker('setDate', '<%=curDate %>');

});


</script>

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
				<button type="button" class="btn-default" onclick="javascript: addReferenceModalOpen();">등록</button>
			</div>
			
			<table class="content-table" >
			<tr style="border-top: 1px solid #545454; border-bottom: 1px solid #ededed;">
				<td style="text-align: center; width: 80px;">NO.</td>
				<td style="text-align: center; width: 120px;">마스터</td>
				<td style="text-align: center; width: 120px;">카테고리</td>
				<td style="text-align: center; width: 80px;">평가결과</td>
				<td style="text-align: center; width: 150px;">기업명</td>
				<td style="text-align: center;">교육명</td>
				<td style="text-align: center; width: 150px;">교육대상</td>
				<td style="text-align: center; width: 80px;">교육인원</td>
				<td style="text-align: center; width: 80px;">교육시간</td>
				<td style="text-align: center; width: 80px;">숨김</td>
				<td style="text-align: center; width: 100px;">교육일</td>
				<td style="text-align: center; width: 150px;">편집</td>
			</tr>
			<%for(int i=0; i<listReference.size(); i++){
				ReferenceModel list = listReference.get(i);
				%>
				<tr>
					<td style="text-align: center;">
						<%=i+1 %>
						<input type="hidden" id="masters_idx_<%=list.getIdx()%>" value="<%=list.getMastersIdx() %>" />
						<input type="hidden" id="score_<%=list.getIdx()%>" value="<%=list.getScore() %>" />
						<input type="hidden" id="company_<%=list.getIdx()%>" value="<%=list.getCompany() %>" />
						<input type="hidden" id="education_<%=list.getIdx()%>" value="<%=list.getEducation() %>" />
						<input type="hidden" id="target_<%=list.getIdx()%>" value="<%=list.getTarget() %>" />
						<input type="hidden" id="people_<%=list.getIdx()%>" value="<%=list.getPeople() %>" />
						<input type="hidden" id="hour_<%=list.getIdx()%>" value="<%=list.getHour() %>" />
						<input type="hidden" id="hide_<%=list.getIdx()%>" value="<%=list.getHide() %>" />
						<input type="hidden" id="date_<%=list.getIdx()%>" value="<%=list.getDate().substring(0, 10) %>" />
					</td>
					<td style="text-align: center;"><%=list.getMasterName() %></td>
					<td style="text-align: center;"><%=CategorySearch.getMasterCategory(list.getCategory()) %></td>
					<td style="text-align: center;"><%=nf.format(list.getScore()) %></td>
					<td style="text-align: center;"><%=list.getCompany() %></td>
					<td style="text-align: center;"><%=list.getEducation() %></td>
					<td style="text-align: center;"><%=list.getTarget() %></td>
					<td style="text-align: center;"><%=nf.format(list.getPeople()) %></td>
					<td style="text-align: center;"><%=list.getHour() %></td>
					<%if(list.getHide() == 0){ %>
						<td style="text-align: center; background-color: #D6FFD0;">보임</td>
					<%}else{ %>
						<td style="text-align: center; background-color: #FFC6C6;">숨김</td>
					<%} %>
					<td style="text-align: center;"><%=list.getDate().substring(0, 10) %></td>
					<td style="text-align: center;">
						<button type="button" class="btn-green" onclick="javascript: modifyReferenceModalOpenForDetail(<%=list.getIdx()%>)">수정</button>
						<button type="button" class="btn-red" onclick="javascript: deleteReference(<%=list.getIdx()%>)">삭제</button>
					</td>
				</tr>
			<%} %>
		</table>
		</div>
	
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>


<!-- reference add -->
<div id="reference_add" class="modal">
	<div class="modal-wrap">
		<a href="javascript: addReferenceModalClose();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title">레퍼런스 등록</span>
		<div class="modal-content-wrap">
			
			<div class="input-wrap">
				<label class="input-label">평가결과</label>
				<input type="text" class="input-box" id="score" value="0.0" />
			</div>
			<div class="input-wrap">
				<label class="input-label">기업명</label>
				<input type="text" class="input-box" id="company" />
			</div>
			<div class="input-wrap">
				<label class="input-label">교육명</label>
				<input type="text" class="input-box" id="education" />
			</div>
			<div class="input-wrap">
				<label class="input-label">교육대상</label>
				<input type="text" class="input-box" id="target" />
			</div>
			<div class="input-wrap">
				<label class="input-label">교육인원</label>
				<input type="text" class="input-box" id="people" />
			</div>
			<div class="input-wrap">
				<label class="input-label">교육시간</label>
				<input type="text" class="input-box" id="hour" value="0" />
			</div>
			<div class="input-wrap">
				<label class="input-label">교육일자</label>
				<input type="text" class="input-box" id="date" />
			</div>
			<div class="input-wrap">
				<label class="input-label">숨김처리</label>
				<select class="input-box" id="hide">
					<option value="0">보임</option>
					<option value="1">숨김</option>
				</select>
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-default" onclick="javascript: addReferenceForDetail();">등록</button>
		</div>
	</div>
</div>

<!-- reference modify -->
<div id="reference_modify" class="modal">
	<div class="modal-wrap">
		<a href="javascript: modifyReferenceModalCloseForDetail();" class="modal-close"><img src="images/modal_close.png" /></a>
		<span class="modal-title">레퍼런스 수정</span>
		<div class="modal-content-wrap">
			<input type="hidden" id="mod_idx" />
			
			<div class="input-wrap">
				<label class="input-label">평가결과</label>
				<input type="text" class="input-box" id="mod_score" value="0.0" />
			</div>
			<div class="input-wrap">
				<label class="input-label">기업명</label>
				<input type="text" class="input-box" id="mod_company" />
			</div>
			<div class="input-wrap">
				<label class="input-label">교육명</label>
				<input type="text" class="input-box" id="mod_education" />
			</div>
			<div class="input-wrap">
				<label class="input-label">교육대상</label>
				<input type="text" class="input-box" id="mod_target" />
			</div>
			<div class="input-wrap">
				<label class="input-label">교육인원</label>
				<input type="text" class="input-box" id="mod_people" />
			</div>
			<div class="input-wrap">
				<label class="input-label">교육시간</label>
				<input type="text" class="input-box" id="mod_hour" value="0" />
			</div>
			<div class="input-wrap">
				<label class="input-label">교육일자</label>
				<input type="text" class="input-box" id="mod_date" />
			</div>
			<div class="input-wrap">
				<label class="input-label">숨김처리</label>
				<select class="input-box" id="mod_hide">
					<option value="0">보임</option>
					<option value="1">숨김</option>
				</select>
			</div>
		</div>
		<div class="modal-bottom-wrap">
			<button type="button" class="btn-green" onclick="javascript: modifyReferenceForDetail();">수정</button>
		</div>
	</div>
</div>


</body>
</html>