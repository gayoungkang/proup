package dao;

import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;

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

public class AdminDAO extends GlovalVariable {
	
	public AdminDAO() {
		conn = DBConnection.getConnection();
	} //end
	
	/**
	 * master section start
	 */
	
	// masters list
	public List<MastersModel> selectListMasters(MastersModel modelParam){
		List<MastersModel> listMasters = new ArrayList<MastersModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			whereSQL = " AND name like '%"+modelParam.getName()+"%' ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT a.idx, a.category, a.img, a.name, a.slogan, a.tag, a.company, a.position, "
					+ "a.best_hide, a.hide, a.date, a.title, a.description, a.keywords, "
					+ "(select sum(score) from reference where masters_idx=a.idx and hide<>1) AS total_score, "
					+ "(select count(idx) from reference where masters_idx=a.idx and hide<>1) AS reference_count, "
					+ "(select sum(people) from reference where masters_idx=a.idx and hide<>1) AS reference_people, "
					+ "(select count(idx) from masters_review where masters_idx=a.idx) AS review_count "
					+ "FROM masters a "
					+ "WHERE a.idx<>-1 "+whereSQL
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
	
	// masters list for excel
	public List<MastersModel> selectListMastersForExcel(){
		List<MastersModel> listMasters = new ArrayList<MastersModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT a.idx, a.category, a.img, a.name, a.slogan, a.tag, a.company, a.position, "
					+ "a.best_hide, a.hide, a.date, a.title, a.description, a.keywords, "
					+ "(select sum(score) from reference where masters_idx=a.idx and hide<>1) AS total_score, "
					+ "(select count(idx) from reference where masters_idx=a.idx and hide<>1) AS reference_count, "
					+ "(select sum(people) from reference where masters_idx=a.idx and hide<>1) AS reference_people, "
					+ "(select count(idx) from masters_review where masters_idx=a.idx) AS review_count "
					+ "FROM masters a "
					+ "WHERE a.idx<>-1 ");
			
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
	
	// masters list count
	public int selectCountListMasters(MastersModel modelParam){
		int totalCount = 0;
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			whereSQL = " AND name like '%"+modelParam.getName()+"%' ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT COUNT(a.idx) AS total "
					+ "FROM masters a "
					+ "WHERE a.idx<>-1 "+whereSQL);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return totalCount;
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
	
	// insert masters
	public int insertMasters(MastersModel modelParam){
		int idx = -1;
		
		try{
			pstmt = conn.prepareStatement(
					"INSERT INTO masters(category, img, name, slogan, tag, company, "
					+ "position, title, description, keywords, best_hide, hide, date) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())");
			
			pstmt.setInt(1, modelParam.getCategory());
			pstmt.setString(2, modelParam.getImg());
			pstmt.setString(3, modelParam.getName());
			pstmt.setString(4, modelParam.getSlogan());
			pstmt.setString(5, modelParam.getTag());
			pstmt.setString(6, modelParam.getCompany());
			pstmt.setString(7, modelParam.getPosition());
			pstmt.setString(8, modelParam.getTitle());
			pstmt.setString(9, modelParam.getDescription());
			pstmt.setString(10, modelParam.getKeywords());
			pstmt.setInt(11, modelParam.getBestHide());
			pstmt.setInt(12, modelParam.getHide());
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"SELECT MAX(idx) AS max_no FROM masters");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				idx = rs.getInt("max_no");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return idx;
	}
	
	// update masters
	public void updateMasters(MastersModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE masters SET category=?, img=?, name=?, slogan=?, tag=?, company=?, "
					+ "position=?, title=?, description=?, keywords=?, best_hide=?, hide=? "
					+ "WHERE idx=?");
			
			pstmt.setInt(1, modelParam.getCategory());
			pstmt.setString(2, modelParam.getImg());
			pstmt.setString(3, modelParam.getName());
			pstmt.setString(4, modelParam.getSlogan());
			pstmt.setString(5, modelParam.getTag());
			pstmt.setString(6, modelParam.getCompany());
			pstmt.setString(7, modelParam.getPosition());
			pstmt.setString(8, modelParam.getTitle());
			pstmt.setString(9, modelParam.getDescription());
			pstmt.setString(10, modelParam.getKeywords());
			pstmt.setInt(11, modelParam.getBestHide());
			pstmt.setInt(12, modelParam.getHide());
			pstmt.setInt(13, modelParam.getIdx());
			
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// delete masters
	public void deleteMasters(int idx){
		try{
			pstmt = conn.prepareStatement(
					"DELETE FROM masters WHERE idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM curriculum WHERE masters_idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM curriculum_detail WHERE masters_idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM masters_activity WHERE masters_idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM masters_cut WHERE masters_idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM masters_history WHERE masters_idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM masters_review WHERE masters_idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM reference WHERE masters_idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
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
	
	// insert masters history
	public void insertMastersHistory(String sql){
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// update masters history
	public void updateMastersHistory(MastersHistoryModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE masters_history SET history=? WHERE idx=?");
			
			pstmt.setString(1, modelParam.getHistory());
			pstmt.setInt(2, modelParam.getIdx());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// delete masters history
	public void deleteMastersHistory(int idx){
		try{
			pstmt = conn.prepareStatement(
					"DELETE FROM masters_history WHERE idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
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
	
	// insert masters activity
	public void insertMastersActivity(String sql){
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// update masters activity
	public void updateMastersActivity(MastersActivityModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE masters_activity SET title=?, content=? "
					+ "WHERE idx=?");
			
			pstmt.setString(1, modelParam.getTitle());
			pstmt.setString(2, modelParam.getContent());
			pstmt.setInt(3, modelParam.getIdx());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// delete masters activity
	public void deleteMastersActivity(int idx){
		try{
			pstmt = conn.prepareStatement(
					"DELETE FROM masters_activity WHERE idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
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
	
	// insert curriculum
	public int insertCuriiculum(CurriculumModel modelParam){
		int idx = -1;
		
		try{
			pstmt = conn.prepareStatement(
					"INSERT INTO curriculum(masters_idx, title, date) "
					+ "VALUES(?, ?, NOW())");
			
			pstmt.setInt(1, modelParam.getMastersIdx());
			pstmt.setString(2, modelParam.getTitle());
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"SELECT MAX(idx) AS max_no FROM curriculum");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				idx = rs.getInt("max_no");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return idx;
	}
	
	// update curriculum
	public void updateCurriculum(CurriculumModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE curriculum SET title=? WHERE idx=?");
			
			pstmt.setString(1, modelParam.getTitle());
			pstmt.setInt(2, modelParam.getIdx());
			pstmt.executeUpdate();
					
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// delete curriculum
	public void deleteCurriculum(int idx){
		try{
			pstmt = conn.prepareStatement(
					"DELETE FROM curriculum WHERE idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"DELETE FROM curriculum_detail WHERE curriculum_idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
					
		}catch(Exception e){
			e.printStackTrace();
		}
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
	
	// insert curriculum detail
	public void insertCurriDetail(String sql){
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// update curriculum detail
	public void updateCurriDetail(CurriculumDetailModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE curriculum_detail SET title=?, content=? "
					+ "WHERE idx=?");
			
			pstmt.setString(1, modelParam.getTitle());
			pstmt.setString(2, modelParam.getContent());
			pstmt.setInt(3, modelParam.getIdx());
			
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// delete curriculum detail
	public void deleteCurriDetail(int idx){
		try{
			pstmt = conn.prepareStatement(
					"DELETE FROM curriculum_detail WHERE idx=?");
			
			pstmt.setInt(1, idx);
			
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
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
	
	// insert masters review
	public int insertMastersReview(MastersReviewModel modelParam){
		int idx = -1;
		
		try{
			pstmt = conn.prepareStatement(
					"INSERT INTO masters_review(masters_idx, img, name, content, date) "
					+ "VALUES(?, ?, ?, ?, NOW())");
			
			pstmt.setInt(1, modelParam.getMastersIdx());
			pstmt.setString(2, modelParam.getImg());
			pstmt.setString(3, modelParam.getName());
			pstmt.setString(4, modelParam.getContent());
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"SELECT MAX(idx) AS max_no FROM masters_review");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				idx = rs.getInt("max_no");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return idx;
	}
	
	// update masters review
	public void updateMastersReview(MastersReviewModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE masters_review SET img=?, name=?, content=? "
					+ "WHERE idx=?");
			
			pstmt.setString(1, modelParam.getImg());
			pstmt.setString(2, modelParam.getName());
			pstmt.setString(3, modelParam.getContent());
			pstmt.setInt(4, modelParam.getIdx());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// delete masters review
	public void deleteMastersReview(int idx){
		try{
			pstmt = conn.prepareStatement(
					"DELETE FROM masters_review WHERE idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
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
	
	// insert master cut
	public int insertMastersCut(MastersCutModel modelParam){
		int idx = -1;
		
		try{
			pstmt = conn.prepareStatement(
					"INSERT INTO masters_cut(masters_idx, category, title, content, date) "
					+ "VALUES(?, ?, ?, ?, NOW())");
			
			pstmt.setInt(1, modelParam.getMastersIdx());
			pstmt.setInt(2, modelParam.getCategory());
			pstmt.setString(3, modelParam.getTitle());
			pstmt.setString(4, modelParam.getContent());
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"SELECT MAX(idx) AS max_no FROM masters_cut");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				idx = rs.getInt("max_no");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return idx;
	}
	
	// update master cut
	public void updateMastersCut(MastersCutModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE masters_cut SET category=?, title=?, content=? "
					+ "WHERE idx=?");
			
			pstmt.setInt(1, modelParam.getCategory());
			pstmt.setString(2, modelParam.getTitle());
			pstmt.setString(3, modelParam.getContent());
			pstmt.setInt(4, modelParam.getIdx());
			
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// delete master cut
	public void deleteMastersCut(int idx){
		try{
			pstmt = conn.prepareStatement(
					"DELETE FROM masters_cut WHERE idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * master section end
	 */
	
	/**
	 * reference section start
	 */
	// search reference list
	public List<ReferenceModel> selectListReference(ReferenceModel modelParam){
		List<ReferenceModel> listReference = new ArrayList<ReferenceModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			if("all".equals(modelParam.getSearchType()))
				whereSQL = " AND (b.name like '%"+modelParam.getSearchText()+"%' or a.company like '%"+modelParam.getSearchText()+"%') ";
			else if("name".equals(modelParam.getSearchType()))
				whereSQL = " AND b.name like '%"+modelParam.getSearchText()+"%' ";
			else if("company".equals(modelParam.getSearchType()))
				whereSQL = " AND a.company like '%"+modelParam.getSearchText()+"%' ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT a.idx, a.masters_idx, b.name, a.score, a.company, a.education, "
					+ "a.target, a.people, a.hour, a.hide, a.date, b.category "
					+ "FROM reference a "
					+ "LEFT JOIN masters b "
					+ "ON a.masters_idx=b.idx "
					+ "WHERE a.idx<>-1 "+whereSQL
					+ "ORDER BY a.date DESC LIMIT ?, ?");
			
			pstmt.setInt(1, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(2, modelParam.getListCount());
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
					+ "WHERE a.idx<>-1 ");
			
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
	
	// search reference count
	public int selectCountListReference(ReferenceModel modelParam){
		int totalCount = 0;
		
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			if("all".equals(modelParam.getSearchType()))
				whereSQL = " AND (b.name like '%"+modelParam.getSearchText()+"%' or a.company like '%"+modelParam.getSearchText()+"%') ";
			else if("name".equals(modelParam.getSearchType()))
				whereSQL = " AND b.name like '%"+modelParam.getSearchText()+"%' ";
			else if("company".equals(modelParam.getSearchType()))
				whereSQL = " AND a.company like '%"+modelParam.getSearchText()+"%' ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT COUNT(a.idx) AS total "
					+ "FROM reference a "
					+ "LEFT JOIN masters b "
					+ "ON a.masters_idx=b.idx "
					+ "WHERE a.idx<>-1 "+whereSQL);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	// search reference 
	public ReferenceModel selectReference(int idx){
		ReferenceModel reference = new ReferenceModel();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, masters_idx, score, company, education, target, people, hour, hide "
					+ "FROM reference "
					+ "WHERE idx=?");
			
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()){
				reference.setIdx(rs.getInt("idx"));
				reference.setMastersIdx(rs.getInt("masters_idx"));
				reference.setScore(rs.getDouble("score"));
				reference.setCompany(rs.getString("company"));
				reference.setEducation(rs.getString("education"));
				reference.setTarget(rs.getString("target"));
				reference.setPeople(rs.getInt("people"));
				reference.setHour(rs.getInt("hour"));
				reference.setHide(rs.getInt("hide"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return reference;
	}
	
	// search reference list
	public List<ReferenceModel> selectListReferenceForMasterDetail(int mastersidx){
		List<ReferenceModel> listReference = new ArrayList<ReferenceModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT a.idx, a.masters_idx, b.name, a.score, a.company, a.education, "
					+ "a.target, a.people, a.hour, a.hide, a.date, b.category "
					+ "FROM reference a "
					+ "LEFT JOIN masters b "
					+ "ON a.masters_idx=b.idx "
					+ "WHERE a.masters_idx=? ");
			
			pstmt.setInt(1, mastersidx);
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
	
	// insert reference
	public void insertReference(ReferenceModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"INSERT INTO reference(masters_idx, score, company, education, target, people, hour, hide, date) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)");
			
			pstmt.setInt(1, modelParam.getMastersIdx());
			pstmt.setDouble(2, modelParam.getScore());
			pstmt.setString(3, modelParam.getCompany());
			pstmt.setString(4, modelParam.getEducation());
			pstmt.setString(5, modelParam.getTarget());
			pstmt.setInt(6, modelParam.getPeople());
			pstmt.setInt(7, modelParam.getHour());
			pstmt.setInt(8, modelParam.getHide());
			pstmt.setString(9, modelParam.getDate());
			
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// update reference
	public void updateReference(ReferenceModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE reference SET masters_idx=?, score=?, company=?, education=?, "
					+ "target=?, people=?, hour=?, hide=?, date=? "
					+ "WHERE idx=?");
			
			pstmt.setInt(1, modelParam.getMastersIdx());
			pstmt.setDouble(2, modelParam.getScore());
			pstmt.setString(3, modelParam.getCompany());
			pstmt.setString(4, modelParam.getEducation());
			pstmt.setString(5, modelParam.getTarget());
			pstmt.setInt(6, modelParam.getPeople());
			pstmt.setInt(7, modelParam.getHour());
			pstmt.setInt(8, modelParam.getHide());
			pstmt.setString(9, modelParam.getDate());
			pstmt.setInt(10, modelParam.getIdx());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// delete reference
	public void deleteReference(int idx){
		try{
			pstmt = conn.prepareStatement(
					"DELETE FROM reference WHERE idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			
		}
	}
	
	// search master list for add reference
	public List<MastersModel> selectListMastersForAddReference(){
		List<MastersModel> listMasters = new ArrayList<MastersModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, name, company "
					+ "FROM masters "
					+ "ORDER BY name ASC");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				MastersModel masters = new MastersModel();
				masters.setIdx(rs.getInt("idx"));
				masters.setName(rs.getString("name"));
				masters.setCompany(rs.getString("company"));
				
				listMasters.add(masters);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listMasters;
	}
	
	/**
	 * reference section end
	 */
	
	/**
	 * news section start
	 */
	
	// select news list
	public List<NewsInfoModel> selectListNewsInfo(NewsInfoModel modelParam){
		List<NewsInfoModel> listNI = new ArrayList<NewsInfoModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			if("all".equals(modelParam.getSearchType()))
				whereSQL = " AND (title like '%"+modelParam.getSearchText()+"%' OR content like '%"+modelParam.getSearchText()+"%') ";
			else
				whereSQL = " AND "+modelParam.getSearchType()+" like '%"+modelParam.getSearchText()+"%' ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, type, top, title, content, thumbnail, view_date, "
					+ "IF(NOW()<view_date, 0, 1) AS listing_check "
					+ "FROM news "
					+ "WHERE idx<>-1 "+whereSQL
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
				ni.setListingCheck(rs.getInt("listing_check"));
				listNI.add(ni);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listNI;
	}
	
	// select news counting for all
	public int selectCountListNewsInfo(NewsInfoModel modelParam){
		int totalCount = 0;
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			if("all".equals(modelParam.getSearchType()))
				whereSQL = " AND (title like '%"+modelParam.getSearchText()+"%' OR content like '%"+modelParam.getSearchText()+"%') ";
			else
				whereSQL = " AND "+modelParam.getSearchType()+" like '%"+modelParam.getSearchText()+"%' ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT COUNT(idx) AS total "
					+ "FROM news "
					+ "WHERE idx<>-1 "+whereSQL);
			
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
	
	// update news top rolling
	public void updateNewsInfoForTopRolling(int idx, int top){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE news SET top=? WHERE idx=?");
			
			pstmt.setInt(1, top);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
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
	
	// insert news
	public int insertNewsInfo(NewsInfoModel modelParam){
		int idx = -1;
		
		try{
			pstmt = conn.prepareStatement(
					"INSERT INTO news(type, title, content, thumbnail, view_date, keywords) "
					+ "VALUES(?, ?, ?, ?, ?, ?)");
			
			pstmt.setInt(1, modelParam.getType());
			pstmt.setString(2, modelParam.getTitle());
			pstmt.setString(3, modelParam.getContent());
			pstmt.setString(4, modelParam.getThumbnail());
			pstmt.setString(5, modelParam.getViewDate());
			pstmt.setString(6, modelParam.getKeywords());
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"SELECT MAX(idx) AS max_no FROM news");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				idx = rs.getInt("max_no");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return idx;
	}
	
	// update news
	public void updateNewsInfo(NewsInfoModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE news SET type=?, title=?, content=?, thumbnail=?, view_date=?, keywords=? "
					+ "WHERE idx=?");
			
			pstmt.setInt(1, modelParam.getType());
			pstmt.setString(2, modelParam.getTitle());
			pstmt.setString(3, modelParam.getContent());
			pstmt.setString(4, modelParam.getThumbnail());
			pstmt.setString(5, modelParam.getViewDate());
			pstmt.setString(6, modelParam.getKeywords());
			pstmt.setInt(7, modelParam.getIdx());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// delete news
	public void deleteNewsInfo(int idx){
		try{
			pstmt = conn.prepareStatement(
					"DELETE FROM news WHERE idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * news section end
	 */
	
	/**
	 * main review section start
	 */
	
	public List<MainReviewModel> selectListMainReview(MainReviewModel modelParam){
		List<MainReviewModel> listMR = new ArrayList<MainReviewModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			if("all".equals(modelParam.getSearchType()))
				whereSQL = " AND (name like '%"+modelParam.getSearchText()+"%' OR content like '%"+modelParam.getSearchText()+"%') ";
			else
				whereSQL = " AND "+modelParam.getSearchType()+" like '%"+modelParam.getSearchText()+"%' ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, img, name, content, date "
					+ "FROM main_review "
					+ "WHERE idx<>-1 "+whereSQL
					+ "ORDER BY idx DESC LIMIT ?, ?");
			
			pstmt.setInt(1, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(2, modelParam.getListCount());
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
	
	public int selectCountListMainReview(MainReviewModel modelParam){
		int totalCount = 0;
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			if("all".equals(modelParam.getSearchType()))
				whereSQL = " AND (name like '%"+modelParam.getSearchText()+"%' OR content like '%"+modelParam.getSearchText()+"%') ";
			else
				whereSQL = " AND "+modelParam.getSearchType()+" like '%"+modelParam.getSearchText()+"%' ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT COUNT(idx) AS total "
					+ "FROM main_review "
					+ "WHERE idx<>-1 "+whereSQL);
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	public int insertMainReview(MainReviewModel modelParam){
		int idx = -1;
		
		try{
			pstmt = conn.prepareStatement(
					"INSERT INTO main_review(img, name, content, date) "
					+ "VALUES(?, ?, ?, NOW())");
			
			pstmt.setString(1, modelParam.getImg());
			pstmt.setString(2, modelParam.getName());
			pstmt.setString(3, modelParam.getContent());
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(
					"SELECT MAX(idx) AS max_no FROM main_review");
			rs = pstmt.executeQuery();
			if(rs.next()){
				idx = rs.getInt("max_no");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return idx;
	}
	
	public void updateMainReview(MainReviewModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE main_review SET img=?, name=?, content=? "
					+ "WHERE idx=?");
			
			pstmt.setString(1, modelParam.getImg());
			pstmt.setString(2, modelParam.getName());
			pstmt.setString(3, modelParam.getContent());
			pstmt.setInt(4, modelParam.getIdx());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void deleteMainReview(int idx){
		try{
			pstmt = conn.prepareStatement(
					"DELETE FROM main_review WHERE idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * main review section end
	 */
	
	
	/**
	 * search section start
	 */
	
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
	
	// update search
	public void updateSearch(SearchModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE search SET title=?, description=?, keywords=? "
					+ "WHERE idx=?");
			
			pstmt.setString(1, modelParam.getTitle());
			pstmt.setString(2, modelParam.getDescription());
			pstmt.setString(3, modelParam.getKeywords());
			pstmt.setInt(4, modelParam.getIdx());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/**
	 * search section end
	 */
	
	/**
	 * contact section start
	 */
	
	// search contact list
	public List<ContactModel> selectListContact(ContactModel modelParam){
		List<ContactModel> listContact = new ArrayList<ContactModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			whereSQL = " AND (name like '%"+modelParam.getSearchText()+"%' OR email like '%"+modelParam.getSearchText()+"%' OR company like '%"+modelParam.getSearchText()+"%' ) ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, name, company, email, contact, target, content, date "
					+ "FROM contact "
					+ "WHERE idx<>-1 "+whereSQL
					+ "ORDER BY idx DESC LIMIT ?, ?");
			
			pstmt.setInt(1, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(2, modelParam.getListCount());
			rs = pstmt.executeQuery();
			while(rs.next()){
				ContactModel contact = new ContactModel();
				contact.setIdx(rs.getInt("idx"));
				contact.setName(rs.getString("name"));
				contact.setCompany(rs.getString("company"));
				contact.setEmail(rs.getString("email"));
				contact.setContact(rs.getString("contact"));
				contact.setTarget(rs.getString("target"));
				contact.setContent(rs.getString("content"));
				contact.setDate(rs.getString("date"));
				
				listContact.add(contact);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listContact;
	}
	
	// search contact list for excel
	public List<ContactModel> selectListContactForExcel(){
		List<ContactModel> listContact = new ArrayList<ContactModel>();
				
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, name, company, email, contact, target, content, date "
					+ "FROM contact "
					+ "WHERE idx<>-1 ");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				ContactModel contact = new ContactModel();
				contact.setIdx(rs.getInt("idx"));
				contact.setName(rs.getString("name"));
				contact.setCompany(rs.getString("company"));
				contact.setEmail(rs.getString("email"));
				contact.setContact(rs.getString("contact"));
				contact.setTarget(rs.getString("target"));
				contact.setContent(rs.getString("content"));
				contact.setDate(rs.getString("date"));
				
				listContact.add(contact);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listContact;
	}
	
	// search count contact
	public int selectCountListContact(ContactModel modelParam){
		int totalCount = 0;
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			whereSQL = " AND (name like '%"+modelParam.getSearchText()+"%' OR email like '%"+modelParam.getSearchText()+"%' OR company like '%"+modelParam.getSearchText()+"%' ) ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT COUNT(idx) AS total "
					+ "FROM contact "
					+ "WHERE idx<>-1 "+whereSQL);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	
	
	/**
	 * contact section end
	 */
	
	/**
	 * recommand section start
	 */
	
	// search recommand list
	public List<RecommandModel> selectListRecommand(RecommandModel modelParam){
		List<RecommandModel> listRecommand = new ArrayList<RecommandModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			whereSQL = " AND (category like '%"+modelParam.getSearchText()+"%' OR email like '%"+modelParam.getSearchText()+"%' OR company like '%"+modelParam.getSearchText()+"%' ) ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, category, purpose, target, target_position, hour, price, place, "
					+ "request_date, manage, request, company, contact, email "
					+ "FROM recommand "
					+ "WHERE idx<>-1 "+whereSQL
					+ "ORDER BY idx DESC LIMIT ?, ?");
			
			pstmt.setInt(1, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(2, modelParam.getListCount());
			rs = pstmt.executeQuery();
			while(rs.next()){
				RecommandModel rec = new RecommandModel();
				rec.setIdx(rs.getInt("idx"));
				rec.setCategory(rs.getString("category"));
				rec.setPurpose(rs.getString("purpose"));
				rec.setTarget(rs.getString("target"));
				rec.setTargetPosition(rs.getString("target_position"));
				rec.setHour(rs.getString("hour"));
				rec.setPrice(rs.getString("price"));
				rec.setPlace(rs.getString("place"));
				rec.setRequestDate(rs.getString("request_date"));
				rec.setManage(rs.getString("manage"));
				rec.setRequest(rs.getString("request"));
				rec.setCompany(rs.getString("company"));
				rec.setContact(rs.getString("contact"));
				rec.setEmail(rs.getString("email"));
				
				listRecommand.add(rec);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listRecommand;
	}
	
	// search recommand for excel
	public List<RecommandModel> selectListRecommandForExcel(){
		List<RecommandModel> listRecommand = new ArrayList<RecommandModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, category, purpose, target, target_position, hour, price, place, "
					+ "request_date, manage, request, company, contact, email, date "
					+ "FROM recommand "
					+ "WHERE idx<>-1 ");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				RecommandModel rec = new RecommandModel();
				rec.setIdx(rs.getInt("idx"));
				rec.setCategory(rs.getString("category"));
				rec.setPurpose(rs.getString("purpose"));
				rec.setTarget(rs.getString("target"));
				rec.setTargetPosition(rs.getString("target_position"));
				rec.setHour(rs.getString("hour"));
				rec.setPrice(rs.getString("price"));
				rec.setPlace(rs.getString("place"));
				rec.setRequestDate(rs.getString("request_date"));
				rec.setManage(rs.getString("manage"));
				rec.setRequest(rs.getString("request"));
				rec.setCompany(rs.getString("company"));
				rec.setContact(rs.getString("contact"));
				rec.setEmail(rs.getString("email"));
				rec.setDate(rs.getString("date"));
				
				listRecommand.add(rec);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listRecommand;
	}
	
	// search count recommand
	public int selectCountListRecommand(RecommandModel modelParam){
		int totalCount = 0;
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			whereSQL = " AND (category like '%"+modelParam.getSearchText()+"%' OR email like '%"+modelParam.getSearchText()+"%' OR company like '%"+modelParam.getSearchText()+"%' ) ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT COUNT(idx) AS total "
					+ "FROM recommand "
					+ "WHERE idx<>-1 "+whereSQL);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	
	
	/**
	 * recommand section end
	 */
	
	/**
	 * stibee section start
	 */
	
	// search stibee list
	public List<SubscribeModel> selectListSubcribe(SubscribeModel modelParam){
		List<SubscribeModel> listSubs = new ArrayList<SubscribeModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			whereSQL = " AND email like '%"+modelParam.getSearchText()+"%' ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, email, date "
					+ "FROM subscribe "
					+ "WHERE idx<>-1 "+whereSQL
					+ "ORDER BY idx DESC LIMIT ?, ?");
			
			pstmt.setInt(1, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(2, modelParam.getListCount());
			rs = pstmt.executeQuery();
			while(rs.next()){
				SubscribeModel subs = new SubscribeModel();
				subs.setIdx(rs.getInt("idx"));
				subs.setEmail(rs.getString("email"));
				subs.setDate(rs.getString("date"));
				
				listSubs.add(subs);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listSubs;
	}
	
	// search stibee list excel
	public List<SubscribeModel> selectListSubcribeForExcel(){
		List<SubscribeModel> listSubs = new ArrayList<SubscribeModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, email, date "
					+ "FROM subscribe "
					+ "WHERE idx<>-1 ");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				SubscribeModel subs = new SubscribeModel();
				subs.setIdx(rs.getInt("idx"));
				subs.setEmail(rs.getString("email"));
				subs.setDate(rs.getString("date"));
				
				listSubs.add(subs);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listSubs;
	}
	
	// search count stibee
	public int selectCountListSubcribe(SubscribeModel modelParam){
		int totalCount = 0;
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			whereSQL = " AND email like '%"+modelParam.getSearchText()+"%' ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT COUNT(idx) AS total "
					+ "FROM subscribe "
					+ "WHERE idx<>-1 "+whereSQL);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	
	
	/**
	 * stibee section end
	 */
	
	/**
	 * apply section start
	 */
	
	// search apply list
	public List<MastersApplyModel> selectListMastersApply(MastersApplyModel modelParam){
		List<MastersApplyModel> listApply = new ArrayList<MastersApplyModel>();
		int pageNum = Integer.parseInt(modelParam.getPageNum());
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			whereSQL = " AND (email like '%"+modelParam.getSearchText()+"%' OR name like '%"+modelParam.getSearchText()+"%' OR company like '%"+modelParam.getSearchText()+"%') ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, name, company, email, contact, target, files, date "
					+ "FROM masters_apply "
					+ "WHERE idx<>-1 "+whereSQL
					+ "ORDER BY idx DESC LIMIT ?, ?");
			
			pstmt.setInt(1, modelParam.getListCount() * (pageNum-1));
			pstmt.setInt(2, modelParam.getListCount());
			rs = pstmt.executeQuery();
			while(rs.next()){
				MastersApplyModel ma = new MastersApplyModel();
				ma.setIdx(rs.getInt("idx"));
				ma.setName(rs.getString("name"));
				ma.setCompany(rs.getString("company"));
				ma.setEmail(rs.getString("email"));
				ma.setContact(rs.getString("contact"));
				ma.setTarget(rs.getString("target"));
				ma.setFiles(rs.getString("files"));
				ma.setDate(rs.getString("date"));
				
				listApply.add(ma);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listApply;
	}
	
	// search apply list for excel
	public List<MastersApplyModel> selectListMastersApplyForExcel(){
		List<MastersApplyModel> listApply = new ArrayList<MastersApplyModel>();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, name, company, email, contact, target, files, date "
					+ "FROM masters_apply "
					+ "WHERE idx<>-1 ");
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				MastersApplyModel ma = new MastersApplyModel();
				ma.setIdx(rs.getInt("idx"));
				ma.setName(rs.getString("name"));
				ma.setCompany(rs.getString("company"));
				ma.setEmail(rs.getString("email"));
				ma.setContact(rs.getString("contact"));
				ma.setTarget(rs.getString("target"));
				ma.setFiles(rs.getString("files"));
				ma.setDate(rs.getString("date"));
				
				listApply.add(ma);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return listApply;
	}
	
	// search count apply
	public int selectCountListMastersApply(MastersApplyModel modelParam){
		int totalCount = 0;
		String whereSQL = "";
		if("".equals(modelParam.getSearchText())==false){
			whereSQL = " AND (email like '%"+modelParam.getSearchText()+"%' OR name like '%"+modelParam.getSearchText()+"%' OR company like '%"+modelParam.getSearchText()+"%') ";
		}
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT COUNT(idx) AS total "
					+ "FROM masters_apply "
					+ "WHERE idx<>-1 "+whereSQL);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				totalCount = rs.getInt("total");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	
	
	/**
	 * apply section end
	 */
	
	/**
	 * setup section start
	 */
	
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
	
	// setup update
	public void updateSetup(SetupModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE setup SET banner=?, pdf=?, contact=?, logo=?, category=?, email=?, color=?, "
					+ "address=?, recommand=?, company_num=?, company_name=? "
					+ "WHERE idx=1");
			
			pstmt.setString(1, modelParam.getBanner());
			pstmt.setString(2, modelParam.getPdf());
			pstmt.setString(3, modelParam.getContact());
			pstmt.setString(4, modelParam.getLogo());
			pstmt.setInt(5, modelParam.getCategory());
			pstmt.setString(6, modelParam.getEmail());
			pstmt.setString(7, modelParam.getColor());
			pstmt.setString(8, modelParam.getAddress());
			pstmt.setString(9, modelParam.getRecommand());
			pstmt.setString(10, modelParam.getCompanyNum());
			pstmt.setString(11, modelParam.getCompanyName());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// setup update information
	public void updateSetupInformation(String information){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE setup SET information=? "
					+ "WHERE idx=1");
			
			pstmt.setString(1, information);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// select popup
	public PopupModel selectPopup(){
		PopupModel popup = new PopupModel();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT img, link, hide "
					+ "FROM popup "
					+ "WHERE idx=1");
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				popup.setImg(rs.getString("img"));
				popup.setLink(rs.getString("link"));
				popup.setHide(rs.getInt("hide"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return popup;
	}
	
	// popup update
	public void updatePopup(PopupModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE popup SET img=?, link=?, hide=? "
					+ "WHERE idx=1");
			
			pstmt.setString(1, modelParam.getImg());
			pstmt.setString(2, modelParam.getLink());
			pstmt.setInt(3, modelParam.getHide());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	/**
	 * setup section end
	 */
	
	/**
	 * family site section start
	 */
	
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
	
	// search family site
	public FamilySiteModel selectFamilySite(int idx){
		FamilySiteModel fs = new FamilySiteModel();
		
		try{
			pstmt = conn.prepareStatement(
					"SELECT idx, name, link FROM family_site "
					+ "WHERE idx=?");
			
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()){
				fs.setIdx(rs.getInt("idx"));
				fs.setName(rs.getString("name"));
				fs.setLink(rs.getString("link"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return fs;
	}
	
	// insert family site 
	public void insertFamilySite(FamilySiteModel modelParam){
		int sort = 0;
		
		try{
			// step 1 : search last sort 
			pstmt = conn.prepareStatement(
					"SELECT MAX(sort) AS max_sort FROM family_site");
			rs = pstmt.executeQuery();
			if(rs.next()){
				sort = rs.getInt("max_sort")+1;
			}
			
			// step 2 : insert family site
			pstmt = conn.prepareStatement(
					"INSERT INTO family_site(name, link, sort) "
					+ "VALUES(?, ?, ?)");
			
			pstmt.setString(1, modelParam.getName());
			pstmt.setString(2, modelParam.getLink());
			pstmt.setInt(3, sort);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// update family site 
	public void updateFamilySite(FamilySiteModel modelParam){
		try{
			pstmt = conn.prepareStatement(
					"UPDATE family_site SET name=?, link=? "
					+ "WHERE idx=?");
			
			pstmt.setString(1, modelParam.getName());
			pstmt.setString(2, modelParam.getLink());
			pstmt.setInt(3, modelParam.getIdx());
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// delete family site 
	public void deleteFamilySite(int idx){
		try{
			pstmt = conn.prepareStatement(
					"DELETE FROM family_site WHERE idx=?");
			
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// family site sort up
	public void updateFamilySiteForUpSort(FamilySiteModel modelParam){
		int targetSort = -1;
		int targetIdx = -1;
		
		try{
			// step 1 : Find the target sorts and index
			pstmt = conn.prepareStatement(
					"SELECT idx, sort FROM family_site WHERE sort<? ORDER BY sort DESC LIMIT 1");
			
			pstmt.setInt(1, modelParam.getSort());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				targetSort = rs.getInt("sort");
				targetIdx = rs.getInt("idx");
			}
			
			// step 2 : update sort for original
			pstmt = conn.prepareStatement(
					"UPDATE family_site SET sort=? WHERE idx=?");
			
			pstmt.setInt(1, targetSort);
			pstmt.setInt(2, modelParam.getIdx());
			pstmt.executeUpdate();
			
			// step 3 : update sort for target
			pstmt = conn.prepareStatement(
					"UPDATE family_site SET sort=? WHERE idx=?");
			pstmt.setInt(1, modelParam.getSort());
			pstmt.setInt(2, targetIdx);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// family site sort down
	public void updateFamilySiteForDownSort(FamilySiteModel modelParam){
		int targetSort = -1;
		int targetIdx = -1;
		
		try{
			// step 1 : Find the target sorts and index
			pstmt = conn.prepareStatement(
					"SELECT idx, sort FROM family_site WHERE ?<sort ORDER BY sort ASC LIMIT 1");
			
			pstmt.setInt(1, modelParam.getSort());
			rs = pstmt.executeQuery();
			if(rs.next()){
				targetSort = rs.getInt("sort");
				targetIdx = rs.getInt("idx");
			}
			
			// step 2 : update sort for original
			pstmt = conn.prepareStatement(
					"UPDATE family_site SET sort=? WHERE idx=?");
			
			pstmt.setInt(1, targetSort);
			pstmt.setInt(2, modelParam.getIdx());
			pstmt.executeUpdate();
			
			// step 3 : update sort for target
			pstmt = conn.prepareStatement(
					"UPDATE family_site SET sort=? WHERE idx=?");
			
			pstmt.setInt(1, modelParam.getSort());
			pstmt.setInt(2, targetIdx);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	/**
	 * family site section end
	 */

	/**
	 * admin section start
	 */
	
	// admin login check
	public boolean selectCheckAdmin(String id, String password){
		boolean bRet = false;
		
		try{
			
			pstmt = conn.prepareStatement(
					"SELECT idx FROM admin_info WHERE id=? AND password=SHA2(?, 256)");
			
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			
			rs = pstmt.executeQuery();
			if(rs.next())
				bRet = true;
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return bRet;
	}
	
	// - ��й�ȣ ���� -
	public void updatePasswd(String modelParam){
		try {
			pstmt = conn.prepareStatement(
				"UPDATE admin_info SET password=SHA2(?, 256)");
			
			pstmt.setString(1, modelParam);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	////////////////////////////////////////////////////
	
	
	////////////////////////////////////////////////////
	// - ���� �α��� -
	public boolean selectPasswdForLogin(String modelParam){
		boolean bRet = false;
		try {
			pstmt = conn.prepareStatement(
					"SELECT * FROM admin_info WHERE password=SHA2(?, 256)");
		
			pstmt.setString(1, modelParam);
			rs = pstmt.executeQuery();
			if(rs.next())
				bRet = true;
		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return bRet;
	}
	////////////////////////////////////////////////////
	/**
	 * admin section end
	 */
	
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
