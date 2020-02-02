// tab
var curriculumBtnList = $(".on-click");
var curriculumContentList = $(".master-list-detail-pg .curriculum .contents");

curriculumBtnList.on("click", function() {
    var content  = $(this).attr("data-target");
    if (!$(this).hasClass("active")) {
        curriculumBtnList.removeClass("active");
        curriculumContentList.removeClass("active");
        $(this).addClass("active");
        $(content).addClass("active");
    } else {
        $(this).removeClass("active");
        $(content).removeClass("active");
    }
});

// record
let recordBtn = document.querySelector('.master-list-detail-pg .record .record-btn');
let recordList = document.querySelector('.master-list-detail-pg .record .contents');

recordBtn.addEventListener("click", function () {
    if (!recordBtn.classList.contains('active')) {
        recordBtn.classList.add('active');
        recordList.classList.add('active');
} else {
        recordBtn.classList.remove('active');
        recordList.classList.remove('active');
    }
});


 // review slider
 var swiper = new Swiper('.review-slider', {
    slidesPerView: '1',
    spaceBetween: 30,
    loop: false,
    centeredSlides: true,
    autoplay: {
      delay: 2400,
      disableOnInteraction: false,
    },
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },
    breakpoints: {
      640: {
        slidesPerView: 1,
        spaceBetween: 30,
      },
      768: {
        slidesPerView: 1.5,
        spaceBetween: 30,
      },
      1024: {
        slidesPerView: 2.5,
        spaceBetween: 30,
      },
    }
  });
  $( ".review-slider .swiper-slide" ).hover(
  function() {
      swiper.autoplay.stop();
  }, function() {
      swiper.autoplay.start();
  }
  );

  // photo
  var galleryThumbs = new Swiper('.gallery-thumbs', {
    spaceBetween: 10,
    slidesPerView: 4,
    freeMode: true,
    watchSlidesVisibility: true,
    watchSlidesProgress: true,
  });
  var galleryTop = new Swiper('.gallery-top', {
    spaceBetween: 10,
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    thumbs: {
      swiper: galleryThumbs
    }
  });