
<%@page import="model.MastersCutModel"%>
<%@page import="model.MastersReviewModel"%>
<%@page import="model.CurriculumDetailModel"%>
<%@page import="model.CurriculumModel"%>
<%@page import="model.MastersActivityModel"%>
<%@page import="model.MastersHistoryModel"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="model.MastersModel"%>
<%@page import="java.util.List"%>
<%@page import="model.SearchModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MastersModel master = (MastersModel) request.getAttribute("master");
	List<MastersHistoryModel> listHistory = (List<MastersHistoryModel>) request.getAttribute("listHistory");
	List<MastersActivityModel> listActivity = (List<MastersActivityModel>) request.getAttribute("listActivity");
	List<CurriculumModel> listCurri = (List<CurriculumModel>) request.getAttribute("listCurri");
	List<CurriculumDetailModel> listCD = (List<CurriculumDetailModel>) request.getAttribute("listCD");
	List<MastersReviewModel> listMR = (List<MastersReviewModel>) request.getAttribute("listMR");
	List<MastersCutModel> listMC = (List<MastersCutModel>) request.getAttribute("listMC");

	NumberFormat nf = NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=master.getTitle() %></title>
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
<meta name="Title" content="<%=master.getTitle() %>">
<meta name="Keyword" content="<%=master.getKeywords() %>">
<meta name="Description" content="<%=master.getDescription() %>">
<meta name="Author" content="프로스쿨">

<meta itemprop="name" content="<%=master.getTitle() %>">
<meta itemprop="description" content="<%=master.getDescription() %>">
<meta itemprop="image" content="upload/masters/<%=master.getIdx()%>/<%=master.getImg()%>">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">
<meta property="og:type" content="website">
<meta property="og:site_name" content="프로스쿨">
<meta property="og:title" content="<%=master.getTitle() %>">
<meta property="og:description" content="<%=master.getDescription() %>">
<meta property="og:image" content="upload/masters/<%=master.getIdx()%>/<%=master.getImg()%>">
<meta property="og:url" content="http://proschool.co.kr/masters?view=masters&menu=masters_detail&idx=<%=master.getIdx()%>">
<meta name="apple-mobile-web-app-title" content="proschool">
<meta name="application-name" content="proschool">

<!-- development -->
<link rel="stylesheet" href="css/user.css">
<script src="js/user.js"></script>

<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/masterlistdetail.css">
<link rel="shortcut icon" href="images/favicon.ico">
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/swiper.min.css">
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/swiper.min.js"></script>

<!-- calendar -->
<script src="js/jquery-ui.js"></script>
<link rel="stylesheet" href="css/jquery-ui.css">

