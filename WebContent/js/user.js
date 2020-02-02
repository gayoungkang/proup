

function searchNews(){
	var searchType = $("#searchType").val();
	var searchText = $("#searchText").val();
	
	location.href="news?view=news&searchType="+encodeURIComponent(searchType)+"&searchText="+encodeURIComponent(searchText);
}

function onSearchNewsKeyup(){
	if (event.keyCode == 13) {
		searchNews();
	}
}

var newsPageNum = 1;

//family site delete
function moreNews(){
	newsPageNum++;
	var searchType = $("#searchType").val();
	var searchText = $("#searchText").val();
	
	var param = "mode=select_news_list&pageNum="+newsPageNum+"&searchText="+encodeURIComponent(searchText)+"&searchType="+encodeURIComponent(searchType);

	$.ajax({
		type: "POST",
		url: "news",
		data: param,
		dataType: 'text',
		success: function(ret){
		
			var obj = JSON.parse(ret);
			for(var i=0; i<obj.length; i++){
				
				$("#news_list").append(
					"<li class=\"clearfix\">" +
	                    "<div class=\"img-wrap\">" +
	                        "<div class=\"img\" style=\"background-image: url('upload/news/"+obj[i].idx+"/"+obj[i].thumbnail+"');\"></div>" +
	                    "</div>" +
	                    "<div class=\"text-wrap clearfix\">" +
	                        "<div class=\"text\">" +
	                            "<h3>"+obj[i].title+"</h3>" +
	                            "<p class=\"date\">"+obj[i].date+"</p>" +
	                            "<p class=\"sub-text\">" +
	                            	obj[i].content +
	                            "</p>" +
	                        "</div>" +
	                        "<div class=\"more-btn\">" +
	                            "<a href=\"news?view=news&menu=news_detail&idx="+obj[i].idx+"\">MORE</a>" +
	                        "</div>" +
	                    "</div>" +
	                "</li>"
				);
			}
		}
	});	
}


// contact agree
function contactAgree(){
	$("#termscheck").prop("checked", true);
	window.open("information");
}

// contact submit
function contactSubmit(){
	var name = $("#contact_name").val();
	var company = $("#contact_company").val();
	var email = $("#contact_email").val();
	var contact = $("#contact_contact").val();
	var target = $("#contact_target").val();
	var content = $("#contact_content").val();
	
	if(name == ""){
		alert("성명을 입력하세요");
		return;
	}
	
	if(company == ""){
		alert("회사명을 입력하세요");
		return;
	}
	
	if(email == ""){
		alert("이메일을 입력하세요");
		return;
	}
	
	if(contact == ""){
		alert("연락처를 입력하세요");
		return;
	}
	
	if(target == ""){
		alert("교육대상자를 입력하세요");
		return;
	}
	
	if(content == ""){
		alert("문의내용을 입력하세요");
		return;
	}
	
	if($("input:checkbox[id='termscheck']").is(":checked") == false){
		alert("개인정보 및 이용약관에 동의해주세요.");
		return;
	}
	
	if(confirm("이대로 문의하시겠습니까?")==false)
		return;
	
	var param = "mode=contact&name="+encodeURIComponent(name)+
				"&company="+encodeURIComponent(company)+
				"&email="+encodeURIComponent(email)+
				"&contact="+encodeURIComponent(contact)+
				"&target="+encodeURIComponent(target)+
				"&content="+encodeURIComponent(content);
	
	$.ajax({
		type: "POST",
		url: 'main',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			location.reload();
		}
	});
}

// reference search
function referenceSearch(searchType){
	var orderBy = $("#orderBy").val();
	
	location.href="references?view=references&searchType="+encodeURIComponent(searchType)+"&orderBy="+encodeURIComponent(orderBy);
}

//reference search for masters
function referenceSearchForMasters(searchType, mastersIdx){
	var orderBy = $("#orderBy").val();
	
	location.href="references?view=references&menu=references_masters&masters_idx="+mastersIdx+"&searchType="+encodeURIComponent(searchType)+"&orderBy="+encodeURIComponent(orderBy);
}


// reference search for order by
function referenceSearchOrder(){
	var searchType = $("#searchType").val();
	var orderBy = $("#orderBy").val();
	if(orderBy == "ASC")
		orderBy = "DESC";
	else
		orderBy = "ASC";
	
	location.href="references?view=references&searchType="+encodeURIComponent(searchType)+"&orderBy="+encodeURIComponent(orderBy);
}

