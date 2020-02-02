// tab

// question
function questionOpen(idx){
    document.getElementById('question_open_'+idx).classList.add('active');
    document.getElementById('question_wrap_'+idx).classList.add('active');
    document.getElementById('question_close_'+idx).classList.add('active');
}

function questionClose(idx){
    document.getElementById('question_open_'+idx).classList.remove('active');
    document.getElementById('question_wrap_'+idx).classList.remove('active');
    document.getElementById('question_close_'+idx).classList.remove('active');
}

