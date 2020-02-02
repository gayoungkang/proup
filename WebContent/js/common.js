 // w-header event

// top-btn
$(function () {
    $(window).scroll(function () {
        if ($(this).scrollTop() > 100) {
            $('.top-btn').fadeIn();
        } else {
            $('.top-btn').fadeOut();
        }
    });

    $(".top-btn").click(function () {
        $('html, body').animate({
            scrollTop: 0
        }, 400);
        return false;
    });
});

 let wHeader = document.querySelector('.w-header nav');

 window.addEventListener('scroll', function () {
 if ($(window).scrollTop() >= 30) {
     if (!wHeader.classList.contains('active')) {
     wHeader.classList.add('active');
     }
 }
 else wHeader.classList.remove('active');
 });

 // menu event
 let menu = document.querySelector('.m-header .menu');
 let mNav = document.querySelector('.m-header .nav-back nav');
 let mClose = document.querySelector('.m-header .nav-back nav .phon .close-btn');
 let back = document.querySelector('.m-header .nav-back');

 function menuCloseAll() {
     mNav.classList.remove("active");
     menu.classList.remove("active");
     mClose.classList.remove("active");
     back.classList.remove("active");
 }
 menu.addEventListener("click", function () {
     menu.classList.add("active");
     mNav.classList.add("active");
     back.classList.add("active");
 });
 mClose.addEventListener("click", menuCloseAll);
 back.addEventListener("click", menuCloseAll);
//master-close-btn close-btn

 // quick 
 $('.quick-btn').click(function(){
     $('.quick-contents-back').fadeIn();
     $('.quick-contents').fadeIn();
 });
 $('.quick-close-btn').click(function(){
     $('.quick-contents-back').fadeOut();
     $('.quick-contents').fadeOut();
 });

 // footer select 
 let select = document.querySelector('footer .select-box');
 let selectList = document.querySelector('footer .select-list');
 let selectListClose = document.querySelector('footer .select-box .select-list .close');

 select.addEventListener("click", function () {
     if (!select.classList.contains('active')) {
         select.classList.add('active');
         selectList.classList.add('active');
         selectListClose.classList.add('active');
 } else {
         select.classList.remove('active');
         selectList.classList.remove('active');
         selectListClose.classList.remove('active');
     }
 });


 // 마스터 모달 관련 슬라이더
var masterModalIdx = 1;
function modalNextBtnM() {
  masterModalIdx++;
  var modalLeft = (masterModalIdx - 1) * 100;
  document.getElementById('modal_step_master_' + masterModalIdx).classList.add("active");
  // console.log(modalLeft);
  document.getElementById('modal_ul_master').style.marginLeft = "-" + modalLeft + "%";
}

//마스터 file upload
$(document).ready(function(){ 
    var fileTarget = $('.file-wrap .upload-hidden'); 
    fileTarget.on('change', function(){  
        if(window.FileReader){  
            var filename = $(this)[0].files[0].name; 
        } else { 
            var filename = $(this).val().split('/').pop().split('\\').pop(); 
        }  $(this).siblings('.upload-name').val(filename); 
    }); 
});

// 마스터 modal 열고 닫기 
$('.master-btn').click(function () {
    $('.master-back').fadeIn();
    $('.master-contents').fadeIn();
  });
  $('.master-close-btn').click(function () {
	  location.reload();
  });
  
  
  function tell(contact){
	  
	  var filter = "win16|win32|win64|mac";
	  if(navigator.platform){
		  if(0 > filter.indexOf(navigator.platform.toLowerCase())){
			  location.href="tel:" + contact; 
	  	}else{
	  		alert("모바일에서만 이용 가능합니다.");
	
		 }

	  }

  }