//reference search for order by for masters
function referenceSearchOrderForMasters(mastersIdx){
	var searchType = $("#searchType").val();
	var orderBy = $("#orderBy").val();
	if(orderBy == "ASC")
		orderBy = "DESC";
	else
		orderBy = "ASC";
	
	location.href="references?view=references&menu=references_masters&masters_idx="+mastersIdx+"&searchType="+encodeURIComponent(searchType)+"&orderBy="+encodeURIComponent(orderBy);
}


// 마스터 페이지 카테고리 클릭
function goMastersCategory(category){
	location.href="masters?view=masters&searchType="+encodeURIComponent(category);
}

// 마스터 더보기 클릭
var mastersPageNum = 1;

//masters more btn
function moreMasters(){
	mastersPageNum++;
	var searchType = $("#searchType").val();
	
	var param = "mode=select_masters_list&pageNum="+mastersPageNum+"&searchType="+encodeURIComponent(searchType);

	$.ajax({
		type: "POST",
		url: "masters",
		data: param,
		dataType: 'text',
		success: function(ret){
		
			var obj = JSON.parse(ret);
			for(var i=0; i<obj.length; i++){
				
				var historyStr = "";
				for(var j=0; j<obj[i].history.length; j++){
					historyStr += "<li>ㆍ "+obj[i].history[j]+"</li>";
				}
				
				$("#masters_list").append(
					
	                "<li class=\"clearfix\">" +
	                    "<div class=\"img-wrap\">" +
	                        "<div class=\"img\" style=\"background-image: url('"+obj[i].image+"');\" ></div>" +
	                    "</div>" +
	                    "<div class=\"text-wrap clearfix\">" +
	                        "<div class=\"text clearfix\">" +
	                            "<p>"+obj[i].tag+"</p>" +
	                            "<h3><strong class=\"name\">"+obj[i].name+"</strong> 마스터</h3>" +
	                            "<div class=\"score clearfix\">" +
	                                "<h4><span class=\"auto\">"+obj[i].score+"</span>/5</h4>" +
	                                "<div class=\"question-wrap\">" +
	                                    "<img id=\"question_open_"+obj[i].idx+"\" class=\"question-btn\" src=\"images/question.png\" alt=\"물음표\"" +
	                                        "onclick=\"javascript: questionOpen("+obj[i].idx+");\">" +
	                                    "<div id=\"question_wrap_"+obj[i].idx+"\" class=\"question-contetns clearfix\">" +
	                                        "<p>" +
	                                            "<strong>MIF란 콘텐츠의 품질과 라이프 사이클을 관리하기 위해" +
	                                                "프로스쿨에서 자체 개발한 마스터 평가 시스템입니다.</strong>" +
	                                            "* 평가 기준 : 학습자 평가지수 + 자문그룹 평가지수 +" +
	                                            "누적 수강생 수 + 추천지수" +
	                                        "</p>" +
	                                        "<img id=\"question_close_"+obj[i].idx+"\" class=\"close-btn\" src=\"images/close.png\" alt=\"닫기\"" +
	                                            "onclick=\"javascript: questionClose("+obj[i].idx+");\">" +
	                                    "</div>" +
	                                "</div>" +
	                            "</div>" +
	                            "<ul class=\"sub-text\">" +
	                            	historyStr +
	                            "</ul>" +
	                        "</div>" +
	                        "<div class=\"more-btn\">" +
	                            "<a href=\"masters?view=masters&menu=masters_detail&idx="+obj[i].idx+"\">MORE</a>" +
	                        "</div>" +
	                    "</div>" +
	                "</li>"
				);
			}
		}
	});	
}


//구독
function subscribeSubmit(){
	var email = $("#subscribe_email").val();

	if(email == ""){
		alert("이메일을 입력하세요");
		return;
	}
	
	 var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	  // 검증에 사용할 정규식 변수 regExp에 저장

  if (email.match(regExp) == null) {
    alert("잘못된 이메일 형식입니다.");
    return;
  }
	
	if(confirm("프로스쿨 최신정보를 구독하시겠습니까?")==false)
		return;
	
	var param = "mode=subscribe&email="+encodeURIComponent(email);
	
	$.ajax({
		type: "POST",
		url: 'main',
		data: param,
		error: ajaxFailed,
		success: function(ret) {
			alert("구독이 완료되었습니다.");
			location.reload();
		}
	});
}

