package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class StatsDao {

	// 사용자별 최대년도, 최소년도
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
		String sql = "SELECT YEAR(t2.cashDate) year"
					+ "		, COUNT(t2.importCash) cntImport"
					+ "		, IFNULL(SUM(t2.importCash), 0) sumImport"
					+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) avgImport"
					+ "		, COUNT(t2.exportCash) cntExport"
					+ "		, IFNULL(SUM(t2.exportCash), 0) sumExport"
					+ "		, IFNULL(ROUND(Avg(t2.exportCash)), 0) avgExport"
					+ "	FROM (SELECT memberId"
					+ "				, cashNo"
					+ "				, cashDate"
					+ "				, IF(categoryKind='수입', t.cashPrice, NULL) importCash"
					+ "				, IF(categoryKind='지출', t.cashPrice, NULL) exportCash"
					+ "		FROM (SELECT cs.cash_no cashNo"
					+ "					, cs.cash_date cashDate"
					+ "					, cs.cash_price cashPrice"
					+ "					, cs.member_id memberId"
					+ "					, cg.category_kind categoryKind"
					+ "			FROM cash cs INNER JOIN category cg"
					+ "			ON cs.category_no = cg.category_no) t) t2"
					+ "	WHERE t2.memberId = ?"
					+ "	GROUP BY YEAR(t2.cashDate)"
					+ "	ORDER BY YEAR(t2.cashDate) ASC";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("year", rs.getInt("year"));
				m.put("cntImport", rs.getInt("cntImport"));
				m.put("sumImport", rs.getInt("sumImport"));
				m.put("avgImport", rs.getInt("avgImport"));
				m.put("cntExport", rs.getInt("cntExport"));
				m.put("sumExport", rs.getInt("sumExport"));
				m.put("avgExport", rs.getInt("avgExport"));
				list.add(m);
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
		return list;
	}
	
	
	// 사용자별 년도를(페이징) 매개값으로 입력받아 월별(수입/지출) sum,avg
	public ArrayList<HashMap<String, Object>> selectSumAvgByMonth(String memberId, int year) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT MONTH(t2.cashDate) month"
					+ "		, COUNT(t2.importCash) cntImport"
					+ "		, IFNULL(SUM(t2.importCash), 0) sumImport"
					+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) avgImport"
					+ "		, COUNT(t2.exportCash) cntExport"
					+ "		, IFNULL(SUM(t2.exportCash), 0) sumExport"
					+ "		, IFNULL(ROUND(AVG(t2.exportCash)), 0) avgExport"
					+ " FROM (SELECT memberId"
					+ "				, cashNo"
					+ "				, cashDate"
					+ "				, IF(categoryKind = '수입', cashPrice, null) importCash"
					+ "				, IF(categoryKind = '지출', cashPrice, null) exportCash"
					+ "		FROM (SELECT cs.cash_no cashNo"
					+ "					, cs.cash_date cashDate"
					+ "					, cs.cash_price cashPrice"
					+ "					, cg.category_kind categoryKind"
					+ "					, cs.member_id memberId\r\n"
					+ "			FROM cash cs INNER JOIN category cg"
					+ "			ON cs.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?"
					+ " GROUP BY MONTH(t2.cashDate)"
					+ " ORDER BY MONTH(t2.cashDate) ASC";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("month", rs.getInt("month"));
				m.put("cntImport", rs.getInt("cntImport"));
				m.put("sumImport", rs.getInt("sumImport"));
				m.put("avgImport", rs.getInt("avgImport"));
				m.put("cntExport", rs.getInt("cntExport"));
				m.put("sumExport", rs.getInt("sumExport"));
				m.put("avgExport", rs.getInt("avgExport"));
				list.add(m);
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
		return list;
	}
	
	
}
