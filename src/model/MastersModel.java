package model;

import java.util.ArrayList;
import java.util.List;

public class MastersModel {
	private int idx = -1;				// primary key
	private int category = 1;			// category				1:디지털혁신, 2: 라이프, 3: 직무역량
	private String img = "";			// master image
	private String name = "";			// master name
	private String slogan = "";			// master slogan
	private String tag = "";			// master tag ex) #test #test
	private String company = "";		// master company
	private String position = "";		// master position
	private String title = "";			// master search title
	private String description = "";	// master search description
	private String keywords = "";		// master search keywords
	private int bestHide = 0;			// master best hide on/off
	private int hide = 0;				// master hide on/off
	private String date = "";			// register date
	
	List<String> listHistory = new ArrayList<String>();
	
	/* util */
	private String pageNum = "1";
	private int listCount = 10;			
	private int pagePerBlock = 10;		
	
	private String searchText = "";
	private String searchType = "";
	
	private double referenceScore = 0;
	private double referenceCount = 0;
	private double referencePeople = 0;
	private double reviewCount = 0;
	
	private int allCount = 0;
	private int digitalCount = 0;
	private int lifeCount = 0;
	private int serviceCount = 0;
	
	public int getAllCount() {
		return allCount;
	}

	public void setAllCount(int allCount) {
		this.allCount = allCount;
	}

	public int getDigitalCount() {
		return digitalCount;
	}

	public void setDigitalCount(int digitalCount) {
		this.digitalCount = digitalCount;
	}

	public int getLifeCount() {
		return lifeCount;
	}

	public void setLifeCount(int lifeCount) {
		this.lifeCount = lifeCount;
	}

	public int getServiceCount() {
		return serviceCount;
	}

	public void setServiceCount(int serviceCount) {
		this.serviceCount = serviceCount;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public List<String> getListHistory() {
		return listHistory;
	}

	public void setListHistory(List<String> listHistory) {
		this.listHistory = listHistory;
	}

	public double getReferenceScore() {
		return referenceScore;
	}

	public void setReferenceScore(double referenceScore) {
		this.referenceScore = referenceScore;
	}

	public double getReferenceCount() {
		return referenceCount;
	}

	public void setReferenceCount(double referenceCount) {
		this.referenceCount = referenceCount;
	}

	public double getReferencePeople() {
		return referencePeople;
	}

	public void setReferencePeople(double referencePeople) {
		this.referencePeople = referencePeople;
	}

	public double getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(double reviewCount) {
		this.reviewCount = reviewCount;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSlogan() {
		return slogan;
	}

	public void setSlogan(String slogan) {
		this.slogan = slogan;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public int getBestHide() {
		return bestHide;
	}

	public void setBestHide(int bestHide) {
		this.bestHide = bestHide;
	}

	public int getHide() {
		return hide;
	}

	public void setHide(int hide) {
		this.hide = hide;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getPageNum() {
		return pageNum;
	}

	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}

	public int getListCount() {
		return listCount;
	}

	public void setListCount(int listCount) {
		this.listCount = listCount;
	}

	public int getPagePerBlock() {
		return pagePerBlock;
	}

	public void setPagePerBlock(int pagePerBlock) {
		this.pagePerBlock = pagePerBlock;
	}

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}
}
