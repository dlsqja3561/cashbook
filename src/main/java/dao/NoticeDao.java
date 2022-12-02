package dao;

import java.sql.*;
import java.util.ArrayList;
import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	// 공지 삭제 admin -> deleteNotice.jsp
	public int deleteNotice(Notice notice) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql ="DELETE FROM notice WHERE notice_no = ?";
		try {	
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, notice.getNoticeNo());
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
	
	// 공지 수정 : 수정폼(select), 수정액션(update)
	// admin -> updateNoticeAction.jsp
	public int updateNotice(Notice notice) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "UPDATE notice SET notice_memo = ?, createdate = NOW() WHERE notice_no = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
			stmt.setInt(2, notice.getNoticeNo());
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
	// admin -> updateNoticeForm.jsp
	public Notice selectNoticeOne(int noticeNo) {
		Notice notice = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo"
					+ " FROM notice"
					+ " WHERE notice_no = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				notice = new Notice();
				notice.setNoticeNo(rs.getInt("noticeNo"));
				notice.setNoticeMemo(rs.getString("noticeMemo"));
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
		return notice;
	}
	
	// 공지 추가 admin -> insertNoticeAction.jsp
	public int insertNotice(Notice notice) {
		int row = 0;	
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "INSERT notice(notice_memo, updatedate, createdate) VALUES(?, NOW(), NOW())";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
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
	
	
	// 마지막 페이지를 구하려면 전체count수 필요
	public int selectNoticeCount() {
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		PreparedStatement stmt = null;
		Connection conn = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) cnt FROM notice";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("cnt");
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
		return count;
	}
	
	// loginForm.jsp 공지목록  
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) {
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
				+ " FROM notice ORDER BY createdate DESC"
				+ " LIMIT ?, ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setCreatedate(rs.getString("createdate"));
				list.add(n);
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
