package model;

public class SetupModel {
	private String banner = "";			// main banner
	private String pdf = "";			// pdf file
	private String contact = "";		// call number
	private String logo = "";			// main logo
	private int category = 0;			// main category on/off
	private String email = "";			// footer email
	private String color = "";			// header color			
	private String address = "";			// 회사 주소
	private String recommand = "";			// 교육추천서 문구
	private String companyNum = "";			// 사업자등록번호
	private String companyName = "";		// 회사명
	
	private String information = "";		// 개인정보처리방침
	
	private int totalReferenceCount = 0;
	private int totalReferencePeople = 0;
	private double totalReferenceScore = 0;
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRecommand() {
		return recommand;
	}
	public void setRecommand(String recommand) {
		this.recommand = recommand;
	}
	public String getCompanyNum() {
		return companyNum;
	}
	public void setCompanyNum(String companyNum) {
		this.companyNum = companyNum;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getInformation() {
		return information;
	}
	public void setInformation(String information) {
		this.information = information;
	}
	public int getTotalReferenceCount() {
		return totalReferenceCount;
	}
	public void setTotalReferenceCount(int totalReferenceCount) {
		this.totalReferenceCount = totalReferenceCount;
	}
	public int getTotalReferencePeople() {
		return totalReferencePeople;
	}
	public void setTotalReferencePeople(int totalReferencePeople) {
		this.totalReferencePeople = totalReferencePeople;
	}
	public double getTotalReferenceScore() {
		return totalReferenceScore;
	}
	public void setTotalReferenceScore(double totalReferenceScore) {
		this.totalReferenceScore = totalReferenceScore;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getBanner() {
		return banner;
	}
	public void setBanner(String banner) {
		this.banner = banner;
	}
	public String getPdf() {
		return pdf;
	}
	public void setPdf(String pdf) {
		this.pdf = pdf;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}
