package util;

public class CategorySearch {
	public static String getNewsCategory(int type) {
		String typeStr = "";
		
		if(type == 1){
			typeStr = "프로업";
		}
		else if(type == 2){
			typeStr = "마스터";
		}
		else{
			typeStr = "공지";
		}
		
		return typeStr;
	}
	
	public static String getMasterCategory(int category){
		
		String categoryStr = "";
		if(category == 1){
			categoryStr = "디지털 혁신";
		}
		else if(category == 2){
			categoryStr = "라이프";
		}
		else {
			categoryStr = "직무역량";
		}
		
		return categoryStr;
	}
}
