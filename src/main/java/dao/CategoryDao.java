package dao;

import java.util.*;
import java.sql.*;
import util.DBUtil;
import vo.Category;

public class CategoryDao {
	// 수정 : 수정폼(select)과 수정 액션(update)으로 구성
	// admin -> updateCategoryAction.jsp
	public int updateCategoryName(Category category) throws Exception {
		int row = 0;
		
		String sql = "UPDATE category"
					+ " SET category_name = ?, updatedate = CURDATE()"
					+ " WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setInt(2, category.getCategoryNo());
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	// admin -> updateCategoryForm.jsp
	public Category selectCategoryOne(int categoryNo) throws Exception {
		Category category = null;
		
		String sql = "SELECT category_no categoryNo, category_name categoryName"
					+ " FROM category"
					+ " WHERE category_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		rs = stmt.executeQuery();
		if(rs.next()) {
			category = new Category();
			category.setCategoryNo(rs.getInt("categoryNo"));
			category.setCategoryName(rs.getString("categoryName"));
		}
		dbUtil.close(rs, stmt, conn);
		return category;
	}
	
	
	// admin -> deleteCategory.jsp
	public int deleteCategory(int categoryNo) throws Exception {
		int row = 0;
	
		String sql = "DELETE FROM category WHERE category_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	
	// admin -> insertCategoryAction.jsp
	public int insertCategory(Category category) throws Exception {
		int row = 0;
		
		String sql = "INSERT INTO category (category_kind, category_name, updatedate, createdate)"
					+ " VALUES (?,?,CURDATE(),CURDATE())";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
	
	// admin -> 카테고리관리 -> 카테고리목록
	public ArrayList<Category> selectCategoryListByAdmin() throws Exception {
		ArrayList<Category> list = null;
		list = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		
		String sql = "SELECT category_no categoryNo"
					+ ", category_name categoryName"
					+ ", category_kind categoryKind"
					+ ", updatedate"
					+ ", createdate"
					+ " FROM category";
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo")); // rs.getInt(1); 1->셀렉트 절의 순서
			c.setCategoryName(rs.getString("categoryName"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setUpdatedate(rs.getString("updatedate")); // DB날짜 타입이지만 자바단에서 문자열 타입으로 받는다
			c.setCreatedate(rs.getString("createdate"));
			list.add(c);
		}
		
		// db자원(jdbc api자원) 반납
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	
	// category 목록 출력  (cash 입력시 <select>목록 출력)
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> categoryList = new ArrayList<Category>();
		// DBUtil db연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT category_no categoryNo, category_name categoryName, category_kind categoryKind"
					+ " FROM category"
					+ " ORDER BY category_kind ASC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setCategoryKind(rs.getString("categoryKind"));
			categoryList.add(c);
		}
		
		dbUtil.close(rs, stmt, conn);
		return categoryList;
	}
}
