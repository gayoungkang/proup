package model;

public class MastersHistoryModel {
	private int idx = -1;				// primary key
	private int mastersIdx = -1;		// master primary key
	private String history = "";		// master history
	private String date = "";			// date
	
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
	public String getHistory() {
		return history;
	}
	public void setHistory(String history) {
		this.history = history;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}
