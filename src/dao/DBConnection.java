package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnection {
	private final static String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	//private final static String DB_URL = "jdbc:mysql://127.0.0.1:3306/idesignlab";
	//private final static String DB_ID = "idesignlab";
	//private final static String DB_PASSWD = "idesignlab1101";
	private final static String DB_URL = "jdbc:mysql://127.0.0.1:3306/b2b";
	private final static String DB_ID = "b2b";
	private final static String DB_PASSWD = "b2b123!@#";
	
	public static Connection getConnection(){
		Connection conn=null;
		try{
			Class.forName(JDBC_DRIVER);
			conn = (Connection) DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWD);

		}catch(Exception e){
			e.printStackTrace();
		}
		return conn;
	}
	
	
	public static void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
