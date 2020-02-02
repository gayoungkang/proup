package model;

public class CurriculumDetailModel {
	private int idx = -1;					// primary key
	private int mastersIdx = -1;			// master primary key
	private int curriculumIdx = -1;			// curriculum primary key
	private int category = 1;				// 1: special, 2: detail
	private String title = "";				// title
	private String content = "";			// content
	private String date = "";				// register date
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getMastersIdx() {
		return mastersIdx;
	}
	public void setMastersIdx(int mastersIdx) {
		this.mastersIdx = mastersIdx;
	}
	public int getCurriculumIdx() {
		return curriculumIdx;
	}
	public void setCurriculumIdx(int curriculumIdx) {
		this.curriculumIdx = curriculumIdx;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}
