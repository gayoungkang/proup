// 모달 관련 슬라이더
var recommandSubmitCheck = true;
function modalNextBtn(idx) {
  var modalLeft = (idx) * 100;
  
  if(idx == 1){
	  if($(':radio[name="rec_category"]:checked').val() == null){
		  alert("강의 분야를 선택하세요.");
		  return;
	  }
	  
	  if($("#rec_purpose").val() == ""){
		  alert("교육 목적을 입력하세요.");
		  return;
	  }
  }
  
  else if(idx == 2){
	  if($(':radio[name="rec_target"]:checked').val() == null){
		  alert("교육 대상자를 선택하세요.");
		  return;
	  }
	  
	  if($(':radio[name="rec_target"]:checked').val() == "기타"){
		  if($("#rec_target_other").val() == ""){
			  alert("교육 대상자 기타 내용을 입력하세요.");
			  return;
		  }
	  }
	  
	  if($("#rec_target_position").val() == ""){
		  alert("교육 대상자 직무를 입력하세요.");
		  return;
	  }
  }
  
  else if(idx == 3){
	  if($(':radio[name="rec_hour"]:checked').val() == null){
		  alert("교육 시간을 선택하세요.");
		  return;
	  }
	  
	  if($(':radio[name="rec_hour"]:checked').val() == "기타"){
		  if($("#rec_hour_other").val() == ""){
			  alert("교육 시간 기타 내용을 입력하세요.");
			  return;
		  }
	  }
  }
  
  else if(idx == 4){
	  if($("#rec_price").val() == ""){
		  alert("교육비 예산을 입력하세요.");
		  return;
	  }
	  
	  if($("#rec_place").val() == ""){
		  alert("교육 장소를 입력하세요.");
		  return;
	  }
	  
	  if($("#rec_request_date").val() == ""){
		  alert("교육 요청일을 입력하세요.");
		  return;
	  }
  }
  
  else if(idx == 5){
	  if($(':radio[name="rec_manage"]:checked').val() == null){
		  alert("교육 운영을 선택하세요.");
		  return;
	  }
	  
	  if($("#rec_request").val() == ""){
		  alert("요청사항을 입력하세요.");
		  return;
	  }
	  
	  if($("#rec_company").val() == ""){
		  alert("회사명을 입력하세요.");
		  return;
	  }
	  
	  if($("#rec_contact").val() == ""){
		  alert("연락처를 입력하세요.");
		  return;
	  }
	  
	  if($("#rec_email").val() == ""){
		  alert("이메일을 입력하세요.");
		  return;
	  }
	  
	  if($("input:checkbox[id='termscheck_ed']").is(":checked") == false){
			alert("개인정보 및 이용약관에 동의해주세요.");
			return;
	  }
	  
	  if(recommandSubmitCheck){
		  var category = $(':radio[name="rec_category"]:checked').val();
		  var purpose = $("#rec_purpose").val();
		  var target = $(':radio[name="rec_target"]:checked').val();
		  if($(':radio[name="rec_target"]:checked').val() == "기타"){
			  target = $("#rec_target_other").val();
		  }
		  var targetPosition = $("#rec_target_position").val();
		  var hour = $(':radio[name="rec_hour"]:checked').val();
		  if($(':radio[name="rec_hour"]:checked').val() == "기타"){
			  hour = $("#rec_hour_other").val();
		  }
		  var price = $("#rec_price").val();
		  var place = $("#rec_place").val();
		  var requestDate = $("#rec_request_date").val();
		  var manage = $(':radio[name="rec_manage"]:checked').val();
		  var request = $("#rec_request").val();
		  var company = $("#rec_company").val();
		  var contact = $("#rec_contact").val();
		  var email = $("#rec_email").val();
			  
		  
		  
		  var param = "mode=recommand&category="+encodeURIComponent(category)+
			"&purpose="+encodeURIComponent(purpose)+
			"&target_position="+encodeURIComponent(targetPosition)+
			"&hour="+encodeURIComponent(hour)+
			"&price="+encodeURIComponent(price)+
			"&place="+encodeURIComponent(place)+
			"&target="+encodeURIComponent(target)+
			"&request_date="+encodeURIComponent(requestDate)+
			"&manage="+encodeURIComponent(manage)+
			"&request="+encodeURIComponent(request)+
			"&company="+encodeURIComponent(company)+
			"&contact="+encodeURIComponent(contact)+
			"&email="+encodeURIComponent(email);

			$.ajax({
				type: "POST",
				url: 'main',
				data: param,
				error: ajaxFailed,
				success: function(ret) {
					 modalSwiperMasters();
				}
			});
	  }
	  else{
		  alert("현재 제출 처리중입니다.");
	  }
	  
	 
  }
  
  
  if(idx != 5){
	  document.getElementById('modal_step_' + (idx+1)).classList.add("active");
	  // console.log(modalLeft);
	  document.getElementById('modal_ul').style.marginLeft = "-" + modalLeft + "%";
  }
  
}


