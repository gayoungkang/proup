<%@page import="model.SetupModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	String menu = request.getParameter("menu");
	SetupModel setup = (SetupModel) request.getAttribute("setup");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자</title>
<!-- jQuery -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/admin.js"></script>

<link rel="stylesheet" href="css/jquery-ui.css">
<link rel="stylesheet" href="css/admin.css">

<script src="js/jodit.min.js"></script>
<link rel="stylesheet" href="js/jodit.min.css">

</head>
<body>

<jsp:include page="./admin_menu.jsp"></jsp:include>

<div class="content-wrap">
	<span class="content-title">설정</span>
	<div class="content-div">
		<table style="width: 100%; margin-bottom: 10px;">
			<tr height="30px">
				<td 
					<%if("admin_setup_content".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: setupSubMenuTab('content');"
					<%} %>>
					설정
				</td>
				<td 
					<%if("admin_setup_information".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: setupSubMenuTab('information');"
					<%} %>>
					개인정보처리방침
				</td>
				<td 
					<%if("admin_setup_site".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: setupSubMenuTab('site');"
					<%} %>>
					패밀리 사이트
				</td>
				<td 
					<%if("admin_setup_popup".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: setupSubMenuTab('popup');"
					<%} %>>
					팝업 관리
				</td>
				<td 
					<%if("admin_setup_password".equals(menu)){ %>
						class="tab-menu-active"
					<%}else{ %>
						class="tab-menu" 
						onclick="javascript: setupSubMenuTab('password');"
					<%} %>>
					비밀번호 변경
				</td>
			</tr>
		</table>
		<form action="admin" method="post" onsubmit="javascript:return setupInformationSubmit();" > 
			<input type="hidden" name="mode" value="update_setup_information" />
			<table class="content-table" >
				<tr><td><textarea id="information" name="information"><%=setup.getInformation() %></textarea></td></tr>
			</table>
			<div class="btn-center-wrap">
				<button type="submit" class="btn-default">적용</button>
			</div>
			<div style="height: 300px; clear: both;"></div>
		</form>
	</div>
</div>


<script type="text/javascript">
	
	var editor = new Jodit('#information', {
	    "height" : 800,
		enableDragAndDropFileToEditor: true,
	    uploader: {
	        url: 'fileupload?type=information',
	        format: 'json',
	        prepareData: function (data) {
	            return data;
	        },
	        isSuccess: function (resp) {
	            return !resp.error;
	        },
	        getMsg: function (resp) {
	            return resp.msg.join !== undefined ? resp.msg.join(' ') : resp.msg;
	        },
	        process: function (resp) {
	        	console.log('baseurl = '+resp.baseurl);
	            return {
	                files: resp.images,
	                path: resp.path,
	                baseurl: resp.baseurl,
	                error: resp.error,
	                msg: resp.msg
	            };
	        },
	        error: function (e) {
	            this.events.fire('errorPopap', [e.getMessage(), 'error', 4000]);
	        },
	        defaultHandlerSuccess: function (data, resp) {
	            var i, field = 'images';
	            if (data[field] && data[field].length) {
	                for (i = 0; i < data[field].length; i += 1) {
	                    this.selection.insertImage(data.baseurl + data[field][i]);
	                }
	            }
	        },
	        defaultHandlerError: function (resp) {
	            this.events.fire('errorPopap', [this.options.uploader.getMsg(resp)]);
	        }
	    },
	    "buttons": "|,bold,strikethrough,underline,italic,|,superscript,subscript,|,ul,ol,|,outdent,indent,|,font,fontsize,brush,paragraph,|,image,video,table,|,align,undo,redo,\n,cut,hr,eraser,copyformat,|,symbol,fullsize,selectall"
	});
</script>

</body>
</html>