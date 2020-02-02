<%@page import="model.MastersModel"%>
<%@page import="util.CategorySearch"%>
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
	List<MastersModel> listMaster = (List<MastersModel>) request.getAttribute("listMaster");
	Calendar cal = Calendar.getInstance();
	String dateStr = String.format("%04d_%02d_%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1, cal.get(Calendar.DAY_OF_MONTH));
	NumberFormat nf = NumberFormat.getNumberInstance();
	nf.setMaximumFractionDigits(2);
		
	response.setHeader("Content-Disposition", "attachment;filename=masters_"+dateStr+".xls");
	response.setHeader("Content-Description", "JSP Generated Data");

	OutputStream fileOut = null;

	HSSFWorkbook objWorkBook = new HSSFWorkbook();
	HSSFSheet objSheet = objWorkBook.createSheet();
	objWorkBook.setSheetName(0, "마스터");

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
	objSheet.setColumnWidth(1, 4500);		//카테고리
	objSheet.setColumnWidth(2, 5000);		//이름
	objSheet.setColumnWidth(3, 3000);		//교육평가결과
	objSheet.setColumnWidth(4, 3000);		//강의컨설팅
	objSheet.setColumnWidth(5, 3000);		//누적교육생
	objSheet.setColumnWidth(6, 3000);		//후기 수
	objSheet.setColumnWidth(7, 3000);		//명예의전당
	objSheet.setColumnWidth(8, 3000);		//숨김
	objSheet.setColumnWidth(9, 8000);		//슬로건
	objSheet.setColumnWidth(10, 5000);		//태그
	objSheet.setColumnWidth(11, 7000);		//이력1
	objSheet.setColumnWidth(12, 7000);		//이력2
	objSheet.setColumnWidth(13, 10000);		//검색 타이틀
	objSheet.setColumnWidth(14, 15000);		//검색 설명
	objSheet.setColumnWidth(15, 15000);		//검색 키워드
	objSheet.setColumnWidth(16, 4500);		//등록일
	
	

	objSheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 16));

	//첫번 째 행
	objRow = objSheet.createRow(0);
	objRow.setHeightInPoints(40);

	objCell = objRow.createCell(0);
	objCell.setCellValue("마스터 목록");
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
	objCell = objRow.createCell(15);
	objCell.setCellStyle(objStyleTitle);
	objCell = objRow.createCell(16);
	objCell.setCellStyle(objStyleTitle);
	
	//두번 째 행
	objRow = objSheet.createRow(1);
	objRow.setHeightInPoints(17);

	objCell = objRow.createCell(0);
	objCell.setCellValue("No.");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(1);
	objCell.setCellValue("카테고리");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(2);
	objCell.setCellValue("이름");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(3);
	objCell.setCellValue("교육평가결과");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(4);
	objCell.setCellValue("강의/컨설팅");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(5);
	objCell.setCellValue("누적교육생");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(6);
	objCell.setCellValue("후기 수");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(7);
	objCell.setCellValue("명예의전당");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(8);
	objCell.setCellValue("숨김");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(9);
	objCell.setCellValue("슬로건");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(10);
	objCell.setCellValue("태그");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(11);
	objCell.setCellValue("이력1");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(12);
	objCell.setCellValue("이력2");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(13);
	objCell.setCellValue("검색 타이틀");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(14);
	objCell.setCellValue("검색 설명");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(15);
	objCell.setCellValue("검색 키워드");
	objCell.setCellStyle(objStyleHeader);
	objCell = objRow.createCell(16);
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
	for(int i=0; i<listMaster.size(); i++){
		MastersModel list = listMaster.get(i);
		
		objRow = objSheet.createRow(celIdx);
		objRow.setHeightInPoints(17);
		
		objCell = objRow.createCell(0);
		objCell.setCellValue(i+1);
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(1);
		objCell.setCellValue(CategorySearch.getMasterCategory(list.getCategory()));
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(2);
		objCell.setCellValue(list.getName());
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(3);
		objCell.setCellValue(nf.format(list.getReferenceScore())+" / 5");
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(4);
		objCell.setCellValue(nf.format(list.getReferenceCount())+" 건");
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(5);
		objCell.setCellValue(nf.format(list.getReferencePeople())+" 명");
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(6);
		objCell.setCellValue(nf.format(list.getReviewCount())+" 개");
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(7);
		if(list.getBestHide() == 0){
			objCell.setCellValue("보임");
		}else{
			objCell.setCellValue("숨김");
		}
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(8);
		if(list.getHide() == 0){
			objCell.setCellValue("보임");
		}else{
			objCell.setCellValue("숨김");
		}
		objCell.setCellStyle(styleCenter);
		objCell = objRow.createCell(9);
		objCell.setCellValue(list.getSlogan());
		objCell.setCellStyle(styleLeft);
		objCell = objRow.createCell(10);
		objCell.setCellValue(list.getTag());
		objCell.setCellStyle(styleLeft);
		objCell = objRow.createCell(11);
		objCell.setCellValue(list.getCompany());
		objCell.setCellStyle(styleLeft);
		objCell = objRow.createCell(12);
		objCell.setCellValue(list.getPosition());
		objCell.setCellStyle(styleLeft);
		objCell = objRow.createCell(13);
		objCell.setCellValue(list.getTitle());
		objCell.setCellStyle(styleLeft);
		objCell = objRow.createCell(14);
		objCell.setCellValue(list.getDescription());
		objCell.setCellStyle(styleLeft);
		objCell = objRow.createCell(15);
		objCell.setCellValue(list.getKeywords());
		objCell.setCellStyle(styleLeft);
		objCell = objRow.createCell(16);
		objCell.setCellValue(list.getDate().substring(0, 19));
		objCell.setCellStyle(styleLeft);
		
		celIdx++;
	}


	out.clear();
	out = pageContext.pushBody();

	fileOut = response.getOutputStream();
	objWorkBook.write(fileOut);
	fileOut.close();
	objWorkBook.close();
	
%>

