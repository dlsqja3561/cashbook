package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Member;

public class MemberDao {
	
	// 관리자 : 멤버레벨수정(update), 수정폼(select)
	// admin -> updateLevelAction.jsp
	public int updateMemberLevel(Member member) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "UPDATE member SET member_level = ?, updatedate = CURDATE() WHERE member_no = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, member.getMemberLevel());
			stmt.setInt(2, member.getMemberNo());
			row = stmt.executeUpdate();
			if(row == 1) {
				System.out.println("멤버레벨 변경성공---");
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
	// admin -> updateLevelForm.jsp
	public Member selectMemberOne(int memberNo) {
		Member member = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT member_no memberNo, member_name memberName, member_level memberLevel"
				+ " FROM member"
				+ " WHERE member_no = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, memberNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				member = new Member();
				member.setMemberNo(rs.getInt("memberNo"));
				member.setMemberName(rs.getString("memberName"));
				member.setMemberLevel(rs.getInt("memberLevel"));
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
		return member;
	}
	
	
	// 관리자 : 멤버수 (전체 count) 
	public int selectMemberCount() {
		int count = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "SELECT COUNT(*) cnt FROM member";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("cnt");
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
		return  count;
	}
	
	// 관리자 : 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) {
		ArrayList<Member> list = new ArrayList<Member>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel"
				+ ", member_name memberName, updatedate, createdate"
				+ " FROM member ORDER BY createdate DESC"
				+ " LIMIT ?, ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while(rs.next()) {
				Member m = new Member();
				m.setMemberNo(rs.getInt("memberNo"));
				m.setMemberId(rs.getString("memberId"));
				m.setMemberLevel(rs.getInt("memberLevel"));
				m.setMemberName(rs.getString("memberName"));
				m.setUpdatedate(rs.getString("updatedate"));
				m.setCreatedate(rs.getString("createdate"));
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
		return  list;
	}
	
	// 관리자 멤버 강퇴
	public int deleteMemberByAdmin(int memberNo) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "DELETE FROM member WHERE member_no = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, memberNo);	
			row = stmt.executeUpdate();
			if(row == 1) {
				System.out.println("강퇴 성공---");
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
	
	// 로그인
	public Member login(Member paramMember) {
		Member resultMember = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName"
					+ " FROM member"
					+ " WHERE member_id = ? AND member_pw = PASSWORD(?)";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			rs = stmt.executeQuery();
			if(rs.next()) {
				resultMember = new Member();
				resultMember.setMemberId(rs.getString("memberId"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
				resultMember.setMemberName(rs.getString("memberName"));
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
		return resultMember;
	}

	// 회원가입 1.중복확인 2.회원가입
	// 반환값 t:중복 , f:사용가능
	public boolean memberIdCk(String memberId) {
		boolean result = false;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT member_id FROM member WHERE member_id = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			if(rs.next()) {
				result = true;
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
		return result;
	}
	// 회원가입
	public int insertMember(Member member) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?, PASSWORD(?), ?, CURDATE(), CURDATE())";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw());
			stmt.setString(3, member.getMemberName());
	
			row = stmt.executeUpdate();
			if(row == 1) {
				System.out.println("회원가입 성공");
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
	
	// 비밀번호 확인
	public int pwCk(String memberId, String memberPw) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setString(2, memberPw);
			
			rs = stmt.executeQuery();
			if(rs.next()) {
				row = 1;
				System.out.println("비밀번호 일치---");
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
		return row;
	}
	// 비밀번호 수정 
	public int updatePw(String memberId, String newPw) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id = ?";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, newPw);
			stmt.setString(2, memberId);
			row = stmt.executeUpdate();
			if(row == 1) {
				System.out.println("변경 성공---");
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
	
	// 회원탈퇴
	public int deleteMember(Member member) {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "DELETE FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw());
			row = stmt.executeUpdate();
			if(row == 1) {
				System.out.println("탈퇴 성공---");
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