package model;

public class SearchModel {
	private int idx = -1;					// 1: main, 2: references, 3: masters, 4: news
	private String title = "";				// title
	private String description = "";		// description
	private String keywords = "";			// keyword
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
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
}