// modal 열고 닫기 
let educationOpenBtn = document.querySelector('.education-btn');
let educationBack = document.querySelector('.education-back');
let educationContents = document.querySelector('.education-contents');
let educationSubmit = document.querySelector('.education-contents .submit-btn');
let educationCloseBtn = document.querySelector('.education-close-btn');

 function CloseAll() {
  educationBack.classList.add("a11y");
  educationContents.classList.add("a11y");
}

educationOpenBtn.addEventListener("click", function () {
  educationBack.classList.remove('a11y');
  educationContents.classList.remove('a11y');
});

educationSubmit.addEventListener("click", function(){
	location.reload();
});
educationCloseBtn.addEventListener("click", function(){
	location.reload();
});

// input 기타 클릭시 
let otherLabel = document.querySelector('.other-label');
let otherInput = document.querySelector('.other-input');

otherLabel.addEventListener("click", function () {
  !otherLabel.classList.contains('active')
  otherLabel.classList.add('active')
  otherInput.classList.add('active')
});

//input 기타 클릭시 
let otherLabel2 = document.querySelector('.hour-label');
let otherInput2 = document.querySelector('.hour-other');

otherLabel2.addEventListener("click", function () {
  !otherLabel2.classList.contains('active')
  otherLabel2.classList.add('active')
  otherInput2.classList.add('active')
});




function recommandAgree(){
	$("#termscheck_ed").prop("checked", true);
	window.open("information");
}




// 제안추천서 슬라이더 모달
function modalSwiperMasters(){
	var categoryStr = $(":input:radio[name=rec_category]:checked").val();
	var category = "";
	if(categoryStr == "디지털 혁신")			category = "1";
	else if(categoryStr = "직무역량")		category = "3";
	else if(categoryStr = "라이프")		category = "2";
	
	var limit = 3;
	
	var param = "mode=get_slider_masters&category="+encodeURIComponent(category)+"&limit="+encodeURIComponent(limit);
	console.log(categoryStr);
	console.log(category);
	console.log(limit);
	$.ajax({
		type: "POST",
		url: "main",
		data: param,
		dataType: 'text',
		success: function(ret){
		
			var obj = JSON.parse(ret);
			console.log(obj.length);
			for(var i=0; i<obj.length; i++){
				
				
				$("#modal_swiper_masters").append(
					"<div class=\"swiper-slide\">" +
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
			
			// modalslider
			var modalSlider = new Swiper('.modal-slider', {
			  slidesPerView: 'auto',
			  spaceBetween: 30,
			  centeredSlides: true,
			  pagination: {
			    el: '.swiper-pagination',
			    clickable: true,
			  },
			});
			
			document.getElementById('modal_step_6').classList.add("active");
			  // console.log(modalLeft);
			document.getElementById('modal_ul').style.marginLeft = "-500%";
		}
	});	
}
