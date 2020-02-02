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
