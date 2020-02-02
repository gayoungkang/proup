package util;

public class PageNavigator {

	/**
	 * ����¡ �׺�����͸� ������ִ� �Լ�
	 * @param pageName		- ��ũ ��������
	 * @param totalCount	- �Ѽ�
	 * @param listCount		- ����� ��� �Խù� ��
	 * @param pagePerBlock	- ����� ��� ��
	 * @param pageNum		- ������ ��ȣ
	 * @param addParam		- �߰� �Ķ����
	 * @return
	 */

	public String getPageNavigator(String pageName, int totalCount, int listCount, int pagePerBlock, int pageNum, String addParam) {
		
		StringBuffer sb = new StringBuffer();
		if(totalCount > 0) {
			int totalNumOfPage = (totalCount % listCount == 0) ? 
					totalCount / listCount :
					totalCount / listCount + 1;
			
			int totalNumOfBlock = (totalNumOfPage % pagePerBlock == 0) ?
					totalNumOfPage / pagePerBlock :
					totalNumOfPage / pagePerBlock + 1;
			
			int currentBlock = (pageNum % pagePerBlock == 0) ? 
					pageNum / pagePerBlock :
					pageNum / pagePerBlock + 1;
			
			int startPage = (currentBlock - 1) * pagePerBlock + 1;
			int endPage = startPage + pagePerBlock - 1;
			
			if(endPage > totalNumOfPage)
				endPage = totalNumOfPage;
			boolean isNext = false;
			boolean isPrev = false;
			if(currentBlock < totalNumOfBlock)
				isNext = true;
			if(currentBlock > 1)
				isPrev = true;
			if(totalNumOfBlock == 1){
				isNext = false;
				isPrev = false;
			}
			if(pageNum > 1){
				sb.append("<a class=\"navi\" href=\"").append(pageName+"?pageNum=1"+addParam);
				sb.append("\" title=\"<<\">< 이전</a>&nbsp;&nbsp;&nbsp;");
			}
			if (isPrev) {
				int goPrevPage = startPage - pagePerBlock;			
				//sb.append("&nbsp;&nbsp;<a class=\"navi\" href=\"").append(pageName+"?pageNum="+goPrevPage+addParam);
				//sb.append("\" title=\"<\"><</a>&nbsp;&nbsp;");
			} else {
				
			}
			for (int i = startPage; i <= endPage; i++) {
				if (i == pageNum) {
					sb.append("<a class=\"navi navi_active\" href=\"#\"  >" ).append(i).append("</a>&nbsp;&nbsp;");
				} else {
					sb.append("<a class=\"navi\" href=\"").append(pageName+"?pageNum="+i+addParam);
					sb.append("\" title=\""+i+"\">").append(i).append("</a>&nbsp;&nbsp;");
				}
			}
			if (isNext) {
				int goNextPage = startPage + pagePerBlock;
	
				//sb.append("<a class=\"navi\" href=\"").append(pageName+"?pageNum="+goNextPage+addParam);
				//sb.append("\" title=\">\">�� �ڷ�></a>");
			} else {
				
			}
			if(totalNumOfPage > pageNum){
				sb.append("&nbsp;&nbsp;&nbsp;<a class=\"navi\" href=\"").append(pageName+"?pageNum="+totalNumOfPage+addParam);
				sb.append("\" title=\">>\">다음 ></a>");
			}
			
		}
		return sb.toString();
	}
	
}
