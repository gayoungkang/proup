/* login submit check */

function loginSubmit(){
	var id = document.getElementById('id').value;
	var passwd = document.getElementById('password').value;
	
	if(id == ""){
		alert("아이디를 입력하세요.");
		return;
	}
	
	if(passwd == ""){
		alert("비밀번호를 입력하세요.");
		return;
	}
}


function pwCheck(){
	var pw1 = document.getElementById('new_pw').value;
	var pw2 = document.getElementById('new_pw2').value;
	
	if(pw1 != "" && pw2 != ""){
		if(pw1 != pw2)
			document.getElementById('pw_check_td').innerHTML = "<font style='font-size:11pt; color: red;'>새 비밀번호와 확인이 일치하지 않습니다.</font>";
		else
			document.getElementById('pw_check_td').innerHTML = "<font style='font-size:11pt; color: blue;'>새 비밀번호와 확인이 일치합니다.</font>";
	}
	else
		document.getElementById('pw_check_td').innerHTML = "";
}

function onSubmitPassword(){
	var oldpw = document.getElementById('old_pw').value;
	var newpw = document.getElementById('new_pw').value;
	var newpw2 = document.getElementById('new_pw2').value;
	
	if(oldpw == ""){
		alert("현재 비밀번호를 입력하세요.");
		return false;
	}
	
	if(newpw == ""){
		alert("새 비밀번호를 입력하세요.");
		return false;
	}
	
	if(newpw2 == ""){
		alert("새 비밀번호 확인을 입력하세요.");
		return false;
	}
	
	if(newpw != newpw2){
		alert("새 비밀번호와 새 비밀번호 확인이 일치하지 않습니다.");
		return false;
	}
	
	if(confirm("비밀번호를 변경하시겠습니까?")==false)
		return false;
}


/**
 * masters section start
 */

function goMastersExcel(){
	location.href="admin?menu=admin_masters_excel";
}

// master modify
function goMasterModify(idx){
	location.href="admin?type=masters&menu=admin_masters_modify&idx="+idx;
}

// delete master
function deleteMasters(idx){
	if(confirm("해당 마스터에 대한 모든 정보가 삭제됩니다. 정말 삭제하시겠습니까?")==false)
		return false;
	
	var param = "mode=delete_master&idx="+idx;
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.href="admin?type=masters&menu=admin_masters";
		}
	});
}

// master modify check
function modifyMasterSubmit(){
	// master info check
	
	var name = $("#name").val();
	var slogan = $("#slogan").val();
	var tag = $("#tag").val();
	var company = $("#company").val();
	var position = $("#position").val();
	var title = $("#title").val();
	var description = $("#description").val();
	var keywords = $("#keywords").val();
	
	if(name == ""){
		alert("이름을 입력하세요.");
		return false;
	}
	
	if(slogan == ""){
		alert("슬로건을 입력하세요.");
		return false;
	}
	
	if(tag == ""){
		alert("태그를 입력하세요.");
		return false;
	}
	
	if(company == ""){
		alert("이력1을 입력하세요.");
		return false;
	}
	
	if(position == ""){
		alert("이력2를 입력하세요.");
		return false;
	}
	
	if(title == ""){
		alert("타이틀을 입력하세요.");
		return false;
	}
	
	if(description == ""){
		alert("설명글을 입력하세요.");
		return false;
	}
	
	if(keywords == ""){
		alert("키워드를 입력하세요.");
		return false;
	}
	
	if(confirm("이대로 수정하시겠습니까?")==false)
		return false;
}

// master submit check
function addMasterSubmit(){
	
	// master info check
	var imgData = $("#img_data").val();
	var name = $("#name").val();
	var slogan = $("#slogan").val();
	var tag = $("#tag").val();
	var company = $("#company").val();
	var position = $("#position").val();
	var title = $("#title").val();
	var description = $("#description").val();
	var keywords = $("#keywords").val();
	
	if(imgData == ""){
		alert("썸네일을 등록해주세요.");
		return false;
	}
	
	if(name == ""){
		alert("이름을 입력하세요.");
		return false;
	}
	
	if(slogan == ""){
		alert("슬로건을 입력하세요.");
		return false;
	}
	
	if(tag == ""){
		alert("태그를 입력하세요.");
		return false;
	}
	
	if(company == ""){
		alert("이력1을 입력하세요.");
		return false;
	}
	
	if(position == ""){
		alert("이력2를 입력하세요.");
		return false;
	}
	
	if(title == ""){
		alert("타이틀을 입력하세요.");
		return false;
	}
	
	if(description == ""){
		alert("설명글을 입력하세요.");
		return false;
	}
	
	if(keywords == ""){
		alert("키워드를 입력하세요.");
		return false;
	}
	
	// history check
	var historySize = Number($("#history_size").val());
	var historyCheck = false;
	for(var i=1; i<=historySize; i++){
		var historyDel = $("#history_del_"+i).val();
		if(historyDel == "0"){
			historyCheck = true;
			var historyTitle = $("#history_"+i).val();
			if(historyTitle == ""){
				alert(i+"번째 경력 및 학력을 입력하세요");
				return false;
			}
		}
	}
	
	if(historyCheck == false){
		alert("경력 및 학력을 최소 한개 이상 입력하세요.");
		return false;
	}
	
	// 주요 활동 체크
	var activitySize = Number($("#activity_size").val());
	var activityCheck = false;
	for(var i=1; i<=activitySize; i++){
		var activityDel = $("#activity_del_"+i).val();
		if(activityDel == "0"){
			activityCheck = true;
			var activityTitle = $("#title_"+i).val();
			var activityContent = $("#content_"+i).val();
			
			if(activityTitle == ""){
				alert(i+"번째 주요 활동 제목을 입력하세요.");
				return false;
			}
			
			if(activityContent == ""){
				alert(i+"번째 주요 활동 내용을 입력하세요.");
				return false;
			}
		}
	}
	
	if(activityContent == false){
		alert("주요 활동을 최소 한개 이상 입력하세요.");
		return false;
	}
	
	// curriculum check curri_size
	var curriculumSize = Number($("#curri_size").val());
	var curriculumCheck = false;
	for(var i=1; i<=curriculumSize; i++){
		var curriculumDel = $("#curri_del_"+i).val();
		if(curriculumDel == "0"){
			curriculumCheck = true;
			var curriTitle = $("#curri_title_"+i).val();
			
			if(curriTitle == ""){
				alert(i+"번 커리큘럼 제목을 입력하세요.");
				return false;
			}
			
			// curriculum special check 
			var curriSpecialSize = Number($("#curri_size_"+i+"_1").val());
			var curriSpecialCheck = false;
			for(var j=1; j<=curriSpecialSize; j++){
				var curriSubDel = $("#curri_del_"+i+"_1_"+j).val();
				if(curriSubDel == "0"){
					curriSpecialCheck = true;
					var curriSubTitle = $("#curri_title_"+i+"_1_"+j).val();
					var curriSubContent = $("#curri_content_"+i+"_1_"+j).val();
					
					if(curriSubTitle == ""){
						alert(i+"번 커리큘럼 특별함 "+j+"번째 제목을 입력하세요.");
						return false;
					}
					
					if(curriSubContent == ""){
						alert(i+"번 커리큘럼 특별함 "+j+"번째 내용을 입력하세요.");
						return false;
					}
				}
			}
			
			if(curriSpecialCheck == false){
				alert(i+"번 커리큘럼에 특별함을 최소 한개 이상 입력해주세요.");
				return false;
			}
			
			// curriculum detail check
			var curriDetailSize = Number($("#curri_size_"+i+"_2").val());
			var curriDetailCheck = false;
			for(var j=1; j<=curriDetailSize; j++){
				var curriSubDel = $("#curri_del_"+i+"_2_"+j).val();
				if(curriSubDel == "0"){
					curriSpecialCheck = true;
					var curriSubTitle = $("#curri_title_"+i+"_2_"+j).val();
					var curriSubContent = $("#curri_content_"+i+"_2_"+j).val();
					
					if(curriSubTitle == ""){
						alert(i+"번 커리큘럼 상세 커리큘럼 "+j+"번째 제목을 입력하세요.");
						return false;
					}
					
					if(curriSubContent == ""){
						alert(i+"번 커리큘럼 상세 커리큘럼 "+j+"번째 내용을 입력하세요.");
						return false;
					}
				}
			}
			
			if(curriSpecialCheck == false){
				alert(i+"번 커리큘럼에 상세 커리큘럼을 최소 한개 이상 입력해주세요.");
				return false;
			}
		}
	}
	
	if(curriculumCheck == false){
		alert("커리큘럼을 한개 이상 입력하세요.");
		return false;
	}
	
	if(confirm("이대로 등록하시겠습니까?")==false)
		return false;
	
}

