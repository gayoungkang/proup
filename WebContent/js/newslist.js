// data-detail-pg select-box 
let detailSelect = document.querySelector('.detail-select-box');
let detailSelectList = document.querySelector('.detail-select-box .select-list');
let detailSelectListClose = document.querySelector('.detail-select-box .select-list .close');

detailSelect.addEventListener("click", function () {
    if (!detailSelect.classList.contains('active')) {
        detailSelect.classList.add('active');
        detailSelectList.classList.add('active');
        detailSelectListClose.classList.add('active');
    } else {
        detailSelect.classList.remove('active');
        detailSelectList.classList.remove('active');
        detailSelectListClose.classList.remove('active');
    }
});


// notice-slider 
var noticeSlider = new Swiper('.notice-slider', {
    loop: true,
    spaceBetween: 30,
    speed: 1000,
    centeredSlides: true,
    autoplay: {
        delay: 3000,
        disableOnInteraction: false,
    }
});

// notice slider 
// 모바일 기준 notice slider 생길때 section padding-top 변환
// 넓이만 인식하는 스크립트
if($(window).width() <= 700) {  
    $('.notice-slider-wrap').hasClass('active')
    $('.news-list-pg').css('padding-top', '124px')
}
// 창바뀔때마다 인식하는 스크립트
$(window).resize(function (){
    if ($(window).width() <= 700) {
        $('.notice-slider-wrap').hasClass('active')
        $('.news-list-pg').css('padding-top', '124px')
    }
});

// 웹 기준 notice slider 생길때 section padding-top 변환
// 넓이만 인식하는 스크립트
if($(window).width() > 700) {  
    $('.notice-slider-wrap').hasClass('active')
    $('.news-list-pg').css('padding-top', '196px')
}
// 창바뀔때마다 인식하는 스크립트
$(window).resize(function (){
    if ($(window).width() > 700) {
        $('.notice-slider-wrap').hasClass('active')
        $('.news-list-pg').css('padding-top', '196px')
    }
});
