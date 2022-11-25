package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import util.DBUtil;
import vo.Cash;

public class CashDao {
	// 호출 : cashDateList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DBUtil  db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		
		/*
		SELECT c.cash_no cashNo
			, c.cash_date cashDate
			, c.cash_price cashPrice 
			, c.cash_memo cashMemo
			, ct.category_kind categoryKind
			, ct.category_name categoryName
		FROM cash c INNER JOIN category ct
		ON c.category_no = ct.category_no
		WHERE c.member_id = ? 
			AND YEAR(c.cash_date) = ? 
			AND MONTH(c.cash_date) = ?
			AND DAY(c.cash_date) = ?
		ORDER BY c.cash_date ASC, ct.category_kind ASC;
		*/
	
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate"
					+ ", c.cash_price cashPrice, c.cash_memo cashMemo"
					+ ", ct.category_kind categoryKind"
					+ ", ct.category_name categoryName"
					+ " FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no"
					+ " WHERE c.member_id = ? AND YEAR(c.cash_date) = ?"
					+ " AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ?"
					+ " ORDER BY c.cash_date ASC, ct.category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);

		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}
			dbUtil.close(rs, stmt, conn);
			return list;
	}
	
	
	/*
		SELECT c.cash_no cashNo
			, c.cash_date cashDate
			, c.cash_price cashPrice
			, c.category_no categoryNo
			, ct.category_kind categoryKind
			, ct.category_name categoryName
		FROM cash c INNER JOIN category ct
		ON c.category_no = ct.category_no
		WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?
		ORDER BY c.cash_date ASC, ct.category_kind ASC;

	 
	 */
	// 호출 : cashList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DBUtil  db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();

		String sql = "SELECT c.cash_no cashNo"
					+ ", c.cash_date cashDate"
					+ ", c.cash_price cashPrice"
					+ ", c.category_no categoryNo"
					+ ", ct.category_kind categoryKind"
					+ ", ct.category_name categoryName"
					+ " FROM cash c"
					+ " INNER JOIN category ct ON c.category_no = ct.category_no"
					+ " WHERE c.member_id = ?"
					+ " AND YEAR(c.cash_date) = ?"
					+ " AND MONTH(c.cash_date) = ?"
					+ " ORDER BY c.cash_date ASC, ct.category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);

		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	
	// 호출 : insertCashAction.jsp  
	public int insertCash(Cash cash) throws Exception {
		int row = 0;
		// DBUtil  db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO cash(category_no"
					+ ", member_id"
					+ ", cash_date"
					+ ", cash_price"
					+ ", cash_memo"
					+ ", updatedate"
					+ ", createdate)"
					+ " VALUES(?,?,?,?,?,CURDATE(),CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNo());
		stmt.setString(2, cash.getMemberId());
		stmt.setString(3, cash.getCashDate());
		stmt.setLong(4, cash.getCashPrice());
		stmt.setString(5, cash.getCashMemo());
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// 호출 : updateCashAction.jsp
	
	public int updateCash(Cash upCash) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE cash"
					+ " SET cash_price = ? cash_memo";
		return row;
	}
}
