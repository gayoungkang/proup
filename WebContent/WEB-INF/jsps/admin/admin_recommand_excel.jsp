<%@page import="model.RecommandModel"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFDataFormat"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<RecommandModel> listRec = (List<RecommandModel>) request.getAttribute("listRec");
	Calendar cal = Calendar.getInstance();
	String dateStr = String.format("%04d_%02d_%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1, cal.get(Calendar.DAY_OF_MONTH));
	NumberFormat nf = NumberFormat.getNumberInstance();
	nf.setMaximumFractionDigits(2);
		
	response.setHeader("Content-Disposition", "attachment;filename=proposal_"+dateStr+".xls");
	response.setHeader("Content-Description", "JSP Generated Data");

	OutputStream fileOut = null;

	HSSFWorkbook objWorkBook = new HSSFWorkbook();
	HSSFSheet objSheet = objWorkBook.createSheet();
	objWorkBook.setSheetName(0, "교육제안서");

	HSSFRow objRow = null;
	HSSFCell objCell = null;

	HSSFDataFormat format = objWorkBook.createDataFormat();

	HSSFFont objFontHeader = objWorkBook.createFont();
	objFontHeader.setBold(true);

	HSSFCellStyle objStyleHeader = objWorkBook.createCellStyle();
	objStyleHeader.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	objStyleHeader.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	objStyleHeader.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	objStyleHeader.setBorderTop(HSSFCellStyle.BORDER_THIN);
	objStyleHeader.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	objStyleHeader.setBorderRight(HSSFCellStyle.BORDER_THIN);
	objStyleHeader.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	objStyleHeader.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
	objStyleHeader.setFont(objFontHeader);
	objStyleHeader.setWrapText(true);

	HSSFFont objFont9 = objWorkBook.createFont();
	objFont9.setFontHeightInPoints((short)9);

	HSSFFont objFont15 = objWorkBook.createFont();
	objFont15.setFontHeightInPoints((short)15);
	objFont15.setBold(true);

	HSSFCellStyle objStyleTitle = objWorkBook.createCellStyle();
	objStyleTitle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	objStyleTitle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	objStyleTitle.setFont(objFont15);

	HSSFCellStyle objStyleCenter = objWorkBook.createCellStyle();
	objStyleCenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	objStyleCenter.setFont(objFont9);

	HSSFCellStyle objStyleLeft = objWorkBook.createCellStyle();
	objStyleLeft.setAlignment(HSSFCellStyle.ALIGN_LEFT);
	objStyleLeft.setFont(objFont9);

	HSSFCellStyle objStyleRight = objWorkBook.createCellStyle();
	objStyleRight.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
	objStyleRight.setFont(objFont9);
	
	objSheet.setColumnWidth(0, 3000);		//No
	objSheet.setColumnWidth(1, 6000);		//강의분야
	objSheet.setColumnWidth(2, 6000);		//교육목적
	objSheet.setColumnWidth(3, 6000);		//교육대상자
	objSheet.setColumnWidth(4, 6000);		//대상자직무
	objSheet.setColumnWidth(5, 6000);		//교육시간
	objSheet.setColumnWidth(6, 6000);		//교육비예산
	objSheet.setColumnWidth(7, 10000);		//교육장소
	objSheet.setColumnWidth(8, 6000);		//교육요청일
	objSheet.setColumnWidth(9, 8000);		//교육운영
	objSheet.setColumnWidth(10, 12000);		//요청사항
	objSheet.setColumnWidth(11, 6000);		//회사명
	objSheet.setColumnWidth(12, 5000);		//연락처
	objSheet.setColumnWidth(13, 7000);		//이메일
	objSheet.setColumnWidth(14, 5000);		//등록일

	objSheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 14));

	//첫번 째 행
	objRow = objSheet.createRow(0);
	objRow.setHeightInPoints(40);

	objCell = objRow.createCell(0);
	objCell.setCellValue("교육제안서 목록");
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(1);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(2);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(3);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(4);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(5);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(6);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(7);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(8);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(9);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(10);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(11);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(12);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(13);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(14);
	objCell.setCellStyle(objStyleTitle);
	
	//두번 째 행
	objRow = objSheet.createRow(1);
	objRow.setHeightInPoints(17);

	objCell = objRow.createCell(0);
	objCell.setCellValue("No.");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(1);
	objCell.setCellValue("강의분야");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(2);
	objCell.setCellValue("교육목적");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(3);
	objCell.setCellValue("교육대상자");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(4);
	objCell.setCellValue("대상자직무");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(5);
	objCell.setCellValue("교육시간");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(6);
	objCell.setCellValue("교육비예산");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(7);
	objCell.setCellValue("교육장소");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(8);
	objCell.setCellValue("교육요청일");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(9);
	objCell.setCellValue("교육운영");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(10);
	objCell.setCellValue("요청사항");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(11);
	objCell.setCellValue("회사명");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(12);
	objCell.setCellValue("연락처");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(13);
	objCell.setCellValue("이메일");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(14);
	objCell.setCellValue("등록일");
	objCell.setCellStyle(objStyleHeader);
	
	/////////////// 셀 스타일 설정 /////
	HSSFCellStyle styleCenter = objWorkBook.createCellStyle();
	styleCenter.setWrapText(true);
	styleCenter.setAlignment(HSSFCellStyle.ALIGN_CENTER);		// 가로 정렬
	styleCenter.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	// 세로 정렬
	styleCenter.setBorderBottom(HSSFCellStyle.BORDER_THIN);		// 테두리
	styleCenter.setBorderTop(HSSFCellStyle.BORDER_THIN);
	styleCenter.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	styleCenter.setBorderRight(HSSFCellStyle.BORDER_THIN);
	styleCenter.setFont(objFont9);
	HSSFCellStyle styleLeft = objWorkBook.createCellStyle();
	styleLeft.setWrapText(true);
	styleLeft.setAlignment(HSSFCellStyle.ALIGN_LEFT);			// 가로 정렬
	styleLeft.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	// 세로 정렬
	styleLeft.setBorderBottom(HSSFCellStyle.BORDER_THIN);		// 테두리
	styleLeft.setBorderTop(HSSFCellStyle.BORDER_THIN);
	styleLeft.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	styleLeft.setBorderRight(HSSFCellStyle.BORDER_THIN);
	styleLeft.setFont(objFont9);
	HSSFCellStyle styleRight = objWorkBook.createCellStyle();
	styleRight.setAlignment(HSSFCellStyle.ALIGN_RIGHT);			// 가로 정렬
	styleRight.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	// 세로 정렬
	styleRight.setBorderBottom(HSSFCellStyle.BORDER_THIN);		// 테두리
	styleRight.setBorderTop(HSSFCellStyle.BORDER_THIN);
	styleRight.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	styleRight.setBorderRight(HSSFCellStyle.BORDER_THIN);
	styleRight.setFont(objFont9);
	styleRight.setDataFormat(format.getFormat("#,##0"));		// 숫자서식 지정

	
	int celIdx = 2;
	for(int i=0; i<listRec.size(); i++){
		RecommandModel list = listRec.get(i);
		
		objRow = objSheet.createRow(celIdx);
		objRow.setHeightInPoints(17);
		
		objCell = objRow.createCell(0);
		objCell.setCellValue(i+1);
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(1);
		objCell.setCellValue(list.getCategory());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(2);
		objCell.setCellValue(list.getPurpose());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(3);
		objCell.setCellValue(list.getTarget());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(4);
		objCell.setCellValue(list.getTargetPosition());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(5);
		objCell.setCellValue(list.getHour());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(6);
		objCell.setCellValue(list.getPrice());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(7);
		objCell.setCellValue(list.getPlace());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(8);
		objCell.setCellValue(list.getRequestDate());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(9);
		objCell.setCellValue(list.getManage());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(10);
		objCell.setCellValue(list.getRequest());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(11);
		objCell.setCellValue(list.getCompany());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(12);
		objCell.setCellValue(list.getContact());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(13);
		objCell.setCellValue(list.getEmail());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(14);
		objCell.setCellValue(list.getDate().substring(0, 19));
		objCell.setCellStyle(styleCenter);
		
		celIdx++;
	}


	out.clear();
	out = pageContext.pushBody();

	fileOut = response.getOutputStream();
	objWorkBook.write(fileOut);
	fileOut.close();
	objWorkBook.close();
	
%>
