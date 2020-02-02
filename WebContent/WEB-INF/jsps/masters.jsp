
<%@page import="java.text.NumberFormat"%>
<%@page import="model.MastersModel"%>
<%@page import="java.util.List"%>
<%@page import="model.SearchModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SearchModel search = (SearchModel) request.getAttribute("search");
	List<MastersModel> listMasters = (List<MastersModel>) request.getAttribute("listMasters");
	MastersModel countMasters = (MastersModel) request.getAttribute("countMasters");
	String searchType = (String) request.getAttribute("searchType");
	int totalCount = (Integer) request.getAttribute("totalCount");
	
	NumberFormat nf = NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
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
<meta property="og:url" content="http://proschool.co.kr/masters?view=masters">
<meta name="apple-mobile-web-app-title" content="proschool">
<meta name="application-name" content="proschool">

<!-- development -->
<link rel="stylesheet" href="css/user.css">
<script src="js/user.js"></script>

<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/masterlist.css">
<link rel="shortcut icon" href="images/favicon.ico">
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/swiper.min.css">
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/swiper.min.js"></script>

</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	
	 <section class="master-list-pg detail-pg">
	 	<input type="hidden" id="searchType" value="<%=searchType %>" />
        <div class="inner">
            <h2 class="detail-title">MASTER</h2>
            <p class="main-text">프로업은 실효성 있는 교육을 제공하기 위해<br>
                학문적 접근을 통한 깊은 지식과 현업의 비즈니스 전문성을 갖춘 [마스터]와 함께 합니다.</p>
            <ul class="master-btn-list clearfix">
                <li><button <%if("all".equals(searchType)){ %> class="on-click active" <%}else{ %> class="on-click" <%} %> type="button" onclick="javascript: goMastersCategory('all');">전체
                    <span class="count"><span class="auto"><%=nf.format(countMasters.getAllCount()) %></span>명</span></button></li>
                <li><button <%if("1".equals(searchType)){ %> class="on-click active" <%}else{ %> class="on-click" <%} %> type="button" onclick="javascript: goMastersCategory('1');">디지털 혁신<span
                            class="count"><span class="auto"><%=nf.format(countMasters.getDigitalCount()) %></span>명</span></button></li>
                <li><button <%if("2".equals(searchType)){ %> class="on-click active" <%}else{ %> class="on-click" <%} %> type="button" onclick="javascript: goMastersCategory('2');">라이프<span class="count"><span
                                class="auto"><%=nf.format(countMasters.getLifeCount()) %></span>명</span></button></li>
                <li><button <%if("3".equals(searchType)){ %> class="on-click active" <%}else{ %> class="on-click" <%} %> type="button" onclick="javascript: goMastersCategory('3');">직무역량<span class="count"><span
                                class="auto"><%=nf.format(countMasters.getServiceCount()) %></span>명</span></button></li>
            </ul>

            <ul class="category" id="masters_list">
            	<%for(int i=0; i<listMasters.size(); i++){
            		MastersModel list = listMasters.get(i);
            		%>
            		<li class="clearfix">
	                    <div class="img-wrap" style="cursor: pointer;" onclick="javascript: location.href='masters?view=masters&menu=masters_detail&idx=<%=list.getIdx()%>'">
	                        <div class="img" style="background-image: url('upload/masters/<%=list.getIdx() %>/<%=list.getImg() %>');" ></div>
	                    </div>
	                    <div class="text-wrap clearfix">
	                        <div class="text clearfix">
	                            <p><%=list.getTag() %></p>
	                            <h3><strong class="name"><%=list.getName() %></strong> 마스터</h3>
	                            <div class="score clearfix">
	                                <h4><span class="auto"><%=nf.format(list.getReferenceScore()) %></span>/5</h4>
	                                <%-- <div class="question-wrap">
	                                    <img id="question_open_<%=list.getIdx()%>" class="question-btn" src="images/question.png" alt="물음표"
	                                        onclick="javascript: questionOpen(<%=list.getIdx()%>);">
	                                    <div id="question_wrap_<%=list.getIdx()%>" class="question-contetns clearfix">
	                                        <p>
	                                            <strong>MIF란 콘텐츠의 품질과 라이프 사이클을 관리하기 위해
	                                                프로스쿨에서 자체 개발한 마스터 평가 시스템입니다.</strong>
	                                            * 평가 기준 : 학습자 평가지수 + 자문그룹 평가지수 +
	                                            누적 수강생 수 + 추천지수
	                                        </p>
	                                        <img id="question_close_<%=list.getIdx()%>" class="close-btn" src="images/close.png" alt="닫기"
	                                            onclick="javascript: questionClose(<%=list.getIdx()%>);">
	                                    </div>
	                                </div> --%>
	                            </div>
	                            <ul class="sub-text">
	                            	<%for(int j=0; j<list.getListHistory().size(); j++){ 
	                            		String history = list.getListHistory().get(j);
	                            	%>
	                            		<li>ㆍ <%=history %></li>
	                            	<%} %>
	                                
	                            </ul>
	                        </div>
	                        <div class="more-btn">
	                            <a href="masters?view=masters&menu=masters_detail&idx=<%=list.getIdx()%>">MORE</a>
	                        </div>
	                    </div>
	                </li>
            	<%} %>
                
             
            </ul>
            <%if(totalCount>10){ %>
	            <button type="button" class="drop-down" onclick="javascript: moreMasters();" >
	                <span>더보기</span><img src="./images/arrow-down-gr.png" alt="다운">
	            </button>
            <%} %>
        </div>
    </section>
    
    <jsp:include page="./footer.jsp"></jsp:include>
    
    <img class="top-btn" src="images/topbtn.png" alt="스크롤탑">
</body>
<script src="js/common.js"></script>
<script src="js/masterlist.js"></script>
</html>