// add History in add Masters
function addMastersHistory(){
	var historySize = Number($("#history_size").val());
	historySize+=1;
	$("#history_size").val(historySize);
	
	$("#history_ul").append(
			"<li class=\"td-li\" id=\"history_li_"+historySize+"\">" +
				"<div class=\"td-li-wrap\">" +
					"<span class=\"td-span\" style=\"width: 10%; float: left;\">"+historySize+".</span>" +
					"<input class=\"input-default\" style=\"width: 80%; float: left;\" id=\"history_"+historySize+"\" name=\"history_"+historySize+"\" />" +
					"<input type=\"hidden\" id=\"history_del_"+historySize+"\" name=\"history_del_"+historySize+"\" value=\"0\" />" +
					"<button type=\"button\" class=\"btn-red\" style=\"width: 10%;\" onclick=\"javascript: removeMastersHistoryAdd("+historySize+");\" >삭제</button>" +
				"</div>" +
			"</li>"
	);
}

function removeMastersHistoryAdd(idx){
	if(confirm("해당 이력사항을 삭제하시겠습니까?")==false)
		return;
	
	$("#history_del_"+idx).val("1");
	$("#history_li_"+idx).css("display", "none");
}

// add History modal open
function addMasterHistoryModalOpen(){
	$("#master_history_add").fadeIn(500);
}

// add History modal close
function addMasterHistoryModalClose(){
	$("#history").val("");
	$("#master_history_add").fadeOut(500);
}

