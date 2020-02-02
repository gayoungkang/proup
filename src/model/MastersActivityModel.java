package model;

public class MastersActivityModel {
	private int idx = -1;				// primary key
	private int mastersIdx = -1;		// master primary key
	private String title = "";			// master activity title
	private String content = "";		// master activity content
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
