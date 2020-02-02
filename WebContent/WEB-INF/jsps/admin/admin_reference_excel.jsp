<%@page import="util.CategorySearch"%>
<%@page import="java.util.Calendar"%>
<%@page import="model.ReferenceModel"%>
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
	List<ReferenceModel> listReference = (List<ReferenceModel>) request.getAttribute("listReference");
	Calendar cal = Calendar.getInstance();
	String dateStr = String.format("%04d_%02d_%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1, cal.get(Calendar.DAY_OF_MONTH));
	NumberFormat nf = NumberFormat.getNumberInstance();
	nf.setMaximumFractionDigits(2);
		
	response.setHeader("Content-Disposition", "attachment;filename=references_"+dateStr+".xls");
	response.setHeader("Content-Description", "JSP Generated Data");

	OutputStream fileOut = null;

	HSSFWorkbook objWorkBook = new HSSFWorkbook();
	HSSFSheet objSheet = objWorkBook.createSheet();
	objWorkBook.setSheetName(0, "레퍼런스");

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
	objSheet.setColumnWidth(1, 6000);		//마스터
	objSheet.setColumnWidth(2, 5000);		//카테고리
	objSheet.setColumnWidth(3, 4000);		//평과결과
	objSheet.setColumnWidth(4, 8000);		//기업명
	objSheet.setColumnWidth(5, 13000);		//교육명
	objSheet.setColumnWidth(6, 6000);		//교육대상
	objSheet.setColumnWidth(7, 4000);		//교육인원
	objSheet.setColumnWidth(8, 4000);		//교육시간
	objSheet.setColumnWidth(9, 3000);		//숨김
	objSheet.setColumnWidth(10, 4500);		//등록일

	objSheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 10));

	//첫번 째 행
	objRow = objSheet.createRow(0);
	objRow.setHeightInPoints(40);

	objCell = objRow.createCell(0);
	objCell.setCellValue("레퍼런스 목록");
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
	
	//두번 째 행
	objRow = objSheet.createRow(1);
	objRow.setHeightInPoints(17);

	objCell = objRow.createCell(0);
	objCell.setCellValue("No.");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(1);
	objCell.setCellValue("마스터");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(2);
	objCell.setCellValue("카테고리");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(3);
	objCell.setCellValue("평가결과");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(4);
	objCell.setCellValue("기업명");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(5);
	objCell.setCellValue("교육명");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(6);
	objCell.setCellValue("교육대상");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(7);
	objCell.setCellValue("교육인원");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(8);
	objCell.setCellValue("교육시간");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(9);
	objCell.setCellValue("숨김");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(10);
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
	for(int i=0; i<listReference.size(); i++){
		ReferenceModel list = listReference.get(i);
		
		objRow = objSheet.createRow(celIdx);
		objRow.setHeightInPoints(17);
		
		objCell = objRow.createCell(0);
		objCell.setCellValue(i+1);
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(1);
		objCell.setCellValue(list.getMasterName());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(2);
		objCell.setCellValue(CategorySearch.getMasterCategory(list.getCategory()));
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(3);
		objCell.setCellValue(nf.format(list.getScore()));
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(4);
		objCell.setCellValue(list.getCompany());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(5);
		objCell.setCellValue(list.getEducation());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(6);
		objCell.setCellValue(list.getTarget());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(7);
		objCell.setCellValue(nf.format(list.getPeople()));
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(8);
		objCell.setCellValue(nf.format(list.getHour()));
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(9);
		if(list.getHide() == 0){
			objCell.setCellValue("보임");
		}else{
			objCell.setCellValue("숨김");
		}
		
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(10);
		objCell.setCellValue(list.getDate().substring(0, 10));
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
