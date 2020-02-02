<%@page import="model.PopupModel"%>
<%@page import="model.SetupModel"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="model.MastersModel"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="model.MainReviewModel"%>
<%@page import="model.SearchModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SearchModel search = (SearchModel) request.getAttribute("search");
	List<MainReviewModel> listMR = (List<MainReviewModel>) request.getAttribute("listMR");
	List<MastersModel> listMasters = (List<MastersModel>) request.getAttribute("listMasters");
	SetupModel setup = (SetupModel) request.getAttribute("setup");
	SetupModel mainData = (SetupModel) request.getAttribute("mainData");
	PopupModel popup = (PopupModel) request.getAttribute("popup");
	
	NumberFormat nf = NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	Calendar cal = Calendar.getInstance();
	String year = String.format("%04d", cal.get(Calendar.YEAR));
	String month = String.format("%02d", cal.get(Calendar.MONTH)+1);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=search.getTitle() %></title>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-145896561-3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-145896561-3');
</script>

<meta name="naver-site-verification" content="c092c09a114f8dfae527a1f03055aa52b38f8700"/>
	
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "32b0ebbcaf7c0c";
wcs_do();
</script>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="Title" content="<%=search.getTitle() %>">
<meta name="Keyword" content="<%=search.getKeywords() %>">
<meta name="Description" content="<%=search.getDescription() %>">
<meta name="Author" content="프로스쿨">

<meta itemprop="name" content="<%=search.getTitle() %>">
<meta itemprop="description" content="<%=search.getDescription() %>">
<meta itemprop="image" content="images/thumbnail.png">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">
<meta property="og:type" content="website">
<meta property="og:site_name" content="프로스쿨">
<meta property="og:title" content="<%=search.getTitle() %>">
<meta property="og:description" content="<%=search.getDescription() %>">
<meta property="og:image" content="images/thumbnail.png">
<meta property="og:url" content="http://proschool.co.kr/">
<meta name="apple-mobile-web-app-title" content="proschool">
<meta name="application-name" content="proschool">

<!-- development -->
<link rel="stylesheet" href="css/user.css">
<script src="js/user.js"></script>

<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/style.css">
<link rel="shortcut icon" href="images/favicon.ico">
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/swiper.min.css">

<script src="js/jquery-3.3.1.min.js"></script>
<!-- calendar -->
<script src="js/jquery-ui.js"></script>
<link rel="stylesheet" href="css/jquery-ui.css">

<script src="js/swiper.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	<%if(popup.getIdx() != -1){%>
		var pename = "pop"+<%=popup.getIdx()%>;
		var result = getCookie(pename);
		
		if (result == 'end') {
		   document.getElementById('pop<%=popup.getIdx()%>').style.display = "none";
		}
	<%}%>
});


$(window).scroll(function () {
	
	  if ((dataSectionTop - marginT) <= $(this).scrollTop()) {
	    if (!counterTrue) {
	    	motion.classList.remove('active');
	      new numberCounter("counter1", <%=nf.format(mainData.getTotalReferenceCount())%>);
	      new numberCounter("counter2", <%=nf.format(mainData.getTotalReferencePeople())%>);
	      new numberCounter("counter3", <%=nf.format(mainData.getTotalReferenceScore()*20)%>);
	      counterTrue = true;
	    }
	  }
});


function popClose(idx){
	document.getElementById('pop'+idx).style.display = "none";
}

function popCloseToday(idx){
	setCookie( "pop"+idx, "end" , 1);
	document.getElementById('pop'+idx).style.display = "none";
}

function getCookie(name) { 
   var cookieName = name + "=";
   var x = 0;
   while ( x <= document.cookie.length ) { 
      var y = (x+cookieName.length); 
      if ( document.cookie.substring( x, y ) == cookieName) { 
         if ((lastChrCookie=document.cookie.indexOf(";", y)) == -1) 
            lastChrCookie = document.cookie.length;
         return decodeURI(document.cookie.substring(y, lastChrCookie));
      }
      x = document.cookie.indexOf(" ", x ) + 1; 
      if ( x == 0 )
         break; 
      } 
   return "";
}

/* setCookie function */
function setCookie(cname, value, expire) {
   var todayValue = new Date();
   // 오늘 날짜를 변수에 저장

   todayValue.setDate(todayValue.getDate() + expire);
   document.cookie = cname + "=" + encodeURI(value) + "; expires=" + todayValue.toGMTString() + "; path=/;";
}

