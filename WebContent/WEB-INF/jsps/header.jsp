<%@page import="model.SetupModel"%>
<%@page import="dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
UserDAO uDao = new UserDAO();
SetupModel setup = uDao.selectSetup();
uDao.dbClose();

String view = request.getParameter("view");
%>
<header class="w-header" style="background-color: <%=setup.getColor()%>;">
    <div class="inner clearfix">
        <div class="col-1" style="cursor: pointer;" onclick="javascript: tell('<%=setup.getContact()%>');">
            <img src="images/telephone.png" alt="전화번호">
            <span><%=setup.getContact() %></span>
        </div>
        <a class="col-2" href="main"><img src="<%=setup.getLogo() %>" alt="로고"></a>
        <a href="<%=setup.getPdf() %>" class="col-3" target="_blank">
            <div class="wrap">
                <span>통합 교육 제안서</span>
                <img src="images/arrow.png" alt="다운받기">
            </div>
        </a>
    </div>
    <nav>
        <ul class="clearfix">
            <li><a href="masters?view=masters" <%if("masters".equals(view)){ %>class="top-menu-active"<%} %>>MASTER</a></li>
            <li><a href="references?view=references" <%if("references".equals(view)){ %>class="top-menu-active"<%} %>>REFERENCE</a></li>
            <li><a href="news?view=news" <%if("news".equals(view)){ %>class="top-menu-active"<%} %>>NEWS</a></li>
        </ul>
    </nav>
</header>

<header class="m-header" style="background-color: <%=setup.getColor()%>;">
    <div class="inner">
        <a class="logo" href="main"><img src="<%=setup.getLogo() %>" alt="로고"></a>
        <img class="menu" src="images/menu.png" alt="menu">
    </div>
    <div class="nav-back">
        <nav>
            <div class="phon">
                <div class="wrap clearfix" style="cursor: pointer;" onclick="javascript: tell('<%=setup.getContact()%>');">
                    <img src="images/telephone.png" alt="전화번호">
                    <span><%=setup.getContact() %></span>
                </div>
                <img class="close-btn" src="images/close.png" alt="닫기">
            </div>
            <ul class="nav-list">
                <li><a href="masters?view=masters">MASTER</a></li>
                <li><a href="references?view=references">REFERENCE</a></li>
                <li><a href="news?view=news">NEWS</a></li>
            </ul>
            <a href="<%=setup.getPdf() %>" class="down" target="_blank">
                <div class="wrap">
                    <span>통합 교육 제안서</span>
                    <img src="images/arrow.png" alt="다운받기">
                </div>
            </a>
        </nav>
    </div>
</header>

