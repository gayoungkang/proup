package servlet;

import java.io.IOException;
import java.io.PrintWriter;
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
import model.NewsInfoModel;
import model.SearchModel;
import dao.UserDAO;

/**
 * Servlet implementation class News
 */
@WebServlet(name = "news", urlPatterns = { "/news" })
public class News extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public News() {
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
		
		if(menu==null){
			String searchType = request.getParameter("searchType");
			String searchText = request.getParameter("searchText");
			
			if(searchType == null){
				searchType = "all";
			}
			if(searchText == null){
				searchText = "";
			}
			
			NewsInfoModel ni = new NewsInfoModel();
			ni.setSearchText(searchText);
			ni.setSearchType(searchType);
			
			SearchModel search = uDao.selectSearch(4);
			List<NewsInfoModel> listNI = uDao.selectListNewsInfo(ni);
			int totalCount = uDao.selectCountListNewsInfo(ni);
			List<NewsInfoModel> listTopNews = uDao.selectListNewsForTopRolling();
			
			uDao.dbClose();
			
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchText", searchText);
			request.setAttribute("listNI", listNI);
			request.setAttribute("listTopNews", listTopNews);
			request.setAttribute("search", search);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/news.jsp");
			dispatcher.forward(request, response);
		}
		else{
			int idx = Integer.parseInt(request.getParameter("idx"));
			
			NewsInfoModel ni = uDao.selectNewsInfo(idx);
			uDao.dbClose();
			
			request.setAttribute("ni", ni);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/news_detail.jsp");
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
		if("select_news_list".equals(mode)){
			String pageNum = request.getParameter("pageNum");
			String searchText = request.getParameter("searchText");
			String searchType = request.getParameter("searchType");
			
			NewsInfoModel ni = new NewsInfoModel();
			ni.setPageNum(pageNum);
			ni.setSearchType(searchType);
			ni.setSearchText(searchText);
			
			UserDAO uDao = new UserDAO();
			List<NewsInfoModel> listNI = uDao.selectListNewsInfo(ni);
			uDao.dbClose();
			
			JSONArray arr = new JSONArray();
			for(int i=0; i<listNI.size(); i++){
				JSONObject obj = new JSONObject();
				obj.put("idx", listNI.get(i).getIdx());
				obj.put("type", listNI.get(i).getType());
				obj.put("title", listNI.get(i).getTitle());
				try {
					obj.put("content", RemoveTag.removeTag(listNI.get(i).getContent()));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				obj.put("thumbnail", listNI.get(i).getThumbnail());
				obj.put("date", listNI.get(i).getViewDate().substring(0, 10));
				
				arr.add(obj);
			}
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(arr);
		}
		
	}

}
