package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Comment;
import vo.Help;

public class CommentDao {
	
	// 답변입력 insertCommentAction.jsp
	public int insertComment(Comment comment) throws Exception {
		int row = 0;
		
		String sql = "INSERT comment(help_no, comment_memo, member_id, updatedate, createdate)"
					+ " VALUES(?, ?, ?, NOW(), NOW())";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getHelpNo());
		stmt.setString(2, comment.getCommentMemo());
		stmt.setString(3, comment.getMemberId());
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	// 문의내용 확인 insertCommentForm.jsp
	public Help selectHelpOne(int helpNo) throws Exception {
		Help help = null;
		String sql = "SELECT help_memo helpMemo, member_id memberId, updatedate"
					+ " FROM help WHERE help_no = ?";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		rs = stmt.executeQuery();
		if(rs.next()) {
			help = new Help();
			help.setHelpMemo(rs.getString("helpMemo"));
			help.setMemberId(rs.getString("memberId"));
			help.setUpdatedate(rs.getString("updatedate"));
		}
		
		dbUtil.close(rs, stmt, conn);
		return help;
	}
	
	// 수정
	public Comment selectComment(int commentNo) throws Exception {
		return null;
	}
	public int updateComment(Comment comment) throws Exception {
		return 0;
	}
	
	// 삭제 deleteComment.jsp
	public int deleteComment(int commentNo) throws Exception {
		int row = 0;
		String sql = "DELETE FROM comment WHERE comment_no = ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = dbUtil.getConnection();
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		row = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return row;
	}
	
}
