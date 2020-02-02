<%@page import="util.CategorySearch"%>
<%@page import="model.ReferenceModel"%>
<%@page import="util.RemoveTag"%>
<%@page import="model.NewsInfoModel"%>
<%@page import="java.util.List"%>
<%@page import="model.SearchModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SearchModel search = (SearchModel) request.getAttribute("search");
	List<ReferenceModel> listReference = (List<ReferenceModel>) request.getAttribute("listReference");
	
	String searchType = (String) request.getAttribute("searchType");
	String orderBy = (String) request.getAttribute("orderBy");
	
	String typeStr = "정렬기준";
	if("master_name".equals(searchType))		typeStr = "마스터";
	else if("date".equals(searchType))			typeStr = "일시";
	else if("company".equals(searchType))		typeStr = "기업명";
	else if("score".equals(searchType))			typeStr = "평가결과";
	else if("category".equals(searchType))		typeStr = "카테고리";
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
<meta property="og:url" content="http://proschool.co.kr/references">
<meta name="apple-mobile-web-app-title" content="proschool">
<meta name="application-name" content="proschool">

<!-- development -->
<link rel="stylesheet" href="css/user.css">
<script src="js/user.js"></script>

<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/reference.css">
<link rel="shortcut icon" href="images/favicon.ico">
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/swiper.min.css">
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/swiper.min.js"></script>

</head>
<body>
	<jsp:include page="./header.jsp"></jsp:include>
	
	
	<input type="hidden" id="searchType" value="<%=searchType %>" />
	<input type="hidden" id="orderBy" value="<%=orderBy %>" />

    <section class="data-detail-pg detail-pg">
        <div class="inner">
            <h2 class="detail-title">
                기업교육 레퍼런스
            </h2>
            <div class="btn-wrap clearfix">
                <div class="detail-select-box">
                    <div class="wrap">
                        <span><%=typeStr %></span>
                        <img src="./images/arrow.png" alt="이미지">
                    </div>
                    <ul class="select-list">
                        <li onclick="javascript: location.href='references?view=references';">
                            <div class="wrap">
                                <span>정렬기준</span>
                                <img src="./images/arrow.png" alt="이미지">
                            </div>
                        </li>
                        <li><a href="javascript: referenceSearch('master_name');">마스터</a></li>
                       	<li><a href="javascript: referenceSearch('date');">일시</a></li>
                        <li><a href="javascript: referenceSearch('company');">기업명</a></li>
                        <li><a href="javascript: referenceSearch('score');">평가결과</a></li>
                        <li><a href="javascript: referenceSearch('category');">카테고리</a></li>
                    </ul>
                </div>
                <a href="references?menu=references_excel" class="excel-btn">
                    <div class="wrap">
                        <span>엑셀다운받기</span>
                        <img src="./images/arrow.png" alt="이미지">
                    </div>
                </a>
            </div>
            <%if("ASC".equals(orderBy)){ %>
            	<div class="updown-btn up-btn" onclick="javascript: referenceSearchOrder();">
	                <div class="wrap clearfix">
	                    <span>오름차순</span><img src="./images/table-arrow.png" alt="오름차순 버튼">
	                </div>
	            </div>
            <%}else{ %>
            	<div class="updown-btn down-btn" style="display: block;" onclick="javascript: referenceSearchOrder();">
	                <div class="wrap clearfix">
	                    <span>내림차순</span><img src="./images/table-arrow-bown.png" alt="내림차순 버튼">
	                </div>
	            </div>
            <%} %>
            
            
            <div class="table-wrap">
            	<div class="overflow-wrap">
	                <table>
	                    <tbody>
	                        <tr>
	                        	<th>마스터</th>
	                            <%for(int i=0; i<listReference.size(); i++){
	                        		ReferenceModel list = listReference.get(i);
	                        		%>
	                        		<td><%=list.getMasterName() %></td>
	                        	<%} %>
	                        </tr>
	                        <tr>
	                            <th>평가결과</th>
	                            <%for(int i=0; i<listReference.size(); i++){
	                        		ReferenceModel list = listReference.get(i);
	                        		%>
	                        		<td class="color"><span class="auto"><%=list.getScore() %></span>/5</td>
	                        	<%} %>
	                        </tr>
	                        <tr>
	                            <th>기업명</th>
	                            <%for(int i=0; i<listReference.size(); i++){
	                        		ReferenceModel list = listReference.get(i);
	                        		%>
	                        		 <td><%=list.getCompany() %></td>
	                        	<%} %>
	                        </tr>
	                        <tr>
	                            <th>일시</th>
	                            <%for(int i=0; i<listReference.size(); i++){
	                        		ReferenceModel list = listReference.get(i);
	                        		%>
	                        		 <td><%=list.getDate().substring(0, 10) %></td>
	                        	<%} %>
	                        </tr>
	                        <tr>
	                            <th>교육명</th>
	                            <%for(int i=0; i<listReference.size(); i++){
	                        		ReferenceModel list = listReference.get(i);
	                        		%>
	                        		 <td><%=list.getEducation() %></td>
	                        	<%} %>
	                        </tr>
	                        <tr>
	                            <th>교육대상</th>
	                            <%for(int i=0; i<listReference.size(); i++){
	                        		ReferenceModel list = listReference.get(i);
	                        		%>
	                        		 <td><%=list.getTarget() %></td>
	                        	<%} %>
	                        </tr>
	                        <tr>
	                            <th>교육인원</th>
	                            <%for(int i=0; i<listReference.size(); i++){
	                        		ReferenceModel list = listReference.get(i);
	                        		%>
	                        		 <td><span><%=list.getPeople() %></span>명</td>
	                        	<%} %>
	                        </tr>
	                        <tr>
	                            <th>교육시간</th>
	                            <%for(int i=0; i<listReference.size(); i++){
	                        		ReferenceModel list = listReference.get(i);
	                        		%>
	                        		 <td><%=list.getHour() %></td>
	                        	<%} %>
	                        </tr>
	                        <tr>
	                            <th>카테고리</th>
	                            <%for(int i=0; i<listReference.size(); i++){
	                        		ReferenceModel list = listReference.get(i);
	                        		%>
	                        		 <td><%=CategorySearch.getMasterCategory(list.getCategory()) %></td>
	                        	<%} %>
	                        </tr>
	                    </tbody>
	                </table>
                </div>
            </div>
        </div>
    </section>
    
    <jsp:include page="./footer.jsp"></jsp:include>
</body>
<script src="js/common.js"></script>
<script src="js/reference.js"></script>
</html>