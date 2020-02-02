package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class Fileupload
 */
@WebServlet(name = "fileupload", urlPatterns = { "/fileupload" })
public class Fileupload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Fileupload() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		ServletContext context = getServletContext();
		
		// 파일 명 생성
		Calendar cal = Calendar.getInstance();
		String dirName = ""+cal.get(Calendar.YEAR)+(cal.get(Calendar.MONTH)+1)+cal.get(Calendar.DAY_OF_MONTH)+cal.get(Calendar.MILLISECOND);
		String dirPath = "/upload/temp/"+dirName;
		
		// 기존 파일이 있으면 삭제 없으면 생성
		File directory = new File(context.getRealPath(dirPath));		
		if(directory.exists() == false) {
			directory.mkdir();
		}
		else {
			removeFiles(dirPath);
		}
		
		String uploadPath = context.getRealPath(dirPath);		
		int maxSize = 50 * 1024 * 1024;							
		
		MultipartRequest multi = null;
		multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
		
		try {
			// �삷湲� �뙆�씪 寃쎈줈 
			String type = multi.getParameter("type");
			
			File saveFolder=new File(request.getSession().getServletContext().getRealPath(dirPath));

		    JSONObject obj = new JSONObject();
		    
		    obj.put("path", "upload/"+type+"/");
		    obj.put("baseurl", "upload/"+type+"/");
		    
		    JSONArray itemsArr = new JSONArray();
		    JSONArray msgs = new JSONArray();
		    
		    int i = 0;
		    for (File saveFiles : saveFolder.listFiles()) { 
		    	
		    	// �씠誘몄� �뙆�씪留� �뿀�슜 (jpg, jpeg, png留�)
		    	String pattern = "^\\S+.(?i)(jpg|jpeg|png)$";
		    	String saveName = saveFiles.getName();
		        
		    	if(Pattern.matches(pattern, saveName)) {
		    		String newFileName = "";
					String[] fileTok = saveName.split("\\.");
					if(fileTok.length>0)
						newFileName = dirName+"_"+i+"." + fileTok[fileTok.length - 1];
					
					File orgFile = new File(context.getRealPath(dirPath+"/"+saveName));
					File movFile = new File(context.getRealPath("/upload/"+type)+"/"+newFileName);
					if(movFile.exists()) movFile.delete();
					if(orgFile.exists())	orgFile.renameTo(movFile);
					
					itemsArr.add(newFileName);
		    	}
		    	i++;
		    }
		    
		    // 다 옮기고 옮기기전 디렉토리 삭제
		    removeDirectory(dirPath);
		    
		    obj.put("images", itemsArr);
		    obj.put("msg", msgs);
		    obj.put("messages", msgs);

			response.setContentType("application/json; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(obj);
			//System.out.println(obj.toString());
			
		} catch(Exception e) {
			e.printStackTrace();
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script> alert('업로드에 실패하였습니다.'); history.go(-1); </script>");
		}
	}
	
	// 파일만 삭제용
	private void removeFiles(String path) {
		ServletContext context = getServletContext();
		File folder = new File(context.getRealPath(path));
		try {
		    while(folder.exists()) {
				File[] folder_list = folder.listFiles(); //파일 리스트를 불러온다
						
				for (int j = 0; j < folder_list.length; j++) {
					folder_list[j].delete(); //파일을 삭제한다.
				}
				
	        }
		 } catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	// 디렉토리 전체 삭제용
	private void removeDirectory(String path) {
		ServletContext context = getServletContext();
		
		File folder = new File(context.getRealPath(path));
		try {
		    while(folder.exists()) {
			File[] folder_list = folder.listFiles(); //파일 리스트를 불러온다
					
				for (int j = 0; j < folder_list.length; j++) {
					folder_list[j].delete(); //파일을 삭제한다.
				}
						
				if(folder_list.length == 0 && folder.isDirectory()){ 
					folder.delete(); //파일이 다 삭제되면 폴더를 삭제한다.
				}
	        }
		 } catch (Exception e) {
			e.getStackTrace();
		}
	}

}
