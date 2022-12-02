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
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT c.cash_no cashNo, c.cash_date cashDate"
				+ ", c.cash_price cashPrice, c.cash_memo cashMemo"
				+ ", ct.category_kind categoryKind"
				+ ", ct.category_name categoryName"
				+ " FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no"
				+ " WHERE c.member_id = ? AND YEAR(c.cash_date) = ?"
				+ " AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ?"
				+ " ORDER BY c.cash_date ASC, ct.category_kind ASC";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
	
			rs = stmt.executeQuery();
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
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();

		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
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
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
	
			rs = stmt.executeQuery();
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
	
	// 호출 : insertCashAction.jsp  
	public int insertCash(Cash cash) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "INSERT INTO cash(category_no"
				+ ", member_id"
				+ ", cash_date"
				+ ", cash_price"
				+ ", cash_memo"
				+ ", updatedate"
				+ ", createdate)"
				+ " VALUES(?,?,?,?,?,CURDATE(),CURDATE())";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setString(2, cash.getMemberId());
			stmt.setString(3, cash.getCashDate());
			stmt.setLong(4, cash.getCashPrice());
			stmt.setString(5, cash.getCashMemo());
			
			row = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	// 호출 : updateCashAction.jsp
	public int updateCash(Cash cash) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "UPDATE cash"
				+ " SET category_no = ?, cash_date = ?, cash_price = ?, cash_memo = ?"
				+ " WHERE member_id = ? AND cash_no = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cash.getCategoryNo());
			stmt.setString(2, cash.getCashDate());
			stmt.setLong(3, cash.getCashPrice());
			stmt.setString(4, cash.getCashMemo());
			stmt.setString(5, cash.getMemberId());
			stmt.setInt(6, cash.getCashNo());
			
			row = stmt.executeUpdate();
			if(row == 1) {
				System.out.println("수정 성공---");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
	
	// 호출 : deleteCashAction.jsp
	public int deleteCash(int cashNo) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "DELETE FROM cash WHERE cash_no = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			
			row = stmt.executeUpdate();
			if(row == 1) {
				System.out.println("삭제 성공---");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return row;
	}
}
