package servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import util.Mail;
import util.RemoveTag;
import model.ContactModel;
import model.MainReviewModel;
import model.MastersApplyModel;
import model.MastersModel;
import model.PopupModel;
import model.RecommandModel;
import model.SearchModel;
import model.SetupModel;
import dao.UserDAO;

/**
 * Servlet implementation class Main
 */
@WebServlet(name = "main", urlPatterns = { "/main" })
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static final String basicAuth = "b56eedd7201ac24abf9a55bcac8c9e4c9af25819ebe0a0ed74ff0e9cb33a74bec30f3e82956f2bc55eb3490e76c963d47dc91852a1d1f54f6508ed5c6b0d8d34";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Main() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		UserDAO uDao = new UserDAO();
		SearchModel search = uDao.selectSearch(1);
		List<MainReviewModel> listMR = uDao.selectListMainReview();
		SetupModel setup = uDao.selectSetup();
		List<MastersModel> listMasters = uDao.selectListMastersForSlider("all", 10);
		SetupModel mainData = uDao.selectMainData();
		PopupModel popup = uDao.selectPopup();
		uDao.dbClose();
		request.setAttribute("popup", popup);
		request.setAttribute("mainData", mainData);
		request.setAttribute("setup", setup);
		request.setAttribute("listMR", listMR);
		request.setAttribute("search", search);
		request.setAttribute("listMasters", listMasters);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/main.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		
		String mode = request.getParameter("mode");
		
		if("contact".equals(mode)){
			String name = request.getParameter("name");
			String company = request.getParameter("company");
			String email = request.getParameter("email");
			String contact = request.getParameter("contact");
			String target = request.getParameter("target");
			String content = request.getParameter("content");
			
			UserDAO uDao = new UserDAO();
			SetupModel setup = uDao.selectSetup();
			
			List<String> listEmail = new ArrayList<String>();
			listEmail.add(setup.getEmail());
			
			String sendTxt = "";
			sendTxt += "이름 : "+name+"<br/>";
			sendTxt += "기업명 : "+company+"<br/>";
			sendTxt += "이메일 : "+email+"<br/>";
			sendTxt += "연락처 : "+contact+"<br/>";
			sendTxt += "교육대상 : "+target+"<br/>";
			sendTxt += "문의목록 : "+content.replaceAll("\n", "<br/>")+"<br/>";
			
			Mail.sendMail(sendTxt, "프로스쿨 - 문의하기 메일 발송", listEmail);
			
			ContactModel cm = new ContactModel();
			cm.setName(name);
			cm.setCompany(company);
			cm.setEmail(email);
			cm.setContact(contact);
			cm.setTarget(target);
			cm.setContent(content);
			uDao.insertContact(cm);
			
			uDao.dbClose();
			
		}
		
		else if("recommand".equals(mode)){
			String category = request.getParameter("category");
			String purpose = request.getParameter("purpose");
			String target = request.getParameter("target");
			String targetPosition = request.getParameter("target_position");
			String hour = request.getParameter("hour");
			String price = request.getParameter("price");
			String place = request.getParameter("place");
			String requestDate = request.getParameter("request_date");
			String manage = request.getParameter("manage");
			String requests = request.getParameter("request");
			String company = request.getParameter("company");
			String contact = request.getParameter("contact");
			String email = request.getParameter("email");
			
			UserDAO uDao = new UserDAO();
			SetupModel setup = uDao.selectSetup();
			
			List<String> listEmail = new ArrayList<String>();
			listEmail.add(setup.getEmail());
			//listEmail.add("rkqnd91@naver.com");
			
			String sendTxt = "";
			sendTxt += "강의 분야 : "+category+"<br/>";
			sendTxt += "교육 목적 : "+purpose+"<br/>";
			sendTxt += "교육 대상자 : "+target+"<br/>";
			sendTxt += "교육 대상자 직무 : "+targetPosition+"<br/>";
			sendTxt += "교육시간 : "+hour+"<br/>";
			sendTxt += "교육비 예산 : "+price.replaceAll("\n", "<br/>")+"<br/>";
			sendTxt += "교육 장소 : "+place.replaceAll("\n", "<br/>")+"<br/>";
			sendTxt += "교육요청일 : "+requestDate+"<br/>";
			sendTxt += "교육 운영 : "+manage+"<br/>";
			sendTxt += "요청 사항 : "+requests.replaceAll("\n", "<br/>")+"<br/>";
			sendTxt += "회사명 : "+company+"<br/>";
			sendTxt += "연락처 : "+contact+"<br/>";
			sendTxt += "이메일 : "+email+"<br/>";
			
			
		//	Mail.sendMail(sendTxt, "프로스쿨 - 교육제안서 요청하기", listEmail);
			
			RecommandModel rc = new RecommandModel();
			rc.setCategory(category);
			rc.setTarget(target);
			rc.setPurpose(purpose);
			rc.setTargetPosition(targetPosition);
			rc.setHour(hour);
			rc.setPrice(price);
			rc.setPlace(place);
			rc.setRequestDate(requestDate);
			rc.setManage(manage);
			rc.setRequest(requests);
			rc.setCompany(company);
			rc.setContact(contact);
			rc.setEmail(email);
			uDao.insertRecommand(rc);
			
			uDao.dbClose();
			
		}
		
		else if("apply".equals(mode)){
			String name = request.getParameter("name");
			String company = request.getParameter("company");
			String email = request.getParameter("email");
			String contact = request.getParameter("contact");
			String target = request.getParameter("target");
			String fileData = request.getParameter("file_data");
			String file[] = fileData.split("/");
			
			MastersApplyModel ma = new MastersApplyModel();
			ma.setName(name);
			ma.setCompany(company);
			ma.setEmail(email);
			ma.setContact(contact);
			ma.setTarget(target);
			ma.setFiles(file[1]);
			
			UserDAO uDao = new UserDAO();
			SetupModel setup = uDao.selectSetup();
			
			List<String> listEmail = new ArrayList<String>();
			listEmail.add(setup.getEmail());
			String sendTxt = "";
			sendTxt += "성명 : "+name+"<br/>";
			sendTxt += "회사명 : "+company+"<br/>";
			sendTxt += "이메일 : "+email+"<br/>";
			sendTxt += "연락처 : "+contact+"<br/>";
			sendTxt += "교육대상자 : "+target+"<br/>";;
			
			
			Mail.sendMail(sendTxt, "프로스쿨 - 마스터 지원하기", listEmail);
			
			
			int idx = uDao.insertMastersApply(ma);
			uDao.dbClose();
			
			ServletContext context = getServletContext();
			
			if(fileData!=null && "".equals(fileData)==false) {
				File directory = new File(context.getRealPath("/upload/masters_apply/"+idx));		// ���� ���� ���
				if(directory.exists() == false) {
					if(directory.mkdir()) {
						File orgFile = new File(context.getRealPath("/upload/temp/"+fileData));
						File movFile = new File(context.getRealPath("/upload/masters_apply/"+idx)+"/"+file[1]);
						
						if(movFile.exists()) movFile.delete();
						if(orgFile.exists())	orgFile.renameTo(movFile);
					}
				} else {
					File orgFile = new File(context.getRealPath("/upload/temp/"+fileData));
					File movFile = new File(context.getRealPath("/upload/masters_apply/"+idx)+"/"+file[1]);
					
					if(movFile.exists()) movFile.delete();
					if(orgFile.exists())	orgFile.renameTo(movFile);
					
				}
			}
		}
		
		else if("get_slider_masters".equals(mode)){
			String category = request.getParameter("category");
			int limit = Integer.parseInt(request.getParameter("limit"));
			
			System.out.println(category);
			System.out.println(limit);
			
			UserDAO uDao = new UserDAO();
			List<MastersModel> listMasters = uDao.selectListMastersForSlider(category, limit);
			uDao.dbClose();
			
			System.out.println(listMasters.size());
			
			NumberFormat nf = NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			
			JSONArray arr = new JSONArray();
			for(int i=0; i<listMasters.size(); i++){
				JSONObject obj = new JSONObject();
				obj.put("idx", listMasters.get(i).getIdx());
				obj.put("tag", listMasters.get(i).getTag());
				obj.put("name", listMasters.get(i).getName());
				obj.put("image", "upload/masters/"+listMasters.get(i).getIdx()+"/"+listMasters.get(i).getImg());
				obj.put("score", nf.format(listMasters.get(i).getReferenceScore()));
				
				arr.add(obj);
			}
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(arr);
		}
		
		else if("subscribe".equals(mode)){
			String email = request.getParameter("email"); 
			
			JSONObject obj = new JSONObject();
			JSONArray groupsId = new JSONArray();
			JSONArray userArr = new JSONArray();
			JSONObject userObj = new JSONObject();
			userObj.put("email", email);
			userObj.put("name", "");
			userObj.put("tag1", "");
			userObj.put("tag2", "");
			userObj.put("tag3", "");
			
			groupsId.add("27656");
			userArr.add(userObj);
			
			obj.put("eventOccuredBy", "SUBSCRIBER");
			obj.put("confirmEmailYN", "N");
			obj.put("groupIds", groupsId);
			obj.put("subscribers", userArr);
			
			URL url = new URL("https://api.stibee.com/v1/lists/39699/subscribers");
			
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty ("AccessToken", basicAuth);
			
			String param = obj.toString();
			
			OutputStreamWriter osw = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
			
			try{
				osw.write(param);
				osw.flush();
				
				BufferedReader br = null;
				br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				StringBuilder sb = new StringBuilder();
				String line = null;
				while((line = br.readLine()) != null){
					sb.append(line);
				}
				br.close();
				
				JSONObject objData = (JSONObject) JSONValue.parseWithException(sb.toString());
				JSONObject valueData = (JSONObject) objData.get("Value");
				
				if(valueData == null){
				}
				else{
					
					JSONArray successArr = (JSONArray) valueData.get("success");
					if(successArr.size()>0){
						UserDAO uDao = new UserDAO();
						uDao.insertSubscribe(email);
					}
				
				}
				
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

}
