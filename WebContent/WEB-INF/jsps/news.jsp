<%@page import="util.RemoveTag"%>
<%@page import="model.NewsInfoModel"%>
<%@page import="java.util.List"%>
<%@page import="model.SearchModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SearchModel search = (SearchModel) request.getAttribute("search");
	List<NewsInfoModel> listNI = (List<NewsInfoModel>) request.getAttribute("listNI");
	List<NewsInfoModel> listTopNews = (List<NewsInfoModel>) request.getAttribute("listTopNews");
	String searchType = (String) request.getAttribute("searchType");
	String searchText = (String) request.getAttribute("searchText");
	int totalCount = (Integer) request.getAttribute("totalCount");
	
	String searchTypeStr = "정렬기준";
	if("1".equals(searchType))	searchTypeStr = "프로스쿨";
	else if("2".equals(searchType))	searchTypeStr = "마스터";
	else if("3".equals(searchType))	searchTypeStr = "공지";
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
<meta property="og:url" content="http://proschool.co.kr/news">
<meta name="apple-mobile-web-app-title" content="proschool">
<meta name="application-name" content="proschool">

<!-- development -->
<link rel="stylesheet" href="css/user.css">
<script src="js/user.js"></script>

<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/newslist.css">
<link rel="shortcut icon" href="images/favicon.ico">
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/swiper.min.css">
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/swiper.min.js"></script>

</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	
	<%if(listTopNews.size()>0){
		
		%>
		<div class="notice-slider-wrap active">
	        <div class="swiper-container notice-slider">
	            <div class="swiper-wrapper">
	            	<%for(int i=0; i<listTopNews.size(); i++){
	        			NewsInfoModel list = listTopNews.get(i);
	        			%>
		                <div class="swiper-slide">
		                    <a class="clearfix" href="news?view=news&menu=news_detail&idx=<%=list.getIdx()%>">
		                        <img src="images/bell.png" alt="알림">
		                        <p><%=list.getTitle() %></p>
		                    </a>
		                </div>
	                <%} %>
	            </div>
	        </div>
	    </div>
	<% }%>
	

    <section class="news-list-pg detail-pg">
        <div class="inner">
            <h2 class="detail-title">NEWS</h2>
            <div class="wrap clearfix">
                <div class="detail-select-box">
                    <div class="wrap">
                        <span><%=searchTypeStr %></span>
                        <img src="./images/arrow.png" alt="이미지">
                    </div>
                    <ul class="select-list">
                        <li class="close">
                            <div class="wrap">
                                <span>정렬기준</span>
                                <img src="images/arrow.png" alt="이미지">
                            </div>
                        </li>
                        <li><a href="news?view=news&searchType=1">프로업</a></li>
                        <li><a href="news?view=news&searchType=2">마스터</a></li>
                        <li><a href="news?view=news&searchType=3">공지</a></li>
                    </ul>
                </div>
                <div class="search">
                	<input type="hidden" id="searchType" value="<%=searchType%>">
                    <input type="text" id="searchText" placeholder="검색어를 입력해주세요." value="<%=searchText%>" onkeyup="javascript: onSearchNewsKeyup();" >
                    <button class="search-btn" type="button" onclick="javascript: searchNews();"><img src="images/search.png" alt="검색"></button>
                </div>
            </div>
            <ul class="category" id="news_list">
            	<%for(int i=0; i<listNI.size(); i++){
            		NewsInfoModel list = listNI.get(i);
            		%>
            		<li class="clearfix">
	                    <div class="img-wrap">
	                        <div class="img" style="background-image: url('upload/news/<%=list.getIdx() %>/<%=list.getThumbnail() %>');"></div>
	                    </div>
	                    <div class="text-wrap clearfix">
	                        <div class="text">
	                            <h3><%=list.getTitle() %></h3>
	                            <p class="date"><%=list.getViewDate().substring(0, 10) %></p>
	                            <p class="sub-text">
	                                <%=RemoveTag.removeTag(list.getContent()) %>
	                            </p>
	                        </div>
	                        <div class="more-btn">
	                            <a href="news?view=news&menu=news_detail&idx=<%=list.getIdx()%>">MORE</a>
	                        </div>
	                    </div>
	                </li>
            	<%} %>
                
            </ul>
            <%if(totalCount>10){ %>
	            <button class="drop-down" onclick="javascript: moreNews();">
	                <span>더보기</span><img src="images/arrow-down-gr.png" alt="다운">
	            </button>
            <%} %>
        </div>
    </section>
    
    <img class="top-btn" src="images/topbtn.png" alt="스크롤탑">
    
    <jsp:include page="./footer.jsp"></jsp:include>
</body>
<script src="js/common.js"></script>
<script src="js/newslist.js"></script>
</html>