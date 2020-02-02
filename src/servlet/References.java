package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ReferenceModel;
import model.SearchModel;
import model.SetupModel;
import dao.UserDAO;

/**
 * Servlet implementation class References
 */
@WebServlet(name = "references", urlPatterns = { "/references" })
public class References extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public References() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String menu = request.getParameter("menu");
		
		if(menu==null){
			String searchType = request.getParameter("searchType");
			String orderBy = request.getParameter("orderBy");
			
			
			
			if(searchType == null){
				searchType = "idx";
			}
			
			if(orderBy == null){
				orderBy = "ASC";
			}
			
			ReferenceModel reference = new ReferenceModel();
			reference.setSearchType(searchType);
			reference.setOrderBy(orderBy);
			
			UserDAO uDao = new UserDAO();
			List<ReferenceModel> listReference = uDao.selectListReference(reference);
			SearchModel search = uDao.selectSearch(2);
			uDao.dbClose();
			
			request.setAttribute("searchType", searchType);
			request.setAttribute("orderBy", orderBy);
			request.setAttribute("listReference", listReference);
			request.setAttribute("search", search);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/references.jsp");
			dispatcher.forward(request, response);
		}
		else{
			if("references_excel".equals(menu)){
				UserDAO uDao = new UserDAO();
				List<ReferenceModel> listReference = uDao.selectListReferenceForExcel();
				uDao.dbClose();
				
				request.setAttribute("listReference", listReference);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/references_excel.jsp");
				dispatcher.forward(request, response);
			}
			else if("references_masters".equals(menu)){
				int mastersIdx = Integer.parseInt(request.getParameter("masters_idx"));
				String searchType = request.getParameter("searchType");
				String orderBy = request.getParameter("orderBy");
				
				if(searchType == null){
					searchType = "idx";
				}
				
				if(orderBy == null){
					orderBy = "ASC";
				}
				
				ReferenceModel reference = new ReferenceModel();
				reference.setMastersIdx(mastersIdx);
				reference.setSearchType(searchType);
				reference.setOrderBy(orderBy);
				
				UserDAO uDao = new UserDAO();
				List<ReferenceModel> listReference = uDao.selectListReferenceForMasters(reference);
				SearchModel search = uDao.selectSearch(2);
				uDao.dbClose();
				
				request.setAttribute("mastersIdx", mastersIdx);
				request.setAttribute("searchType", searchType);
				request.setAttribute("orderBy", orderBy);
				request.setAttribute("listReference", listReference);
				request.setAttribute("search", search);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/references_masters.jsp");
				dispatcher.forward(request, response);
			}
			
			else if("references_masters_excel".equals(menu)){
				int mastersIdx = Integer.parseInt(request.getParameter("masters_idx"));
				
				UserDAO uDao = new UserDAO();
				List<ReferenceModel> listReference = uDao.selectListReferenceForMastersExcel(mastersIdx);
				uDao.dbClose();
				
				request.setAttribute("listReference", listReference);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/references_masters_excel.jsp");
				dispatcher.forward(request, response);
			}
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}

