package dao;

import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.proxy.annotation.Pre;
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

public class UserDAO extends GlovalVariable {
	public UserDAO() {
		conn = DBConnection.getConnection();
	} //end
	
	// select search
	public SearchModel selectSearch(int idx){
		SearchModel search = new SearchModel();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT title, description, keywords "
					+ "FROM search "
					+ "WHERE idx=?");
			
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()){
				search.setTitle(rs.getString("title"));
				search.setDescription(rs.getString("description"));
				search.setKeywords(rs.getString("keywords"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return search;
	}
	
	// search setup
	public SetupModel selectSetup(){
		SetupModel setup = new SetupModel();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT banner, pdf, contact, logo, category, email, color, address, recommand, company_num, "
					+ "company_name, information "
					+ "FROM setup "
					+ "WHERE idx=1");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				setup.setBanner(rs.getString("banner"));
				setup.setPdf(rs.getString("pdf"));
				setup.setContact(rs.getString("contact"));
				setup.setLogo(rs.getString("logo"));
				setup.setCategory(rs.getInt("category"));
				setup.setEmail(rs.getString("email"));
				setup.setColor(rs.getString("color"));
				setup.setAddress(rs.getString("address"));
				setup.setRecommand(rs.getString("recommand"));
				setup.setCompanyNum(rs.getString("company_num"));
				setup.setCompanyName(rs.getString("company_name"));
				setup.setInformation(rs.getString("information"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return setup;
	}
	
	// search family site for list
	public List<FamilySiteModel> selectListFamilySite(){
		List<FamilySiteModel> listFS = new ArrayList<FamilySiteModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, name, link, sort, ts FROM family_site "
					+ "ORDER BY sort ASC");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				FamilySiteModel fs = new FamilySiteModel();
				fs.setIdx(rs.getInt("idx"));
				fs.setName(rs.getString("name"));
				fs.setLink(rs.getString("link"));
				fs.setSort(rs.getInt("sort"));
				fs.setTs(rs.getString("ts"));
				listFS.add(fs);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listFS;
	}
	
	/* main review */
	public List<MainReviewModel> selectListMainReview(){
		List<MainReviewModel> listMR = new ArrayList<MainReviewModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, img, name, content, date "
					+ "FROM main_review "
					+ "WHERE idx<>-1 "
					+ "ORDER BY idx DESC LIMIT 10");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				MainReviewModel mr = new MainReviewModel();
				mr.setIdx(rs.getInt("idx"));
				mr.setImg(rs.getString("img"));
				mr.setName(rs.getString("name"));
				mr.setContent(rs.getString("content"));
				mr.setDate(rs.getString("date"));
				listMR.add(mr);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listMR;
	}
	
	// select news for top rolling
	public List<NewsInfoModel> selectListNewsForTopRolling(){
		List<NewsInfoModel> listNI = new ArrayList<NewsInfoModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, title, top, content, thumbnail, view_date "
					+ "FROM news "
					+ "WHERE top=1 "
					+ "ORDER BY view_date DESC");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				NewsInfoModel ni = new NewsInfoModel();
				ni.setIdx(rs.getInt("idx"));
				ni.setTitle(rs.getString("title"));
				ni.setTop(rs.getInt("top"));
				ni.setContent(rs.getString("content"));
				ni.setThumbnail(rs.getString("thumbnail"));
				ni.setViewDate(rs.getString("view_date"));
				
				listNI.add(ni);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listNI;
	}
	
	// select news list
	public List<NewsInfoModel> selectListNewsInfo(NewsInfoModel modelParam){
		List<NewsInfoModel> listNI = new ArrayList<NewsInfoModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		String whereSQL = "";
		
		if("all".equals(modelParam.getSearchType())==false){
			int searchTypeInt = 0;
			try{ searchTypeInt = Integer.parseInt(modelParam.getSearchType()); } catch(Exception e){ searchTypeInt = 0; }
			
			whereSQL+=" AND type="+searchTypeInt+" ";
		}
		
		if("".equals(modelParam.getSearchText())==false){
			whereSQL+=" AND (title like '%"+modelParam.getSearchText()+"%' OR content like '%"+modelParam.getSearchText()+"%') ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, type, top, title, content, thumbnail, view_date "
					+ "FROM news "
					+ "WHERE idx<>-1 AND NOW()>=view_date "+whereSQL
					+ "ORDER BY view_date DESC LIMIT ?, ?");
			
			pstmt.setInt(1, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(2, modelParam.getListCount());
			rs = pstmt.executeQuery();
			while(rs.next()){
				NewsInfoModel ni = new NewsInfoModel();
				ni.setIdx(rs.getInt("idx"));
				ni.setType(rs.getInt("type"));
				ni.setTop(rs.getInt("top"));
				ni.setTitle(rs.getString("title"));
				ni.setContent(rs.getString("content"));
				ni.setThumbnail(rs.getString("thumbnail"));
				ni.setViewDate(rs.getString("view_date"));
				listNI.add(ni);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listNI;
	}
	
	// select news list
	public int selectCountListNewsInfo(NewsInfoModel modelParam){
		int totalCount = 0;
		String whereSQL = "";
		
		if("all".equals(modelParam.getSearchType())==false){
			int searchTypeInt = 0;
			try{ searchTypeInt = Integer.parseInt(modelParam.getSearchType()); } catch(Exception e){ searchTypeInt = 0; }
			
			whereSQL+=" AND type="+searchTypeInt+" ";
		}
		
		if("".equals(modelParam.getSearchText())==false){
			whereSQL+=" AND (title like '%"+modelParam.getSearchText()+"%' OR content like '%"+modelParam.getSearchText()+"%') ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT COUNT(idx) AS total "
					+ "FROM news "
					+ "WHERE idx<>-1 AND NOW()>=view_date "+whereSQL);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	// select news for detail
	public NewsInfoModel selectNewsInfo(int idx){
		NewsInfoModel ni = new NewsInfoModel();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, type, top, title, content, thumbnail, view_date, keywords, "
					+ "IF(NOW()<view_date, 0, 1) AS listing_check "
					+ "FROM news "
					+ "WHERE idx=?");
			
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()){
				ni.setIdx(rs.getInt("idx"));
				ni.setType(rs.getInt("type"));
				ni.setTitle(rs.getString("title"));
				ni.setContent(rs.getString("content"));
				ni.setThumbnail(rs.getString("thumbnail"));
				ni.setViewDate(rs.getString("view_date"));
				ni.setListingCheck(rs.getInt("listing_check"));
				ni.setKeywords(rs.getString("keywords"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return ni;
	}
	
	// add contact
	public void insertContact(ContactModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"INSERT INTO contact(name, company, email, contact, target, content, date) "
					+ "VALUES(?, ?, ?, ?, ?, ?, NOW())");
			
			pstmt.setString(1, modelParam.getName());
			pstmt.setString(2, modelParam.getCompany());
			pstmt.setString(3, modelParam.getEmail());
			pstmt.setString(4, modelParam.getContact());
			pstmt.setString(5, modelParam.getTarget());
			pstmt.setString(6, modelParam.getContent());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	// search reference list
	public List<ReferenceModel> selectListReference(ReferenceModel modelParam){
		List<ReferenceModel> listReference = new ArrayList<ReferenceModel>();
		
		String whereSQL = " "+modelParam.getSearchType()+" "+modelParam.getOrderBy()+" ";
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT a.idx AS idx, a.masters_idx, b.name AS master_name, a.score AS score, a.company AS company, a.education, "
					+ "a.target, a.people, a.hour, a.hide, a.date AS date, b.category AS category "
					+ "FROM reference a "
					+ "LEFT JOIN masters b "
					+ "ON a.masters_idx=b.idx "
					+ "WHERE a.idx<>-1 AND a.hide<>1 "
					+ "ORDER BY "+whereSQL);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ReferenceModel reference = new ReferenceModel();
				reference.setIdx(rs.getInt("idx"));
				reference.setMastersIdx(rs.getInt("masters_idx"));
				reference.setMasterName(rs.getString("master_name"));
				reference.setScore(rs.getDouble("score"));
				reference.setCompany(rs.getString("company"));
				reference.setEducation(rs.getString("education"));
				reference.setTarget(rs.getString("target"));
				reference.setPeople(rs.getInt("people"));
				reference.setHour(rs.getInt("hour"));
				reference.setHide(rs.getInt("hide"));
				reference.setDate(rs.getString("date"));
				reference.setCategory(rs.getInt("category"));
				
				listReference.add(reference);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listReference;
	}
	
	// search reference list
	public List<ReferenceModel> selectListReferenceForMasters(ReferenceModel modelParam){
		List<ReferenceModel> listReference = new ArrayList<ReferenceModel>();
		
		String whereSQL = " "+modelParam.getSearchType()+" "+modelParam.getOrderBy()+" ";
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT a.idx AS idx, a.masters_idx, b.name AS master_name, a.score AS score, a.company AS company, a.education, "
					+ "a.target, a.people, a.hour, a.hide, a.date AS date, b.category AS category "
					+ "FROM reference a "
					+ "LEFT JOIN masters b "
					+ "ON a.masters_idx=b.idx "
					+ "WHERE a.idx<>-1 AND a.hide<>1 AND a.masters_idx=? "
					+ "ORDER BY "+whereSQL);
			
			pstmt.setInt(1, modelParam.getMastersIdx());
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ReferenceModel reference = new ReferenceModel();
				reference.setIdx(rs.getInt("idx"));
				reference.setMastersIdx(rs.getInt("masters_idx"));
				reference.setMasterName(rs.getString("master_name"));
				reference.setScore(rs.getDouble("score"));
				reference.setCompany(rs.getString("company"));
				reference.setEducation(rs.getString("education"));
				reference.setTarget(rs.getString("target"));
				reference.setPeople(rs.getInt("people"));
				reference.setHour(rs.getInt("hour"));
				reference.setHide(rs.getInt("hide"));
				reference.setDate(rs.getString("date"));
				reference.setCategory(rs.getInt("category"));
				
				listReference.add(reference);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listReference;
	}
	
	// search reference list for excel
	public List<ReferenceModel> selectListReferenceForMastersExcel(int mastersIdx){
		List<ReferenceModel> listReference = new ArrayList<ReferenceModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT a.idx, a.masters_idx, b.name, a.score, a.company, a.education, "
					+ "a.target, a.people, a.hour, a.hide, a.date, b.category "
					+ "FROM reference a "
					+ "LEFT JOIN masters b "
					+ "ON a.masters_idx=b.idx "
					+ "WHERE a.idx<>-1 AND a.hide<>1  AND a.masters_idx=? ");
			
			pstmt.setInt(1, mastersIdx);
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ReferenceModel reference = new ReferenceModel();
				reference.setIdx(rs.getInt("idx"));
				reference.setMastersIdx(rs.getInt("masters_idx"));
				reference.setMasterName(rs.getString("name"));
				reference.setScore(rs.getDouble("score"));
				reference.setCompany(rs.getString("company"));
				reference.setEducation(rs.getString("education"));
				reference.setTarget(rs.getString("target"));
				reference.setPeople(rs.getInt("people"));
				reference.setHour(rs.getInt("hour"));
				reference.setHide(rs.getInt("hide"));
				reference.setDate(rs.getString("date"));
				reference.setCategory(rs.getInt("category"));
				
				listReference.add(reference);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listReference;
	}
	
	// search reference list for excel
	public List<ReferenceModel> selectListReferenceForExcel(){
		List<ReferenceModel> listReference = new ArrayList<ReferenceModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT a.idx, a.masters_idx, b.name, a.score, a.company, a.education, "
					+ "a.target, a.people, a.hour, a.hide, a.date, b.category "
					+ "FROM reference a "
					+ "LEFT JOIN masters b "
					+ "ON a.masters_idx=b.idx "
					+ "WHERE a.idx<>-1 AND a.hide<>1 ");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ReferenceModel reference = new ReferenceModel();
				reference.setIdx(rs.getInt("idx"));
				reference.setMastersIdx(rs.getInt("masters_idx"));
				reference.setMasterName(rs.getString("name"));
				reference.setScore(rs.getDouble("score"));
				reference.setCompany(rs.getString("company"));
				reference.setEducation(rs.getString("education"));
				reference.setTarget(rs.getString("target"));
				reference.setPeople(rs.getInt("people"));
				reference.setHour(rs.getInt("hour"));
				reference.setHide(rs.getInt("hide"));
				reference.setDate(rs.getString("date"));
				reference.setCategory(rs.getInt("category"));
				
				listReference.add(reference);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listReference;
	}
	
	// masters page count
	public MastersModel selectCountMastersForCategory(){
		MastersModel countMasters = new MastersModel();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT "
					+ "(select count(idx) from masters where hide=0) AS all_count, "
					+ "(select count(idx) from masters where category=1 and hide=0) AS digital_count, "
					+ "(select count(idx) from masters where category=2 and hide=0) AS life_count, "
					+ "(select count(idx) from masters where category=3 and hide=0) AS service_count ");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				countMasters.setAllCount(rs.getInt("all_count"));
				countMasters.setDigitalCount(rs.getInt("digital_count"));
				countMasters.setLifeCount(rs.getInt("life_count"));
				countMasters.setServiceCount(rs.getInt("service_count"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return countMasters;
	}
	
	// masters list
	public List<MastersModel> selectListMasters(MastersModel modelParam){
		List<MastersModel> listMasters = new ArrayList<MastersModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
	
		String whereSQL = "";
		if("all".equals(modelParam.getSearchType())==false)
			whereSQL = " AND a.category="+Integer.parseInt(modelParam.getSearchType())+" ";
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT a.idx, a.category, a.img, a.name, a.slogan, a.tag, a.company, a.position, "
					+ "a.best_hide, a.hide, a.date, a.title, a.description, a.keywords, "
					+ "(select sum(score) from reference where masters_idx=a.idx and hide<>1) AS total_score, "
					+ "(select count(idx) from reference where masters_idx=a.idx and hide<>1) AS reference_count, "
					+ "(select sum(people) from reference where masters_idx=a.idx and hide<>1) AS reference_people, "
					+ "(select count(idx) from masters_review where masters_idx=a.idx) AS review_count "
					+ "FROM masters a "
					+ "WHERE a.idx<>-1 AND a.hide<>1 "+whereSQL
					+ "ORDER BY a.idx DESC LIMIT ?, ?");
			
			pstmt.setInt(1, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(2, modelParam.getListCount());
			rs = pstmt.executeQuery();
			while(rs.next()){
				MastersModel masters = new MastersModel();
				masters.setIdx(rs.getInt("idx"));
				masters.setCategory(rs.getInt("category"));
				masters.setImg(rs.getString("img"));
				masters.setName(rs.getString("name"));
				masters.setSlogan(rs.getString("slogan"));
				masters.setTag(rs.getString("tag"));
				masters.setCompany(rs.getString("company"));
				masters.setPosition(rs.getString("position"));
				masters.setBestHide(rs.getInt("best_hide"));
				masters.setHide(rs.getInt("hide"));
				masters.setDate(rs.getString("date"));
				if(Double.isNaN(rs.getDouble("total_score")/rs.getInt("reference_count")))
					masters.setReferenceScore(0);
				else
					masters.setReferenceScore(rs.getDouble("total_score")/rs.getInt("reference_count"));
				masters.setReferenceCount(rs.getInt("reference_count"));
				masters.setReferencePeople(rs.getInt("reference_people"));
				masters.setReviewCount(rs.getInt("review_count"));
				masters.setTitle(rs.getString("title"));
				masters.setDescription(rs.getString("description"));
				masters.setKeywords(rs.getString("keywords"));
				
				listMasters.add(masters);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listMasters;
	}
	
	// masters list
	public int selectCountListMasters(MastersModel modelParam){
		int totalCount = 0;
		String whereSQL = "";
		if("all".equals(modelParam.getSearchType())==false)
			whereSQL = " AND a.category="+Integer.parseInt(modelParam.getSearchType())+" ";
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT COUNT(a.idx) AS total "
					+ "FROM masters a "
					+ "WHERE a.idx<>-1 AND a.hide<>1 "+whereSQL);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	
	// masters list
	public List<MastersModel> selectListMastersForSlider(String category, int limit){
		List<MastersModel> listMasters = new ArrayList<MastersModel>();
		
		String whereSQL = "";
		if("all".equals(category)==false)
			whereSQL = " AND a.category="+Integer.parseInt(category)+" ";
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT a.idx, a.category, a.img, a.name, a.slogan, a.tag, a.company, a.position, "
					+ "a.best_hide, a.hide, a.date, a.title, a.description, a.keywords, "
					+ "((select sum(score) from reference where masters_idx=a.idx and hide<>1)/"
					+ "(select count(idx) from reference where masters_idx=a.idx and hide<>1)) AS score, "
					+ "(select sum(people) from reference where masters_idx=a.idx and hide<>1) AS reference_people, "
					+ "(select count(idx) from masters_review where masters_idx=a.idx) AS review_count "
					+ "FROM masters a "
					+ "WHERE a.idx<>-1 AND a.hide<>1 AND a.best_hide<>1 "+whereSQL
					+ "ORDER BY score DESC LIMIT ?");
			
			pstmt.setInt(1, limit);
			rs = pstmt.executeQuery();
			while(rs.next()){
				MastersModel masters = new MastersModel();
				masters.setIdx(rs.getInt("idx"));
				masters.setCategory(rs.getInt("category"));
				masters.setImg(rs.getString("img"));
				masters.setName(rs.getString("name"));
				masters.setSlogan(rs.getString("slogan"));
				masters.setTag(rs.getString("tag"));
				masters.setCompany(rs.getString("company"));
				masters.setPosition(rs.getString("position"));
				masters.setBestHide(rs.getInt("best_hide"));
				masters.setHide(rs.getInt("hide"));
				masters.setDate(rs.getString("date"));
				masters.setReferenceScore(rs.getDouble("score"));
				masters.setReferencePeople(rs.getInt("reference_people"));
				masters.setReviewCount(rs.getInt("review_count"));
				masters.setTitle(rs.getString("title"));
				masters.setDescription(rs.getString("description"));
				masters.setKeywords(rs.getString("keywords"));
				
				listMasters.add(masters);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listMasters;
	}
	
	public List<String> selectListHistoryForMasters(int mastersIdx){
		List<String> listHistory = new ArrayList<String>();
		try{
			pstmt = conn.prepareStatement(
					"SELECT history FROM masters_history WHERE masters_idx=? ORDER BY idx DESC LIMIT 5");
			
			pstmt.setInt(1, mastersIdx);
			rs = pstmt.executeQuery();
			while(rs.next()){
				listHistory.add(rs.getString("history"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return listHistory;
	}
	
	// masters detail
	public MastersModel selectMasters(int idx){
		MastersModel masters = new MastersModel();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT a.idx, a.category, a.img, a.name, a.slogan, a.tag, a.company, a.position, "
					+ "a.best_hide, a.hide, a.date, a.title, a.description, a.keywords, "
					+ "(select sum(score) from reference where masters_idx=a.idx and hide<>1) AS total_score, "
					+ "(select count(idx) from reference where masters_idx=a.idx and hide<>1) AS reference_count, "
					+ "(select sum(people) from reference where masters_idx=a.idx and hide<>1) AS reference_people, "
					+ "(select count(idx) from masters_review where masters_idx=a.idx) AS review_count "
					+ "FROM masters a "
					+ "WHERE a.idx=? ");
			
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()){
				masters.setIdx(rs.getInt("idx"));
				masters.setCategory(rs.getInt("category"));
				masters.setImg(rs.getString("img"));
				masters.setName(rs.getString("name"));
				masters.setSlogan(rs.getString("slogan"));
				masters.setTag(rs.getString("tag"));
				masters.setCompany(rs.getString("company"));
				masters.setPosition(rs.getString("position"));
				masters.setBestHide(rs.getInt("best_hide"));
				masters.setHide(rs.getInt("hide"));
				masters.setDate(rs.getString("date"));
				masters.setTitle(rs.getString("title"));
				masters.setDescription(rs.getString("description"));
				masters.setKeywords(rs.getString("keywords"));
				if(Double.isNaN(rs.getDouble("total_score")/rs.getInt("reference_count")))
					masters.setReferenceScore(0);
				else
					masters.setReferenceScore(rs.getDouble("total_score")/rs.getInt("reference_count"));
				masters.setReferenceCount(rs.getInt("reference_count"));
				masters.setReferencePeople(rs.getInt("reference_people"));
				masters.setReviewCount(rs.getInt("review_count"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return masters;
	}
	
	// masters history list
	public List<MastersHistoryModel> selectListMastersHistory(int mastersIdx){
		List<MastersHistoryModel> listMH = new ArrayList<MastersHistoryModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, history, date FROM masters_history "
					+ "WHERE masters_idx=? "
					+ "ORDER BY idx ASC");
			
			pstmt.setInt(1, mastersIdx);
			rs = pstmt.executeQuery();
			while(rs.next()){
				MastersHistoryModel mh = new MastersHistoryModel();
				mh.setIdx(rs.getInt("idx"));
				mh.setHistory(rs.getString("history"));
				mh.setDate(rs.getString("date"));
				listMH.add(mh);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listMH;
	}
	
	// masters activity list
	public List<MastersActivityModel> selectListMastersActivity(int mastersIdx){
		List<MastersActivityModel> listMA = new ArrayList<MastersActivityModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, title, content, date "
					+ "FROM masters_activity "
					+ "WHERE masters_idx=?");
			
			pstmt.setInt(1, mastersIdx);
			rs = pstmt.executeQuery();
			while(rs.next()){
				MastersActivityModel ma = new MastersActivityModel();
				ma.setIdx(rs.getInt("idx"));
				ma.setTitle(rs.getString("title"));
				ma.setContent(rs.getString("content"));
				ma.setDate(rs.getString("date"));
				listMA.add(ma);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listMA;
	}
	
	// curriculum list
	public List<CurriculumModel> selectListCurriculum(int mastersIdx){
		List<CurriculumModel> listCurri = new ArrayList<CurriculumModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, title, date "
					+ "FROM curriculum "
					+ "WHERE masters_idx=?");
					
			pstmt.setInt(1, mastersIdx);
			rs = pstmt.executeQuery();
			while(rs.next()){
				CurriculumModel curri = new CurriculumModel();
				curri.setIdx(rs.getInt("idx"));
				curri.setTitle(rs.getString("title"));
				curri.setDate(rs.getString("date"));
				listCurri.add(curri);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listCurri;
	}
	
	// curriculum detail list
	public List<CurriculumDetailModel> selectListCurriDetail(int mastersIdx){
		List<CurriculumDetailModel> listCD = new ArrayList<CurriculumDetailModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, curriculum_idx, category, title, content, date "
					+ "FROM curriculum_detail "
					+ "WHERE masters_idx=? ORDER BY curriculum_idx ASC, category ASC");
			
			pstmt.setInt(1, mastersIdx);
			rs = pstmt.executeQuery();
			while(rs.next()){
				CurriculumDetailModel cd = new CurriculumDetailModel();
				cd.setIdx(rs.getInt("idx"));
				cd.setCurriculumIdx(rs.getInt("curriculum_idx"));
				cd.setCategory(rs.getInt("category"));
				cd.setTitle(rs.getString("title"));
				cd.setContent(rs.getString("content"));
				cd.setDate(rs.getString("date"));
				listCD.add(cd);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listCD;
	}
	
	// search masters review list
	public List<MastersReviewModel> selectListMastersReview(int mastersIdx){
		List<MastersReviewModel> listReview = new ArrayList<MastersReviewModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, masters_idx, img, name, content, date "
					+ "FROM masters_review "
					+ "WHERE masters_idx=?");
			
			pstmt.setInt(1, mastersIdx);
			rs = pstmt.executeQuery();
			while(rs.next()){
				MastersReviewModel review = new MastersReviewModel();
				review.setIdx(rs.getInt("idx"));
				review.setMastersIdx(rs.getInt("masters_idx"));
				review.setImg(rs.getString("img"));
				review.setName(rs.getString("name"));
				review.setContent(rs.getString("content"));
				review.setDate(rs.getString("date"));
				
				listReview.add(review);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listReview;
	}
	
	// search list master cut
	public List<MastersCutModel> selectListMastersCut(int mastersIdx){
		List<MastersCutModel> listMC = new ArrayList<MastersCutModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, masters_idx, category, title, content, date "
					+ "FROM masters_cut "
					+ "WHERE masters_idx=?");
			
			pstmt.setInt(1, mastersIdx);
			rs = pstmt.executeQuery();
			while(rs.next()){
				MastersCutModel mc = new MastersCutModel();
				mc.setIdx(rs.getInt("idx"));
				mc.setMastersIdx(rs.getInt("masters_idx"));
				mc.setCategory(rs.getInt("category"));
				mc.setTitle(rs.getString("title"));
				mc.setContent(rs.getString("content"));
				mc.setDate(rs.getString("date"));
				
				listMC.add(mc);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listMC;
	}
	
	// 교육추천서 등록
	public void insertRecommand(RecommandModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"INSERT INTO recommand(category, purpose, target, target_position, hour, price, place, "
					+ "request_date, manage, request, company, contact, email, date) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())");
			
			pstmt.setString(1, modelParam.getCategory());
			pstmt.setString(2, modelParam.getPurpose());
			pstmt.setString(3, modelParam.getTarget());
			pstmt.setString(4, modelParam.getTargetPosition());
			pstmt.setString(5, modelParam.getHour());
			pstmt.setString(6, modelParam.getPrice());
			pstmt.setString(7, modelParam.getPlace());
			pstmt.setString(8, modelParam.getRequestDate());
			pstmt.setString(9, modelParam.getManage());
			pstmt.setString(10, modelParam.getRequest());
			pstmt.setString(11, modelParam.getCompany());
			pstmt.setString(12, modelParam.getContact());
			pstmt.setString(13, modelParam.getEmail());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// 구독
	public void insertSubscribe(String email){
		try{
			pstmt = conn.prepareStatement(
					"INSERT INTO subscribe(email, date) VALUES(?, NOW())");
			
			pstmt.setString(1, email);
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// 메인용 데이터
	public SetupModel selectMainData(){
		SetupModel mainData = new SetupModel();
		try{
			pstmt = conn.prepareStatement(
					"SELECT "
					+ "(select count(idx) from reference where hide<>1) AS total_reference_count, "
					+ "(select sum(people) from reference where hide<>1) AS total_reference_people, "
					+ "((select sum(score) from reference where hide<>1)/"
					+ "(select count(idx) from reference where hide<>1)) AS total_reference_score ");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				mainData.setTotalReferenceCount(rs.getInt("total_reference_count"));
				mainData.setTotalReferencePeople(rs.getInt("total_reference_people"));
				mainData.setTotalReferenceScore(rs.getDouble("total_reference_score"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return mainData;
	}
	
	// select popup
	public PopupModel selectPopup(){
		PopupModel popup = new PopupModel();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, img, link, hide "
					+ "FROM popup "
					+ "WHERE idx=1 and hide=0");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				popup.setIdx(rs.getInt("idx"));
				popup.setImg(rs.getString("img"));
				popup.setLink(rs.getString("link"));
				popup.setHide(rs.getInt("hide"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return popup;
	}
	
	// master apply
	public int insertMastersApply(MastersApplyModel modelParam){
		int idx = -1;
		
		try{
			pstmt = conn.prepareStatement(
					"INSERT INTO masters_apply(name, company, email, contact, target, files, date) "
					+ "VALUES(?, ?, ?, ?, ?, ?, NOW())");
			
			pstmt.setString(1, modelParam.getName());
			pstmt.setString(2, modelParam.getCompany());
			pstmt.setString(3, modelParam.getEmail());
			pstmt.setString(4, modelParam.getContact());
			pstmt.setString(5, modelParam.getTarget());
			pstmt.setString(6, modelParam.getFiles());
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"SELECT MAX(idx) AS max_no FROM masters_apply");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				idx = rs.getInt("max_no");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return idx;
	}
	
	
	/**
	 * database connection close
	 */
	public void dbClose() {
		try {
			DBConnection.close(rs, pstmt, conn);
		} catch (Exception e) {

		}
	}

}
