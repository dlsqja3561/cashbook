package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class StatsDao {

	public HashMap<String, Object> selectMaxMinYear(String memberId) {
		HashMap<String, Object> map = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT MAX(YEAR(cash_date)) maxYear"
					+ ", MIN(YEAR(cash_date)) minYear"
					+ " FROM cash"
					+ " WHERE member_id = ?";
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			if(rs.next()) {
				map = new HashMap<String, Object>();
				map.put("maxYear", rs.getInt("maxYear"));
				map.put("minYear", rs.getInt("minYear"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
		return map;
	}
	
	
	// 사용자별 년도별 수입/지출 sum,avg
	public ArrayList<HashMap<String, Object>> selectSumAvgByYear(String memberId) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	
	// 사용자별 년도를(페이징) 매개값으로 입력받아 월별(수입/지출) sum,avg
	public ArrayList<HashMap<String, Object>> selectSumAvgByMonth(String memberId, int year) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	
}