</script>
</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>

    

    <%if(popup.getIdx() != -1){ %>
    	<div class="popup-wrap" id="pop<%=popup.getIdx()%>">
    		<a href="<%=popup.getLink() %>" target="_blank" class="popup-a">
    			<img class="popup-img" src="<%=popup.getImg() %>" />
    		</a>
    		<div style="width: 100%; height: 30px; text-align: right; padding-right: 10px; position: relative; background-color: #EEEEEE; margin-top: -5px;">
			
				<a href="javascript: popCloseToday(<%=popup.getIdx() %>)" style="color: #444; line-height: 30px; font-size: 13px;">[오늘 하루 열지 않기]</a>&nbsp;&nbsp;&nbsp;
				<a href="javascript: popClose(<%=popup.getIdx() %>)" style="color: #444; line-height: 30px; font-size: 13px;">[닫기]</a>
			</div>
    	</div>
    <%} %>


    <section class="main-pg">
        <div class="inner">
            <div class="text-wrap">
                <span>기업의 경영성과 창출에 기여하는</span>
                <h1>가장 <strong>효과적인</strong> 교육 솔루션!</h1>
            </div>
            <div class="education-btn">
                <div class="wrap">
                    <span>교육제안서 요청하기</span>
                    <img src="images/arrow.png" alt="교육제안서 요청하기 버튼">
                </div>
            </div>
        </div>
    </section>

    <section class="data-pg">
        <div class="inner">
            <h2 class="active">프로업은 <strong>데이터</strong>로 말합니다.</h2>
            <div class="wrap clearfix">
                <ul>
                    <li>기업 교육 횟수 <span class="data" id="counter1">0</span></li>
                    <li>누적 교육생 수 <span class="data" id="counter2">0</span></li>
                    <li>교육평가 결과 <span class="data" id="counter3">0</span><span class="point">/100</span></li>
                </ul>
                <a class="detail-btn" href="references?view=references">
                    <div class="wrap">
                        <span>상세보기</span>
                        <img src="images/arrow_blue.png" alt="상세보기">
                    </div>
                </a>
            </div>
            <p class="date"><span class="year"><%=year %></span>년<span class="mont"><%=month %></span>월 기준</p>
        </div>
    </section>

    <section class="review-pg">
        <div class="inner">
            <div class="main-title">
                <h3>REVIEW</h3>
                <p>기업교육 담당자의 실제 후기입니다.</p>
            </div>
        </div>
        <div class="swiper-container review-slider">
            <div class="swiper-wrapper">
            	<%for(int i=0; i<listMR.size(); i++){
            		MainReviewModel list = listMR.get(i);
            		%>
            		<div class="swiper-slide">
	                    <div class="wrap">
	                        <img src="upload/main_review/<%=list.getIdx() %>/<%=list.getImg() %>" alt="아이콘">
	                        <p class="name"><%=list.getName() %></p>
	                        <p class="text"><%=list.getContent() %></p>
	                    </div>
	                </div>
            	<%} %>
                
             
            </div>
            <div class="swiper-pagination"></div>
        </div>
    </section>

    <section class="honor-pg">
        <div class="inner">
            <div class="main-title">
                <h3>명예의 전당</h3>
                <p>교육평가 최고점을 기록 중인 프로업 마스터!<br>
                    지금 바로 확인하세요.</p>
            </div>
            <ul class="category-btn-list clearfix">
                <li><button class="on-click active" type="button" id="main_swiper_1" onclick="javascript: mainSwiperTab('all');">전체</button></li>
                <%if(setup.getCategory() == 1){ %>
                <li><button class="on-click" type="button" id="main_swiper_2" onclick="javascript: mainSwiperTab('1');">디지털 혁신</button>
                </li>
                <li><button class="on-click" type="button" id="main_swiper_3" onclick="javascript: mainSwiperTab('2');">라이프</button></li>
                <li><button class="on-click" type="button" id="main_swiper_4" onclick="javascript: mainSwiperTab('3');">직무역량</button></li>
                <%} %>
            </ul>
            <div class="category-list">
                <div class="swiper-container category category-list1-slider active">
                    <div class="swiper-wrapper" id="main_swiper_masters">
                    	<%for(int i=0; i<listMasters.size(); i++){ 
                    		MastersModel list = listMasters.get(i);
                    	%>
                    		<div class="swiper-slide list">
	                            <div class="wrap">
	                                <div class="img-wrap">
	                                    <div class="img" style="background-image: url('upload/masters/<%=list.getIdx()%>/<%=list.getImg()%>')"></div>
	                                </div>
	                                <div class="text-wrap">
	                                    <p class="title"><%=list.getTag() %></p>
	                                    <h6><strong class="name"><%=list.getName() %></strong>마스터</h6>
	                                    <p class="score"><strong class="score-auto"><%=nf.format(list.getReferenceScore()) %></strong>/5</p>
	                                    <a href="masters?view=masters&menu=masters_detail&idx=<%=list.getIdx()%>">MORE</a>
	                                </div>
	                            </div>
	                        </div>
                    	<%} %>
                    </div>
                    <div class="swiper-pagination"></div>
                </div>
               
            </div>
        </div>
    </section>
    
    <jsp:include page="./footer.jsp"></jsp:include>
</body>
<script src="js/common.js"></script>
<script src="js/main.js"></script>
<script src="js/modalslider.js"></script>
</html>