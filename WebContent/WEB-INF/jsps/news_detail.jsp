<%@page import="util.RemoveTag"%>
<%@page import="model.NewsInfoModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	NewsInfoModel ni = (NewsInfoModel) request.getAttribute("ni");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로스쿨 기업교육 | <%=ni.getTitle() %></title>
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
<meta name="Title" content="프로스쿨 기업교육 | <%=ni.getTitle() %>">
<meta name="Keyword" content="<%=ni.getKeywords() %>">
<meta name="Description" content="<%=RemoveTag.removeTag(ni.getContent()) %>">
<meta name="Author" content="프로스쿨">

<meta itemprop="name" content="프로스쿨 기업교육 | <%=ni.getTitle() %>">
<meta itemprop="description" content="<%=RemoveTag.removeTag(ni.getContent()) %>">
<meta itemprop="image" content="images/thumbnail.png">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">
<meta property="og:type" content="website">
<meta property="og:site_name" content="프로스쿨">
<meta property="og:title" content="프로스쿨 기업교육 | <%=ni.getTitle() %>">
<meta property="og:description" content="<%=RemoveTag.removeTag(ni.getContent()) %>">
<meta property="og:image" content="images/thumbnail.png">
<meta property="og:url" content="http://proschool.co.kr/news?view=news&menu=news_detail&idx=<%=ni.getIdx()%>">
<meta name="apple-mobile-web-app-title" content="proschool">
<meta name="application-name" content="proschool">

<!-- development -->
<link rel="stylesheet" href="css/user.css">
<script src="js/user.js"></script>

<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/newslistdetail.css">
<link rel="shortcut icon" href="images/favicon.ico">
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/swiper.min.css">
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/swiper.min.js"></script>

</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	
	<section class="news-list-detail-pg detail-pg">
        <div class="inner detail-content">
            <h3><%=ni.getTitle() %></h3>
            <p class="date"><%=ni.getViewDate().substring(0, 19) %></p>
            
            <p class="sub-text">
                <%=ni.getContent() %>
            </p>
            <div class="list-btn">
                <a href="javascript: history.go(-1);">목록보기</a>
            </div>
        </div>
    </section>
    
    <jsp:include page="./footer.jsp"></jsp:include>
</body>
 <script src="js/common.js"></script>
</html>