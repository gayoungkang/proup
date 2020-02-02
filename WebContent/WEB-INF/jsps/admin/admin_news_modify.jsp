<%@page import="model.NewsInfoModel"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	String menu = request.getParameter("menu");
	NewsInfoModel ni = (NewsInfoModel) request.getAttribute("ni");
	
	String dateStr[] = ni.getViewDate().substring(0, 19).split(" ");
	String dateTimeStr[] = dateStr[1].split(":");
	
	Calendar cal = Calendar.getInstance();
	String date = String.format("%04d-%02d-%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1, cal.get(Calendar.DAY_OF_MONTH));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자</title>
<!-- jQuery -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/admin.js"></script>
<script src="js/jquery-ui.js"></script>
<link rel="stylesheet" href="css/jquery-ui.css">
<link rel="stylesheet" href="css/admin.css">
<script src="js/jodit.min.js"></script>
<link rel="stylesheet" href="js/jodit.min.css">

<script type="text/javascript">
$(function(){
	$.datepicker.regional['ko'] = {
		closeText: '닫기',
		prevText: '이전',
		nextText: '다음',
		currentText: '오늘',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true,
		changeMonth: true,
		changeYear: true,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	
	$("#view_date").datepicker();
	$("#view_date").datepicker('setDate', '<%=dateStr[0] %>');
	
	
});

</script>
</head>
<body>

<jsp:include page="./admin_menu.jsp"></jsp:include>

<div class="content-wrap">
	<span class="content-title" style="margin-top: 20px;">뉴스 수정</span>
	<div class="content-div">
		
		<form action="admin" method="post" onsubmit="javascript:return modifyNewsSubmit();">
			<input type="hidden" name="mode" value="update_news" />
			<input type="hidden" name="idx" value="<%=ni.getIdx() %>" />
			<table class="content-table" style="width: 1000px;">
				<tr>
					<td style="width: 200px; text-align: center;">카테고리</td>
					<td style="width: 800px;">
						<select class="input-default" name="type" >
							<option value="1" <%if(ni.getType() == 1){ %>selected="selected"<%} %>>프로스쿨</option>
							<option value="2" <%if(ni.getType() == 2){ %>selected="selected"<%} %>>마스터</option>
							<option value="3" <%if(ni.getType() == 3){ %>selected="selected"<%} %>>공지</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">썸네일</td>
					<td>
						<input type="file" id="thumbnail" name="thumbnail" class="input-default" style="padding-top: 3px;" onchange="javascript: newsFileUpload('thumbnail');" />
						<input type="hidden" id="thumbnail_data" name="thumbnail_data" />
						<input type="hidden" id="thumbnail_old" name="thumbnail_old" value="<%=ni.getThumbnail() %>" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">예약여부</td>
					<td>
						<select class="input-default" id="reservation" name="reservation" onchange="javascript: newsAddReserve();" >
							<option value="0" <%if(ni.getListingCheck() == 1){ %> selected="selected" <%} %>>바로등록</option>
							<option value="1" <%if(ni.getListingCheck() == 0){ %> selected="selected" <%} %>>예약</option>
						</select>
					</td>
				</tr>
				<tr id="date_tr" <%if(ni.getListingCheck() == 1){ %> style="display: none;" <%} %>>
					<td style="text-align: center;">리스팅 일자</td>
					<td>
						<input type="text" class="input-default" id="view_date" name="view_date" style="float: left; width: 120px;" />
						<select class="input-default" name="view_hour" style="float: left; width: 60px; margin-left: 5px;" >
							<%for(int i=0; i<=23; i++){ %>
								<option value="<%=String.format("%02d", i)%>" <%if(dateTimeStr[0].equals(String.format("%02d", i))){ %> selected="selected" <%} %>><%=String.format("%02d", i)%></option>
							<%} %>
						</select>
						<span style="height: 30px; display: block; float: left; margin-left: 5px; line-height: 30px;">:</span>
						<select class="input-default" name="view_minute" style="float: left; width: 60px; margin-left: 5px;" >
							<%for(int i=0; i<=59; i++){ %>
								<option value="<%=String.format("%02d", i)%>" <%if(dateTimeStr[1].equals(String.format("%02d", i))){ %> selected="selected" <%} %>><%=String.format("%02d", i)%></option>
							<%} %>
						</select>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">제목</td>
					<td>
						<input type="text" id="title" name="title" class="input-default" value="<%=ni.getTitle() %>" />
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">내용</td>
					<td>
						<textarea id="content" name="content"><%=ni.getContent() %></textarea>
					</td>
				</tr>
				<tr>
					<td style="text-align: center;">검색 키워드</td>
					<td>
						<textarea id="keywords" name="keywords" class="input-default" style="height: 50px;"><%=ni.getKeywords() %></textarea>
					</td>
				</tr>
				<tr style="border: none; height: 80px;">
					<td style="text-align: center;" colspan="2">
						<button type="submit" class="btn-green">수정</button>
					</td>
				</tr>
			</table>
		</form>
		<div style="width: 100%; height: 100px;"></div>
	</div>
</div>


<script type="text/javascript">
	
	var editor = new Jodit('#content', {
	    "height" : 700,
		enableDragAndDropFileToEditor: true,
	    uploader: {
	        url: 'fileupload?type=news',
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