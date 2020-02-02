package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import util.RemoveTag;
import model.CurriculumDetailModel;
import model.CurriculumModel;
import model.MastersActivityModel;
import model.MastersCutModel;
import model.MastersHistoryModel;
import model.MastersModel;
import model.MastersReviewModel;
import model.SearchModel;
import dao.UserDAO;

/**
 * Servlet implementation class Masters
 */
@WebServlet(name = "masters", urlPatterns = { "/masters" })
public class Masters extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Masters() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		UserDAO uDao = new UserDAO();
		
		String menu = request.getParameter("menu");
		if(menu == null){
			String pageNum = request.getParameter("pageNum");
			String searchType = request.getParameter("searchType");
			
			if(pageNum == null){
				pageNum = "1";
			}
			
			if(searchType == null){
				searchType = "all";
			}
			
			MastersModel masters = new MastersModel();
			masters.setPageNum(pageNum);
			masters.setSearchType(searchType);
			
			List<MastersModel> listMasters = uDao.selectListMasters(masters);
			int totalCount = uDao.selectCountListMasters(masters);
			for(int i=0; i<listMasters.size(); i++){
				listMasters.get(i).setListHistory(uDao.selectListHistoryForMasters(listMasters.get(i).getIdx()));
			}
			SearchModel search = uDao.selectSearch(3);
			MastersModel countMasters = uDao.selectCountMastersForCategory();
			
			uDao.dbClose();
			
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("search", search);
			request.setAttribute("listMasters", listMasters);
			request.setAttribute("searchType", searchType);
			request.setAttribute("countMasters", countMasters);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/masters.jsp");
			dispatcher.forward(request, response);
		}
		
		else if("masters_detail".equals(menu)){
			int idx = Integer.parseInt(request.getParameter("idx"));
			
			MastersModel master = uDao.selectMasters(idx);
			List<MastersHistoryModel> listHistory = uDao.selectListMastersHistory(idx);
			List<MastersActivityModel> listActivity = uDao.selectListMastersActivity(idx);
			List<CurriculumModel> listCurri = uDao.selectListCurriculum(idx);
			List<CurriculumDetailModel> listCD = uDao.selectListCurriDetail(idx);
			List<MastersReviewModel> listMR = uDao.selectListMastersReview(idx);
			List<MastersCutModel> listMC = uDao.selectListMastersCut(idx);
			uDao.dbClose();
			
			request.setAttribute("master", master);
			request.setAttribute("listHistory", listHistory);
			request.setAttribute("listActivity", listActivity);
			request.setAttribute("listCurri", listCurri);
			request.setAttribute("listCD", listCD);
			request.setAttribute("listMR", listMR);
			request.setAttribute("listMC", listMC);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/masters_detail.jsp");
			dispatcher.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		
		String mode = request.getParameter("mode");
		
		if("select_masters_list".equals(mode)){
			String pageNum = request.getParameter("pageNum");
			String searchType = request.getParameter("searchType");
			
			MastersModel masters = new MastersModel();
			masters.setPageNum(pageNum);
			masters.setSearchType(searchType);
			
			NumberFormat nf = NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			
			UserDAO uDao = new UserDAO();
			List<MastersModel> listMasters = uDao.selectListMasters(masters);
			for(int i=0; i<listMasters.size(); i++){
				listMasters.get(i).setListHistory(uDao.selectListHistoryForMasters(listMasters.get(i).getIdx()));
			}
			uDao.dbClose();
			
			JSONArray arr = new JSONArray();
			for(int i=0; i<listMasters.size(); i++){
				JSONObject obj = new JSONObject();
				JSONArray history = new JSONArray();
				for(int j=0; j<listMasters.get(i).getListHistory().size(); j++){
					history.add(listMasters.get(i).getListHistory().get(j));
				}
				
				obj.put("idx", listMasters.get(i).getIdx());
				obj.put("name", listMasters.get(i).getName());
				obj.put("image", "upload/masters/"+listMasters.get(i).getIdx()+"/"+listMasters.get(i).getImg());
				obj.put("tag", listMasters.get(i).getTag());
				obj.put("score", nf.format(listMasters.get(i).getReferenceScore()));
				obj.put("history", history);
				
				arr.add(obj);
			}
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(arr);
		}
	}

}