// add history for detail page
function addMasterHistoryForDetail(){
	var mastersIdx = $("#master_index").val();
	var history = $("#history").val();
	
	if(history == ""){
		alert("마스터 이력을 입력하세요.");
		return;
	}
	
	if(confirm("마스터 이력을 등록하시겠습니까?")==false)
		return;
	
	var param = "mode=insert_master_history&masters_idx="+mastersIdx+
		"&history="+encodeURIComponent(history);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// modify history modal open
function modifyMasterHistoryModalOpen(idx){
	$("#mod_idx").val(idx);
	$("#mod_history").val($("#history_"+idx).val());
	$("#master_history_modify").fadeIn(500);
}

// modify history modal close
function modifyMasterHistoryModalClose(){
	$("#mod_idx").val("");
	$("#mod_history").val("");
	$("#master_history_modify").fadeOut(500);
}

//modify history for detail page
function modifyMasterHistoryForDetail(){
	var idx = $("#mod_idx").val();
	var history = $("#mod_history").val();
	
	if(history == ""){
		alert("마스터 이력을 입력하세요.");
		return;
	}
	
	if(confirm("마스터 이력을 수정하시겠습니까?")==false)
		return;
	
	var param = "mode=update_master_history&idx="+idx+
		"&history="+encodeURIComponent(history);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// delete history for detail page
function deleteMasterHistory(idx){
	if(confirm("마스터 이력을 정말 삭제하시겠습니까?")==false)
		return;
	
	var param = "mode=delete_master_history&idx="+idx;
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// add Activity in add Masters
function addMastersActivity(){
	var activitySize = Number($("#activity_size").val());
	activitySize+=1;
	$("#activity_size").val(activitySize);
	
	$("#activity_ul").append(
			"<li class=\"td-li\" id=\"activity_li_"+activitySize+"\">" +
				"<div class=\"td-li-wrap\">" +
					"<span class=\"td-span\" style=\"width: 10%; float: left;\">"+activitySize+".</span>" +
					"<span class=\"td-span\" style=\"width: 10%; float: left;\">제목</span>" +
					"<input class=\"input-default\" style=\"width: 20%; float: left;\" id=\"title_"+activitySize+"\" name=\"title_"+activitySize+"\" />" +
					"<span class=\"td-span\" style=\"width: 10%; float: left;\">내용</span>" +
					"<input class=\"input-default\" style=\"width: 40%; float: left;\" id=\"content_"+activitySize+"\" name=\"content_"+activitySize+"\" />" +
					"<input type=\"hidden\" id=\"activity_del_"+activitySize+"\" name=\"activity_del_"+activitySize+"\" value=\"0\" />" +
					"<button type=\"button\" class=\"btn-red\" style=\"width: 10%;\" onclick=\"javascript: removeMastersActivityAdd("+activitySize+");\">삭제</button>" +
				"</div>" +
			"</li>"
	);
}

function removeMastersActivityAdd(idx){
	if(confirm("해당 주요활동을 삭제하시겠습니까?")==false)
		return;
	
	$("#activity_del_"+idx).val("1");
	$("#activity_li_"+idx).css("display", "none");
}

// activity add modal open
function addMasterActivityModalOpen(){
	$("#master_activity_add").fadeIn(500);
}

// activity add modal open
function addMasterActivityModalClose(){
	$("#title").val("");
	$("#content").val("");
	$("#master_activity_add").fadeOut(500);
}

//activity add for detail page
function addMasterActivityForDetail(){
	var mastersIdx = $("#master_index").val();
	var title = $("#title").val();
	var content = $("#content").val();
	
	if(title == ""){
		alert("제목을 입력하세요.");
		return;
	}
	
	if(content == ""){
		alert("내용을 입력하세요.");
		return;
	}
	
	if(confirm("마스터 주요 활동을 등록하시겠습니까?")==false)
		return;
	
	var param = "mode=insert_master_activity&masters_idx="+mastersIdx+
		"&title="+encodeURIComponent(title)+
		"&content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// activity modify modal open
function modifyMasterActivityModalOpen(idx){
	$("#mod_idx").val(idx);
	$("#mod_title").val($("#title_"+idx).val());
	$("#mod_content").val($("#content_"+idx).val());
	$("#master_activity_modify").fadeIn(500);
}

//	activity modify modal close
function modifyMasterActivityModalClose(){
	$("#mod_idx").val("");
	$("#mod_title").val("");
	$("#mod_content").val("");
	$("#master_activity_modify").fadeOut(500);
}

// activity modify for detail page
function modifyMasterActivityForDetail(){
	var idx = $("#mod_idx").val();
	var title = $("#mod_title").val();
	var content = $("#mod_content").val();
	
	if(title == ""){
		alert("제목을 입력하세요.");
		return;
	}
	
	if(content == ""){
		alert("내용을 입력하세요.");
		return;
	}
	
	if(confirm("마스터 주요 활동을 수정하시겠습니까?")==false)
		return;
	
	var param = "mode=update_master_activity&idx="+idx+
		"&title="+encodeURIComponent(title)+
		"&content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// activity delete for detail page
function deleteMasterActivity(idx){
	if(confirm("마스터 주요 활동을 삭제하시겠습니까?")==false)
		return;
	
	var param = "mode=delete_master_activity&idx="+idx;
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// curriculum add in add master page

function curriAdd(){
	var curriSize = Number($("#curri_size").val());
	curriSize+=1;
	$("#curri_size").val(curriSize);
	
	$("#curri_ul").append(
			"<li class=\"curri-li\" id=\"curri_li_"+curriSize+"\">" +
				"<div class=\"curri-wrap\" >" +
					"<span class=\"td-span\" style=\"width: 10%; float: left;\">"+curriSize+".</span>" +
					"<div style=\"width: 90%; float: right;\">" +
						"<input class=\"input-default\" style=\"width: 80%; float: left;\" id=\"curri_title_"+curriSize+"\" name=\"curri_title_"+curriSize+"\" />" +
						"<input type=\"hidden\" id=\"curri_del_"+curriSize+"\" name=\"curri_del_"+curriSize+"\" value=\"0\" />" +
						"<button type=\"button\" class=\"btn-red\" style=\"width: 20%;\" onclick=\"javascript: curriRemove("+curriSize+");\">커리큘럼 "+curriSize+" 삭제</button>" +
						"<div class=\"curri-sub-wrap\">" +
							"<input type=\"hidden\" id=\"curri_size_"+curriSize+"_1\" name=\"curri_size_"+curriSize+"_1\" value=\"1\" />" +
							"<span class=\"curri-sub-title\" >특별함</span>" +
							"<button type=\"button\" class=\"btn-default\" style=\"float: right;\" onclick=\"javascript: curriSubAdd("+curriSize+", 1)\">특별함 추가</button>" +
							"<div style=\"clear: both;\"></div>" +
							"<ul class=\"td-ul\" id=\"curri_ul_"+curriSize+"_1\">" +
								"<li class=\"td-li\" id=\"curri_li_"+curriSize+"_1_1\">" +
									"<div class=\"td-li-wrap\">" +
										"<span class=\"td-span\" style=\"width: 10%; float: left;\">1.</span>" +
										"<span class=\"td-span\" style=\"width: 10%; float: left;\">제목</span>" +
										"<input class=\"input-default\" style=\"width: 20%; float: left;\" id=\"curri_title_"+curriSize+"_1_1\" name=\"curri_title_"+curriSize+"_1_1\" />" +
										"<span class=\"td-span\" style=\"width: 10%; float: left;\">내용</span> "+
										"<input class=\"input-default\" style=\"width: 40%; float: left;\" id=\"curri_content_"+curriSize+"_1_1\" name=\"curri_content_"+curriSize+"_1_1\" />" +
										"<input type=\"hidden\" id=\"curri_del_"+curriSize+"_1_1\" name=\"curri_del_"+curriSize+"_1_1\" value=\"0\" />" +
										"<button type=\"button\" class=\"btn-red\" style=\"width: 10%;\" onclick=\"javascript: curriSubRemove("+curriSize+", 1, 1);\">삭제</button>" +
									"</div>" +
								"</li>" +
							"</ul>" +
						"</div>" +
						"<div class=\"curri-sub-wrap\">" +
							"<input type=\"hidden\" id=\"curri_size_"+curriSize+"_2\" name=\"curri_size_"+curriSize+"_2\" value=\"1\" />" +
							"<span class=\"curri-sub-title\" >상세 커리큘럼</span>" +
							"<button type=\"button\" class=\"btn-default\" style=\"float: right;\" onclick=\"javascript: curriSubAdd("+curriSize+", 2)\">상세 커리큘럼 추가</button>" +
							"<div style=\"clear: both;\"></div>" +
							"<ul class=\"td-ul\" id=\"curri_ul_"+curriSize+"_2\">" +
								"<li class=\"td-li\" id=\"curri_li_"+curriSize+"_2_1\">" +
									"<div class=\"td-li-wrap\">" +
										"<span class=\"td-span\" style=\"width: 10%; float: left;\">1.</span>" +
										"<span class=\"td-span\" style=\"width: 10%; float: left;\">제목</span>" +
										"<input class=\"input-default\" style=\"width: 20%; float: left;\" id=\"curri_title_"+curriSize+"_2_1\" name=\"curri_title_"+curriSize+"_2_1\" />" +
										"<span class=\"td-span\" style=\"width: 10%; float: left;\">내용</span>" +
										"<input class=\"input-default\" style=\"width: 40%; float: left;\" id=\"curri_content_"+curriSize+"_2_1\" name=\"curri_content_"+curriSize+"_2_1\" />" +
										"<input type=\"hidden\" id=\"curri_del_"+curriSize+"_2_1\" name=\"curri_del_"+curriSize+"_2_1\" value=\"0\" />" +
										"<button type=\"button\" class=\"btn-red\" style=\"width: 10%;\" onclick=\"javascript: curriSubRemove("+curriSize+", 2, 1);\">삭제</button>" +
									"</div>" +
								"</li>" +
							"</ul>" +
						"</div>" +
					"</div>" +
				"</div>" +
				"<div style=\"clear: both;\"></div>" +
			"</li>" 
	);
}

// curriculum remove in add master page
function curriRemove(idx){
	if(confirm("해당 커리큘럼을 삭제하시겠습니까?")==false)
		return;
	
	$("#curri_del_"+idx).val("1");
	$("#curri_li_"+idx).css("display", "none");
}

// curriculum sub add in add master page
function curriSubAdd(curriSize, subType){
	// curriSubSize get
	var curriSubSize = Number($("#curri_size_"+curriSize+"_"+subType).val());
	curriSubSize+=1;
	$("#curri_size_"+curriSize+"_"+subType).val(curriSubSize);
	
	$("#curri_ul_"+curriSize+"_"+subType).append(
			"<li class=\"td-li\" id=\"curri_li_"+curriSize+"_"+subType+"_"+curriSubSize+"\">" +
				"<div class=\"td-li-wrap\">" +
					"<span class=\"td-span\" style=\"width: 10%; float: left;\">"+curriSubSize+".</span>" +
					"<span class=\"td-span\" style=\"width: 10%; float: left;\">제목</span>" +
					"<input class=\"input-default\" style=\"width: 20%; float: left;\" id=\"curri_title_"+curriSize+"_"+subType+"_"+curriSubSize+"\" name=\"curri_title_"+curriSize+"_"+subType+"_"+curriSubSize+"\" />" +
					"<span class=\"td-span\" style=\"width: 10%; float: left;\">내용</span>" +
					"<input class=\"input-default\" style=\"width: 40%; float: left;\" id=\"curri_content_"+curriSize+"_"+subType+"_"+curriSubSize+"\" name=\"curri_content_"+curriSize+"_"+subType+"_"+curriSubSize+"\" />" +
					"<input type=\"hidden\" id=\"curri_del_"+curriSize+"_"+subType+"_"+curriSubSize+"\" name=\"curri_del_"+curriSize+"_"+subType+"_"+curriSubSize+"\" value=\"0\" />" +
					"<button type=\"button\" class=\"btn-red\" style=\"width: 10%;\" onclick=\"javascript: curriSubRemove("+curriSize+", "+subType+", "+curriSubSize+");\">삭제</button>" +
				"</div>" +
			"</li>"
	);
}

// curriculum sub remove in add master page
function curriSubRemove(curriSize, subType, idx){
	var alertStr = "해당 특별함을 삭제하시겠습니까?";
	if(subType == 2)	alertStr = "해당 상세 커리큘럼을 삭제하시겠습니까?";
	if(confirm(alertStr)==false)
		return;
	
	$("#curri_del_"+curriSize+"_"+subType+"_"+idx).val("1");
	$("#curri_li_"+curriSize+"_"+subType+"_"+idx).css("display", "none");
}

// add curriculum modal open in master detail
function addCurriculumModalOpen(){
	$("#curriculum_add").fadeIn(500);
}

// add curriculum modal close in master detail
function addCurriculumModalClose(){
	$("#add_curriculum_wrap").html(
		"<div class=\"input-wrap\">"+
			"<label class=\"input-label\">제목</label>" +
			"<input type=\"text\" class=\"input-box\" id=\"title\" name=\"title\" />" +
		"</div>" +
		"<div class=\"curri-sub-wrap\">" +
			"<input type=\"hidden\" id=\"curri_size_1\" name=\"curri_size_1\" value=\"1\" />" +
			"<span class=\"curri-sub-title\" >특별함</span>" +
			"<button type=\"button\" class=\"btn-default\" style=\"float: right;\" onclick=\"javascript: curriSubAddForDetail(1)\">특별함 추가</button>" +
			"<div style=\"clear: both;\"></div>" +
			"<ul class=\"td-ul\" id=\"curri_ul_1\">" +
				"<li class=\"td-li\" id=\"curri_li_1_1\">" +
					"<div class=\"td-li-wrap\">" +
						"<span class=\"td-span\" style=\"width: 10%; float: left;\">1.</span>" +
						"<span class=\"td-span\" style=\"width: 10%; float: left;\">제목</span>" +
						"<input class=\"input-default\" style=\"width: 20%; float: left;\" id=\"curri_title_1_1\" name=\"curri_title_1_1\" />" +
						"<span class=\"td-span\" style=\"width: 10%; float: left;\">내용</span>" +
						"<input class=\"input-default\" style=\"width: 40%; float: left;\" id=\"curri_content_1_1\" name=\"curri_content_1_1\" />" +
						"<input type=\"hidden\" id=\"curri_del_1_1\" name=\"curri_del_1_1\" value=\"0\" />" +
						"<button type=\"button\" class=\"btn-red\" style=\"width: 10%;\" onclick=\"javascript: curriSubRemoveForDetail(1, 1);\">삭제</button>" +
					"</div>" +
				"</li>" +
			"</ul>" +
		"</div>" +
		"<div class=\"curri-sub-wrap\">" +
			"<input type=\"hidden\" id=\"curri_size_2\" name=\"curri_size_2\" value=\"1\" />" +
			"<span class=\"curri-sub-title\" >상세 커리큘럼</span>" +
			"<button type=\"button\" class=\"btn-default\" style=\"float: right;\" onclick=\"javascript: curriSubAddForDetail(2)\">상세 커리큘럼 추가</button>" +
			"<div style=\"clear: both;\"></div>" +
			"<ul class=\"td-ul\" id=\"curri_ul_2\">" +
				"<li class=\"td-li\" id=\"curri_li_2_1\">" +
					"<div class=\"td-li-wrap\">" +
						"<span class=\"td-span\" style=\"width: 10%; float: left;\">1.</span>" +
						"<span class=\"td-span\" style=\"width: 10%; float: left;\">제목</span>" +
						"<input class=\"input-default\" style=\"width: 20%; float: left;\" id=\"curri_title_2_1\" name=\"curri_title_2_1\" />" +
						"<span class=\"td-span\" style=\"width: 10%; float: left;\">내용</span>" +
						"<input class=\"input-default\" style=\"width: 40%; float: left;\" id=\"curri_content_2_1\" name=\"curri_content_2_1\" />" +
						"<input type=\"hidden\" id=\"curri_del_2_1\" name=\"curri_del_2_1\" value=\"0\" />" +
						"<button type=\"button\" class=\"btn-red\" style=\"width: 10%;\" onclick=\"javascript: curriSubRemoveForDetail(2, 1);\">삭제</button>" +
					"</div>" +
				"</li>" +
			"</ul>" +
		"</div>	"
	);
	$("#curriculum_add").fadeOut(500);
}

function curriSubAddForDetail(category){
	var sizeNum = Number($("#curri_size_"+category).val());
	sizeNum++;
	$("#curri_size_"+category).val(sizeNum);
	$("#curri_ul_"+category).append(
		"<li class=\"td-li\" id=\"curri_li_"+category+"_"+sizeNum+"\">" +
			"<div class=\"td-li-wrap\">" +
				"<span class=\"td-span\" style=\"width: 10%; float: left;\">"+sizeNum+".</span>" +
				"<span class=\"td-span\" style=\"width: 10%; float: left;\">제목</span>" +
				"<input class=\"input-default\" style=\"width: 20%; float: left;\" id=\"curri_title_"+category+"_"+sizeNum+"\" name=\"curri_title_"+category+"_"+sizeNum+"\" />" +
				"<span class=\"td-span\" style=\"width: 10%; float: left;\">내용</span>" +
				"<input class=\"input-default\" style=\"width: 40%; float: left;\" id=\"curri_content_"+category+"_"+sizeNum+"\" name=\"curri_content_"+category+"_"+sizeNum+"\" />" +
				"<input type=\"hidden\" id=\"curri_del_"+category+"_"+sizeNum+"\" name=\"curri_del_"+category+"_"+sizeNum+"\" value=\"0\" />" +
				"<button type=\"button\" class=\"btn-red\" style=\"width: 10%;\" onclick=\"javascript: curriSubRemoveForDetail("+category+", "+sizeNum+");\">삭제</button>" +
			"</div>" +
		"</li>"
	);
}

function curriSubRemoveForDetail(category, sizeNum){
	var confirmStr = "해당 특별함을 삭제하시겠습니까?";
	if(category == 2){
		confirmStr = "해당 상세 커리큘럼을 삭제하시겠습니까?";
	}
	
	if(confirm(confirmStr)==false)
		return;
	
	$("#curri_li_"+category+"_"+sizeNum).css("display", "none");
	$("#curri_del_"+category+"_"+sizeNum).val("1");
}

function addCurriculumSubmit(){
	var title = $("#title").val();
	if(title == ""){
		alert("제목을 입력하세요");
		return false;
	}
	
	var specialCheck = false;
	var specialSize = Number($("#curri_size_1").val());
	for(var i=1; i<=specialSize; i++){
		var del = $("#curri_del_1_"+i).val();
		if(del == "0"){
			var title = $("#curri_title_1_"+i).val();
			var content = $("#curri_content_1_"+i).val();
			
			if(title == ""){
				alert("특별함 "+i+"번 제목을 입력하세요");
				return false;
			}
			
			if(content == ""){
				alert("특별함 "+i+"번 내용을 입력하세요.");
				return false;
			}
			
			specialCheck = true;
		}
	}
	
	if(!specialCheck){
		alert("특별함을 최소 한개 이상입력하세요.");
		return false;
	}
	
	var detailCheck = false;
	var detailSize = Number($("#curri_size_2").val());
	for(var i=1; i<=detailSize; i++){
		var del = $("#curri_del_2_"+i).val();
		if(del == "0"){
			var title = $("#curri_title_2_"+i).val();
			var content = $("#curri_content_2_"+i).val();
			
			if(title == ""){
				alert("상세 커리큘럼 "+i+"번 제목을 입력하세요");
				return false;
			}
			
			if(content == ""){
				alert("상세 커리큘럼 "+i+"번 내용을 입력하세요.");
				return false;
			}
			
			detailCheck = true;
		}
	}
	
	if(!detailCheck){
		alert("상세 커리큘럼을 최소 한개 이상입력하세요.");
		return false;
	}
	
	if(confirm("커리큘럼을 등록하시겠습니까?")==false)
		return false;
}

// modify curriculum modal open in master detail
function modifyCurriculumModalOpen(idx){
	$("#mod_idx").val(idx);
	$("#mod_title").val($("#title_"+idx).val());
	
	$("#curriculum_modify").fadeIn(500);
}

//modify curriculum modal close in master detail
function modifyCurriculumModalClose(){
	$("#mod_idx").val("");
	$("#mod_title").val("");
	
	$("#curriculum_modify").fadeOut(500);
}

// modify curriculum
function modifyCurriculum(){
	var idx = $("#mod_idx").val();
	var title = $("#mod_title").val();
	
	if(title == ""){
		alert("제목을 입력하세요.");
		return;
	}
	
	if(confirm("이대로 커리큘럼을 수정하시겠습니까?")==false)
		return;
	
	var param = "mode=update_curriculum&idx="+idx+
				"&title="+encodeURIComponent(title);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// delete curriculum
function deleteCurriculumForDetail(idx){
	if(confirm("정말 커리큘럼을 삭제하시겠습니까?")==false)
		return;
	
	var param = "mode=delete_curriculum&idx="+idx;
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// add curriculum detail modal open
function addCurriculumDetailModalOpen(curriculum_idx, category){
	$("#detail_curriculum_idx").val(curriculum_idx);
	$("#detail_category").val(category);
	if(category == 1)
		$("#curriculum_detail_add_title").html("마스터 특별함 등록");
	else
		$("#curriculum_detail_add_title").html("마스터 상세 커리큘럼 등록");
	
	$("#curriculum_detail_add").fadeIn(500);
}

// add curriculum detail modal close
function addCurriculumDetailModalClose(){
	$("#detail_curriculum_idx").val("");
	$("#detail_category").val("");
	$("#detail_title").val("");
	$("#detail_content").val("");
	
	$("#curriculum_detail_add").fadeOut(500);
}

// add curriculum detail
function addCurriculumDetail(){
	var mastersIdx = $("#master_index").val();
	var curriculumIdx = $("#detail_curriculum_idx").val();
	var category = $("#detail_category").val();
	var title = $("#detail_title").val();
	var content = $("#detail_content").val();
	
	if(title == ""){
		alert("제목을 입력하세요.");
		return;
	}
	
	if(content == ""){
		alert("내용을 입력하세요.");
		return;
	}
	
	var confirmStr = "마스터 특별함을 등록하시겠습니까?";
	if(category == 2)
		confirmStr = "마스터 상세 커리큘럼을 등록하시겠습니까?";
	
	if(confirm(confirmStr)==false)
		return;
	
	var param = "mode=insert_curriculum_detail&masters_idx="+mastersIdx+
				"&curriculum_idx="+curriculumIdx+"&category="+category+
				"&title="+encodeURIComponent(title)+"&content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// modify curriculum detail modal open
function modifyCurriculumDetailModalOpen(idx, category){
	if(category == 1){
		$("#curriculum_detail_modify_title").html("마스터 특별함 수정");
	}
	else{
		$("#curriculum_detail_modify_title").html("마스터 상세 커리큘럼 수정");
	}
	
	$("#mod_detail_idx").val(idx);
	$("#mod_detail_title").val($("#detail_title_"+idx).val());
	$("#mod_detail_content").val($("#detail_content_"+idx).val());
	
	$("#curriculum_detail_modify").fadeIn(500);
}


// modify curriculum detail modal close
function modifyCurriculumDetailModalClose(){
	$("#mod_detail_idx").val("");
	$("#mod_detail_title").val("");
	$("#mod_detail_content").val("");
	
	$("#curriculum_detail_modify").fadeOut(500);
}

// modify curriculum detail
function modifyCurriculumDetail(){
	var idx = $("#mod_detail_idx").val();
	var title = $("#mod_detail_title").val();
	var content = $("#mod_detail_content").val();
	
	if(title == ""){
		alert("제목을 입력하세요.");
		return;
	}
	
	if(content == ""){
		alert("내용을 입력하세요.");
		return;
	}
	
	if(confirm("이대로 수정하시겠습니까?")==false)
		return;
	
	var param = "mode=update_curriculum_detail&idx="+idx+
		"&title="+encodeURIComponent(title)+"&content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

//delete curriculum detail
function deleteCurriculumDetail(idx){
	if(confirm("정말 삭제하시겠습니까?")==false)
		return;
	
	var param = "mode=delete_curriculum_detail&idx="+idx;
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

//masters thumbnail upload
function mastersFileUpload(type){
	if($('#'+type).val() == '') {
		alert('파일을 선택하세요.');
		return false;
	}
	
	var fileCheck = $('#'+type).val();
		fileCheck = fileCheck.slice(fileCheck.indexOf(".") + 1).toLowerCase();
	
	if(fileCheck != "jpg" && fileCheck != "png" && fileCheck != "gif" && fileCheck != "bmp" && fileCheck != "JPG" && fileCheck != "PNG" && fileCheck != "GIF" && fileCheck != "BMP" && fileCheck == ""){
		alert('이미지 파일(jpg, png, gif, bmp)만 등록 가능합니다.');
		return false;
	}
	
	var formData = new FormData();
	formData.append("file_name", $("input[name="+type+"]")[0].files[0]);
	formData.append("file_code", type);
	$.ajax({ 
		url: 'imgupload', 
		data: formData, 
		processData: false, 
		contentType: false, 
		type: 'POST', 
		success: function(data){
			$("#"+type+"_data").val(data+"/"+type+"."+fileCheck);
			
		} 
	}); 
}

// add masters
function addMasters(){
	location.href="admin?type=masters&menu=admin_masters_write";
}

// go master detail for history
function mastersDetailHistory(idx){
	location.href="admin?type=masters&menu=admin_masters_detail_history&idx="+idx;
}

// go master detail sub page
function mastersSubMenuTab(pages){
	var masterIndex = $("#master_index").val();
	if(pages == "history")			location.href="admin?type=masters&menu=admin_masters_detail_history&idx="+masterIndex;
	else if(pages == "activity")	location.href="admin?type=masters&menu=admin_masters_detail_activity&idx="+masterIndex;
	else if(pages == "curriculum")	location.href="admin?type=masters&menu=admin_masters_detail_curriculum&idx="+masterIndex;
	else if(pages == "reference")	location.href="admin?type=masters&menu=admin_masters_detail_reference&idx="+masterIndex;
	else if(pages == "review")		location.href="admin?type=masters&menu=admin_masters_detail_review&idx="+masterIndex;
	else if(pages == "mastercut")	location.href="admin?type=masters&menu=admin_masters_detail_mastercut&idx="+masterIndex;
}

// master review modal open
function addMasterReviewModalOpen(){
	$("#master_review_add").fadeIn(500);
}

//master review modal close
function addMasterReviewModalClose(){
	$("#img").val("");
	$("#img_data").val("");
	$("#img_img").attr("src", "");
	$("#name").val("");
	$("#content").val("");
	$("#master_review_add").fadeOut(500);
}


//insert master review
function addMasterReview(){
	var mastersIdx = $("#master_index").val();
	var img = $("#img_data").val();
	var name = $("#name").val();
	var content = $("#content").val();
	
	if(img == ""){
		alert("썸네일을 입력하세요.");
		return;
	}
	
	if(name == ""){
		alert("이름을 입력하세요.");
		return;
	}
	
	if(content == ""){
		alert("내용을 입력하세요.");
		return;
	}
	
	if(confirm("이대로 등록하시겠습니까?")==false)
		return;
	
	var param = "mode=insert_master_review&masters_idx="+mastersIdx +
				"&img_data="+encodeURIComponent(img)+
				"&name="+encodeURIComponent(name)+
				"&content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

//master review modify modal open
function modifyMasterReviewModalOpen(idx){
	$("#mod_idx").val(idx);
	$("#mod_img_old").val($("#img_"+idx).val());
	$("#mod_img_img").attr("src", "upload/review/"+idx+"/"+$("#img_"+idx).val());
	$("#mod_name").val($("#name_"+idx).val());
	$("#mod_content").val($("#content_"+idx).val());
	$("#master_review_modify").fadeIn(500);
}

// master review modify modal close
function modifyMasterReviewModalClose(){
	$("#master_review_modify").fadeOut(500);
}


//modify master review
function modifyMasterReview(){
	var idx = $("#mod_idx").val();
	var imgOld = $("#mod_img_old").val();
	var img = $("#mod_img_data").val();
	var name = $("#mod_name").val();
	var content = $("#mod_content").val();
	
	if(name == ""){
		alert("이름을 입력하세요.");
		return;
	}
	
	if(content == ""){
		alert("내용을 입력하세요.");
		return;
	}
	
	if(confirm("이대로 수정하시겠습니까?")==false)
		return;
	
	var param = "mode=update_master_review&idx="+idx+
				"&img_old="+encodeURIComponent(imgOld)+
				"&img_data="+encodeURIComponent(img)+
				"&name="+encodeURIComponent(name)+
				"&content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}


//delete master review
function deleteMasterReview(idx){
	if(confirm("정말 삭제하시겠습니까?")==false)
		return;
	
	var param = "mode=delete_master_review&idx="+idx;
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// mastercut modal open
function addMasterCutModalOpen(){
	$("#master_cut_add").fadeIn(500);
}

// mastercut modal close
function addMasterCutModalClose(){
	$("#master_cut_add").fadeOut(500);
}

// mastercut category change
function addMasterCutCategoryChange(){
	var category = $("#category").val();
	
	$("#add_content_div").html("");
	$("#youtube").val("");
	$("#img").val("");
	$("#img_data").val("");
	
	if(category == "0"){
		$("#add_image").css("display", "");
		$("#add_youtube").css("display", "none");
	}
	else{
		$("#add_image").css("display", "none");
		$("#add_youtube").css("display", "");
	}
}


// mastercut file upload
function masterCutFileUpload(type){
	var changeType = type;
	if(type == "mod_img")
		changeType = "img";
	
	if($('#'+type).val() == '') {
		alert('파일을 선택하세요.');
		return false;
	}
	
	 var fileCheck = $('#'+type).val();
		fileCheck = fileCheck.slice(fileCheck.indexOf(".") + 1).toLowerCase();
	
	if(fileCheck != "jpg" && fileCheck != "png" && fileCheck != "gif" && fileCheck != "bmp" && fileCheck != "JPG" && fileCheck != "PNG" && fileCheck != "GIF" && fileCheck != "BMP" && fileCheck == ""){
		alert('이미지 파일(jpg, png, gif, bmp)만 등록 가능합니다.');
		return false;
	}
	
	var formData = new FormData();
	formData.append("file_name", $("input[name="+type+"]")[0].files[0]);
	formData.append("file_code", changeType);
	$.ajax({ 
		url: 'imgupload', 
		data: formData, 
		processData: false, 
		contentType: false, 
		type: 'POST', 
		success: function(data){
			$("#"+type+"_data").val(data+"/"+changeType+"."+fileCheck);
			
			$("#add_content_div").html("<img style='width: 100%; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);' src='upload/temp/"+data+"/"+changeType+"."+fileCheck+"' />");
		} 
	}); 
}

function masterCutFileUploadMod(type){
	var changeType = type;
	if(type == "mod_img")
		changeType = "img";
	
	if($('#'+type).val() == '') {
		alert('파일을 선택하세요.');
		return false;
	}
	
	 var fileCheck = $('#'+type).val();
		fileCheck = fileCheck.slice(fileCheck.indexOf(".") + 1).toLowerCase();
	
	if(fileCheck != "jpg" && fileCheck != "png" && fileCheck != "gif" && fileCheck != "bmp" && fileCheck != "JPG" && fileCheck != "PNG" && fileCheck != "GIF" && fileCheck != "BMP" && fileCheck == ""){
		alert('이미지 파일(jpg, png, gif, bmp)만 등록 가능합니다.');
		return false;
	}
	
	var formData = new FormData();
	formData.append("file_name", $("input[name="+type+"]")[0].files[0]);
	formData.append("file_code", changeType);
	$.ajax({ 
		url: 'imgupload', 
		data: formData, 
		processData: false, 
		contentType: false, 
		type: 'POST', 
		success: function(data){
			$("#"+type+"_data").val(data+"/"+changeType+"."+fileCheck);
			
			$("#mod_content_div_0").html("<img style='width: 100%; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);' src='upload/temp/"+data+"/"+changeType+"."+fileCheck+"' />");
		} 
	});
}

function masterCutYoutube(){
	var youtubeIds = youtubeId($("#youtube").val());
	$("#add_content_div").html("<iframe style='width:100%; height:100%;' src='https://www.youtube.com/embed/"+youtubeIds+"?rel=0'></iframe>");
}

function youtubeId(url) {
    var tag = "";
    if(url)  {
        var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
        var matchs = url.match(regExp);
        if (matchs) {
            tag = matchs[7];
        }
        return tag;
    }
}

function masterCutYoutubeMod(){
	var youtubeIds = youtubeId($("#mod_youtube").val());
	$("#mod_content_div_1").html("<iframe style='width:100%; height:100%;' src='https://www.youtube.com/embed/"+youtubeIds+"?rel=0'></iframe>");
}

function modifyMasterCurModalOpen(category, idx){
	$("#mod_idx_"+category).val(idx);
	$("#mod_title_"+category).val($("#title_"+idx).val());
	if(category == 0){
		$("#mod_img_old").val($("#content_"+idx).val());
		$("#mod_content_div_0").html("<img style='width: 100%; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);' src='upload/master_cut/"+idx+"/"+$("#content_"+idx).val()+"' />");
	}
	else{
		$("#mod_youtube").val("https://youtu.be/"+$("#content_"+idx).val());
		$("#mod_content_div_1").html("<iframe style='width:100%; height:100%;' src='https://www.youtube.com/embed/"+$("#content_"+idx).val()+"?rel=0'></iframe>");
	}
	
	$("#master_cut_modify_"+category).fadeIn(500);
}

function modifyMasterCutModalClose(category){
	$("#master_cut_modify_"+category).fadeOut(500);
}

// add master cut
function addMasterCut(){
	var mastersIdx = $("#master_index").val();
	var category = $("#category").val();
	var title = $("#title").val();
	var content = "";
	
	if(category == "0"){
		var imgData = $("#img_data").val();
		if(imgData == ""){
			alert("이미지를 업로드해주세요.");
			return;
		}
		content = imgData;
	}
	else{
		var youtubeIds = youtubeId($("#youtube").val());
		if(youtubeIds == ""){
			alert("유튜브 링크를 등록해주세요.");
			return;
		}
		content = youtubeIds;
	}
	
	if(title == ""){
		alert("제목을 입력하세요.");
		return;
	}
	
	if(confirm("이대로 등록하시겠습니까?")==false)
		return;
	
	var param = "mode=insert_master_cut&masters_idx="+mastersIdx+
				"&category="+category+
				"&title="+encodeURIComponent(title)+
				"&content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

function modifyMasterCut(category){
	var idx = $("#mod_idx_"+category).val();
	var title = $("#mod_title_"+category).val();
	var content = "";
	var imgOld = "";
	
	if(category == "0"){
		content = $("#mod_img_data").val();
		var imgOld = $("#mod_img_old").val();
		
	}
	else{
		content = youtubeId($("#mod_youtube").val());
	}
	
	if(title == ""){
		alert("제목을 입력하세요.");
		return;
	}
	
	if(confirm("이대로 수정하시겠습니까?")==false)
		return;
	
	var param = "mode=update_master_cut&idx="+idx+
				"&category="+category+
				"&title="+encodeURIComponent(title)+
				"&content="+encodeURIComponent(content)+
				"&img_old="+encodeURIComponent(imgOld);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

function deleteMastersCut(idx){
	if(confirm("마스터 컷or영상을 삭제하시겠습니까?")==false)
		return;
	
	var param = "mode=delete_master_cut&idx="+idx;
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

/**
 * masters section end
 */

/**
 * reference section start
 */

function goReferenceExcel(){
	location.href="admin?menu=admin_reference_excel";
}

// add reference
function addReference(){
	var mastersIdx = $("#masters_idx").val();
	var score = $("#score").val();
	var company = $("#company").val();
	var education = $("#education").val();
	var target = $("#target").val();
	var people = $("#people").val();
	var hour = $("#hour").val();
	var hide = $("#hide").val();
	var date = $("#date").val();
	
	if(score == ""){
		alert("평과결과를 입력하세요.");
		return;
	}
	
	if(company == ""){
		alert("기업명을 입력하세요.");
		return;
	}
	
	if(education == ""){
		alert("교육명을 입력하세요.");
		return;
	}
	
	if(target == ""){
		alert("교육대상을 입력하세요.");
		return;
	}
	
	if(people == ""){
		alert("교육인원을 입력하세요.");
		return;
	}
	
	if(hour == ""){
		alert("교육시간을 입력하세요.");
		return;
	}
	
	if(date == ""){
		alert("교육 일자를 입력하세요.");
		return;
	}
	
	if(confirm("이대로 등록하시겠습니까?")==false)
		return;
	
	var param = "mode=insert_reference&masters_idx="+mastersIdx+
				"&score="+score+
				"&company="+encodeURIComponent(company)+
				"&education="+encodeURIComponent(education)+
				"&target="+encodeURIComponent(target)+
				"&people="+people+"&hour="+hour+"&hide="+hide+"&date="+encodeURIComponent(date);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}


//add reference for detail page
function addReferenceForDetail(){
	var mastersIdx = $("#master_index").val();
	var score = $("#score").val();
	var company = $("#company").val();
	var education = $("#education").val();
	var target = $("#target").val();
	var people = $("#people").val();
	var hour = $("#hour").val();
	var hide = $("#hide").val();
	var date = $("#date").val();
	
	if(score == ""){
		alert("평과결과를 입력하세요.");
		return;
	}
	
	if(company == ""){
		alert("기업명을 입력하세요.");
		return;
	}
	
	if(education == ""){
		alert("교육명을 입력하세요.");
		return;
	}
	
	if(target == ""){
		alert("교육대상을 입력하세요.");
		return;
	}
	
	if(people == ""){
		alert("교육인원을 입력하세요.");
		return;
	}
	
	if(hour == ""){
		alert("교육시간을 입력하세요.");
		return;
	}
	
	if(date == ""){
		alert("교육일자를 입력하세요.");
		return;
	}
	
	if(confirm("이대로 등록하시겠습니까?")==false)
		return;
	
	var param = "mode=insert_reference&masters_idx="+mastersIdx+
				"&score="+score+
				"&company="+encodeURIComponent(company)+
				"&education="+encodeURIComponent(education)+
				"&target="+encodeURIComponent(target)+
				"&people="+people+"&hour="+hour+"&hide="+hide+"&date="+encodeURIComponent(date);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}


//add reference
function modifyReference(){
	var idx = $("#mod_idx").val();
	var mastersIdx = $("#mod_masters_idx").val();
	var score = $("#mod_score").val();
	var company = $("#mod_company").val();
	var education = $("#mod_education").val();
	var target = $("#mod_target").val();
	var people = $("#mod_people").val();
	var hour = $("#mod_hour").val();
	var hide = $("#mod_hide").val();
	var date = $("#mod_date").val();
	
	if(score == ""){
		alert("평과결과를 입력하세요.");
		return;
	}
	
	if(company == ""){
		alert("기업명을 입력하세요.");
		return;
	}
	
	if(education == ""){
		alert("교육명을 입력하세요.");
		return;
	}
	
	if(target == ""){
		alert("교육대상을 입력하세요.");
		return;
	}
	
	if(people == ""){
		alert("교육인원을 입력하세요.");
		return;
	}
	
	if(hour == ""){
		alert("교육시간을 입력하세요.");
		return;
	}
	
	if(date == ""){
		alert("교육 일자를 입력하세요.");
		return;
	}
	
	if(confirm("이대로 수정하시겠습니까?")==false)
		return;
	
	var param = "mode=update_reference&idx="+idx+"&masters_idx="+mastersIdx+
				"&score="+score+
				"&company="+encodeURIComponent(company)+
				"&education="+encodeURIComponent(education)+
				"&target="+encodeURIComponent(target)+
				"&people="+people+"&hour="+hour+"&hide="+hide+"&date="+encodeURIComponent(date);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}


//modify reference for detail
function modifyReferenceForDetail(){
	var idx = $("#mod_idx").val();
	var mastersIdx = $("#master_index").val();
	var score = $("#mod_score").val();
	var company = $("#mod_company").val();
	var education = $("#mod_education").val();
	var target = $("#mod_target").val();
	var people = $("#mod_people").val();
	var hour = $("#mod_hour").val();
	var hide = $("#mod_hide").val();
	var date = $("#mod_date").val();
	
	if(score == ""){
		alert("평과결과를 입력하세요.");
		return;
	}
	
	if(company == ""){
		alert("기업명을 입력하세요.");
		return;
	}
	
	if(education == ""){
		alert("교육명을 입력하세요.");
		return;
	}
	
	if(target == ""){
		alert("교육대상을 입력하세요.");
		return;
	}
	
	if(people == ""){
		alert("교육인원을 입력하세요.");
		return;
	}
	
	if(hour == ""){
		alert("교육시간을 입력하세요.");
		return;
	}
	
	if(date == ""){
		alert("교육일자를 입력하세요.");
		return;
	}
	
	if(confirm("이대로 수정하시겠습니까?")==false)
		return;
	
	var param = "mode=update_reference&idx="+idx+"&masters_idx="+mastersIdx+
				"&score="+score+
				"&company="+encodeURIComponent(company)+
				"&education="+encodeURIComponent(education)+
				"&target="+encodeURIComponent(target)+
				"&people="+people+"&hour="+hour+"&hide="+hide+"&date="+encodeURIComponent(date);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// delete reference
function deleteReference(idx){
	if(confirm("정말 삭제하시겠습니까?")==false)
		return;
	
	var param = "mode=delete_reference&idx="+idx;
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// add reference modal open 
function addReferenceModalOpen(){
	$("#reference_add").fadeIn(500);
}

// add reference modal close
function addReferenceModalClose(){
	$("#masters_idx option:eq(0)").prop("selected", true);
	$("#score").val("0.0");
	$("#company").val("");
	$("#education").val("");
	$("#target").val("");
	$("#people").val("");
	$("#hour").val("0");
	$("#hide option:eq(0)").prop("selected", true);
	$("#reference_add").fadeOut(500);
}

// modify reference modal open
function modifyReferenceModalOpen(idx){
	$("#mod_idx").val(idx);
	$("#mod_masters_idx").val($("#masters_idx_"+idx).val()).prop("selected", true);
	$("#mod_score").val($("#score_"+idx).val());
	$("#mod_company").val($("#company_"+idx).val());
	$("#mod_education").val($("#education_"+idx).val());
	$("#mod_target").val($("#target_"+idx).val());
	$("#mod_people").val($("#people_"+idx).val());
	$("#mod_hour").val($("#hour_"+idx).val());
	$("#mod_hide").val($("#hide_"+idx).val()).prop("selected", true);
	$("#mod_date").val($("#date_"+idx).val());
	
	$("#reference_modify").fadeIn(500);
}

//modify reference modal open for detail
function modifyReferenceModalOpenForDetail(idx){
	$("#mod_idx").val(idx);
	$("#mod_score").val($("#score_"+idx).val());
	$("#mod_company").val($("#company_"+idx).val());
	$("#mod_education").val($("#education_"+idx).val());
	$("#mod_target").val($("#target_"+idx).val());
	$("#mod_people").val($("#people_"+idx).val());
	$("#mod_hour").val($("#hour_"+idx).val());
	$("#mod_hide").val($("#hide_"+idx).val()).prop("selected", true);
	$("#mod_date").val($("#date_"+idx).val());
	
	$("#reference_modify").fadeIn(500);
}

// modify reference modal close
function modifyReferenceModalClose(){
	$("#mod_idx").val("");
	$("#mod_masters_idx option:eq(0)").prop("selected", true);
	$("#mod_score").val("");
	$("#mod_company").val("");
	$("#mod_education").val("");
	$("#mod_target").val("");
	$("#mod_people").val("");
	$("#mod_hour").val("");
	$("#mod_hide option:eq(0)").prop("selected", true);
	
	$("#reference_modify").fadeOut(500);
}

//modify reference modal close for detail
function modifyReferenceModalCloseForDetail(){
	$("#mod_idx").val("");
	$("#mod_score").val("");
	$("#mod_company").val("");
	$("#mod_education").val("");
	$("#mod_target").val("");
	$("#mod_people").val("");
	$("#mod_hour").val("");
	$("#mod_hide option:eq(0)").prop("selected", true);
	
	$("#reference_modify").fadeOut(500);
}

// search reference
function referenceSearch(){
	var searchType = $("#searchType").val();
	var searchText = $("#searchText").val();
	location.href="admin?type=reference&menu=admin_reference&searchText="+encodeURIComponent(searchText)+"&searchType="+encodeURIComponent(searchType);
}

//reference input keyup
function onReferenceSearch(){
	if (event.keyCode == 13) {
		referenceSearch();
	}
}

/**
 * reference section end
 */

/**
 * news section start
 */

// news add page
function addNews(){
	location.href="admin?type=news&menu=admin_news_write";
}

// news add for reserve
function newsAddReserve(){
	var reserve = $("#reservation").val();
	if(reserve == 0){
		$("#date_tr").css("display", "none");
	}
	else{
		$("#date_tr").css("display", "");
	}
}

// news thumbnail upload
function newsFileUpload(type){
	if($('#'+type).val() == '') {
		alert('파일을 선택하세요.');
		return false;
	}
	
	var fileCheck = $('#'+type).val();
		fileCheck = fileCheck.slice(fileCheck.indexOf(".") + 1).toLowerCase();
	
	if(fileCheck != "jpg" && fileCheck != "png" && fileCheck != "gif" && fileCheck != "bmp" && fileCheck != "JPG" && fileCheck != "PNG" && fileCheck != "GIF" && fileCheck != "BMP" && fileCheck == ""){
		alert('이미지 파일(jpg, png, gif, bmp)만 등록 가능합니다.');
		return false;
	}
	
	var formData = new FormData();
	formData.append("file_name", $("input[name="+type+"]")[0].files[0]);
	formData.append("file_code", type);
	$.ajax({ 
		url: 'imgupload', 
		data: formData, 
		processData: false, 
		contentType: false, 
		type: 'POST', 
		success: function(data){
			$("#"+type+"_data").val(data+"/"+type+"."+fileCheck);
			
		} 
	}); 
}

// news add submit
function addNewsSubmit(){
	var thumbnailData = $("#thumbnail_data").val();
	var title = $("#title").val();
	var content = $("#content").val();
	var reservation = $("#reservation").val();
	
	if(thumbnailData == ""){
		alert("썸네일을 등록해주세요.");
		return false;
	}
	
	if(title == ""){
		alert("제목을 입력하세요.");
		return false;
	}
	
	if(content == ""){
		alert("내용을 입력하세요.");
		return false;
	}
	
	if(reservation == 1){
		if($("#view_date").val() == ""){
			alert("리스팅 일자를 입력하세요.");
			return false;
		}
	}
	
	if(confirm("이대로 등록하시겠습니까?")==false)
		return false;
	
}

//news modify submit
function modifyNewsSubmit(){
	var title = $("#title").val();
	var content = $("#content").val();
	var reservation = $("#reservation").val();
	
	if(title == ""){
		alert("제목을 입력하세요.");
		return false;
	}
	
	if(content == ""){
		alert("내용을 입력하세요.");
		return false;
	}
	
	if(reservation == 1){
		if($("#view_date").val() == ""){
			alert("리스팅 일자를 입력하세요.");
			return false;
		}
	}
	
	if(confirm("이대로 수정하시겠습니까?")==false)
		return false;
	
}

// news input keyup
function onNewsSearch(){
	if (event.keyCode == 13) {
		newsSearch();
	}
}

// news search
function newsSearch(){
	var searchText = $("#searchText").val();
	var searchType = $("#searchType").val();
	
	location.href="admin?type=news&menu=admin_news_list"+
					"&searchType="+encodeURIComponent(searchType)+
					"&searchText="+encodeURIComponent(searchText); 
}

// news detail
function newsDetail(idx){
	location.href="admin?type=news&menu=admin_news_detail&idx="+idx;
}

// news modify
function goNewsModify(idx){
	location.href="admin?type=news&menu=admin_news_modify&idx="+idx;
}

// news rolling fix
function newsRollingFix(idx, rollSize){
	if(rollSize<5){
		if(confirm("해당 뉴스를 상단 롤링 고정하시겠습니까?")==false)
			return;
		
		var param = "mode=update_news_rolling&idx="+idx+"&top=1";
		
		$.ajax({
			type: "POST",
			url: 'admin',
			data: param,
			error: ajaxFailed,
			success: function(ret) {
				location.reload();
			}
		});
	}
	else{
		alert("상단 롤링 고정은 5개 이상 불가능합니다.");
		return;
	}
}

//news rolling cancel
function newsRollingCancel(idx){
	if(confirm("상단 롤링 고정을 취소하시겠습니까?")==false)
		return;
	
	var param = "mode=update_news_rolling&idx="+idx+"&top=0";
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// news delete
function deleteNews(idx){
	if(confirm("뉴스를 정말 삭제하시겠습니까?")==false)
		return;
	
	var param = "mode=delete_news&idx="+idx;
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.href="admin?type=news&menu=admin_news_list";
		}
	});
}

/**
 * news section end
 */

/**
 * main review start
 */

// main review add img
function mainReviewFileUpload(type){
	var changeType = type;
	if(type == "mod_img")
		changeType = "img";
	
	if($('#'+type).val() == '') {
		alert('파일을 선택하세요.');
		return false;
	}
	
	 var fileCheck = $('#'+type).val();
		fileCheck = fileCheck.slice(fileCheck.indexOf(".") + 1).toLowerCase();
	
	if(fileCheck != "jpg" && fileCheck != "png" && fileCheck != "gif" && fileCheck != "bmp" && fileCheck != "JPG" && fileCheck != "PNG" && fileCheck != "GIF" && fileCheck != "BMP" && fileCheck == ""){
		alert('이미지 파일(jpg, png, gif, bmp)만 등록 가능합니다.');
		return false;
	}
	
	var formData = new FormData();
	formData.append("file_name", $("input[name="+type+"]")[0].files[0]);
	formData.append("file_code", changeType);
	$.ajax({ 
		url: 'imgupload', 
		data: formData, 
		processData: false, 
		contentType: false, 
		type: 'POST', 
		success: function(data){
			$("#"+type+"_data").val(data+"/"+changeType+"."+fileCheck);
			$("#"+type+"_img").attr("src", "upload/temp/"+data+"/"+changeType+"."+fileCheck);	
		} 
	}); 
}

// insert main review
function addMainReview(){
	var img = $("#img_data").val();
	var name = $("#name").val();
	var content = $("#content").val();
	
	if(confirm("이대로 등록하시겠습니까?")==false)
		return;
	
	var param = "mode=insert_main_review&img_data="+encodeURIComponent(img)+
				"&name="+encodeURIComponent(name)+
				"&content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

//modify main review
function modifyMainReview(){
	var idx = $("#mod_idx").val();
	var imgOld = $("#mod_img_old").val();
	var img = $("#mod_img_data").val();
	var name = $("#mod_name").val();
	var content = $("#mod_content").val();
	
	if(confirm("이대로 수정하시겠습니까?")==false)
		return;
	
	var param = "mode=update_main_review&idx="+idx+
				"&img_old="+encodeURIComponent(imgOld)+
				"&img_data="+encodeURIComponent(img)+
				"&name="+encodeURIComponent(name)+
				"&content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// delete main review
function deleteMainReview(idx){
	if(confirm("정말 삭제하시겠습니까?")==false)
		return;
	
	var param = "mode=delete_main_review&idx="+idx;
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// main review modal open
function addMainReviewModalOpen(){
	$("#main_review_add").fadeIn(500);
}

// main review modal close
function addMainReviewModalClose(){
	$("#img").val("");
	$("#img_data").val("");
	$("#img_img").attr("src", "");
	$("#name").val("");
	$("#content").val("");
	$("#main_review_add").fadeOut(500);
}

// main review modify modal open
function modifyMainReviewModalOpen(idx){
	$("#mod_idx").val(idx);
	$("#mod_img_old").val($("#img_"+idx).val());
	$("#mod_img_img").attr("src", "upload/main_review/"+idx+"/"+$("#img_"+idx).val());
	$("#mod_name").val($("#name_"+idx).val());
	$("#mod_content").val($("#content_"+idx).val());
	$("#main_review_modify").fadeIn(500);
}

// main review modify modal close
function modifyMainReviewModalClose(){
	$("#main_review_modify").fadeOut(500);
}

// main review search
function mainReviewSearch(){
	var searchText = $("#searchText").val();
	var searchType = $("#searchType").val();
	
	location.href="admin?type=main_review&menu=admin_main_review&searchType="+encodeURIComponent(searchType)+
					"&searchText="+encodeURIComponent(searchText);
}

//news input keyup
function onMainReviewSearch(){
	if (event.keyCode == 13) {
		mainReviewSearch();
	}
}


/**
 * main review end
 */

/**
 * search section start
 */

//tab click on search sub menu 
function searchSubMenuTab(menu){
	// search -> main
	if(menu == "main")				location. href="admin?type=search&menu=admin_search_main";
	// search -> references
	else if(menu == "references")	location. href="admin?type=search&menu=admin_search_references";
	// search -> masters
	else if(menu == "masters")		location. href="admin?type=search&menu=admin_search_masters";
	// search -> news
	else if(menu == "news")			location. href="admin?type=search&menu=admin_search_news";
}

// search submit check
function searchSubmit(){
	var title = $("#title").val();
	var description = $("#description").val();
	var keywords = $("#keywords").val();
	
	if(title == ""){
		alert("타이틀을 입력하세요.");
		return false;
	}
	
	if(description == ""){
		alert("설명을 입력하세요.");
		return false;
	}
	
	if(keywords == ""){
		alert("키워드를 입력하세요.");
		return false;
	}
	
	if(confirm("이대로 적용하시겠습니까?")==false)
		return false;
}

/**
 * search section end
 */

/**
 * setup section start
 */

//setup file upload
function setupFileUpload(type){
	if($('#'+type).val() == '') {
		alert('파일을 선택하세요.');
		return false;
	}
	
	 var fileCheck = $('#'+type).val();
		fileCheck = fileCheck.slice(fileCheck.indexOf(".") + 1).toLowerCase();
	
	if(type == "pdf"){
		if(fileCheck != "pdf" && fileCheck != "PDF"){
			alert('pdf 파일만 등록 가능합니다.');
			return false;
		}
	}
	else{
		if(fileCheck != "jpg" && fileCheck != "png" && fileCheck != "gif" && fileCheck != "bmp" && fileCheck != "JPG" && fileCheck != "PNG" && fileCheck != "GIF" && fileCheck != "BMP" && fileCheck == ""){
			alert('이미지 파일(jpg, png, gif, bmp)만 등록 가능합니다.');
			return false;
		}
	}
	
	var formData = new FormData();
	formData.append("file_name", $("input[name="+type+"]")[0].files[0]);
	formData.append("file_code", type);
	$.ajax({ 
		url: 'imgupload', 
		data: formData, 
		processData: false, 
		contentType: false, 
		type: 'POST', 
		success: function(data){
			$("#"+type+"_data").val(data+"/"+type+"."+fileCheck);
			
			if(type == "pdf"){
				$("#"+type+"_a").attr("href", "upload/temp/"+data+"/"+type+"."+fileCheck);
			}
			else{
				$("#"+type+"_img").attr("src", "upload/temp/"+data+"/"+type+"."+fileCheck);	
			}
		} 
	}); 
}

// setup submit check
function setupSubmit(){
	var contact = $("#contact").val();
	var email = $("#email").val();
	var color = $("#color").val();
	
	if(contact == ""){
		alert("연락처를 입력하세요.");
		return false;
	}
	
	if(email == ""){
		alert("이메일을 입력하세요.");
		return false;
	}
	
	if(color == ""){
		alert("헤더 컬러를 입력하세요.");
		return false;
	}
	
	if(confirm("이대로 적용하시겠습니까?")==false)
		return false;
}


//popup submit check
function popupSubmit(){
	var link = $("#link").val();
	if(link == ""){
		alert("링크를 입력하세요.");
		return false;
	}
	
	if(confirm("이대로 적용하시겠습니까?")==false)
		return false;
}



// tab click on setup sub menu 
function setupSubMenuTab(menu){
	// setup -> centent
	if(menu == "content")		location. href="admin?type=setup&menu=admin_setup_content";
	// setup -> family site
	else if(menu == "site")		location. href="admin?type=setup&menu=admin_setup_site";
	// setup -> family site
	else if(menu == "information")		location. href="admin?type=setup&menu=admin_setup_information";
	// setup -> password
	else if(menu == "password")	location. href="admin?type=setup&menu=admin_setup_password";
	// setup -> popup
	else if(menu == "popup")	location. href="admin?type=setup&menu=admin_setup_popup";
}

function setupInformationSubmit(){
	if(confirm("이대로 적용하시겠습니까?")==false)
		return false;
}

// up sort family site
function upSortFamilySite(idx, sort){
	
	var param = "mode=update_family_site_up_sort&idx="+idx+"&sort="+sort;
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// down sort family site
function downSortFamilySite(idx, sort){
	var param = "mode=update_family_site_down_sort&idx="+idx+"&sort="+sort;
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// family site add modal open
function addFamilySiteModalOpen(){
	$("#site_add").fadeIn(500);
}

// family site add modal close
function addFamilySiteModalClose(){
	$("#name").val("");
	$("#link").val("");
	$("#site_add").fadeOut(500);
}

// family site add
function addFamilySite(){
	var name = $("#name").val();
	var link = $("#link").val();
	
	if(name == ""){
		alert("사이트명을 입력하세요.");
		return;
	}
	
	if(link == ""){
		alert("사이트 링크를 입력하세요.");
		return;
	}
	
	if(confirm("패밀리 사이트를 등록하시겠습니까?")==false){
		return;
	}
	
	var param = "mode=insert_family_site&name="+encodeURIComponent(name)+
				"&link="+encodeURIComponent(link);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

//family site modify modal open
function modifyFamilySiteModalOpen(idx){
	$("#mod_idx").val($("#idx_"+idx).val());
	$("#mod_name").val($("#name_"+idx).val());
	$("#mod_link").val($("#link_"+idx).val());
	$("#site_modify").fadeIn(500);
}

// family site modify modal close
function modifyFamilySiteModalClose(){
	$("#mod_idx").val("");
	$("#mod_name").val("");
	$("#mod_link").val("");
	$("#site_modify").fadeOut(500);
}

// family site add
function modifyFamilySite(){
	var idx = $("#mod_idx").val();
	var name = $("#mod_name").val();
	var link = $("#mod_link").val();
	
	if(name == ""){
		alert("사이트명을 입력하세요.");
		return;
	}
	
	if(link == ""){
		alert("사이트 링크를 입력하세요.");
		return;
	}
	
	if(confirm("패밀리 사이트를 수정하시겠습니까?")==false){
		return;
	}
	
	var param = "mode=update_family_site&idx="+idx
				+"&name="+encodeURIComponent(name)+
				"&link="+encodeURIComponent(link);
	
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// family site delete
function deleteFamilySite(idx){
	if(confirm("해당 패밀리 사이트를 삭제하시겠습니까?")==false){
		return;
	}
	
	var param = "mode=delete_family_site&idx="+idx;
				
	$.ajax({
		type: "POST",
		url: 'admin',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

/**
 * setup section end
 */

function onContactSearch(){
	if (event.keyCode == 13) {
		contactSearch();
	}
}

function contactSearch(){
	var searchText = document.getElementById('searchText').value;
	location.href="admin?type=contact&menu=admin_contact&searchText="+encodeURIComponent(searchText);
}

function onRecSearch(){
	if (event.keyCode == 13) {
		recSearch();
	}
}

function recSearch(){
	var searchText = document.getElementById('searchText').value;
	location.href="admin?type=recommand&menu=admin_recommand&searchText="+encodeURIComponent(searchText);
}

function onSubsSearch(){
	if (event.keyCode == 13) {
		subsSearch();
	}
}

function subsSearch(){
	var searchText = document.getElementById('searchText').value;
	location.href="admin?type=stibee&menu=admin_stibee&searchText="+encodeURIComponent(searchText);
}

function goStibeeExcel(){
	location.href="admin?menu=admin_stibee_excel";
}

function goRecommandExcel(){
	location.href="admin?menu=admin_recommand_excel";
}

function goContactExcel(){
	location.href="admin?menu=admin_contact_excel";
}


function onApplySearch(){
	if (event.keyCode == 13) {
		applySearch();
	}
}

function applySearch(){
	var searchText = document.getElementById('searchText').value;
	location.href="admin?type=apply&menu=admin_apply&searchText="+encodeURIComponent(searchText);
}

function goApplyExcel(){
	location.href="admin?menu=admin_apply_excel";
}

// ajax Failed alert
function ajaxFailed(xmlRequest){
	alert(xmlRequest.status+"\n\r"+xmlRequest.statusText+"\n\r"+xmlRequest.responseText);
}