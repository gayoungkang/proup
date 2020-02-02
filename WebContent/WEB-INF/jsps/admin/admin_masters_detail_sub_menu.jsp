<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
String menu = request.getParameter("menu");
	
%>

<table style="width: 100%;">
	<tr height="30px">
		<td 
			<%if("admin_masters_detail_history".equals(menu)){ %>
				class="tab-menu-active"
			<%}else{ %>
				class="tab-menu" 
				onclick="javascript: mastersSubMenuTab('history');"
			<%} %>>
			마스터 이력
		</td>
		<td 
			<%if("admin_masters_detail_activity".equals(menu)){ %>
				class="tab-menu-active"
			<%}else{ %>
				class="tab-menu" 
				onclick="javascript: mastersSubMenuTab('activity');"
			<%} %>>
			주요 활동
		</td>
		<td 
			<%if("admin_masters_detail_curriculum".equals(menu)){ %>
				class="tab-menu-active"
			<%}else{ %>
				class="tab-menu" 
				onclick="javascript: mastersSubMenuTab('curriculum');"
			<%} %>>
			커리큘럼
		</td>
		<td 
			<%if("admin_masters_detail_reference".equals(menu)){ %>
				class="tab-menu-active"
			<%}else{ %>
				class="tab-menu" 
				onclick="javascript: mastersSubMenuTab('reference');"
			<%} %>>
			레퍼런스
		</td>
		<td 
			<%if("admin_masters_detail_review".equals(menu)){ %>
				class="tab-menu-active"
			<%}else{ %>
				class="tab-menu" 
				onclick="javascript: mastersSubMenuTab('review');"
			<%} %>>
			후기
		</td>
		<td 
			<%if("admin_masters_detail_mastercut".equals(menu)){ %>
				class="tab-menu-active"
			<%}else{ %>
				class="tab-menu" 
				onclick="javascript: mastersSubMenuTab('mastercut');"
			<%} %>>
			마스터컷
		</td>
	</tr>
</table>