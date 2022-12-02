package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Comment;
import vo.Help;

public class CommentDao {
	
	// 답변입력 insertCommentAction.jsp
	public int insertComment(Comment comment) {
		int row = 0;
		String sql = "INSERT comment(help_no, comment_memo, member_id, updatedate, createdate)"
					+ " VALUES(?, ?, ?, NOW(), NOW())";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
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
	// 문의내용 확인 insertCommentForm.jsp
	public Help selectHelpOne(int helpNo) {
		Help help = null;
		String sql = "SELECT help_memo helpMemo, member_id memberId, createdate"
					+ " FROM help WHERE help_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, helpNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				help = new Help();
				help.setHelpMemo(rs.getString("helpMemo"));
				help.setMemberId(rs.getString("memberId"));
				help.setCreatedate(rs.getString("createdate"));
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
		return help;
	}
	
	// 수정폼(select) -> updateCommentForm.jsp
	public Comment selectCommentOne(int commentNo) {
		Comment comment = null;
		String sql = "SELECT comment_memo commentMemo"
					+ " FROM comment"
					+ " WHERE comment_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				comment = new Comment();
				comment.setCommentMemo(rs.getString("commentMemo"));
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
		return comment;
	}
	// 답변수정(update) -> updateCommentAction.jsp
	public int updateComment(Comment comment) {
		int row = 0;
		String sql = "UPDATE comment SET comment_memo = ?, updatedate = NOW() WHERE comment_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, comment.getCommentMemo());
			stmt.setInt(2, comment.getCommentNo());
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
	
	// 삭제 deleteComment.jsp
	public int deleteComment(int commentNo) {
		int row = 0;
		String sql = "DELETE FROM comment WHERE comment_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, commentNo);
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
	
}
