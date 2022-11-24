package util;

import java.sql.*;
	// db 연결 메서드 분리
public class DBUtil {
	public Connection getConnection() throws Exception {
		String driver = "org.mariadb.jdbc.Driver"; 
		String dbUrl = "jdbc:mariadb://127.0.0.1:3306/cashbook";
		String dbUser = "root";
		String dbPw = "java1234";
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
		return conn;
	}
	
	public void close(ResultSet rs, PreparedStatement stmt, Connection conn) throws Exception {
		if(rs != null) { 
			rs.close(); 
		} 
		if(stmt != null) { 
			stmt.close(); 
		} 
		if(conn != null) { 
			conn.close(); 
		} 
	}
}
