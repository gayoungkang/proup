package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.PageNavigator;
import model.ContactModel;
import model.CurriculumDetailModel;
import model.CurriculumModel;
import model.FamilySiteModel;
import model.MainReviewModel;
import model.MastersActivityModel;
import model.MastersApplyModel;
import model.MastersCutModel;
import model.MastersHistoryModel;
import model.MastersModel;
import model.MastersReviewModel;
import model.NewsInfoModel;
import model.PopupModel;
import model.RecommandModel;
import model.ReferenceModel;
import model.SearchModel;
import model.SetupModel;
import model.SubscribeModel;
import dao.AdminDAO;

/**
 * Servlet implementation class Admin
 */
@WebServlet(name = "admin", urlPatterns = { "/admin" })
public class Admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		/* login check */
		HttpSession session = request.getSession();
		String adminCheck = (String) session.getAttribute("adminCheck");
		
		/* not login */
		if(adminCheck == null){
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_login.jsp");
			dispatcher.forward(request, response);
		}
		
		/* use login */
		else{
			// define DAO
			AdminDAO aDao = new AdminDAO();
			
			/* menu parameter */
			String menu = request.getParameter("menu");
			
			/* masters list */
			if("admin_masters".equals(menu)){
				String pageNum = request.getParameter("pageNum");
				String searchText = request.getParameter("searchText");
				
				if(pageNum == null)
					pageNum = "1";
				
				if(searchText == null)
					searchText = "";
				
				MastersModel master = new MastersModel();
				master.setPageNum(pageNum);
				master.setSearchText(searchText);
				
				List<MastersModel> listMaster = aDao.selectListMasters(master);
				int totalCount = aDao.selectCountListMasters(master);
				aDao.dbClose();
				
				String addParam = "&menu=admin_masters&searchText="+searchText;
				
				request.setAttribute("searchText", searchText);
				request.setAttribute("listMaster", listMaster);
				request.setAttribute("totalCount", totalCount);
				request.setAttribute("master", master);
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin", totalCount, master.getListCount(), master.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_masters.jsp");
				dispatcher.forward(request, response);
			}
			
			/* masters list excel */
			else if("admin_masters_excel".equals(menu)){
				//selectListMastersForExcel
				List<MastersModel> listMaster = aDao.selectListMastersForExcel();
				aDao.dbClose();
				
				request.setAttribute("listMaster", listMaster);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_masters_excel.jsp");
				dispatcher.forward(request, response);
			}
			
			/* masters write */
			else if("admin_masters_write".equals(menu)){
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_masters_write.jsp");
				dispatcher.forward(request, response);
			}
			
			/* masters modify */
			else if("admin_masters_modify".equals(menu)){
				int idx = Integer.parseInt(request.getParameter("idx"));
				
				MastersModel master = aDao.selectMasters(idx);
				aDao.dbClose();
				
				request.setAttribute("master", master);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_masters_modify.jsp");
				dispatcher.forward(request, response);
			}
			
			/* masters detail page for history */
			else if("admin_masters_detail_history".equals(menu)){
				int idx = Integer.parseInt(request.getParameter("idx"));
				
				MastersModel master = aDao.selectMasters(idx);
				List<MastersHistoryModel> listHistory = aDao.selectListMastersHistory(idx);
				aDao.dbClose();
				
				request.setAttribute("master", master);
				request.setAttribute("listHistory", listHistory);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_masters_detail_history.jsp");
				dispatcher.forward(request, response);
			}
			
			/* masters detail page for activity */
			else if("admin_masters_detail_activity".equals(menu)){
				int idx = Integer.parseInt(request.getParameter("idx"));
				
				MastersModel master = aDao.selectMasters(idx);
				List<MastersActivityModel> listActivity = aDao.selectListMastersActivity(idx);
				aDao.dbClose();
				
				request.setAttribute("master", master);
				request.setAttribute("listActivity", listActivity);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_masters_detail_activity.jsp");
				dispatcher.forward(request, response);
			}
			
			/* masters detail page for curriculum */
			else if("admin_masters_detail_curriculum".equals(menu)){
				int idx = Integer.parseInt(request.getParameter("idx"));
				
				MastersModel master = aDao.selectMasters(idx);
				List<CurriculumModel> listCurri = aDao.selectListCurriculum(idx);
				List<CurriculumDetailModel> listCD = aDao.selectListCurriDetail(idx);
				
				aDao.dbClose();
				
				request.setAttribute("master", master);
				request.setAttribute("listCurri", listCurri);
				request.setAttribute("listCD", listCD);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_masters_detail_curriculum.jsp");
				dispatcher.forward(request, response);
			}
			
			/* masters detail page for reference */
			else if("admin_masters_detail_reference".equals(menu)){
				int idx = Integer.parseInt(request.getParameter("idx"));
				
				MastersModel master = aDao.selectMasters(idx);
				List<ReferenceModel> listReference = aDao.selectListReferenceForMasterDetail(idx);
				aDao.dbClose();
				
				request.setAttribute("master", master);
				request.setAttribute("listReference", listReference);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_masters_detail_reference.jsp");
				dispatcher.forward(request, response);
			}
			
			/* masters detail page for review */
			else if("admin_masters_detail_review".equals(menu)){
				int idx = Integer.parseInt(request.getParameter("idx"));
				
				MastersModel master = aDao.selectMasters(idx);
				List<MastersReviewModel> listMR = aDao.selectListMastersReview(idx);
				aDao.dbClose();
				
				request.setAttribute("master", master);
				request.setAttribute("listMR", listMR);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_masters_detail_review.jsp");
				dispatcher.forward(request, response);
			}
			
			/* masters detail page for mastercut */
			else if("admin_masters_detail_mastercut".equals(menu)){
				int idx = Integer.parseInt(request.getParameter("idx"));
				
				MastersModel master = aDao.selectMasters(idx);
				List<MastersCutModel> listMC = aDao.selectListMastersCut(idx);
				aDao.dbClose();
				
				request.setAttribute("master", master);
				request.setAttribute("listMC", listMC);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_masters_detail_mastercut.jsp");
				dispatcher.forward(request, response);
			}
			
			/* reference page */
			else if("admin_reference".equals(menu)){
				String pageNum = request.getParameter("pageNum");
				String searchText = request.getParameter("searchText");
				String searchType = request.getParameter("searchType");
				
				if(pageNum == null){
					pageNum = "1";
				}
				
				if(searchText == null){
					searchText = "";
					searchType = "all";
				}
				
				ReferenceModel reference = new ReferenceModel();
				reference.setPageNum(pageNum);
				reference.setSearchText(searchText);
				reference.setSearchType(searchType);
				
				List<ReferenceModel> listReference = aDao.selectListReference(reference);
				int totalCount = aDao.selectCountListReference(reference);
				List<MastersModel> listMasters = aDao.selectListMastersForAddReference();
				
				aDao.dbClose();
				
				String addParam = "&menu=admin_reference&searchText="+searchText+"&searchType="+searchType;
				
				request.setAttribute("searchType", searchType);
				request.setAttribute("searchText", searchText);
				request.setAttribute("listReference", listReference);
				request.setAttribute("listMasters", listMasters);
				request.setAttribute("totalCount", totalCount);
				request.setAttribute("reference", reference);
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin", totalCount, reference.getListCount(), reference.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_reference.jsp");
				dispatcher.forward(request, response);
			}
			
			/* reference_excel page */
			else if("admin_reference_excel".equals(menu)){
				List<ReferenceModel> listReference = aDao.selectListReferenceForExcel();
				aDao.dbClose();
				
				request.setAttribute("listReference", listReference);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_reference_excel.jsp");
				dispatcher.forward(request, response);
			}
			
			/* news list page */
			else if("admin_news_list".equals(menu)){
				String pageNum = request.getParameter("pageNum");
				String searchText = request.getParameter("searchText");
				String searchType = request.getParameter("searchType");
				
				if(pageNum == null)
					pageNum = "1";
				
				if(searchText == null){
					searchText = "";
					searchType = "all";
				}
				
				NewsInfoModel ni = new NewsInfoModel();
				ni.setPageNum(pageNum);
				ni.setSearchText(searchText);
				ni.setSearchType(searchType);
				
				List<NewsInfoModel> listNI = aDao.selectListNewsInfo(ni);
				List<NewsInfoModel> topListNI = aDao.selectListNewsForTopRolling();
				int totalCount = aDao.selectCountListNewsInfo(ni);
				aDao.dbClose();
				
				String addParam = "&menu=admin_news_list&searchText="+searchText+"&searchType="+searchType;
				
				request.setAttribute("topListNI", topListNI);
				request.setAttribute("searchType", searchType);
				request.setAttribute("searchText", searchText);
				request.setAttribute("listNI", listNI);
				request.setAttribute("totalCount", totalCount);
				request.setAttribute("ni", ni);
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin", totalCount, ni.getListCount(), ni.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_news_list.jsp");
				dispatcher.forward(request, response);
			}
			
			/* news write page */
			else if("admin_news_write".equals(menu)){
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_news_write.jsp");
				dispatcher.forward(request, response);
			}
			
			/* news detail page */
			else if("admin_news_detail".equals(menu)){
				int idx = Integer.parseInt(request.getParameter("idx"));
				
				NewsInfoModel ni = aDao.selectNewsInfo(idx);
				aDao.dbClose();
				request.setAttribute("ni", ni);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_news_detail.jsp");
				dispatcher.forward(request, response);
			}
			
			/* news modify page */
			else if("admin_news_modify".equals(menu)){
				int idx = Integer.parseInt(request.getParameter("idx"));
				
				NewsInfoModel ni = aDao.selectNewsInfo(idx);
				aDao.dbClose();
				request.setAttribute("ni", ni);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_news_modify.jsp");
				dispatcher.forward(request, response);
			}
			
			/* main review list page */
			else if("admin_main_review".equals(menu)){
				String pageNum = request.getParameter("pageNum");
				String searchText = request.getParameter("searchText");
				String searchType = request.getParameter("searchType");
				
				if(pageNum == null)
					pageNum = "1";
				
				if(searchText == null){
					searchText = "";
					searchType = "all";
				}
				
				MainReviewModel mr = new MainReviewModel();
				mr.setPageNum(pageNum);
				mr.setSearchText(searchText);
				mr.setSearchType(searchType);
				
				List<MainReviewModel> listMR = aDao.selectListMainReview(mr);
				int totalCount = aDao.selectCountListMainReview(mr);
				aDao.dbClose();
				
				String addParam = "&menu=admin_main_review&searchText="+searchText+"&searchType="+searchType;
				
				request.setAttribute("searchType", searchType);
				request.setAttribute("searchText", searchText);
				request.setAttribute("listMR", listMR);
				request.setAttribute("totalCount", totalCount);
				request.setAttribute("mr", mr);
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin", totalCount, mr.getListCount(), mr.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_main_review.jsp");
				dispatcher.forward(request, response);
			}
			
			/* main search keyword */
			else if("admin_search_main".equals(menu)){
				SearchModel search = aDao.selectSearch(1);
				aDao.dbClose();
				request.setAttribute("search", search);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_search_main.jsp");
				dispatcher.forward(request, response);
			}
			
			/* references search keyword */
			else if("admin_search_references".equals(menu)){
				SearchModel search = aDao.selectSearch(2);
				aDao.dbClose();
				request.setAttribute("search", search);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_search_references.jsp");
				dispatcher.forward(request, response);
			}
			
			/* masters search keyword */
			else if("admin_search_masters".equals(menu)){
				SearchModel search = aDao.selectSearch(3);
				aDao.dbClose();
				request.setAttribute("search", search);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_search_masters.jsp");
				dispatcher.forward(request, response);
			}
			
			/* masters search keyword */
			else if("admin_search_news".equals(menu)){
				SearchModel search = aDao.selectSearch(4);
				aDao.dbClose();
				request.setAttribute("search", search);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_search_news.jsp");
				dispatcher.forward(request, response);
			}
			
			/* contact list */
			else if("admin_contact".equals(menu)){
				String pageNum = request.getParameter("pageNum");
				String searchText = request.getParameter("searchText");
				if(pageNum == null){
					pageNum = "1";
				}
				
				if(searchText == null){
					searchText = "";
				}
				
				ContactModel contact = new ContactModel();
				contact.setPageNum(pageNum);
				contact.setSearchText(searchText);
				
				List<ContactModel> listContact = aDao.selectListContact(contact);
				int totalCount = aDao.selectCountListContact(contact);
				aDao.dbClose();
				
				String addParam = "&menu=admin_contact&searchText="+searchText;
				
				request.setAttribute("searchText", searchText);
				request.setAttribute("listContact", listContact);
				request.setAttribute("totalCount", totalCount);
				request.setAttribute("contact", contact);
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin", totalCount, contact.getListCount(), contact.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_contact.jsp");
				dispatcher.forward(request, response);
			}
			
			/* contact list excel */
			else if("admin_contact_excel".equals(menu)){
				List<ContactModel> listContact = aDao.selectListContactForExcel();
				aDao.dbClose();
				
				request.setAttribute("listContact", listContact);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_contact_excel.jsp");
				dispatcher.forward(request, response);
			}
			
			/* apply list */
			else if("admin_apply".equals(menu)){
				String pageNum = request.getParameter("pageNum");
				String searchText = request.getParameter("searchText");
				if(pageNum == null){
					pageNum = "1";
				}
				
				if(searchText == null){
					searchText = "";
				}
				
				MastersApplyModel ma = new MastersApplyModel();
				ma.setPageNum(pageNum);
				ma.setSearchText(searchText);
				
				List<MastersApplyModel> listMA = aDao.selectListMastersApply(ma);
				int totalCount = aDao.selectCountListMastersApply(ma);
				aDao.dbClose();
				
				String addParam = "&menu=admin_apply&searchText="+searchText;
				
				request.setAttribute("searchText", searchText);
				request.setAttribute("listMA", listMA);
				request.setAttribute("totalCount", totalCount);
				request.setAttribute("ma", ma);
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin", totalCount, ma.getListCount(), ma.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_apply.jsp");
				dispatcher.forward(request, response);
			}
			
			/* apply list excel */
			else if("admin_apply_excel".equals(menu)){
				List<MastersApplyModel> listMA = aDao.selectListMastersApplyForExcel();
				aDao.dbClose();
				
				request.setAttribute("listMA", listMA);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_apply_excel.jsp");
				dispatcher.forward(request, response);
			}
			
			/* recommand list */
			else if("admin_recommand".equals(menu)){
				String pageNum = request.getParameter("pageNum");
				String searchText = request.getParameter("searchText");
				if(pageNum == null){
					pageNum = "1";
				}
				
				if(searchText == null){
					searchText = "";
				}
				
				RecommandModel rec = new RecommandModel();
				rec.setPageNum(pageNum);
				rec.setSearchText(searchText);
				
				List<RecommandModel> listRec = aDao.selectListRecommand(rec);
				int totalCount = aDao.selectCountListRecommand(rec);
				aDao.dbClose();
				
				String addParam = "&menu=admin_recommand&searchText="+searchText;
				
				request.setAttribute("searchText", searchText);
				request.setAttribute("listRec", listRec);
				request.setAttribute("totalCount", totalCount);
				request.setAttribute("rec", rec);
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin", totalCount, rec.getListCount(), rec.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_recommand.jsp");
				dispatcher.forward(request, response);
			}
			
			/* recommand list excel */
			else if("admin_recommand_excel".equals(menu)){
				List<RecommandModel> listRec = aDao.selectListRecommandForExcel();
				aDao.dbClose();
				
				request.setAttribute("listRec", listRec);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_recommand_excel.jsp");
				dispatcher.forward(request, response);
			}
			
			/* stibee list */
			else if("admin_stibee".equals(menu)){
				String pageNum = request.getParameter("pageNum");
				String searchText = request.getParameter("searchText");
				if(pageNum == null){
					pageNum = "1";
				}
				
				if(searchText == null){
					searchText = "";
				}
				
				SubscribeModel subs = new SubscribeModel();
				subs.setPageNum(pageNum);
				subs.setSearchText(searchText);
				
				List<SubscribeModel> listSubs = aDao.selectListSubcribe(subs);
				int totalCount = aDao.selectCountListSubcribe(subs);
				aDao.dbClose();
				
				String addParam = "&menu=admin_stibee&searchText="+searchText;
				
				request.setAttribute("searchText", searchText);
				request.setAttribute("listSubs", listSubs);
				request.setAttribute("totalCount", totalCount);
				request.setAttribute("subs", subs);
				request.setAttribute("pageNavigator", new PageNavigator().getPageNavigator("admin", totalCount, subs.getListCount(), subs.getPagePerBlock(), Integer.parseInt(pageNum), addParam));
				
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_stibee.jsp");
				dispatcher.forward(request, response);
			}
			
			/* stibee excel */
			else if("admin_stibee_excel".equals(menu)){
				
				List<SubscribeModel> listSubs = aDao.selectListSubcribeForExcel();
				aDao.dbClose();
				
				request.setAttribute("listSubs", listSubs);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_stibee_excel.jsp");
				dispatcher.forward(request, response);
			}
			
			/* main and ETC content setup */
			else if("admin_setup_content".equals(menu)){
				SetupModel setup = aDao.selectSetup();
				aDao.dbClose();
				request.setAttribute("setup", setup);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_setup_content.jsp");
				dispatcher.forward(request, response);
			}
			
			/* 개인정보처리방침 setup */
			else if("admin_setup_information".equals(menu)){
				SetupModel setup = aDao.selectSetup();
				aDao.dbClose();
				request.setAttribute("setup", setup);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_setup_information.jsp");
				dispatcher.forward(request, response);
			}
			
			/* family site content setup */
			else if("admin_setup_site".equals(menu)){
				List<FamilySiteModel> listFS = aDao.selectListFamilySite();
				aDao.dbClose();
				request.setAttribute("listFS", listFS);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_setup_site.jsp");
				dispatcher.forward(request, response);
			}
			
			/* main and ETC popup setup */
			else if("admin_setup_popup".equals(menu)){
				PopupModel popup = aDao.selectPopup();
				aDao.dbClose();
				request.setAttribute("popup", popup);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_setup_popup.jsp");
				dispatcher.forward(request, response);
			}
			
			/* admin password setup */
			else if("admin_setup_password".equals(menu)){
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/admin/admin_setup_password.jsp");
				dispatcher.forward(request, response);
			}
			
			/* admin logout */
			else if("admin_logout".equals(menu)){
				session.invalidate();
				response.sendRedirect("admin");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		
		// define DAO
		AdminDAO aDao = new AdminDAO();
		
		// get Mode Parameter
		String mode = request.getParameter("mode");
		
		// admin login
		if("admin_login".equals(mode)){
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			
			boolean bRet = aDao.selectCheckAdmin(id, password);
			aDao.dbClose();
			
			if(bRet){
				HttpSession session = request.getSession();
				session.setMaxInactiveInterval(6*60*60); // 초 단위
				session.setAttribute("adminCheck", "1");
				
				response.sendRedirect("admin?type=setup&menu=admin_setup_content");
			}
			else{
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("<script> window.alert('아이디와 비밀번호가 맞지 않습니다. 다시 확인하세요.'); history.go(-1); </script>");
			}
		}
		
		/**
		 * masters start
		 */
		else if("insert_masters".equals(mode)){
			/* master info */
			int category = Integer.parseInt(request.getParameter("category"));
			String imgData = request.getParameter("img_data");
			String img[] = imgData.split("/");
			String name = request.getParameter("name");
			String slogan = request.getParameter("slogan");
			String tag = request.getParameter("tag");
			String company = request.getParameter("company");
			String position = request.getParameter("position");
			String title = request.getParameter("title");
			String description = request.getParameter("description");
			String keywords = request.getParameter("keywords");
			
			// step 1 : master add
			MastersModel master = new MastersModel();
			master.setCategory(category);
			master.setImg(img[1]);
			master.setName(name);
			master.setSlogan(slogan);
			master.setTag(tag);
			master.setCompany(company);
			master.setPosition(position);
			master.setTitle(title);
			master.setDescription(description);
			master.setKeywords(keywords);
			
			int masterIdx = aDao.insertMasters(master);
			
			ServletContext context = getServletContext();
			
			if(imgData!=null && "".equals(imgData)==false) {
				File directory = new File(context.getRealPath("/upload/masters/"+masterIdx));		// ���� ���� ���
				if(directory.exists() == false) {
					if(directory.mkdir()) {
						File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
						File movFile = new File(context.getRealPath("/upload/masters/"+masterIdx)+"/"+img[1]);
						
						if(movFile.exists()) movFile.delete();
						if(orgFile.exists())	orgFile.renameTo(movFile);
					}
				} else {
					File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
					File movFile = new File(context.getRealPath("/upload/masters/"+masterIdx)+"/"+img[1]);
					
					if(movFile.exists()) movFile.delete();
					if(orgFile.exists())	orgFile.renameTo(movFile);
					
				}
			}
			
			/* history info */
			String historySql = "INSERT INTO masters_history(masters_idx, history, date) VALUES";
			int historySize = Integer.parseInt(request.getParameter("history_size"));
			for(int i=1; i<=historySize; i++){
				int historyDel = Integer.parseInt(request.getParameter("history_del_"+i));
				if(historyDel == 0){
					String history = request.getParameter("history_"+i);
					if(i == historySize)	historySql+="("+masterIdx+", '"+history+"', NOW())";
					else					historySql+="("+masterIdx+", '"+history+"', NOW()),";
				}
			}
			aDao.insertMastersHistory(historySql);
			
			/* activity info */
			String activitySql = "INSERT INTO masters_activity(masters_idx, title, content, date) VALUES";
			int activitySize = Integer.parseInt(request.getParameter("activity_size"));
			for(int i=1; i<=activitySize; i++){
				int activityDel = Integer.parseInt(request.getParameter("activity_del_"+i));
				if(activityDel == 0){
					String titles = request.getParameter("title_"+i);
					String content = request.getParameter("content_"+i);
					if(i == activitySize)	activitySql+="("+masterIdx+", '"+titles+"', '"+content+"', NOW())";
					else					activitySql+="("+masterIdx+", '"+titles+"', '"+content+"', NOW()),";
				}
			}
			aDao.insertMastersActivity(activitySql);
			
			/* curriculum info */
			int curriSize = Integer.parseInt(request.getParameter("curri_size"));
		
			for(int i=1; i<=curriSize; i++){
				int curriDel = Integer.parseInt(request.getParameter("curri_del_"+i));
				if(curriDel == 0){
					String titles = request.getParameter("curri_title_"+i);
					
					CurriculumModel curriculum = new CurriculumModel();
					curriculum.setMastersIdx(masterIdx);
					curriculum.setTitle(titles);
					
					int curriculumIdx = aDao.insertCuriiculum(curriculum);
					
					String curriSubSql = "INSERT INTO curriculum_detail(masters_idx, curriculum_idx, category, title, content, date) "
							+ "VALUES";
					/* curriculum special info */
					int curriSpecialSize = Integer.parseInt(request.getParameter("curri_size_"+i+"_1"));
					for(int j=1; j<=curriSpecialSize; j++){
						int curriSpecialDel = Integer.parseInt(request.getParameter("curri_del_"+i+"_1_"+j));
						if(curriSpecialDel == 0){
							String subTitle = request.getParameter("curri_title_"+i+"_1_"+j);
							String subContent = request.getParameter("curri_content_"+i+"_1_"+j);
							
							curriSubSql+="("+masterIdx+", "+curriculumIdx+", 1, '"+subTitle+"', '"+subContent+"', NOW()),";
						}
					}
					
					/* curriculum detail info */
					int curriDetailSize = Integer.parseInt(request.getParameter("curri_size_"+i+"_2"));
					for(int j=1; j<=curriDetailSize; j++){
						int curriDetailDel = Integer.parseInt(request.getParameter("curri_del_"+i+"_2_"+j));
						if(curriDetailDel == 0){
							String subTitle = request.getParameter("curri_title_"+i+"_2_"+j);
							String subContent = request.getParameter("curri_content_"+i+"_2_"+j);
							
							if(j == curriDetailSize)	curriSubSql+="("+masterIdx+", "+curriculumIdx+", 2, '"+subTitle+"', '"+subContent+"', NOW())";
							else						curriSubSql+="("+masterIdx+", "+curriculumIdx+", 2, '"+subTitle+"', '"+subContent+"', NOW()),";
						}
					}
					
					aDao.insertCurriDetail(curriSubSql);
				}
			}
			aDao.dbClose();
			response.sendRedirect("admin?type=masters&menu=admin_masters_detail_history&idx="+masterIdx);
		}
		
		// update masters
		else if("update_masters".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			int category = Integer.parseInt(request.getParameter("category"));
			String imgData = request.getParameter("img_data");
			String imgOld = request.getParameter("img_old");
			String name = request.getParameter("name");
			String slogan = request.getParameter("slogan");
			String tag = request.getParameter("tag");
			String company = request.getParameter("company");
			String position = request.getParameter("position");
			String title = request.getParameter("title");
			String description = request.getParameter("description");
			String keywords = request.getParameter("keywords");
			int bestHide = Integer.parseInt(request.getParameter("best_hide"));
			int hide = Integer.parseInt(request.getParameter("hide"));
			
			MastersModel master = new MastersModel();
			master.setIdx(idx);
			master.setCategory(category);
			master.setImg(imgOld);
			master.setName(name);
			master.setSlogan(slogan);
			master.setTag(tag);
			master.setCompany(company);
			master.setPosition(position);
			master.setTitle(title);
			master.setDescription(description);
			master.setKeywords(keywords);
			master.setBestHide(bestHide);
			master.setHide(hide);
			
			ServletContext context = getServletContext();
			
			if(imgData!=null && "".equals(imgData)==false) {
				String img[] = imgData.split("/");
				master.setImg(img[1]);
				
				File directory = new File(context.getRealPath("/upload/masters/"+idx));		// ���� ���� ���
				if(directory.exists() == false) {
					if(directory.mkdir()) {
						File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
						File movFile = new File(context.getRealPath("/upload/masters/"+idx)+"/"+img[1]);
						
						if(movFile.exists()) movFile.delete();
						if(orgFile.exists())	orgFile.renameTo(movFile);
					}
				} else {
					File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
					File movFile = new File(context.getRealPath("/upload/masters/"+idx)+"/"+img[1]);
					
					if(movFile.exists()) movFile.delete();
					if(orgFile.exists())	orgFile.renameTo(movFile);
					
				}
			}
			
			aDao.updateMasters(master);
			aDao.dbClose();
			
			response.sendRedirect("admin?type=masters&menu=admin_masters_detail_history&idx="+idx);
		}
		
		// delete master
		else if("delete_master".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			aDao.deleteMasters(idx);
			aDao.dbClose();
		}
		
		// insert master history for detail page
		else if("insert_master_history".equals(mode)){
			int mastersIdx = Integer.parseInt(request.getParameter("masters_idx"));
			String history = request.getParameter("history");
			
			String historySql = "INSERT INTO masters_history(masters_idx, history, date) VALUES("+mastersIdx+", '"+history+"', NOW())";
			aDao.insertMastersHistory(historySql);
			aDao.dbClose();
		}
		
		// update master history for detail page
		else if("update_master_history".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			String history = request.getParameter("history");
			
			MastersHistoryModel historys = new MastersHistoryModel();
			historys.setIdx(idx);
			historys.setHistory(history);
			aDao.updateMastersHistory(historys);
			aDao.dbClose();
		}
		
		// delete master history for detail page
		else if("delete_master_history".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			aDao.deleteMastersHistory(idx);
			aDao.dbClose();
		}
		
		// insert master activity for detail page
		else if("insert_master_activity".equals(mode)){
			int mastersIdx = Integer.parseInt(request.getParameter("masters_idx"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			String activitySql = "INSERT INTO masters_activity(masters_idx, title, content, date)"
					+ " VALUES("+mastersIdx+", '"+title+"', '"+content+"', NOW())";
			
			aDao.insertMastersActivity(activitySql);
			aDao.dbClose();
		}
		
		// update master activity for detail page
		else if("update_master_activity".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			MastersActivityModel activity = new MastersActivityModel();
			activity.setIdx(idx);
			activity.setTitle(title);
			activity.setContent(content);
			
			aDao.updateMastersActivity(activity);
			aDao.dbClose();
		}
		
		// delete master activity for detail page
		else if("delete_master_activity".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			
			aDao.deleteMastersActivity(idx);
			aDao.dbClose();
		}
		
		// insert curriculum for detail page
		else if("insert_curriculum".equals(mode)){
			int mastersIdx = Integer.parseInt(request.getParameter("masters_idx"));
			String title = request.getParameter("title");
			
			CurriculumModel curriculum = new CurriculumModel();
			curriculum.setMastersIdx(mastersIdx);
			curriculum.setTitle(title);
			int curriculumIdx = aDao.insertCuriiculum(curriculum);
			
			/* curriculum detail info */
			String curriSubSql = "INSERT INTO curriculum_detail(masters_idx, curriculum_idx, category, title, content, date) "
					+ "VALUES";
			/* curriculum special info */
			int curriSpecialSize = Integer.parseInt(request.getParameter("curri_size_1"));
			for(int j=1; j<=curriSpecialSize; j++){
				int curriSpecialDel = Integer.parseInt(request.getParameter("curri_del_1_"+j));
				if(curriSpecialDel == 0){
					String subTitle = request.getParameter("curri_title_1_"+j);
					String subContent = request.getParameter("curri_content_1_"+j);
					
					curriSubSql+="("+mastersIdx+", "+curriculumIdx+", 1, '"+subTitle+"', '"+subContent+"', NOW()),";
				}
			}
			
			/* curriculum detail info */
			int curriDetailSize = Integer.parseInt(request.getParameter("curri_size_2"));
			for(int j=1; j<=curriDetailSize; j++){
				int curriDetailDel = Integer.parseInt(request.getParameter("curri_del_2_"+j));
				if(curriDetailDel == 0){
					String subTitle = request.getParameter("curri_title_2_"+j);
					String subContent = request.getParameter("curri_content_2_"+j);
					
					if(j == curriDetailSize)	curriSubSql+="("+mastersIdx+", "+curriculumIdx+", 2, '"+subTitle+"', '"+subContent+"', NOW())";
					else						curriSubSql+="("+mastersIdx+", "+curriculumIdx+", 2, '"+subTitle+"', '"+subContent+"', NOW()),";
				}
			}
			
			aDao.insertCurriDetail(curriSubSql);
			aDao.dbClose();
			response.sendRedirect("admin?type=masters&menu=admin_masters_detail_curriculum&idx="+mastersIdx);
		}
		
		// update curriculum for detail page
		else if("update_curriculum".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			String title = request.getParameter("title");
			
			CurriculumModel curriculum = new CurriculumModel();
			curriculum.setIdx(idx);
			curriculum.setTitle(title);
			
			aDao.updateCurriculum(curriculum);;
			aDao.dbClose();
		}
		
		// delete curriculum for detail page
		else if("delete_curriculum".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			aDao.deleteCurriculum(idx);
			aDao.dbClose();
		}
		
		// insert master curriculum detail for detail page
		else if("insert_curriculum_detail".equals(mode)){
			int mastersIdx = Integer.parseInt(request.getParameter("masters_idx"));
			int curriculumIdx = Integer.parseInt(request.getParameter("curriculum_idx"));
			int category = Integer.parseInt(request.getParameter("category"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			String sqlStr = "INSERT INTO curriculum_detail(masters_idx, curriculum_idx, category, title, content, date) "
					+ "VALUES("+mastersIdx+", "+curriculumIdx+", "+category+", '"+title+"', '"+content+"', NOW())";
			
			aDao.insertCurriDetail(sqlStr);
			aDao.dbClose();
		}
		
		// update master curriculum detail for detail page
		else if("update_curriculum_detail".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			CurriculumDetailModel cd = new CurriculumDetailModel();
			cd.setIdx(idx);
			cd.setTitle(title);
			cd.setContent(content);
			
			aDao.updateCurriDetail(cd);
			aDao.dbClose();
		}
		
		// delete master curriculum detail for detail page
		else if("delete_curriculum_detail".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			
			aDao.deleteCurriDetail(idx);
			aDao.dbClose();
		}
		
		
		// insert master review
		else if("insert_master_review".equals(mode)){
			int mastersIdx = Integer.parseInt(request.getParameter("masters_idx"));
			String imgData = request.getParameter("img_data");
			String img[] = imgData.split("/");
			String name = request.getParameter("name");
			String content = request.getParameter("content");
			
			MastersReviewModel mr = new MastersReviewModel();
			mr.setMastersIdx(mastersIdx);
			mr.setImg(img[1]);
			mr.setName(name);
			mr.setContent(content);
			
			int idx = aDao.insertMastersReview(mr);
			aDao.dbClose();
			
			ServletContext context = getServletContext();
			
			if(imgData!=null && "".equals(imgData)==false) {
				File directory = new File(context.getRealPath("/upload/review/"+idx));		// ���� ���� ���
				if(directory.exists() == false) {
					if(directory.mkdir()) {
						File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
						File movFile = new File(context.getRealPath("/upload/review/"+idx)+"/"+img[1]);
						
						if(movFile.exists()) movFile.delete();
						if(orgFile.exists())	orgFile.renameTo(movFile);
					}
				} else {
					File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
					File movFile = new File(context.getRealPath("/upload/review/"+idx)+"/"+img[1]);
					
					if(movFile.exists()) movFile.delete();
					if(orgFile.exists())	orgFile.renameTo(movFile);
					
				}
			}
		}
		
		// update master review
		else if("update_master_review".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			String imgOld = request.getParameter("img_old");
			String imgData = request.getParameter("img_data");
			
			String name = request.getParameter("name");
			String content = request.getParameter("content");
			
			MastersReviewModel mr = new MastersReviewModel();
			mr.setIdx(idx);
			mr.setImg(imgOld);
			mr.setName(name);
			mr.setContent(content);
			
			ServletContext context = getServletContext();
			
			if(imgData!=null && "".equals(imgData)==false) {
				String img[] = imgData.split("/");
				mr.setImg(img[1]);
				
				File directory = new File(context.getRealPath("/upload/review/"+idx));		// ���� ���� ���
				if(directory.exists() == false) {
					if(directory.mkdir()) {
						File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
						File movFile = new File(context.getRealPath("/upload/review/"+idx)+"/"+img[1]);
						
						if(movFile.exists()) movFile.delete();
						if(orgFile.exists())	orgFile.renameTo(movFile);
					}
				} else {
					File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
					File movFile = new File(context.getRealPath("/upload/review/"+idx)+"/"+img[1]);
					
					if(movFile.exists()) movFile.delete();
					if(orgFile.exists())	orgFile.renameTo(movFile);
					
				}
			}
			
			aDao.updateMastersReview(mr);
			aDao.dbClose();
		}
		
		// delete master review
		else if("delete_master_review".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			aDao.deleteMastersReview(idx);
			aDao.dbClose();
		}
		
		// insert master cut
		else if("insert_master_cut".equals(mode)){
			int mastersIdx = Integer.parseInt(request.getParameter("masters_idx"));
			int category = Integer.parseInt(request.getParameter("category"));
			String title = request.getParameter("title");
			String content = "";
			if(category == 0){
				String imgData = request.getParameter("content");
				String img[] = imgData.split("/");
				
				MastersCutModel mc = new MastersCutModel();
				mc.setMastersIdx(mastersIdx);
				mc.setCategory(category);
				mc.setTitle(title);
				mc.setContent(img[1]);
				
				int idx = aDao.insertMastersCut(mc);
				aDao.dbClose();
				
				ServletContext context = getServletContext();
				
				if(imgData!=null && "".equals(imgData)==false) {
					File directory = new File(context.getRealPath("/upload/master_cut/"+idx));		// ���� ���� ���
					if(directory.exists() == false) {
						if(directory.mkdir()) {
							File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
							File movFile = new File(context.getRealPath("/upload/master_cut/"+idx)+"/"+img[1]);
							
							if(movFile.exists()) movFile.delete();
							if(orgFile.exists())	orgFile.renameTo(movFile);
						}
					} else {
						File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
						File movFile = new File(context.getRealPath("/upload/master_cut/"+idx)+"/"+img[1]);
						
						if(movFile.exists()) movFile.delete();
						if(orgFile.exists())	orgFile.renameTo(movFile);
						
					}
				}
			}
			else{
				content = request.getParameter("content");
				
				MastersCutModel mc = new MastersCutModel();
				mc.setMastersIdx(mastersIdx);
				mc.setCategory(category);
				mc.setTitle(title);
				mc.setContent(content);
				aDao.insertMastersCut(mc);
				aDao.dbClose();
			}
		}
		
		// update master cut
		else if("update_master_cut".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			String title = request.getParameter("title");
			int category = Integer.parseInt(request.getParameter("category"));
			String content = request.getParameter("content");
			
			if(category == 0){
				String imgOld = request.getParameter("img_old");
				
				MastersCutModel mc = new MastersCutModel();
				mc.setIdx(idx);
				mc.setCategory(category);
				mc.setTitle(title);
				mc.setContent(imgOld);
				
				ServletContext context = getServletContext();
				
				if(content!=null && "".equals(content)==false) {
					String img[] = content.split("/");
					mc.setContent(img[1]);
					
					File directory = new File(context.getRealPath("/upload/master_cut/"+idx));		// ���� ���� ���
					if(directory.exists() == false) {
						if(directory.mkdir()) {
							File orgFile = new File(context.getRealPath("/upload/temp/"+content));
							File movFile = new File(context.getRealPath("/upload/master_cut/"+idx)+"/"+img[1]);
							
							if(movFile.exists()) movFile.delete();
							if(orgFile.exists())	orgFile.renameTo(movFile);
						}
					} else {
						File orgFile = new File(context.getRealPath("/upload/temp/"+content));
						File movFile = new File(context.getRealPath("/upload/master_cut/"+idx)+"/"+img[1]);
						
						if(movFile.exists()) movFile.delete();
						if(orgFile.exists())	orgFile.renameTo(movFile);
						
					}
				}
				aDao.updateMastersCut(mc);
				aDao.dbClose();
			}
			else{
				MastersCutModel mc = new MastersCutModel();
				mc.setIdx(idx);
				mc.setCategory(category);
				mc.setTitle(title);
				mc.setContent(content);;
				aDao.updateMastersCut(mc);
				aDao.dbClose();
			}
		}
		
		// delete_master_cut
		else if("delete_master_cut".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			aDao.deleteMastersCut(idx);
			aDao.dbClose();
		}
		
		/**
		 * masters end
		 */
		
		/**
		 * reference start
		 */
		
		// insert reference
		else if("insert_reference".equals(mode)){
			int mastersIdx = Integer.parseInt(request.getParameter("masters_idx"));
			double score = 0;
			try{ score = Double.parseDouble(request.getParameter("score")); }catch(Exception e){ score = 0; }
			String company = request.getParameter("company");
			String education = request.getParameter("education");
			String target = request.getParameter("target");
			int people = 0;
			try{ people = Integer.parseInt(request.getParameter("people")); }catch(Exception e){ people = 0; }
			int hour = 0;
			try{ hour = Integer.parseInt(request.getParameter("hour")); }catch(Exception e){ hour = 0; }
			int hide = Integer.parseInt(request.getParameter("hide"));
			String date = request.getParameter("date")+" 00:00:00";
			
			ReferenceModel reference = new ReferenceModel();
			reference.setMastersIdx(mastersIdx);
			reference.setScore(score);
			reference.setCompany(company);
			reference.setEducation(education);
			reference.setTarget(target);
			reference.setPeople(people);
			reference.setHour(hour);
			reference.setHide(hide);
			reference.setDate(date);
			
			aDao.insertReference(reference);
			aDao.dbClose();
		}
		
		// update reference
		else if("update_reference".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			int mastersIdx = Integer.parseInt(request.getParameter("masters_idx"));
			double score = 0;
			try{ score = Double.parseDouble(request.getParameter("score")); }catch(Exception e){ score = 0; }
			String company = request.getParameter("company");
			String education = request.getParameter("education");
			String target = request.getParameter("target");
			int people = 0;
			try{ people = Integer.parseInt(request.getParameter("people")); }catch(Exception e){ people = 0; }
			int hour = 0;
			try{ hour = Integer.parseInt(request.getParameter("hour")); }catch(Exception e){ hour = 0; }
			int hide = Integer.parseInt(request.getParameter("hide"));
			String date = request.getParameter("date")+" 00:00:00";
			
			ReferenceModel reference = new ReferenceModel();
			reference.setIdx(idx);
			reference.setMastersIdx(mastersIdx);
			reference.setScore(score);
			reference.setCompany(company);
			reference.setEducation(education);
			reference.setTarget(target);
			reference.setPeople(people);
			reference.setHour(hour);
			reference.setHide(hide);
			reference.setDate(date);
			
			aDao.updateReference(reference);
			aDao.dbClose();
		}
		
		// delete reference
		else if("delete_reference".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			aDao.deleteReference(idx);
			aDao.dbClose();
		}
		
		/**
		 * reference end
		 */
		
		/**
		 * news start
		 */
		
		// insert news
		else if("insert_news".equals(mode)){
			Calendar cal = Calendar.getInstance();
			
			int type = Integer.parseInt(request.getParameter("type"));
			String thumbnailData = request.getParameter("thumbnail_data");
			String thumbnail[] = thumbnailData.split("/");
			int reservation = Integer.parseInt(request.getParameter("reservation"));
			String viewDate = "";
			if(reservation == 0)
				viewDate = String.format("%04d-%02d-%02d %02d:%02d:00", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1, cal.get(Calendar.DAY_OF_MONTH), cal.get(Calendar.HOUR_OF_DAY), cal.get(Calendar.MINUTE));
			else
				viewDate = request.getParameter("view_date")+" "+request.getParameter("view_hour")+":"+request.getParameter("view_minute")+":00";
			
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String keywords = request.getParameter("keywords");
			
			NewsInfoModel ni = new NewsInfoModel();
			ni.setType(type);
			ni.setThumbnail(thumbnail[1]);
			ni.setViewDate(viewDate);
			ni.setTitle(title);
			ni.setContent(content);
			ni.setKeywords(keywords);
			
			ServletContext context = getServletContext();
			
			int idx = aDao.insertNewsInfo(ni);
			aDao.dbClose();
			
			if(thumbnailData!=null && "".equals(thumbnailData)==false) {
				File directory = new File(context.getRealPath("/upload/news/"+idx));		// ���� ���� ���
				if(directory.exists() == false) {
					if(directory.mkdir()) {
						File orgFile = new File(context.getRealPath("/upload/temp/"+thumbnailData));
						File movFile = new File(context.getRealPath("/upload/news/"+idx)+"/"+thumbnail[1]);
						
						if(movFile.exists()) movFile.delete();
						if(orgFile.exists())	orgFile.renameTo(movFile);
					}
				} else {
					File orgFile = new File(context.getRealPath("/upload/temp/"+thumbnailData));
					File movFile = new File(context.getRealPath("/upload/news/"+idx)+"/"+thumbnail[1]);
					
					if(movFile.exists()) movFile.delete();
					if(orgFile.exists())	orgFile.renameTo(movFile);
					
				}
			}
			
			response.sendRedirect("admin?type=news&menu=admin_news_detail&idx="+idx);
		}
		
		// update news
		else if("update_news".equals(mode)){
			Calendar cal = Calendar.getInstance();
			
			int idx = Integer.parseInt(request.getParameter("idx"));
			int type = Integer.parseInt(request.getParameter("type"));
			String thumbnailData = request.getParameter("thumbnail_data");
			String thumbnailOld = request.getParameter("thumbnail_old");
			int reservation = Integer.parseInt(request.getParameter("reservation"));
			String viewDate = "";
			if(reservation == 0)
				viewDate = String.format("%04d-%02d-%02d %02d:%02d:00", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH)+1, cal.get(Calendar.DAY_OF_MONTH), cal.get(Calendar.HOUR_OF_DAY), cal.get(Calendar.MINUTE));
			else
				viewDate = request.getParameter("view_date")+" "+request.getParameter("view_hour")+":"+request.getParameter("view_minute")+":00";
			
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String keywords = request.getParameter("keywords");
			
			NewsInfoModel ni = new NewsInfoModel();
			ni.setIdx(idx);
			ni.setType(type);
			ni.setThumbnail(thumbnailOld);
			ni.setViewDate(viewDate);
			ni.setTitle(title);
			ni.setContent(content);
			ni.setKeywords(keywords);
			
			ServletContext context = getServletContext();
			
			if(thumbnailData!=null && "".equals(thumbnailData)==false) {
				String thumbnail[] = thumbnailData.split("/");
				ni.setThumbnail(thumbnail[1]);
				
				File directory = new File(context.getRealPath("/upload/news/"+idx));		// ���� ���� ���
				if(directory.exists() == false) {
					if(directory.mkdir()) {
						File orgFile = new File(context.getRealPath("/upload/temp/"+thumbnailData));
						File movFile = new File(context.getRealPath("/upload/news/"+idx)+"/"+thumbnail[1]);
						
						if(movFile.exists()) movFile.delete();
						if(orgFile.exists())	orgFile.renameTo(movFile);
					}
				} else {
					File orgFile = new File(context.getRealPath("/upload/temp/"+thumbnailData));
					File movFile = new File(context.getRealPath("/upload/news/"+idx)+"/"+thumbnail[1]);
					
					if(movFile.exists()) movFile.delete();
					if(orgFile.exists())	orgFile.renameTo(movFile);
					
				}
			}
			
			aDao.updateNewsInfo(ni);
			aDao.dbClose();
			
			response.sendRedirect("admin?type=news&menu=admin_news_detail&idx="+idx);
		}
		
		// update news for rolling
		else if("update_news_rolling".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			int top = Integer.parseInt(request.getParameter("top"));
			
			aDao.updateNewsInfoForTopRolling(idx, top);
			aDao.dbClose();
		}
		
		// delete news
		else if("delete_news".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			aDao.deleteNewsInfo(idx);
			aDao.dbClose();
		}
		
		/**
		 * news end
		 */
		
		/**
		 * main review start
		 */
		
		// insert main review
		else if("insert_main_review".equals(mode)){
			String imgData = request.getParameter("img_data");
			String img[] = imgData.split("/");
			String name = request.getParameter("name");
			String content = request.getParameter("content");
			
			MainReviewModel mr = new MainReviewModel();
			mr.setImg(img[1]);
			mr.setName(name);
			mr.setContent(content);
			
			int idx = aDao.insertMainReview(mr);
			aDao.dbClose();
			
			ServletContext context = getServletContext();
			
			if(imgData!=null && "".equals(imgData)==false) {
				File directory = new File(context.getRealPath("/upload/main_review/"+idx));		// ���� ���� ���
				if(directory.exists() == false) {
					if(directory.mkdir()) {
						File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
						File movFile = new File(context.getRealPath("/upload/main_review/"+idx)+"/"+img[1]);
						
						if(movFile.exists()) movFile.delete();
						if(orgFile.exists())	orgFile.renameTo(movFile);
					}
				} else {
					File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
					File movFile = new File(context.getRealPath("/upload/main_review/"+idx)+"/"+img[1]);
					
					if(movFile.exists()) movFile.delete();
					if(orgFile.exists())	orgFile.renameTo(movFile);
					
				}
			}
		}
		
		// update main review
		else if("update_main_review".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			String imgOld = request.getParameter("img_old");
			String imgData = request.getParameter("img_data");
			
			String name = request.getParameter("name");
			String content = request.getParameter("content");
			
			MainReviewModel mr = new MainReviewModel();
			mr.setIdx(idx);
			mr.setImg(imgOld);
			mr.setName(name);
			mr.setContent(content);
			
			ServletContext context = getServletContext();
			
			if(imgData!=null && "".equals(imgData)==false) {
				String img[] = imgData.split("/");
				mr.setImg(img[1]);
				
				File directory = new File(context.getRealPath("/upload/main_review/"+idx));		// ���� ���� ���
				if(directory.exists() == false) {
					if(directory.mkdir()) {
						File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
						File movFile = new File(context.getRealPath("/upload/main_review/"+idx)+"/"+img[1]);
						
						if(movFile.exists()) movFile.delete();
						if(orgFile.exists())	orgFile.renameTo(movFile);
					}
				} else {
					File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
					File movFile = new File(context.getRealPath("/upload/main_review/"+idx)+"/"+img[1]);
					
					if(movFile.exists()) movFile.delete();
					if(orgFile.exists())	orgFile.renameTo(movFile);
					
				}
			}
			
			aDao.updateMainReview(mr);
			aDao.dbClose();
		}
		
		// delete main review
		else if("delete_main_review".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			aDao.deleteMainReview(idx);
			aDao.dbClose();
		}
		
		/**
		 * main review end
		 */
		
		/**
		 * search start
		 */
		
		else if("update_search".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			String title = request.getParameter("title");
			String description = request.getParameter("description");
			String keywords = request.getParameter("keywords");
			String location = request.getParameter("location");
			
			SearchModel search = new SearchModel();
			search.setIdx(idx);
			search.setTitle(title);
			search.setDescription(description);
			search.setKeywords(keywords);
			
			aDao.updateSearch(search);
			aDao.dbClose();
			
			response.sendRedirect("admin?type=search&menu="+location);
		}
		
		/**
		 * search end
		 */
		
		/**
		 * setup start
		 */
		// setup update
		else if("update_setup".equals(mode)){
			String bannerData = request.getParameter("banner_data");
			String bannerOld = request.getParameter("banner_old");
			String pdfData = request.getParameter("pdf_data");
			String pdfOld = request.getParameter("pdf_old");
			String contact = request.getParameter("contact");
			String logoData = request.getParameter("logo_data");
			String logoOld = request.getParameter("logo_old");
			int category = Integer.parseInt(request.getParameter("category"));
			String email = request.getParameter("email");
			String color = request.getParameter("color");
			String address = request.getParameter("address");
			String recommand = request.getParameter("recommand");
			String companyNum = request.getParameter("company_num");
			String companyName = request.getParameter("company_name");
			
			SetupModel setup = new SetupModel();
			setup.setContact(contact);
			setup.setEmail(email);
			setup.setCategory(category);
			setup.setBanner(bannerOld);
			setup.setPdf(pdfOld);
			setup.setLogo(logoOld);
			setup.setColor(color);
			setup.setAddress(address);
			setup.setRecommand(recommand);
			setup.setCompanyNum(companyNum);
			setup.setCompanyName(companyName);
			
			ServletContext context = getServletContext();
			
			if(bannerData!=null && "".equals(bannerData)==false) {
				String banner[] = bannerData.split("/");
				
				setup.setBanner("upload/setup/"+banner[1]);
				
				File orgFile = new File(context.getRealPath("/upload/temp/"+bannerData));
				File movFile = new File(context.getRealPath("/upload/setup")+"/"+banner[1]);
				
				if(movFile.exists()) movFile.delete();
				if(orgFile.exists())	orgFile.renameTo(movFile);
			}
			
			if(pdfData!=null && "".equals(pdfData)==false) {
				String pdf[] = pdfData.split("/");
				
				setup.setPdf("upload/setup/"+pdf[1]);
				
				File orgFile = new File(context.getRealPath("/upload/temp/"+pdfData));
				File movFile = new File(context.getRealPath("/upload/setup")+"/"+pdf[1]);
				
				if(movFile.exists()) movFile.delete();
				if(orgFile.exists())	orgFile.renameTo(movFile);
			}
			
			if(logoData!=null && "".equals(logoData)==false) {
				String logo[] = logoData.split("/");
				
				setup.setLogo("upload/setup/"+logo[1]);
				
				File orgFile = new File(context.getRealPath("/upload/temp/"+logoData));
				File movFile = new File(context.getRealPath("/upload/setup")+"/"+logo[1]);
				
				if(movFile.exists()) movFile.delete();
				if(orgFile.exists())	orgFile.renameTo(movFile);
			}
			
			aDao.updateSetup(setup);
			aDao.dbClose();
			
			response.sendRedirect("admin?type=setup&menu=admin_setup_content");
		}
		
		// setup update information
		else if("update_setup_information".equals(mode)){
			String information = request.getParameter("information");
			
			aDao.updateSetupInformation(information);
			aDao.dbClose();
			
			response.sendRedirect("admin?type=setup&menu=admin_setup_information");
		}
		
		/**
		 * setup end
		 */
		
		/**
		 * popup start
		 */
		// popup update
		else if("update_popup".equals(mode)){
			String imgData = request.getParameter("img_data");
			String imgOld = request.getParameter("img_old");
			String link = request.getParameter("link");
			int hide = Integer.parseInt(request.getParameter("hide"));
			
			PopupModel popup = new PopupModel();
			popup.setImg(imgOld);
			popup.setLink(link);
			popup.setHide(hide);
			
			ServletContext context = getServletContext();
			
			if(imgData!=null && "".equals(imgData)==false) {
				String img[] = imgData.split("/");
				
				popup.setImg("upload/popup/"+img[1]);
				
				File orgFile = new File(context.getRealPath("/upload/temp/"+imgData));
				File movFile = new File(context.getRealPath("/upload/popup")+"/"+img[1]);
				
				if(movFile.exists()) movFile.delete();
				if(orgFile.exists())	orgFile.renameTo(movFile);
			}
			
			aDao.updatePopup(popup);
			aDao.dbClose();
			
			response.sendRedirect("admin?type=setup&menu=admin_setup_popup");
		}
		
		/**
		 * popup end
		 */
		
		/**
		 * family site start
		 */
		
		// insert family site
		else if("insert_family_site".equals(mode)){
			String name = request.getParameter("name");
			String link = request.getParameter("link");
			
			FamilySiteModel fs = new FamilySiteModel();
			fs.setName(name);
			fs.setLink(link);
			
			aDao.insertFamilySite(fs);
			aDao.dbClose();
		}
		
		// update family site
		else if("update_family_site".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			String name = request.getParameter("name");
			String link = request.getParameter("link");
			
			FamilySiteModel fs = new FamilySiteModel();
			fs.setIdx(idx);
			fs.setName(name);
			fs.setLink(link);
			
			aDao.updateFamilySite(fs);
			aDao.dbClose();
		}
		
		// delete family site
		else if("delete_family_site".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			
			aDao.deleteFamilySite(idx);
			aDao.dbClose();
		}
		
		// up sort family site
		else if("update_family_site_up_sort".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			int sort = Integer.parseInt(request.getParameter("sort"));
			
			FamilySiteModel fs = new FamilySiteModel();
			fs.setIdx(idx);
			fs.setSort(sort);
			aDao.updateFamilySiteForUpSort(fs);
			aDao.dbClose();
		}
		
		// down sort family site
		else if("update_family_site_down_sort".equals(mode)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			int sort = Integer.parseInt(request.getParameter("sort"));
			
			FamilySiteModel fs = new FamilySiteModel();
			fs.setIdx(idx);
			fs.setSort(sort);
			aDao.updateFamilySiteForDownSort(fs);
			aDao.dbClose();
		}
		
		// update_password
		else if("update_password".equals(mode)){
			String oldpw = request.getParameter("old_pw");
			String newpw = request.getParameter("new_pw");
			
			boolean bRet = aDao.selectPasswdForLogin(oldpw);
			if(bRet){
				aDao.updatePasswd(newpw);
				aDao.dbClose();
				HttpSession session = request.getSession();
				
				session.invalidate();
				response.sendRedirect("admin");
			}
			else{
				aDao.dbClose();
				response.setContentType("text/html; charset=utf-8");
				PrintWriter out = response.getWriter();
				out.print("<script> window.alert('현재 비밀번호가 맞지 않습니다.'); history.go(-1); </script>");
			}
		}
		
		/**
		 * family site end
		 */
	}

}