function mainSwiperTab(category){
	var limit = 10;
	if(category != "all")
		limit = 3;
	
	for(var i=1; i<=4; i++){
		$("#main_swiper_"+i).removeClass("active");
	}
	
	if(category == "all")		$("#main_swiper_1").addClass("active");
	else if(category == "1")	$("#main_swiper_2").addClass("active");
	else if(category == "2")	$("#main_swiper_3").addClass("active");
	else if(category == "3")	$("#main_swiper_4").addClass("active");
	
	var searchType = $("#searchType").val();
	
	var param = "mode=get_slider_masters&category="+encodeURIComponent(category)+"&limit="+encodeURIComponent(limit);

	$.ajax({
		type: "POST",
		url: "main",
		data: param,
		dataType: 'text',
		success: function(ret){
		
			var obj = JSON.parse(ret);
			$("#main_swiper_masters").empty();
			for(var i=0; i<obj.length; i++){
				
				$("#main_swiper_masters").append(
					
					"<div class=\"swiper-slide list\">" +
                        "<div class=\"wrap\">" +
                            "<div class=\"img-wrap\" >" +
                                "<div class=\"img\" style=\"background-image: url('"+obj[i].image+"');\" ></div>" +
                            "</div>" +
                            "<div class=\"text-wrap\">" +
                                "<p class=\"title\">"+obj[i].tag+"</p>" +
                                "<h6><strong class=\"name\">"+obj[i].name+"</strong>마스터</h6>" +
                                "<p class=\"score\"><strong class=\"score-auto\">"+obj[i].score+"</strong>/5" +
                                "</p>" +
                                "<a href=\"masters?view=masters&menu=masters_detail&idx="+obj[i].idx+"\">MORE</a>" +
                            "</div>" +
                        "</div>" +
                    "</div>"
				);
			}
			
			// honor-pg all-slider slider
			var allSlider = new Swiper('.category-list1-slider', {
			  slidesPerView: 'auto',
			  centeredSlides: true,
			  spaceBetween: 30,
			  pagination: {
			    el: '.swiper-pagination',
			    clickable: true,
			  },
			});
		}
	});	
}


//apply
function applyFileUpload(type){
	if($('#'+type).val() == '') {
		alert('파일을 선택하세요.');
		return false;
	}
	
	 var fileCheck = $('#'+type).val();
		fileCheck = fileCheck.slice(fileCheck.indexOf(".") + 1).toLowerCase();
		
	if(fileCheck != "pdf" && fileCheck != "PDF" && fileCheck != "jpg" && fileCheck != "png" && fileCheck != "gif" && fileCheck != "bmp" && fileCheck != "JPG" && fileCheck != "PNG" && fileCheck != "GIF" && fileCheck != "BMP" && fileCheck == ""){
		alert('pdf 파일만 등록 가능합니다.');
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

//apply agree
function applyAgree(){
	$("#termscheck_").prop("checked", true);
	window.open("information");
}

var applyChecked = true;

// apply submit
function applySubmit(){
	var name = $("#apply_name").val();
	var company = $("#apply_company").val();
	var email = $("#apply_email").val();
	var contact = $("#apply_contact").val();
	var target = $("#apply_target").val();
	var fileData = $("#file_data").val();
	
	if(name == ""){
		alert("성명을 입력하세요.");
		return;
	}
	
	if(company == ""){
		alert("회사명을 입력하세요.");
		return;
	}
	if(email == ""){
		alert("이메일을 입력하세요.");
		return;
	}
	if(contact == ""){
		alert("연락처를 입력하세요.");
		return;
	}
	if(target == ""){
		alert("교육대상자를 입력하세요.");
		return;
	}
	if(fileData == ""){
		alert("파일을 업로드하세요.");
		return;
	}
	
	if($("input:checkbox[id='termscheck_']").is(":checked") == false){
		alert("개인정보 및 이용약관에 동의해주세요.");
		return;
	}
	
	if(confirm("이대로 제출하시겠습니까?")==false)
		return;
	
	var param = "mode=apply&name="+encodeURIComponent(name)+
				"&company="+encodeURIComponent(company)+
				"&email="+encodeURIComponent(email)+
				"&contact="+encodeURIComponent(contact)+
				"&target="+encodeURIComponent(target)+
				"&file_data="+encodeURIComponent(fileData);
	
	if(applyChecked == false){
		alert("제출중입니다. 잠시만 기다려주세요.");
		return;
	}
	else{
		applyChecked = false;
		$.ajax({
			type: "POST",
			url: 'main',
			data: param,
			error: ajaxFailed,
			success: function(ret) {
				applyChecked = true;
				location.reload();
			}
		});
	}
	
	
	
}


//ajax Failed alert
function ajaxFailed(xmlRequest){
	alert(xmlRequest.status+"\n\r"+xmlRequest.statusText+"\n\r"+xmlRequest.responseText);
}

