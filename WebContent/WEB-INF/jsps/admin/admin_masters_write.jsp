
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자</title>
<!-- jQuery -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/admin.js"></script>
<link rel="stylesheet" href="css/admin.css">

</head>
<body>

<jsp:include page="./admin_menu.jsp"></jsp:include>

<div class="content-wrap">
	<span class="content-title" style="margin-top: 20px;">마스터 등록</span>
	<div class="content-div">
		
		<form action="admin" method="post" onsubmit="javascript:return addMasterSubmit();">
			<input type="hidden" name="mode" value="insert_masters" />
			<table class="content-table" style="width: 1000px;">
				<tr>
					<td style="width: 200px; text-align: center;">카테고리</td>
					<td style="width: 800px;">
						<select class="input-default" name="category" >
							<option value="1">디지털 혁신</option>
							<option value="2">라이프</option>
							<option value="3">직무역량</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">썸네일</td>
					<td>
						<input type="file" id="img" name="img" class="input-default" style="padding-top: 3px;" onchange="javascript: mastersFileUpload('img');" />
						<input type="hidden" id="img_data" name="img_data" />
					</td>
				</tr>
				
				<tr>
					<td style="text-align: center;">이름</td>
					<td>
						<input type="text" id="name" name="name" class="input-default" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">슬로건</td>
					<td>
						<input type="text" id="slogan" name="slogan" class="input-default" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">태그</td>
					<td>
						<input type="text" id="tag" name="tag" class="input-default" placeholder="#직무역량 #디지털 혁신" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">이력1</td>
					<td>
						<input type="text" id="company" name="company" class="input-default" placeholder="" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">이력2</td>
					<td>
						<input type="text" id="position" name="position" class="input-default" placeholder="" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">검색 타이틀</td>
					<td>
						<input type="text" id="title" name="title" class="input-default" value="프로스쿨 기업교육 | " />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">검색 설명</td>
					<td>
						<textarea class="input-default" style="height: 50px;" id="description" name="description"></textarea>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">검색 키워드</td>
					<td>
						<textarea class="input-default" style="height: 50px;" id="keywords" name="keywords"></textarea>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">경력 및 학력</td>
					<td>
						<div class="td-wrap">
							<input type="hidden" id="history_size" name="history_size" value="1" />
							<div class="btn-wrap">
								<button type="button" class="btn-green" onclick="javascript: addMastersHistory();">경력 및 학력 추가</button>
							</div>
							<ul class="td-ul" id="history_ul">
								<li class="td-li" id="history_li_1">
									<div class="td-li-wrap">
										<span class="td-span" style="width: 10%; float: left;">1.</span>
										<input class="input-default" style="width: 80%; float: left;" id="history_1" name="history_1" />
										<input type="hidden" id="history_del_1" name="history_del_1" value="0" />
										<button type="button" class="btn-red" style="width: 10%;" onclick="javascript: removeMastersHistoryAdd(1);">삭제</button>
									</div>
								</li>
							</ul>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">주요 활동</td>
					<td>
						<div class="td-wrap">
							<input type="hidden" id="activity_size" name="activity_size" value="1" />
							<div class="btn-wrap">
								<button type="button" class="btn-green" onclick="javascript: addMastersActivity();">주요 활동 추가</button>
							</div>
							<ul class="td-ul" id="activity_ul">
								<li class="td-li" id="activity_li_1">
									<div class="td-li-wrap">
										<span class="td-span" style="width: 10%; float: left;">1.</span>
										<span class="td-span" style="width: 10%; float: left;">제목</span>
										<input class="input-default" style="width: 20%; float: left;" id="title_1" name="title_1" />
										<span class="td-span" style="width: 10%; float: left;">내용</span>
										<input class="input-default" style="width: 40%; float: left;" id="content_1" name="content_1" />
										<input type="hidden" id="activity_del_1" name="activity_del_1" value="0" />
										<button type="button" class="btn-red" style="width: 10%;" onclick="javascript: removeMastersActivityAdd(1);">삭제</button>
									</div>
								</li>
							</ul>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">커리큘럼</td>
					<td>
						<div class="td-wrap">
							<input type="hidden" id="curri_size" name="curri_size" value="1" />
							<div class="btn-wrap">
								<button type="button" class="btn-green" onclick="javascript: curriAdd()">커리큘럼 추가</button>
							</div>
							<ul class="curri-ul" id="curri_ul">
								<li class="curri-li" id="curri_li_1">
									<div class="curri-wrap" >
										<span class="td-span" style="width: 10%; float: left;">1.</span>
										<div style="width: 90%; float: right;">
											<input class="input-default" style="width: 80%; float: left;" id="curri_title_1" name="curri_title_1" />
											<input type="hidden" id="curri_del_1" name="curri_del_1" value="0" />
											<button type="button" class="btn-red" style="width: 20%;" onclick="javascript: curriRemove(1);">커리큘럼 1 삭제</button>
											
											<div class="curri-sub-wrap">
												<input type="hidden" id="curri_size_1_1" name="curri_size_1_1" value="1" />
												<span class="curri-sub-title" >특별함</span>
												<button type="button" class="btn-default" style="float: right;" onclick="javascript: curriSubAdd(1, 1)">특별함 추가</button>
												<div style="clear: both;"></div>
												<ul class="td-ul" id="curri_ul_1_1">
													<li class="td-li" id="curri_li_1_1_1">
														<div class="td-li-wrap">
															<span class="td-span" style="width: 10%; float: left;">1.</span>
															<span class="td-span" style="width: 10%; float: left;">제목</span>
															<input class="input-default" style="width: 20%; float: left;" id="curri_title_1_1_1" name="curri_title_1_1_1" />
															<span class="td-span" style="width: 10%; float: left;">내용</span>
															<input class="input-default" style="width: 40%; float: left;" id="curri_content_1_1_1" name="curri_content_1_1_1" />
															<input type="hidden" id="curri_del_1_1_1" name="curri_del_1_1_1" value="0" />
															<button type="button" class="btn-red" style="width: 10%;" onclick="javascript: curriSubRemove(1, 1, 1);">삭제</button>
														</div>
													</li>
												</ul>
											</div>
											<div class="curri-sub-wrap">
												<input type="hidden" id="curri_size_1_2" name="curri_size_1_2" value="1" />
												<span class="curri-sub-title" >상세 커리큘럼</span>
												<button type="button" class="btn-default" style="float: right;" onclick="javascript: curriSubAdd(1, 2)">상세 커리큘럼 추가</button>
												<div style="clear: both;"></div>
												<ul class="td-ul" id="curri_ul_1_2">
													<li class="td-li" id="curri_li_1_2_1">
														<div class="td-li-wrap">
															<span class="td-span" style="width: 10%; float: left;">1.</span>
															<span class="td-span" style="width: 10%; float: left;">제목</span>
															<input class="input-default" style="width: 20%; float: left;" id="curri_title_1_2_1" name="curri_title_1_2_1" />
															<span class="td-span" style="width: 10%; float: left;">내용</span>
															<input class="input-default" style="width: 40%; float: left;" id="curri_content_1_2_1" name="curri_content_1_2_1" />
															<input type="hidden" id="curri_del_1_2_1" name="curri_del_1_2_1" value="0" />
															<button type="button" class="btn-red" style="width: 10%;" onclick="javascript: curriSubRemove(1, 2, 1);">삭제</button>
														</div>
													</li>
												</ul>
											</div>
										</div>
									</div>
									<div style="clear: both;"></div>
								</li>
							</ul>
						</div>
					</td>
				</tr>
				<tr style="border: none; height: 80px;">
					<td style="text-align: center;" colspan="2">
						<button type="submit" class="btn-default">등록</button>
					</td>
				</tr>
			</table>
		</form>
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>


</body>
</html>