</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	
	 <section class="master-list-detail-pg detail-pg">
        <div class="inner">
            <p class="quote">
                “<%=master.getSlogan() %>”
            </p>
            <div class="profile-wrap clearfix">
                <div class="img-wrap">
                    <div class="img" style="background-image: url('upload/masters/<%=master.getIdx()%>/<%=master.getImg()%>')"></div>
                </div>
                <div class="text-wrap">
                    <p><%=master.getTag() %></p>
                    <h3><strong class="name"><%=master.getName() %></strong> 마스터</h3>
                    <ul class="infor-list">
                        <li><%=master.getCompany() %></li>
                        <li><%=master.getPosition() %></li>
                    </ul>
                    <div class="reference-list">
                        <ul>
                            <li>
                                <a <%if(master.getReferenceCount() != 0){ %>href="references?view=references&menu=references_masters&masters_idx=<%=master.getIdx()%>"<%} %>>
                                    <div class="wrap">
                                        <p>교육 평가 결과</p>
                                        <h4><span class="auto"><%=nf.format(master.getReferenceScore()) %></span>/5</h4>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a <%if(master.getReferenceCount() != 0){ %>href="references?view=references&menu=references_masters&masters_idx=<%=master.getIdx()%>"<%} %>>
                                    <div class="wrap">
                                        <p>강의/컨설팅</p>
                                        <h4><span class="auto"><%=nf.format(master.getReferenceCount()) %></span>건</h4>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a <%if(master.getReferenceCount() != 0){ %>href="references?view=references&menu=references_masters&masters_idx=<%=master.getIdx()%>"<%} %>>
                                    <div class="wrap">
                                        <p>누적 교육생 수</p>
                                        <h4><span class="auto"><%=nf.format(master.getReferencePeople()) %></span>명</h4>
                                    </div>
                                </a>
                            </li>
                        </ul>
                        <%if(master.getReferenceCount() == 0){ %>
                        	 <!-- 레퍼런스 데이터가 없을때 나오는 요소입니다. -->
	                        <div class="screen">
	                            <img src="images/warning.png" alt="아이콘">
	                            <p>신규 마스터이므로 준비중입니다.</p>
	                        </div>
                        <%} %>
                    </div>
                </div>
            </div>
            <div class="record">
                <button class="record-btn">
                    <span>마스터 이력</span>
                    <img src="images/arrow-down-gr.png" alt="펼치기">
                </button>
                <div class="contents">
                    <div class="wrap clearfix">
                        <span>경력 및 학력</span>
                        <ul class="contents-list">
                        	<%for(int i=0; i<listHistory.size(); i++){ %>
                        		<li>ㆍ <%=listHistory.get(i).getHistory() %></li>
                        	<%} %>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="action">
                <h5>주요 활동</h5>
                <div class="wrap">
                	<%for(int i=0; i<listActivity.size(); i++){ %>
                		<div class="text-wrap">
	                        <p class="title"><%=listActivity.get(i).getTitle() %></p>
	                        <p class="text"><%=listActivity.get(i).getContent() %></p>
	                    </div>
                	<%} %>
                </div>
            </div>
            <ul class="curriculum">
            	<%for(int i=0; i<listCurri.size(); i++){
            		CurriculumModel list = listCurri.get(i);
            		%>
            		<li>
	                    <button class="curriculum-btn on-click <%if(i==0){ %>active<%} %> clearfix" type="button"
	                        data-target=".curriculum-list<%=list.getIdx()%>">
	                        <span>[ 커리큘럼<%=i+1 %> ] <%=list.getTitle() %></span>
	                        <img src="images/arrow-down-gr.png" alt="펼치기">
	                    </button>
	                    <div class="contents curriculum-list<%=list.getIdx() %> <%if(i==0){ %>active<%} %>">
	                        <div class="wrap clearfix">
	                            <div class="col-1">
	                                <h6>특별함</h6>
	                                <%for(int j=0; j<listCD.size(); j++){
	                                	CurriculumDetailModel detail = listCD.get(j);
	    								if(detail.getCurriculumIdx() == list.getIdx() && detail.getCategory() == 1){
	                                	%>
	                                	<div class="list-wrap">
		                                    <p class="title"><%=detail.getTitle() %></p>
		                                    <p class="text"><%=detail.getContent() %></p>
			                            </div>
	                                <%}
	    							}%>
	                            </div>
	                            <div class="col-2">
	                                <h6>상세 커리큘럼</h6>
	                                <%for(int j=0; j<listCD.size(); j++){
	                                	CurriculumDetailModel detail = listCD.get(j);
	    								if(detail.getCurriculumIdx() == list.getIdx() && detail.getCategory() == 2){
	                                	%>
	                                	<div class="list-wrap">
		                                    <p class="title"><%=detail.getTitle() %></p>
		                                    <p class="text"><%=detail.getContent() %></p>
			                            </div>
	                                <%}
	    							}%>
	                            </div>
	                        </div>
	                    </div>
	                </li>
            	<%} %>
                
            </ul>

            <div class="review">
                <div class="inner">
                    <div class="review-title">
                        <h3>교육생 후기</h3>
                    </div>
                </div>
                <div class="swiper-container review-slider">
                    <div class="swiper-wrapper">
                    	<%for(int i=0; i<listMR.size(); i++){
                    		MastersReviewModel list = listMR.get(i);
                    		%>
                    		<div class="swiper-slide">
	                            <div class="wrap">
	                                <img src="upload/review/<%=list.getIdx() %>/<%=list.getImg() %>" alt="아이콘">
	                                <p class="name"><%=list.getName() %></p>
	                                <p class="text"><%=list.getContent() %></p>
	                            </div>
	                        </div>
                    	<%} %>
                    </div>
                    <div class="swiper-pagination"></div>
                </div>
            </div>

            <div class="photo">
                <div class="wrap">
                    <p class="photo-title">마스터’s 컷 교육사진 or 영상</p>
                    <div class="swiper-container gallery-top">
                        <div class="swiper-wrapper">
                        	<%for(int i=0; i<listMC.size(); i++){
                        		MastersCutModel list = listMC.get(i);
                        		%>
                        		<div class="swiper-slide">
                        			<%if(list.getCategory() == 0){ %>
		                                <div class="img-wrap">
		                                    <div class="img" style="background-image: url('upload/master_cut/<%=list.getIdx() %>/<%=list.getContent() %>');" ></div>
		                                </div>
	                                <%}else{ %>
		                                <div class="video-wrap">
		                                    <iframe src="https://www.youtube.com/embed/<%=list.getContent() %>?rel=0"></iframe>
		                                </div>
	                                <%} %>
	                                <p class="title"><%=list.getTitle() %></p>
	                            </div>
                        	<%} %>
                            
                        </div>
                        <div class="swiper-button-next swiper-button-white"></div>
                        <div class="swiper-button-prev swiper-button-white"></div>
                    </div>
                    <div class="swiper-container gallery-thumbs">
                        <div class="swiper-wrapper">
                        	<%for(int i=0; i<listMC.size(); i++){
                        		MastersCutModel list = listMC.get(i);
                        		%>
                        		<div class="swiper-slide">
                        			<%if(list.getCategory() == 0){ %>
		                                <div class="img-wrap">
		                                    <div class="img" style="background-image: url('upload/master_cut/<%=list.getIdx() %>/<%=list.getContent() %>');" ></div>
		                                </div>
	                                <%}else{ %>
		                                <div class="video-wrap">
		                                    <iframe src="https://www.youtube.com/embed/<%=list.getContent() %>?rel=0"></iframe>
		                                     <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></div>
		                                </div>
	                                <%} %>
	                            </div>
                        	<%} %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="education-pg">
        <div class="inner clearfix">
            <div class="text-wrap">
                <p>기업의 경영성과 창출에 기여하는</p>
                <p>가장 <strong>효과적인</strong> 교육 솔루션!</p>
            </div>
            <a href="javascript: void(0);" class="education-btn">
                <div class="wrap">
                    <span>교육 추천 받기</span>
                    <img src="images/arrow.png" alt="교육 추천 받기ㅣ">
                </div>
            </a>
        </div>
    </div>
    
    <jsp:include page="./footer.jsp"></jsp:include>
</body>
<script src="js/common.js"></script>
<script src="js/masterlistdetail.js"></script>
<script src="js/modalslider.js"></script>
</html>