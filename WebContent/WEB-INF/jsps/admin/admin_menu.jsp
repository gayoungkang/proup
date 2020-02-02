<%@page import="model.SetupModel"%>
<%@page import="dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String type = request.getParameter("type");
	AdminDAO aDao = new AdminDAO();
	SetupModel setup = aDao.selectSetup();
	aDao.dbClose();
%>
<html>
<head>
<style type="text/css">

</style>
</head>
<body>
<div class="admin-menu-wrap" >
	<div class="menu-title-wrap" ><img src="<%=setup.getLogo() %>" /></div>
	<ul class="menu-ul" style="">
		<li class="menu-li"><a <%if("masters".equals(type)){ %>class="menu_a_active"<%}else{ %> class="menu_a"<%} %> href="admin?type=masters&menu=admin_masters">마스터 관리</a></li>
		<li class="menu-li"><a <%if("reference".equals(type)){ %>class="menu_a_active"<%}else{ %> class="menu_a"<%} %> href="admin?type=reference&menu=admin_reference">레퍼런스 관리</a></li>
		<li class="menu-li"><a <%if("news".equals(type)){ %>class="menu_a_active"<%}else{ %> class="menu_a"<%} %> href="admin?type=news&menu=admin_news_list">뉴스 관리</a></li>
		<li class="menu-li"><a <%if("main_review".equals(type)){ %>class="menu_a_active"<%}else{ %> class="menu_a"<%} %> href="admin?type=main_review&menu=admin_main_review">메인 리뷰 관리</a></li>
		<li class="menu-li"><a <%if("search".equals(type)){ %>class="menu_a_active"<%}else{ %> class="menu_a"<%} %> href="admin?type=search&menu=admin_search_main">검색 키워드 관리</a></li>
		<li class="menu-li"><a <%if("stibee".equals(type)){ %>class="menu_a_active"<%}else{ %> class="menu_a"<%} %> href="admin?type=stibee&menu=admin_stibee">스티비 목록</a></li>
		<li class="menu-li"><a <%if("recommand".equals(type)){ %>class="menu_a_active"<%}else{ %> class="menu_a"<%} %> href="admin?type=recommand&menu=admin_recommand">교육제안서 목록</a></li>
		<li class="menu-li"><a <%if("contact".equals(type)){ %>class="menu_a_active"<%}else{ %> class="menu_a"<%} %> href="admin?type=contact&menu=admin_contact">문의하기 목록</a></li>
		<li class="menu-li"><a <%if("apply".equals(type)){ %>class="menu_a_active"<%}else{ %> class="menu_a"<%} %> href="admin?type=apply&menu=admin_apply">마스터 지원 목록</a></li>
		<li class="menu-li"><a <%if("setup".equals(type)){ %>class="menu_a_active"<%}else{ %> class="menu_a"<%} %> href="admin?type=setup&menu=admin_setup_content">설정</a></li>
		<li class="menu-li"><a class="menu_a" href="admin?menu=admin_logout">로그아웃</a></li>
	</ul>
</div>
</body>
</html>