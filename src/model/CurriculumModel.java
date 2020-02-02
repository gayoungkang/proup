package model;

public class CurriculumModel {
	private int idx = -1;				// primary key
	private int mastersIdx = -1;		// master primary key
	private String title = "";			// curriculum title
	private String date = "";			// register date
	
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}
