package servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class ImgUpload
 */
@WebServlet(name = "imgupload", urlPatterns = { "/imgupload" })
public class ImgUpload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImgUpload() {
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
		String uploadPath = context.getRealPath("/upload/temp");		// �� ���� ���� ���
		int maxSize = 100 * 1024 * 1024;							// ���� �ִ� ũ��(50MByte)
		
		try {
			MultipartRequest multi = null;
			multi = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
			
			Calendar cal = Calendar.getInstance();
			
			String fileLink = "link"+cal.get(Calendar.YEAR)+(cal.get(Calendar.MONTH)+1)+cal.get(Calendar.DAY_OF_MONTH)+cal.get(Calendar.HOUR_OF_DAY)+cal.get(Calendar.MINUTE)+cal.get(Calendar.SECOND)+cal.get(Calendar.MILLISECOND);
			
			String fileName = multi.getFilesystemName("file_name");
			String fileCode = multi.getParameter("file_code");
			
			String newFileName = "";
			String[] fileTok = fileName.split("\\.");
			if(fileTok.length>0)
				newFileName = fileCode + "." + fileTok[fileTok.length - 1];
			
			
			/// fpi ��ȣ ���丮 ���� �ű�� ÷������ �̵� ó��...
			if(fileName!=null && "".equals(fileName)==false) {
				File directory = new File(context.getRealPath("/upload/temp/"+fileLink));		// ���� ���� ���
				if(directory.exists() == false) {
					if(directory.mkdir()) {
						File orgFile = new File(context.getRealPath("/upload/temp/"+fileName));
						
						File movFile = new File(context.getRealPath("/upload/temp/"+fileLink)+"/"+newFileName);
						if(movFile.exists()) movFile.delete();
						
						if(orgFile.exists())	orgFile.renameTo(movFile);
					}
				} else {
					File orgFile = new File(context.getRealPath("/upload/temp/"+fileName));
					
					File movFile = new File(context.getRealPath("/upload/temp/"+fileLink)+"/"+newFileName);
					if(movFile.exists()) movFile.delete();
					
					if(orgFile.exists())	orgFile.renameTo(movFile);
				}
			}
			///////////////////////////////////////
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(fileLink);
			
		} catch(Exception e) {
			e.printStackTrace();
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script> alert('용량이 50MByte가 초과됩니다.'); history.go(-1); </script>");
		}
	}

}
